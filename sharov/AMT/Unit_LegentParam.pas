unit Unit_LegentParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, MPIDeclaration;

type
  TfrmLegentParam = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    Label3: TLabel;
    ListBox1: TListBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edStartTime: TEdit;
    edEndTime: TEdit;
    Label2: TLabel;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    omX, omY               : Integer;  // --- Старое положение Мышки на ЧАРТЕ ----
    MouseDownFirstTime     : Boolean;  // --- Первое нажатие мыши ---
    MouseDownSecondTime    : Boolean;  // --- Второе нажатие Крысы ---
    CurrentMousePosX       : TDateTime;  // --- Текущее реальное значение по координате Х ---
  public
     CurrentLegend          : TLegend;
     LegendDraw             : Boolean;
     CurrentPoleDrawLegend  : Integer;
     procedure ChartMouseMove(Shift: TShiftState; X, Y: Integer);
     procedure ChartClick();
     procedure SetParamListBox();
     procedure DeleteLegend();
  end;

var
  frmLegentParam: TfrmLegentParam;

implementation

uses Unit_Main, Unit_SaveType, Unit_PlanshetParam;

{$R *.DFM}

procedure TfrmLegentParam.FormCreate(Sender: TObject);
begin
  omX                 := -1;
  omY                 := -1;
  //CountLegend         := 0;
  MouseDownFirstTime  := false;
  MouseDownSecondTime := false;
  LegendDraw          := false;
end;

procedure TfrmLegentParam.FormShow(Sender: TObject);
begin
  left := Form1.ClientWidth - width - 3;
  top  := 45;
  if (Form1.LegendList[NumberPole].Count  = 0) and (ListBox1.ItemIndex = -1) then begin
      ListBox1.Enabled     := false;
      Radiobutton1.Enabled := false;
      Radiobutton2.Enabled := false;
      EdStartTime.Text := 'Нету';
      EdEndTime.Text := 'Нету';
      exit;
  end;
  ListBox1.ItemIndex := 0;
  ListBox1Click(self);
end;

procedure TfrmLegentParam.ChartClick();
begin
  if toolButton1.Down then begin
      if not MouseDownFirstTime then begin
          MouseDownFirstTime := true;
      end else begin
        LegendDraw          := false;
        MouseDownSecondTime := true;
        toolButton1.Down    := false;
        ListBox1.Enabled    := True;
        Form1.ChartArray[NumberPole,1].Repaint;
      end;
  end;
end;

procedure TfrmLegentParam.ChartMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if toolButton1.Down then begin
      with Form1.ChartArray[NumberPole,1].Canvas do begin
        // ------------------------------
        Form1.ChartArray[NumberPole,1].canvas.ReDrawBitmap;
        form1.Chart1AfterDraw(nil);
        // ------------------------------

        pen.mode := pmNot;

        CurrentMousePosX := Form1.ChartArray[NumberPole,1].Series[0].XScreenToValue(x);

        if not MouseDownFirstTime and not MouseDownSecondTime then begin
          edStartTime.Text :=   DateToStr(CurrentMousePosX) + ' '
                              + TimeToStr(CurrentMousePosX);

          CurrentLegend.StartPos  := point(Form1.ChartArray[NumberPole,1].Series[0].CalcXPosValue(CurrentMousePosX),
                                           Form1.ChartArray[NumberPole,1].ChartRect.Bottom);

          CurrentLegend.StartTimePos                   := CurrentMousePosX;

          MoveTo(CurrentLegend.StartPos.x, Form1.ChartArray[NumberPole,1].TopAxis.PosAxis);
          LineTo(CurrentLegend.StartPos.x, Form1.ChartArray[NumberPole,1].BottomAxis.PosAxis);
        end;
        if MouseDownFirstTime and not MouseDownSecondTime then begin
          edEndTime.Text :=   DateToStr(CurrentMousePosX) + ' '
                            + TimeToStr(CurrentMousePosX);

          CurrentLegend.EndPos := point(Form1.ChartArray[NumberPole,1].Series[0].CalcXPosValue(CurrentMousePosX),
                                        Form1.ChartArray[NumberPole,1].BottomAxis.PosAxis);
          CurrentLegend.EndTimePos                   := CurrentMousePosX;
          MoveTo(CurrentLegend.EndPos.x, Form1.ChartArray[NumberPole,1].TopAxis.PosAxis);
          LineTo(CurrentLegend.EndPos.x, Form1.ChartArray[NumberPole,1].BottomAxis.PosAxis);
         end;

        omX := x;
        omY := y;
      end;
  end;
end;

procedure TfrmLegentParam.ToolButton1Click(Sender: TObject);
var
  ListBox1Text : String;
