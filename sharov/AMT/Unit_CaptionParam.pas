unit Unit_CaptionParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ToolWin, MPIDeclaration, ExtCtrls;

type
  TfrmCaptionParam = class(TForm)
    Label1: TLabel;
    edCaption: TEdit;
    Label2: TLabel;
    ListBox1: TListBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edStartTime: TEdit;
    edEndTime: TEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    FontDialog1: TFontDialog;
    CheckBox1: TCheckBox;
    Bevel1: TBevel;
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1Click(Sender: TObject);
    procedure edCaptionChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    omX, omY               : Integer;  // --- Старое положение Мышки на ЧАРТЕ ----
    MouseDownFirstTime     : Boolean;  // --- Первое нажатие мыши ---
    MouseDownSecondTime    : Boolean;  // --- Второе нажатие Крысы ---
    CurrentMousePosX       : TDateTime;  // --- Текущее реальное значение по координате Х ---
    CurrentMousePosY       : TDateTime;  // --- Текущее реальное значение по координате Y ---
    CurrentCaption              : TMyCaption;

    procedure ClearOldMousePosCircle();
  public
     CaptionDraw            : Boolean;
     CurrentPoleDrawCaption  : Integer;
     procedure ChartMouseMove(Shift: TShiftState; X, Y: Integer);
     procedure ChartClick();
     procedure SetParamListBox();
     procedure DeleteCaption();
  end;

var
  frmCaptionParam: TfrmCaptionParam;

implementation

uses Unit_Main, Unit_SaveType;

{$R *.DFM}

procedure TfrmCaptionParam.FormCreate(Sender: TObject);
begin
  omX                 := -1;
  omY                 := -1;
  MouseDownFirstTime  := false;
  MouseDownSecondTime := false;
  CaptionDraw         := false;
end;

procedure TfrmCaptionParam.FormShow(Sender: TObject);
begin
  left := Form1.ClientWidth - width - 3;
  top  := 45;
  if (Form1.CaptionList[NumberPole].Count  = 0) and (ListBox1.ItemIndex = -1) then begin
      ListBox1.Enabled     := false;
      Radiobutton1.Enabled := false;
      Radiobutton2.Enabled := false;
      CheckBox1   .Enabled := false;
      edCaption   .Enabled := false;
      Button1     .Enabled := false;
      EdStartTime.Text := 'Нету';
      EdEndTime.Text   := 'Нету';
      edCaption.Text   := 'Подпись - ';
      exit;
  end else begin
      ListBox1.Enabled     := True;
      Radiobutton1.Enabled := True;
      Radiobutton2.Enabled := True;
      CheckBox1   .Enabled := True;
      edCaption   .Enabled := True;
      Button1     .Enabled := True;
  end;
  ListBox1.ItemIndex := 0;
  ListBox1Click(self);
end;

procedure TfrmCaptionParam.ToolButton1Click(Sender: TObject);
var
  edCaptionText : String;
begin
  if ToolButton1.Down then begin

      ListBox1.Enabled        := false;
      Radiobutton1.Enabled    := true;
      Radiobutton2.Enabled    := true;
      CheckBox1   .Enabled    := true;
      edCaption   .Enabled    := true;
      Button1     .Enabled    := true;
      CaptionDraw             := true;
      CurrentPoleDrawCaption  := NumberPole;


      omX := -1;
      omY := -1;

      MouseDownFirstTime     := False;
      MouseDownSecondTime    := False;

      CurrentCaption := TMyCaption.Create(Form1.ChartArray[NumberPole,1].Canvas);

      Form1.CaptionList[NumberPole].Add(CurrentCaption);

      edCaptionText := 'Подпись - '+ intToStr(Form1.CaptionList[NumberPole].Count);

      ListBox1.Items.AddObject(edCaptionText, CurrentCaption);

      ListBox1.ItemIndex  := ListBox1.Items.Count-1;



      edCaption.Text      := edCaptionText;
      CurrentCaption.Caption   := edCaption.Text;

      EdStartTime.Text := 'Нету';
      EdEndTime.Text   := 'Нету';

      edCaption.SelectAll;
      edCaption.SetFocus;

      Radiobutton1.Checked := true;
      CheckBox1   .Checked := CurrentCaption.LineVisible;
  end else begin
      if MouseDownSecondTime = False then DeleteCaption();
  end;
