unit ChartNT;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Menus,
  ExtCtrls, StdCtrls, Spin, Buttons, Dialogs, Messages,
   SysUtils, KzaCom;

type

  TAxis = (aX,aY);

  TAxisKind = (akCenter, akLeftCenter, akLeftBottom);

  TChartNT = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    BottomPanel: TPanel;
    LeftPanel: TPanel;
    Platform: TPaintBox;
    TopPanel: TPanel;
    RightPanel: TPanel;
    Label1: TLabel;
    HorizStepGridEdit: TSpinEdit;
    RightBottomLabel: TLabel;
    LeftBottomLabel: TLabel;
    CenterBottomLabel: TLabel;
    LeftTopLabel: TLabel;
    Panel10: TPanel;
    CloseBtn: TBitBtn;
    RightTopLabel: TLabel;
    CenterTopLabel: TLabel;
    PopupMenu: TPopupMenu;
    PanelsItem: TMenuItem;
    AxisKindMenu: TMenuItem;
    AxisCenterItem: TMenuItem;
    AxisLeftCenterItem: TMenuItem;
    AxisLeftBottomItem: TMenuItem;
    GridVisibleItem: TMenuItem;
    ScalesPanel: TPanel;
    ScaleXEdit: TEdit;
    ScaleYEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OkButton: TSpeedButton;
    CancelButton: TSpeedButton;
    ScaleItem: TMenuItem;
    SaveBMPItem: TMenuItem;
    SaveBMPDialog: TSaveDialog;
    CursorItem: TMenuItem;
    CursorPanel: TPanel;
    XEdit: TEdit;
    YEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PlatformPaint(Sender: TObject);
    procedure HorizStepGridEditChange(Sender: TObject);
    procedure PanelsItemClick(Sender: TObject);
    procedure AxisCenterItemClick(Sender: TObject);
    procedure AxisLeftCenterItemClick(Sender: TObject);
    procedure AxisLeftBottomItemClick(Sender: TObject);
    procedure GridVisibleItemClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ScaleItemClick(Sender: TObject);
    procedure SaveBMPItemClick(Sender: TObject);
    procedure PlatformMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CursorItemClick(Sender: TObject);
  private
    { Private declarations }
    canContinue: Boolean;
    PrevPoint: TPoint;
    FCenter: TPoint;
    FAxisKind: TAxisKind;
    FGridVisible: Boolean;
    FHorizGridStep: Byte;
    FVertGridStep: Byte;
    FMaxLength: Word;
    FCurentIndex: Integer;
    FMaxX: Extended;
    FMaxY: Extended;
    FNameX: String;
    FNameY: String;
    FTakt: Double;
    FScale: Byte;
    FRateX: Extended;
    FRateY: Extended;
    FData: array [TAxis,0..1023] of Extended;
    procedure SetCenter(Kind: TAxisKind);
    procedure SetPanels(Kind: TAxisKind);
    procedure SetRates(Kind: TAxisKind);
    procedure SetAxisKind(Value: TAxisKind);
    procedure SetHorizGridStep(Value: Byte);
    procedure SetVertGridStep(Value: Byte);
    function GetData(Axis: TAxis; Count: Cardinal): Extended;
    procedure SetData(Axis: TAxis; Count: Cardinal; const Value: Extended);
    function GetXX(Count: Cardinal): Extended;
    function GetYY(Count: Cardinal): Extended;
    procedure SetMaxLength(Value: Word);
    procedure SetCurentIndex(Value: Integer);
    procedure SetScale(Value: Byte);
    procedure SetMaxX(Value: Extended);
    procedure SetMaxY(Value: Extended);
    procedure UpdateCursor;
    procedure WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    { Public declarations }
    CurTakt: Extended;
    canPaint: Boolean;
    property Data[Axis: TAxis ;Count: Cardinal]: Extended read GetData write SetData;Default;
    property XX[Count: Cardinal]: Extended read GetXX ;
    property YY[Count: Cardinal]: Extended read GetYY ;
    procedure AxisPaint;
    procedure GridPaint;
    procedure ChartPaint;
    procedure AddPaint(ValueX,ValueY: Extended);
    procedure Clear;
    procedure UpdateMenu;
  published
    Property HorizGridStep: Byte read FHorizGridStep write SetHorizGridStep default 20;
    Property VertGridStep: Byte read FVertGridStep write SetVertGridStep default 20;
    property MaxLength: Word read FMaxLength write SetMaxLength default 1024;
    property CurentIndex: Integer read FCurentIndex write SetCurentIndex default 0;
    property GridVisible: boolean read FGridVisible write FGridVisible default True;
    property AxisKind: TAxisKind read FAxisKind write SetAxisKind default akLeftBottom;
    property MaxX: Extended read FMaxX write SetMaxX ;
    property MaxY: Extended read FMaxY write SetMaxY ;
    property Scale: Byte read FScale write SetScale default 100;
    property NameX: String read FNameX Write FNameX;
    property NameY: String read FNameY Write FNameY;
    property Takt: Double read FTakt write FTakt;
  end;


