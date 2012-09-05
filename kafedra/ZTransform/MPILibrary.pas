unit MPILibrary;

interface

uses Graphics, teCanvas, stdctrls;

  procedure OutRotateText(Canvas : TCanvas; x, y : Integer; Angle : Integer; OutText : String);
  procedure DrawCircle(Canvas : TCanvas; x, y : Double); overload;
  procedure DrawCircle(Canvas : TCanvas3D; x, y : Double); overload;
  procedure ShowWrongEdit(Edit : TEdit);

implementation

uses Windows, Dialogs;

procedure ShowWrongEdit(Edit : TEdit);
begin
  Edit.SetFocus;
  Edit.SelectAll;
  MessageDlg('¬ведено не числовое значение !!!', mtError, [mbOk],0);
end;

procedure OutRotateText(Canvas : TCanvas; x, y : Integer; Angle : Integer; OutText : String);
var
  lf : TLogFont;
  tf : TFont;
  rot  : Integer;
begin
  rot := Angle*10;
  with Canvas do begin
    tf := TFont.Create;
    try
      tf.Assign(Font);
      GetObject(tf.Handle, sizeof(lf), @lf);
      lf.lfEscapement := rot;
      lf.lfOrientation := Rot;
      tf.Handle := CreateFontIndirect(lf);
      Font.Assign(tf);
    finally
      tf.Free;
    end;
    TextOut(x, y, OutText);
  end;
end;

procedure DrawCircle(Canvas : TCanvas; x, y : Double);
var
  CircleArray : array [1..9] of TPoint;
begin
   CircleArray[1].x := trunc(x-1);  CircleArray[1].y := Trunc(Y-3);
   CircleArray[2].x := trunc(x+1);  CircleArray[2].y := Trunc(Y-3);
   CircleArray[3].x := trunc(x+3);  CircleArray[3].y := Trunc(Y-1);
   CircleArray[4].x := trunc(x+3);  CircleArray[4].y := Trunc(Y+1);
   CircleArray[5].x := trunc(x+1);  CircleArray[5].y := Trunc(Y+3);
   CircleArray[6].x := trunc(x-1);  CircleArray[6].y := Trunc(Y+3);
   CircleArray[7].x := trunc(x-3);  CircleArray[7].y := Trunc(Y+1);
   CircleArray[8].x := trunc(x-3);  CircleArray[8].y := Trunc(Y-1);
   CircleArray[9].x := trunc(x-1);  CircleArray[9].y := Trunc(Y-3);
   Canvas.Pen.Width := 1;
   Canvas.Polyline(CircleArray);
end;

procedure DrawCircle(Canvas : TCanvas3D; x, y : Double); overload;
var
  CircleArray : array [1..9] of TPoint;
begin
   CircleArray[1].x := trunc(x-1);  CircleArray[1].y := Trunc(Y-3);
   CircleArray[2].x := trunc(x+1);  CircleArray[2].y := Trunc(Y-3);
   CircleArray[3].x := trunc(x+3);  CircleArray[3].y := Trunc(Y-1);
   CircleArray[4].x := trunc(x+3);  CircleArray[4].y := Trunc(Y+1);
   CircleArray[5].x := trunc(x+1);  CircleArray[5].y := Trunc(Y+3);
   CircleArray[6].x := trunc(x-1);  CircleArray[6].y := Trunc(Y+3);
   CircleArray[7].x := trunc(x-3);  CircleArray[7].y := Trunc(Y+1);
   CircleArray[8].x := trunc(x-3);  CircleArray[8].y := Trunc(Y-1);
   CircleArray[9].x := trunc(x-1);  CircleArray[9].y := Trunc(Y-3);
   Canvas.Pen.Width := 1;
   Canvas.Polygon(CircleArray);
end;
end.