end;

procedure TfrmCaptionParam.ClearOldMousePosCircle;
begin
  if toolButton1.Down and (omX<>-1) and  (omY<>-1) then
      with Form1.ChartArray[NumberPole,1].Canvas do begin
         pen.mode := pmNot;
         ellipse(omX-5,omY-5,omX+5,omY+5);
         omX := -1;
         omY := -1;
      end;
end;

procedure TfrmCaptionParam.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ClearOldMousePosCircle();
end;

procedure TfrmCaptionParam.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ListBox1.Enabled       := True;

  if (MouseDownFirstTime) and (not MouseDownSecondTime) and (ListBox1.ItemIndex <> -1) then begin
    TMyCaption(Form1.CaptionList[NumberPole].Items[ListBox1.ItemIndex]).Free;
    Form1.CaptionList[NumberPole].Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);
    CurrentCaption := nil;
  end;

  ToolButton1.Down       := False;
  MouseDownFirstTime     := False;
  MouseDownSecondTime    := False;

  //Form1.NumberButtonDown := 1;
  Form1.ToolButton3.Down := True;
  Form1.ChartArray[NumberPole,1].Repaint;
end;

procedure TfrmCaptionParam.ChartMouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  if toolButton1.Down then begin
      with Form1.ChartArray[NumberPole,1].Canvas do begin
        // ------------------------------
        Form1.ChartArray[NumberPole,1].canvas.ReDrawBitmap;
        form1.Chart1AfterDraw(nil);
        // ------------------------------

        pen.mode := pmNot;

        CurrentMousePosX := Form1.ChartArray[NumberPole,1].Series[0].XScreenToValue(x);
        CurrentMousePosY := Form1.ChartArray[NumberPole,1].Series[0].YScreenToValue(y);


        if not MouseDownFirstTime and not MouseDownSecondTime then begin
          edStartTime.Text :=   DateToStr(CurrentMousePosX) + ' '
                              + TimeToStr(CurrentMousePosX);

          CurrentCaption.StartPos := point(X, Y);
          CurrentCaption.StartTimePos := CurrentMousePosX;
          CurrentCaption.YStartValue  := CurrentMousePosY;

          ellipse(x-5,y-5,x+5,y+5);
        end;
        if MouseDownFirstTime and not MouseDownSecondTime then begin
          edEndTime.Text :=   DateToStr(CurrentMousePosX) + ' '
                            + TimeToStr(CurrentMousePosX);
          CurrentCaption.EndPos := point(X, Y);
          CurrentCaption.EndTimePos := CurrentMousePosX;
          CurrentCaption.YEndValue  := CurrentMousePosY;
          //CurrentCaption.Draw;
         end;
        omX := x;
        omY := y;
      end;
  end;
end;

procedure TfrmCaptionParam.ChartClick;
begin
  if toolButton1.Down then begin
      if not MouseDownFirstTime then begin
          MouseDownFirstTime := true;
          Radiobutton1.Enabled := True;
          Radiobutton2.Enabled := True;
      end else begin
        CaptionDraw          := false;
        Radiobutton1.Enabled := false;
        Radiobutton2.Enabled := false;
        MouseDownSecondTime := true;
        //ClearOldMousePosCircle();
        toolButton1.Down := false;
        ListBox1.Enabled := True;
      end;
  end;
end;