implementation

{$R *.DFM}

procedure TChartNT.FormCreate(Sender: TObject);
begin
  canContinue:=True;
  PrevPoint.X:=-1;
  PrevPoint.Y:=-1;
  FScale:=100;
  FMaxX:=2;
  MaxY:=3;
  HorizGridStep:=20;
  VertGridStep:=20;
  MaxLength:=1024;
  FCurentIndex:=0;
  canPaint:=False;
  GridVisible:=True;
  AxisKind:=akLeftBottom;
  { For Component}
  GridVisibleItem.Checked:=GridVisible;
  case AxisKind of
    akCenter      : begin
                      AxisCenterItem.Checked:=True;
                      AxisLeftCenterItem.Checked:=False;
                      AxisLeftBottomItem.Checked:=False;
                    end;
    akLeftCenter  : begin
                      AxisCenterItem.Checked:=False;
                      AxisLeftCenterItem.Checked:=True;
                      AxisLeftBottomItem.Checked:=False;
                    end;
    akLeftBottom  : begin
                      AxisCenterItem.Checked:=False;
                      AxisLeftCenterItem.Checked:=False;
                      AxisLeftBottomItem.Checked:=True;
                    end;
  end;
  end;

procedure TChartNT.UpdateCursor;
var i,j: Integer;
    t: Extended;
begin
  j:=0;
  t:=(PrevPoint.X-FCenter.X)/FRateX;
  if (t<0)or(CurentIndex=0)or(t>xx[CurentIndex-1]) then begin
    XEdit.Text:='Пусто';
    YEdit.Text:='Пусто';
  end else begin
    for i:=0 to CurentIndex-1 do
      if xx[i]>t then begin
        j:=i-1;
        break;
      end;
    XEdit.Text:=FloatToStr(xx[j]);
    YEdit.Text:=FloatToStr(yy[j]);
  end;
end;

procedure TChartNT.Clear;
begin
  CurentIndex:=0;
  PlatFormPaint(Self);
  canContinue:=True;
end;

procedure TChartNT.UpdateMenu;
begin
  if NameX='Текущее время' then CursorItem.Enabled:=True;
end;

procedure TChartNT.SetAxisKind(Value: TAxisKind);
begin
  FAxisKind:=Value;
  SetPanels(FAxisKind);
end;

procedure TChartNT.SetPanels(Kind: TAxisKind);
begin
  Case Kind of
    akCenter      : begin
                      LeftPanel.Caption:=FloatToStr(-MaxX*Scale/100);
                      RightPanel.Caption:=FloatToStr(MaxX*Scale/100);
                      LeftTopLabel.Caption:='';
                      LeftBottomLabel.Caption:='';
                      RightTopLabel.Caption:='';
                      RightBottomLabel.Caption:='';
                      CenterTopLabel.Caption:=FloatToStr(MaxY*Scale/100);
                      CenterBottomLabel.Caption:=FloatToStr(-MaxY*Scale/100);
                    end;
    akLeftCenter  : begin
                      LeftPanel.Caption:='0';
                      RightPanel.Caption:=FloatToStr(MaxX*Scale/100);
                      LeftTopLabel.Caption:=FloatToStr(MaxY*Scale/100);
                      LeftBottomLabel.Caption:=FloatToStr(-MaxY*Scale/100);
                      RightTopLabel.Caption:='';
                      RightBottomLabel.Caption:='';
                      CenterTopLabel.Caption:='';
                      CenterBottomLabel.Caption:='';
                    end;
    akLeftBottom  : begin
                      LeftPanel.Caption:='';
                      RightPanel.Caption:='';
                      LeftTopLabel.Caption:=FloatToStr(MaxY*Scale/100);
                      LeftBottomLabel.Caption:='0  ';
                      RightTopLabel.Caption:='';
                      RightBottomLabel.Caption:=FloatToStr(MaxX*Scale/100);
                      CenterTopLabel.Caption:='';
                      CenterBottomLabel.Caption:='';
                    end;
  end;
