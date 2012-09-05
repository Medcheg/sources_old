{Для корректной отработки установки позиции ScrollBar'a при
 создании формы, процедура перераспредления эскизов помещена
 в обработчик OnResize ScrollBar'a
 }

unit KatalogFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, KatalogFram;

type
  TKatalogForm = class(TForm)
    sbxKatalog: TScrollBox;
    pnlBtn: TPanel;
    KatalogFrame1: TKatalogFrame;
    KatalogFrame2: TKatalogFrame;
    KatalogFrame4: TKatalogFrame;
    KatalogFrame5: TKatalogFrame;
    KatalogFrame3: TKatalogFrame;
    KatalogFrame6: TKatalogFrame;
    KatalogFrame7: TKatalogFrame;
    KatalogFrame8: TKatalogFrame;
    KatalogFrame9: TKatalogFrame;
    KatalogFrame10: TKatalogFrame;
    KatalogFrame11: TKatalogFrame;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure sbxKatalogResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FCurW : Integer;
    procedure WM_GETMINMAXINFO(var mmInfo: TWMGetMinMaxInfo);
       message wm_GetMinMaxInfo;
  public
    CurFrame : TKatalogFrame;
    function SelectTraek (STraekNo:integer):Boolean;
    function SelectedTraekNo : integer;
    function SelectedTraekPic : TPicture;
    function SelectedTraekCaption : string;
    property ColCount: Integer read FCurW;
    { Public declarations }
  end;


implementation

const TraekNo=11;

{$R *.DFM}

procedure TKatalogForm.FormCreate(Sender: TObject);
begin
  {Чтобы при вызове распложение фрэймов
  не определялось их положением полученным  Designtime}
  FCurW := -1;
end;

procedure TKatalogForm.sbxKatalogResize(Sender: TObject);
var W,i  : integer;
    Pos : TRect;
    crW, crH : integer;
    PFrame : TKatalogFrame;
begin
  W := (sbxKatalog.Width-sbxKatalog.VertScrollBar.Size) div
        (KatalogFrame1.Width)-1;

  IF FCurW <> W then begin //Оптимиз.: перепостр. только по необходим.
    crW:=0;
    crH:=0;

    Pos.Bottom := KatalogFrame1.Width;
    Pos.Right  := KatalogFrame1.Height;
    Pos.Left := KatalogFrame1.Left;
    Pos.Top := KatalogFrame1.Top;

    FOR i := 1 to TraekNo do begin
      PFrame := TKatalogFrame(FindComponent('KatalogFrame'+IntToStr(i)));
      If Assigned(PFrame) then begin
        PFrame.Parent := sbxKatalog;
        PFrame.Left:= crW*(Pos.Bottom+9)+Pos.Left ;
        PFrame.Top := crH*(Pos.Right +5)+Pos.Top ;
        PFrame.Parent := sbxKatalog;

        if crW < W then
          Inc(crW)
        else begin
          crW:=0;
          Inc(crH);
        end;
      End;
    END;
    FCurW := W;
 END; // IF CurW <> W
end; //of procedure


procedure TKatalogForm.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled:= True;
  sbxKatalog.VertScrollBar.Position := sbxKatalog.VertScrollBar.Position +
                                        sbxKatalog.VertScrollBar.Increment;
end;

procedure TKatalogForm.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled:= True;
  sbxKatalog.VertScrollBar.Position := sbxKatalog.VertScrollBar.Position -
                                         sbxKatalog.VertScrollBar.Increment;
end;


{ ------- Методы и св-ва для взаимодействия с формой извне ---------}
function TKatalogForm.SelectedTraekNo: integer;
begin
  if Assigned(CurFrame) then
    Result := CurFrame.Tag;
end;

function TKatalogForm.SelectedTraekCaption: string;
begin
  if Assigned(CurFrame) then
    Result := CurFrame.stxtTraekName.Caption;
end;

function TKatalogForm.SelectedTraekPic: TPicture;
begin
  if Assigned(CurFrame) then
    Result := CurFrame.imgTraek.Picture;
end;

function TKatalogForm.SelectTraek(STraekNo: integer) : Boolean;
var NewFrame : TKatalogFrame;
    Dop : integer;
    CursbxState : integer;
begin
  Result := False;
  NewFrame := TKatalogFrame(FindComponent('KatalogFrame'+IntToStr(STraekNo)));
  if Assigned(NewFrame) then begin
    if Self.Visible and not(sbxKatalog.Focused) then sbxKatalog.SetFocus;
    NewFrame.SetActive;
    CurFrame := NewFrame;
    {акт. зона ScrollBox'a сдвигается так, чтобы
     эскиз выбранной траектории был видимый}
    sbxKatalog.ScrollInView(CurFrame);
    Result := True;
  end;
end;

procedure TKatalogForm.FormResize(Sender: TObject);
begin
  {ScrollInView не в sbxKatalogResize потому как FormResize
   вызывается после sbxKatalogResize}
  sbxKatalog.ScrollInView(CurFrame);
end;

procedure TKatalogForm.WM_GETMINMAXINFO(var mmInfo: TWMGETMINMAXINFO);
begin
  with mmInfo.minmaxinfo^ do begin
    ptmaxposition.x := Left;
    ptmaxposition.y := Top;
  end;
end;

end.