procedure TfrmCaptionParam.ListBox1Click(Sender: TObject);
begin
      CurrentCaption   := TMyCaption(ListBox1.Items.Objects[ListBox1.ItemIndex]);
      edCaption.Text   := ListBox1.Items.Strings[ListBox1.ItemIndex];
      edStartTime.Text := DateToStr(CurrentCaption.StartTimePos) + ' ' + TimeToStr(CurrentCaption.StartTimePos);
      edEndTime.Text   := DateToStr(CurrentCaption.EndTimePos)   + ' ' + TimeToStr(CurrentCaption.EndTimePos);
      CheckBox1.Checked := CurrentCaption.LineVisible;
      if CurrentCaption.Orientation  = oVertical      then Radiobutton2.Checked := true
                                                 else Radiobutton1.Checked := true;
end;

procedure TfrmCaptionParam.edCaptionChange(Sender: TObject);
var i : byte;
begin
  if CurrentCaption <> nil then begin
       CurrentCaption.Caption                               := edCaption.Text;
       ListBox1.Items.Strings[ListBox1.ItemIndex]           := edCaption.Text;
     if MouseDownSecondTime or (not MouseDownfirstTime and not MouseDownSecondTime)then
            for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
  end;
end;

procedure TfrmCaptionParam.Button1Click(Sender: TObject);
var
  i : byte;
begin
  if CurrentCaption = nil then exit;

  FontDialog1.Font.Assign(CurrentCaption.Font);
  if FontDialog1.Execute then begin
     CurrentCaption.Font.Assign(FontDialog1.Font);

     if MouseDownSecondTime or (not MouseDownfirstTime and not MouseDownSecondTime)then
         for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
  end;
end;

procedure TfrmCaptionParam.DeleteCaption();
begin
    TMyCaption(Form1.CaptionList[CurrentPoleDrawCaption].Items[ListBox1.ItemIndex]).Free;
    Form1.CaptionList[CurrentPoleDrawCaption].Delete(ListBox1.ItemIndex);
    ListBox1.Items.Delete(ListBox1.ItemIndex);

    ListBox1.Enabled    := true;
    MouseDownFirstTime  := true;
    MouseDownSecondTime := true;
    toolButton1.Down    := false;
    CaptionDraw         := false;

    Form1.ChartArray[CurrentPoleDrawCaption,1].Repaint;
end;

procedure TfrmCaptionParam.ListBox1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Listbox1.ItemIndex = -1 then Exit;
  CurrentPoleDrawCaption := NumberPole;
  if Key = 46                then DeleteCaption()
end;

procedure TfrmCaptionParam.RadioButton2Click(Sender: TObject);
var i : byte;
begin
  if CurrentCaption = nil then exit;

  CurrentCaption.Orientation                                    := oVertical;
  if MouseDownSecondTime or (not MouseDownfirstTime and not MouseDownSecondTime)then
       for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
end;

procedure TfrmCaptionParam.RadioButton1Click(Sender: TObject);
var i : byte;
begin
  if CurrentCaption = nil then exit;

  CurrentCaption.Orientation                                    := oHorizontal;
  if MouseDownSecondTime then
       for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
end;

procedure TfrmCaptionParam.CheckBox1Click(Sender: TObject);
var i : byte;
begin
  if CurrentCaption = nil then exit;

   CurrentCaption.LineVisible                                    := CheckBox1.Checked;
  if MouseDownSecondTime or (not MouseDownfirstTime and not MouseDownSecondTime)then
       for i:=1 to 3 do Form1.ChartArray[i,1].RePaint;
end;

procedure TfrmCaptionParam.SetParamListBox;
var
 i          : integer;
 CurCaption : TMyCaption;
begin
  ListBox1.Clear;
  CurrentCaption := nil;
  RadioButton1.Checked := True;
  for i:=0 to Form1.CaptionList[NumberPole].Count - 1 do begin
     CurCaption := TMyCaption(Form1.CaptionList[NumberPole].Items[i]);
     ListBox1.Items.AddObject(CurCaption.Caption, CurCaption);
     ListBox1.itemIndex := ListBox1.Items.Count - 1;
  end;
end;

end.