end;

procedure TChartNT.SetRates(Kind: TAxisKind);
begin
  Case Kind of
    akCenter      : begin
                      FRateX := 100*(PlatForm.Width/(FMaxX*2*FScale));
                      FRateY := 100*(PlatForm.Height/(FMaxY*2*FScale));
                    end;
    akLeftCenter  : begin
                      FRateX := 100*(PlatForm.Width/(FMaxX*FScale));
                      FRateY := 100*(PlatForm.Height/(FMaxY*2*FScale));
                    end;
    akLeftBottom  : begin
                      FRateX := 100*(PlatForm.Width/(FMaxX*FScale));
                      FRateY := 100*(PlatForm.Height/(FMaxY*FScale));
                    end;
  end;
  if CursorItem.Checked then UpdateCursor;
end;

procedure TChartNT.SetMaxX(Value: Extended);
begin
  FMaxX := Value;
  SetRates(AxisKind);
  SetPanels(AxisKind);
end;

procedure TChartNT.SetMaxY(Value: Extended);
begin
  FMaxY := Value;
  SetRates(AxisKind);
  SetPanels(AxisKind);
end;

procedure TChartNT.SetCenter(Kind: TAxisKind);
begin
  Case Kind of
    akCenter      : begin
                      FCenter.X:=PlatForm.Width div 2;
                      FCenter.Y:=Platform.Height div 2;
                    end;
    akLeftCenter  : begin
                      FCenter.X:=0;
                      FCenter.Y:=Platform.Height div 2;
                    end;
    akLeftBottom  : begin
                      FCenter.X:=0;
                      FCenter.Y:=Platform.Height-1;
                    end;
  end;
end;

procedure TChartNT.AxisPaint;
begin
with PlatForm.Canvas do begin
  Pen.Color:=clGray;
  Pen.Style:=psSolid;
  Pen.Mode:=pmCopy;
  Pen.Width:=1;
  MoveTo(FCenter.X,0);
  LineTo(FCenter.X,Platform.Height-1);
  MoveTo(0,FCenter.Y);
  LineTo(Platform.Width-1,FCenter.Y);
  end;
end;

procedure TChartNT.GridPaint;
begin
  if GridVisible then begin
    with PlatForm.Canvas do begin
    Pen.Color:=clGray;
    Pen.Style:=psDot;
    Pen.Mode:=pmCopy;
    Pen.Width:=1;
    MoveTo(FCenter.X,0);
    While (PlatForm.Width-1-PenPos.X)>HorizGridStep do begin
      MoveTo(PenPos.X+HorizGridStep,0);
      LineTo(PenPos.X,PlatForm.Height-1);
    end;
    MoveTo(FCenter.X,0);
    While PenPos.X>HorizGridStep do begin
      MoveTo(PenPos.X-HorizGridStep,0);
      LineTo(PenPos.X,PlatForm.Height-1);
    end;
    MoveTo(0,FCenter.Y);
    While (PenPos.Y)>VertGridStep do begin
      MoveTo(0,PenPos.Y-VertGridStep);
      LineTo(PlatForm.Width-1,PenPos.Y);
    end;
    MoveTo(0,FCenter.Y);
    While (PlatForm.Height-1-PenPos.Y)>VertGridStep do begin
      MoveTo(0,PenPos.Y+VertGridStep);
      LineTo(PlatForm.Width-1,PenPos.Y);
    end;
  end;
  end;
end;

procedure TChartNT.ChartPaint;
var i: Integer;
    a,b,c,d,
    x1,x2,y1,y2 : Extended;