begin
  if ToolButton1.Down then begin

      ListBox1.Enabled     := false;

      MouseDownFirstTime     := False;
      MouseDownSecondTime    := False;
      LegendDraw             := true;
      CurrentPoleDrawLegend  := NumberPole;

      CurrentLegend := TLegend.Create(Form1.ChartArray[NumberPole,1].Canvas);
      Form1.LegendList[NumberPole].Add(CurrentLegend);

      ListBox1Text                                          := 'Легенда - '+ intToStr(Form1.LegendList[NumberPole].Count);
      ListBox1.Items.AddObject(ListBox1Text, CurrentLegend);
      ListBox1.ItemIndex                                    := ListBox1.Items.Count-1;
      CurrentLegend.Caption                                 := ListBox1Text;

      Radiobutton1.Enabled := true;
      Radiobutton2.Enabled := true;
      RadioButton2.Checked := True;
      EdStartTime.Text     := 'Нету';
      EdEndTime.Text       := 'Нету';
      omX                  := -1;
      omY                  := -1;
  end else begin
      if MouseDownSecondTime = False then DeleteLegend();
  end;
end;

procedure TfrmLegentParam.RadioButton2Click(Sender: TObject);
var i : byte;
begin
  if CurrentLegend = nil then exit;

  CurrentLegend.BrushStyle                   := bsBDiagonal;

  if MouseDownSecondTime then
     for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
end;

procedure TfrmLegentParam.RadioButton1Click(Sender: TObject);
var i : byte;
begin
  if CurrentLegend      = nil then exit;
  if ListBox1.ItemIndex = -1 then exit;

  CurrentLegend.BrushStyle                   := bsVertical;
  if MouseDownSecondTime then
       for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
end;

procedure TfrmLegentParam.ListBox1Click(Sender: TObject);
begin
  if CurrentLegend      = nil then exit;
  if ListBox1.ItemIndex = -1 then exit;

      CurrentLegend    := TLegend(ListBox1.Items.Objects[ListBox1.ItemIndex]);
      edStartTime.Text := DateToStr(CurrentLegend.StartTimePos) + ' ' + TimeToStr(CurrentLegend.StartTimePos);
      edEndTime.Text   := DateToStr(CurrentLegend.EndTimePos)   + ' ' + TimeToStr(CurrentLegend.EndTimePos);
     if CurrentLegend.BrushStyle  = bsVertical then Radiobutton1.Checked := true
                                                else Radiobutton2.Checked := true;
end;

procedure TfrmLegentParam.DeleteLegend();
begin
    TLegend(Form1.LegendList[CurrentPoleDrawLegend].Items[ListBox1.ItemIndex]).Free;
    Form1.LegendList[CurrentPoleDrawLegend].Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    ListBox1.Enabled := true;

    MouseDownFirstTime  := true;
    MouseDownSecondTime := true;
    toolButton1.Down    := false;
    LegendDraw          := false;
    Form1.ChartArray[CurrentPoleDrawLegend,1].Repaint;
end;

procedure TfrmLegentParam.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ListBox1.ItemIndex = -1 then exit;
  CurrentPoleDrawLegend := NumberPole;
  if Key = 46                then DeleteLegend();
end;

procedure TfrmLegentParam.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{  ListBox1.Enabled       := True;

  if (MouseDownFirstTime) and (not MouseDownSecondTime) and (ListBox1.ItemIndex <> -1) then begin
    TLegend(Form1.LegendList[NumberPole].Items[ListBox1.ItemIndex]).Free;
    Form1.LegendList[NumberPole].Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    CurrentLegend := nil;
  end;

  ToolButton1.Down       := False;
  MouseDownFirstTime     := False;
  MouseDownSecondTime    := False;
  Form1.ToolButton3.Down := True;
  Form1.ChartArray[NumberPole,1].Repaint;}
end;

procedure TfrmLegentParam.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ListBox1.Enabled       := True;

  if    ((not MouseDownFirstTime) and (not MouseDownSecondTime) and (ToolButton1.Down) and (ListBox1.ItemIndex <> -1))
     or ((MouseDownFirstTime) and (not MouseDownSecondTime) and (ListBox1.ItemIndex <> -1)) then begin
      TLegend(Form1.LegendList[NumberPole].Items[ListBox1.ItemIndex]).Free;
      Form1.LegendList[NumberPole].Delete(ListBox1.ItemIndex);
      ListBox1.Items.Delete(ListBox1.ItemIndex);
      CurrentLegend := nil;
  end;

  ToolButton1.Down       := False;
  MouseDownFirstTime     := False;
  MouseDownSecondTime    := False;
  Form1.ToolButton3.Down := True;
  Form1.ChartArray[NumberPole,1].Repaint;

  CanClose := true;
end;

procedure TfrmLegentParam.SetParamListBox;
var
 i : integer;
 CurLegend : TLegend;
begin
  ListBox1.Clear;
  CurrentLegend := nil;
  RadioButton2.Checked := True;
  for i:=0 to Form1.LegendList[NumberPole].Count - 1 do begin
     CurLegend := TLegend(Form1.LegendList[NumberPole].Items[i]);
     ListBox1.Items.AddObject(CurLegend.Caption, CurLegend);
     ListBox1.itemIndex := ListBox1.Items.Count - 1;
  end;
end;

end.