begin
  with PlatForm.Canvas do begin
    Pen.Color:=clRed;
    Pen.Style:=psSolid;
    Pen.Mode:=pmCopy;
  end;
  for i:=1 to CurentIndex-1 do begin
   a:=-1;
   b:=-1;
   c:=-1;
   d:=-1;
      x1:=FCenter.X+XX[i-1]*FRateX;
      y1:=FCenter.Y-YY[i-1]*FRateY;
      x2:=FCenter.X+XX[i]*FRateX;
      y2:=FCenter.Y-yy[i]*FRateY;
      with platform do begin
       if abs(x1-x2)<1 then begin
        if (x1>=0)and(x1<=Platform.Width) then begin
         if y1>Platform.Height then begin
          a:=trunc(x1); b:=Platform.Height;
         end else begin
          if y1<0 then begin
           a:=trunc(x1); b:=0;
          end else begin
           a:=trunc(x1); b:=trunc(y1);
          end;
         end;{y1}
         if y2>Platform.Height then begin
          c:=trunc(x2); d:=Platform.Height;
         end else begin
          if y2<0 then begin
           c:=trunc(x1); d:=0;
          end else begin
           c:=trunc(x2); d:=trunc(y2);
          end;
         end;{y2}
        end;
       end else begin{x1<>x2}
        if abs(y1-y2)<1 then begin
         if (y1>=0)and(y1<=Platform.Height) then begin
          if x1>Platform.Width then begin
           a:=Platform.Width; b:=trunc(y1);
          end else begin
           if x1<0 then begin
            a:=0; b:=trunc(y1);
           end else begin
            a:=trunc(x1); b:=trunc(y1);
           end;
          end;{x1}
          if x2>Platform.Width then begin
           c:=Platform.Width; d:=y2;
          end else begin
           if x2<0 then begin
            c:=0; d:=y2;
           end else begin
            c:=x2; d:=y2;
           end;
          end;{x2}
         end;
        end else begin{y1<>y2}
         {begin x1,y1}
         if x1<0 then begin
          y1:=(-x2*(y1-y2)/(x1-x2)+y2);
          x1:=0;
          if y1<0 then begin
           x1:=(-y2*(x1-x2)/(y1-y2)+x2);
           y1:=0;
           if (x1>=0)and(x1<=Platform.Width) then begin
            a:=x1; b:=0;
           end;
          end else begin
           if y1>Platform.Height then begin
            x1:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
            y1:=PlatForm.Height;
            if (x1>=0)and(x1<=Platform.Width) then begin
             a:=x1; b:=Platform.Height;
            end;
           end else begin
            a:=0; b:=y1;
           end;
          end;
         end else begin
          if x1>Platform.Width then begin
           y1:=((Platform.Width-x2)*(y1-y2)/(x1-x2)+y2);
           x1:=Platform.Width;
           if y1<0 then begin
            x1:=(-y2*(x1-x2)/(y1-y2)+x2);
            y1:=0;
            if (x1>=0)and(x1<=Platform.Width) then begin
             a:=x1; b:=0;
            end;
           end else begin
            if y1>Platform.Height then begin
             x1:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y1:=Platform.Height;
             if (x1>=0)and(x1<=Platform.Width) then begin
              a:=x1; b:=Platform.Height;
             end;
            end else begin
             a:=Platform.Width; b:=y1;
            end;
           end;
          end else begin
           if y1<0 then begin
            x1:=(-y2*(x1-x2)/(y1-y2)+x2);
            y1:=0;
            if (x1>=0)and(x1<=Platform.Width) then begin
             a:=x1; b:=0;
            end;
           end else begin
            if y1>Platform.Height then begin
             x1:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y1:=PlatForm.Height;
             if (x1>=0)and(x1<=Platform.Width) then begin
              a:=x1; b:=Platform.Height;
             end;
            end else begin
             a:=x1; b:=y1;
            end;
           end;
          end;
         end;
         {begin x2,y2}
         if x2<0 then begin
          y2:=(-x2*(y1-y2)/(x1-x2)+y2);
          x2:=0;
          if y2<0 then begin
           x2:=(-y2*(x1-x2)/(y1-y2)+x2);
           y2:=0;
           if (x2>=0)and(x2<=Platform.Width) then begin
            c:=x2; d:=0;
           end;
          end else begin
           if y2>Platform.Height then begin
            x2:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
            y2:=PlatForm.Height;
            if (x2>=0)and(x2<=Platform.Width) then begin
             c:=x2; d:=Platform.Height;
            end;
           end else begin
            c:=0; d:=y2;
           end;
          end;
         end else begin
          if x2>Platform.Width then begin
           y2:=((Platform.Width-x2)*(y1-y2)/(x1-x2)+y2);
           x2:=Platform.Width;
           if y2<0 then begin
            x2:=(-y2*(x1-x2)/(y1-y2)+x2);
            y2:=0;
            if (x2>=0)and(x2<=Platform.Width) then begin
             c:=x2; d:=0;
            end;
           end else begin
            if y2>Platform.Height then begin
             x2:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y2:=PlatForm.Height;
             if (x2>=0)and(x2<=Platform.Width) then begin
              c:=x2; d:=Platform.Height;
             end;
            end else begin
             c:=Platform.Width; d:=y2;
            end;
           end;
          end else begin
           if y2<0 then begin
            x2:=(-y2*(x1-x2)/(y1-y2)+x2);
            y2:=0;
            if (x2>=0)and(x2<=Platform.Width) then begin
             c:=x2; d:=0;
            end;
           end else begin
            if y2>Platform.Height then begin
             x2:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y2:=Platform.Height;
             if (x2>=0)and(x2<=Platform.Width) then begin
              c:=x2; d:=Platform.Height;
             end;
            end else begin
             c:=x2; d:=y2;
            end;
           end;
          end;
         end;
        end;
       end;

       Canvas.MoveTo( trunc(a),trunc(b));
       Canvas.LineTo( trunc(c),trunc(d))
      end;
  end;
end;

procedure TChartNT.AddPaint(ValueX,ValueY: Extended);
var a,b,c,d,
    x1,x2,y1,y2: Extended;
begin
  a:=-1;
  b:=-1;
  c:=-1;
  d:=-1;
  if (CurentIndex<MaxLength)then begin
  if CurTakt>=Takt then begin
    CurTakt:=0;
    with PlatForm.Canvas do begin
      Pen.Color:=clRed;
      Pen.Style:=psSolid;
      Pen.Mode:=pmCopy;
    end;
    Data[aX,CurentIndex]:=ValueX;
    Data[aY,CurentIndex]:=ValueY;
    if PlatForm.Visible then
    if CurentIndex>0 then begin
      x1:=FCenter.X+XX[curentIndex-1]*FRateX;
      y1:=FCenter.Y-YY[CurentIndex-1]*FRateY;
      x2:=FCenter.X+ValueX*FRateX;
      y2:=FCenter.Y-ValueY*FRateY;
      with platform do begin
       if abs(x1-x2)<1 then begin
        if (x1>=0)and(x1<=Platform.Width) then begin
         if y1>Platform.Height then begin
          a:=trunc(x1); b:=Platform.Height;
         end else begin
          if y1<0 then begin
           a:=trunc(x1); b:=0;
          end else begin
           a:=trunc(x1); b:=trunc(y1);
          end;
         end;{y1}
         if y2>Platform.Height then begin
          c:=trunc(x2); d:=Platform.Height;
         end else begin
          if y2<0 then begin
           c:=trunc(x1); d:=0;
          end else begin
           c:=trunc(x2); d:=trunc(y2);
          end;
         end;{y2}
        end;
       end else begin{x1<>x2}
        if abs(y1-y2)<1 then begin
         if (y1>=0)and(y1<=Platform.Height) then begin
          if x1>Platform.Width then begin
           a:=Platform.Width; b:=trunc(y1);
          end else begin
           if x1<0 then begin
            a:=0; b:=trunc(y1);
           end else begin
            a:=trunc(x1); b:=trunc(y1);
           end;
          end;{x1}
          if x2>Platform.Width then begin
           c:=Platform.Width; d:=y2;
          end else begin
           if x2<0 then begin
            c:=0; d:=y2;
           end else begin
            c:=x2; d:=y2;
           end;
          end;{x2}
         end;
        end else begin{y1<>y2}
         {begin x1,y1}
         if x1<0 then begin
          y1:=(-x2*(y1-y2)/(x1-x2)+y2);
          x1:=0;
          if y1<0 then begin
           x1:=(-y2*(x1-x2)/(y1-y2)+x2);
           y1:=0;
           if (x1>=0)and(x1<=Platform.Width) then begin
            a:=x1; b:=0;
           end;
          end else begin
           if y1>Platform.Height then begin
            x1:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
            y1:=PlatForm.Height;
            if (x1>=0)and(x1<=Platform.Width) then begin
             a:=x1; b:=Platform.Height;
            end;
           end else begin
            a:=0; b:=y1;
           end;
          end;
         end else begin
          if x1>Platform.Width then begin
           y1:=((Platform.Width-x2)*(y1-y2)/(x1-x2)+y2);
           x1:=Platform.Width;
           if y1<0 then begin
            x1:=(-y2*(x1-x2)/(y1-y2)+x2);
            y1:=0;
            if (x1>=0)and(x1<=Platform.Width) then begin
             a:=x1; b:=0;
            end;
           end else begin
            if y1>Platform.Height then begin
             x1:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y1:=Platform.Height;
             if (x1>=0)and(x1<=Platform.Width) then begin
              a:=x1; b:=Platform.Height;
             end;
            end else begin
             a:=Platform.Width; b:=y1;
            end;
           end;
          end else begin
           if y1<0 then begin
            x1:=(-y2*(x1-x2)/(y1-y2)+x2);
            y1:=0;
            if (x1>=0)and(x1<=Platform.Width) then begin
             a:=x1; b:=0;
            end;
           end else begin
            if y1>Platform.Height then begin
             x1:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y1:=PlatForm.Height;
             if (x1>=0)and(x1<=Platform.Width) then begin
              a:=x1; b:=Platform.Height;
             end;
            end else begin
             a:=x1; b:=y1;
            end;
           end;
          end;
         end;
         {begin x2,y2}
         if x2<0 then begin
          y2:=(-x2*(y1-y2)/(x1-x2)+y2);
          x2:=0;
          if y2<0 then begin
           x2:=(-y2*(x1-x2)/(y1-y2)+x2);
           y2:=0;
           if (x2>=0)and(x2<=Platform.Width) then begin
            c:=x2; d:=0;
           end;
          end else begin
           if y2>Platform.Height then begin
            x2:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
            y2:=PlatForm.Height;
            if (x2>=0)and(x2<=Platform.Width) then begin
             c:=x2; d:=Platform.Height;
            end;
           end else begin
            c:=0; d:=y2;
           end;
          end;
         end else begin
          if x2>Platform.Width then begin
           y2:=((Platform.Width-x2)*(y1-y2)/(x1-x2)+y2);
           x2:=Platform.Width;
           if y2<0 then begin
            x2:=(-y2*(x1-x2)/(y1-y2)+x2);
            y2:=0;
            if (x2>=0)and(x2<=Platform.Width) then begin
             c:=x2; d:=0;
            end;
           end else begin
            if y2>Platform.Height then begin
             x2:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y2:=PlatForm.Height;
             if (x2>=0)and(x2<=Platform.Width) then begin
              c:=x2; d:=Platform.Height;
             end;
            end else begin
             c:=Platform.Width; d:=y2;
            end;
           end;
          end else begin
           if y2<0 then begin
            x2:=(-y2*(x1-x2)/(y1-y2)+x2);
            y2:=0;
            if (x2>=0)and(x2<=Platform.Width) then begin
             c:=x2; d:=0;
            end;
           end else begin
            if y2>Platform.Height then begin
             x2:=((Platform.Height-y2)*(x1-x2)/(y1-y2)+x2);
             y2:=Platform.Height;
             if (x2>=0)and(x2<=Platform.Width) then begin
              c:=x2; d:=Platform.Height;
             end;
            end else begin
             c:=x2; d:=y2;
            end;
           end;
          end;
         end;
        end;
       end;

       Canvas.MoveTo( trunc(a),trunc(b));
       Canvas.LineTo( trunc(c),trunc(d))
      end;
    end;
    CurentIndex:=CurentIndex+1;
  end; end else if canContinue then begin
    MessageDlg('График "'+Caption+'" прекратил прорисовку. Исчерпан лимит памяти.',mtInformation,[mbOk],0);
    CanContinue:=False;
  end;
end;

procedure TChartNT.WMGetMinMaxInfo(var Message: TWMGetMinMaxInfo);
begin
  inherited;
  With (Message.MinMaxInfo^).ptMinTrackSize do begin
    if CursorItem.Checked then x:=400
       else x:=330;
    y:=205;
  end;
end;

procedure TChartNT.SetScale(Value: Byte);
begin
  if (Value>200)or(Value<50) then
                             raise ERangeError.Create('Invalid scale Value!')
     else begin
       FScale:=Value;
       HorizStepGridEdit.Value:=Value;
       SetRates(AxisKind);
     end;
end;

procedure TChartNT.SetCurentIndex(Value: Integer);
begin
  if (Value>MaxLength) or (Value<0) then raise ERangeError.Create('CurentIndex Out of MaxLength')
     else FCurentIndex:=Value;
end;

procedure TChartNT.SetData(Axis: TAxis; Count: Cardinal; const Value: Extended);
begin
  if Count>MaxLength-1 then begin
     raise ERangeError.Create('CurentIndex Out of MaxLength')
  end else begin
      FData[Axis, Count]:=Value;
  end;
end;

function TChartNT.GetData(Axis: TAxis; Count: Cardinal): Extended;
begin
  if Count>MaxLength-1 then begin
     raise ERangeError.Create('CurentIndex Out of MaxLength')
  end else begin
      Result:=FData[Axis, Count];
  end;
end;

function TChartNT.GetXX(Count: Cardinal): Extended;
begin
  if Count>MaxLength-1 then begin
     raise ERangeError.Create('CurentIndex Out of MaxLength')
  end else begin
      Result:=FData[aX, Count];
  end;
end;

function TChartNT.GetYY(Count: Cardinal): Extended;
begin
  if Count>MaxLength-1 then begin
     raise ERangeError.Create('CurentIndex Out of MaxLength')
  end else begin
      Result:=FData[aY, Count];
  end;
end;

procedure TChartNT.SetMaxLength(Value: Word);
begin
  case Value of
    0..1         : FMaxLength:=1;
    2..1024      : FMaxLength:=Value;
    else FMaxLength:=1024;
  end;
end;
procedure TChartNT.SetHorizGridStep(Value: Byte);
begin
  if Value<10 then FHorizGridStep:=10
    else FHorizGridStep:=Value;
end;

procedure TChartNT.SetVertGridStep(Value: Byte);
begin
  if Value<10 then FVertGridStep:=10
    else FVertGridStep:=Value;
end;

procedure TChartNT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TChartNT.PlatformPaint(Sender: TObject);
var p: TPoint;
begin
  With Platform.Canvas do begin
    Brush.Color:=clWhite;
    Brush.Style:=bsSolid;
    FillRect(ClipRect);
    SetCenter(AxisKind);
    GridPaint;
    AxisPaint;
    SetRates(AxisKind);
    if canPaint then begin
      ChartPaint;
    end;
    if CursorItem.Checked then begin
           p:=PenPos;
           Pen.Mode:=pmXor;
           Pen.Color:=clRed;
           moveTo(Self.PrevPoint.X,0);
           lineTo(Self.PrevPoint.X,Platform.Height-1);
           MoveTo(p.X,p.Y);
    end;
  end;
end;

procedure TChartNT.HorizStepGridEditChange(Sender: TObject);
var NewStep: Integer;
begin
  Scale:=HorizStepGridEdit.Value;
  NewStep:=Trunc(2000/Scale);
  HorizGridStep:=NewStep;
  VertGridStep:=NewStep;
  SetPanels(AxisKind);
  PlatForm.Refresh;
end;

procedure TChartNT.PanelsItemClick(Sender: TObject);
begin
  If PanelsItem.Checked then begin
    PanelsItem.Checked:=False;
    LeftPanel.Visible:=False;
    RightPanel.Visible:=False;
    TopPanel.Visible:=False;
    BottomPanel.Visible:=False;
  end else begin
    PanelsItem.Checked:=True;
    LeftPanel.Visible:=True;
    RightPanel.Visible:=True;
    TopPanel.Visible:=True;
    BottomPanel.Visible:=True;
  end;
end;

procedure TChartNT.AxisCenterItemClick(Sender: TObject);
begin
  AxisCenterItem.Checked:=True;
  AxisLeftBottomItem.Checked:=False;
  AxisLeftCenterItem.Checked:=False;
  AxisKind:=akCenter;
  canPaint:=True;
  SetPanels(akCenter);
  SetRates(akCenter);
  Self.PlatformPaint(Self);
end;

procedure TChartNT.AxisLeftCenterItemClick(Sender: TObject);
begin
  AxisCenterItem.Checked:=False;
  AxisLeftBottomItem.Checked:=False;
  AxisLeftCenterItem.Checked:=True;
  AxisKind:=akLeftCenter;
  canPaint:=True;
  SetPanels(akLeftCenter);
  SetRates(akLeftCenter);
  Self.PlatformPaint(Self);
end;

procedure TChartNT.AxisLeftBottomItemClick(Sender: TObject);
begin
  AxisCenterItem.Checked:=False;
  AxisLeftBottomItem.Checked:=True;
  AxisLeftCenterItem.Checked:=False;
  AxisKind:=akLeftBottom;
  canPaint:=True;
  SetPanels(akLeftBottom);
  SetRates(akLeftBottom);
  Self.PlatformPaint(Self);
end;

procedure TChartNT.GridVisibleItemClick(Sender: TObject);
begin
  GridVisible:=not GridVisible;
  GridVisibleItem.Checked:=GridVisible;
  Self.PlatformPaint(Self);
end;

procedure TChartNT.OkButtonClick(Sender: TObject);
begin
  try
    MaxX:=StrToFloat(ScaleXEdit.Text);
    MaxY:=StrToFloat(ScaleYEdit.Text);
    ScalesPanel.Hide;
    SetPanels(AxisKind);
    SetRates(AxisKind);
    PlatForm.Refresh;
  except
    on EConvertError do MessageDlg('Try ones more! Dummy.',mtError,[mbOk],0);
  end;
end;

procedure TChartNT.CancelButtonClick(Sender: TObject);
begin
  ScalesPanel.Hide;
end;

procedure TChartNT.ScaleItemClick(Sender: TObject);
begin
  ScalesPanel.Top:=Trunc((Panel5.Height-ScalesPanel.Height)/2);
  ScalesPanel.Left:=Trunc((Panel5.Width-ScalesPanel.Width)/2);
  ScaleXEdit.Text:=FloatToStr(MaxX);
  ScaleYEdit.Text:=FloatToStr(MaxY);
  ScalesPanel.Show;
end;

procedure TChartNT.SaveBMPItemClick(Sender: TObject);
var   Bmp  : TBitMap;
      Rect2 : TRect;
      Rect1: TRect;
begin
  If SaveBmpDialog.Execute then begin
    Bmp:=TBitMap.Create;
    PlatFormPaint(Self);
    Application.ProcessMessages;
    Rect2.Left:=Self.ClientRect.Left+11;
    Rect2.Top:=Self.ClientRect.Top+11;
    Rect2.Right:=Self.ClientRect.Right-11;
    Rect2.Bottom:=Self.ClientRect.Bottom-42;
    Bmp.Width:=Rect2.Right-Rect2.Left+10;
    Bmp.Height:=Rect2.Bottom-Rect2.Top+40;
    Bmp.Monochrome:=False;
    Rect1.left:=5;
    Rect1.Top:=5;
    Rect1.Right:=Bmp.Width-5;
    Rect1.Bottom:=Bmp.Height-35;
    With BMP.Canvas do begin
      Pen.Color:=clRed;
      Pen.Style:=psSolid;
      Pen.Mode:=pmCopy;
      Pen.Width:=1;
      Brush.Color:=clWhite;
      Brush.Style:=bsSolid;
      FillRect(ClipRect);
      Rectangle(Rect1.left-1,Rect1.Top-1,Rect1.Right+1,Rect1.Bottom+1);
      Pen.Color:=clBlack;
      TextOut(40,ClipRect.Bottom-25,'Рис.   . '+Self.Caption+'.');
    end;
    Bmp.Canvas.CopyRect(Rect1,Self.Canvas,Rect2);
    Bmp.SaveToFile(SaveBMPDialog.FileName);
    Bmp.Free;
  end;
end;

procedure TChartNT.PlatformMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var p: TPoint;
begin
  if Sender = PlatForm then
   if CursorItem.Checked then begin
    With PlatForm.Canvas do begin
           p:=PenPos;
           Pen.Mode:=pmXor;
           Pen.Color:=clRed;
           moveTo(Self.PrevPoint.X,0);
           lineTo(Self.PrevPoint.X,Height-1);
           moveTo(X,0);
           lineTo(X,Height-1);
           Self.PrevPoint.X:=X;
           Self.PrevPoint.Y:=Y;
           MoveTo(p.X,p.Y);
           UpdateCursor;
    end;

   end;
end;

procedure TChartNT.CursorItemClick(Sender: TObject);
begin
  platFormMouseMove(PlatForm,[],-1,-1);
  CursorItem.Checked:= not CursorItem.Checked;
  if CursorItem.Checked then PlatForm.Cursor:=crHSplit
                        else PlatForm.Cursor:=crDefault;
  if Width<400 then Width:=400;
  CursorPanel.Visible:=CursorItem.Checked;
end;

end.
