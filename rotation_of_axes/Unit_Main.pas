unit Unit_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, OpenGL;

const
   L = 40;
   L1 = L*0.90;
   L2 = L*0.48;
   CoefStrelka = 0.6;
   LengthStrelka = 4;
   DiscretStep   = 2;

type
  TVector = record
     x, y, z : Extended;
  end;

  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    N111111111: TMenuItem;
    N2222222221: TMenuItem;
    N333333331: TMenuItem;
    N444441: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    z1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N111111111Click(Sender: TObject);
    procedure N2222222221Click(Sender: TObject);
    procedure N333333331Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N444441Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure z1Click(Sender: TObject);
  private
    DC                     : HDC;
    hrc                    : HGLRC;
    StartPosYMouse         : Integer;
    StartPosXMouse         : Integer;

    MouseDown : boolean;

    Order : array [0..2] of integer;
    NumberTurn : Integer;
    YAngelCamera : Integer;
    XAngelCamera : Integer;

    procedure TurnX();
    procedure TurnY();
    procedure TurnZ();
    procedure FormPaint(var msg : TWMPAINT); message WM_Paint;
  public
    ang1, ang2, ang3       : Extended;
    x, y, z                : TVector;
    Coef                   : Integer;

    ArrowEnabled : Boolean;
    MainLineWidth  : byte;
    MinorLineWidth : byte;
    RotationAngle  : integer;

    procedure CreateList();
    procedure Draw_GL();
  end;

var
  frmMain: TfrmMain;

implementation

uses Unit_Param, Unit_About;

{$R *.DFM}

procedure TfrmMain.FormCreate(Sender: TObject);
var nPixelFormat: Integer;
    pfd: TPixelFormatDescriptor;
begin
  x.x := L;  x.y := 0;   x.z := 0;
  y.x := 0;  y.y := L;   y.z := 0;
  z.x := 0;  z.y := 0;   z.z :=  L;

  YAngelCamera := 25;
  XAngelCamera := 25;

  Coef := 1;
//  y.y := -L;

  ang1 := 0;
  ang2 := 0;
  ang3 := 0;
  NumberTurn := 0;

    ArrowEnabled   := True;
    MainLineWidth  := 3;
    MinorLineWidth := 1;
    RotationAngle  := 20;

  DC  := GetDC(Handle);

  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags   := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  pfd.cColorBits := 2;
  nPixelFormat  := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);

  hrc := wglCreateContext(DC); wglMakeCurrent(DC, hrc);

  CreateList();
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC (DC);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 glOrtho(-45,45,-45,45,-270,270);
// gluPerspective (1000.0, ClientWidth / ClientHeight, 1.0, 1000.0);
 glMatrixMode (GL_MODELVIEW);
 glLoadIdentity;
 InvalidateRect(Handle, nil, False);

  glViewport(0, 0, ClientWidth, ClientHeight);
  glClearColor(1, 1, 1,1);
  glEnable(GL_DEPTH_TEST);

end;

procedure TfrmMain.FormPaint(var msg: TWMPAINT);
begin
  Draw_GL();
end;

procedure TfrmMain.Draw_GL();
begin
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

   glPushMatrix;
         gluLookAt(XAngelCamera,YAngelCamera,25, 0,0,0, 0,1,0);
         glCallList(1);
         glPushMatrix;
               glCallList(1);
               Case Order[0] of
                 1 : begin glRotatef(ang1, 1, 0, 0); TurnX(); end;
                 2 : begin glRotatef(ang2, 0, 1, 0); TurnY(); end;
                 3 : begin glRotatef(ang3, 0, 0, 1); TurnZ(); end;
               end;
               glPushMatrix;
                        glCallList(1);
                        Case Order[1] of
                           1 : begin glRotatef(ang1, 1, 0, 0); TurnX(); end;
                           2 : begin glRotatef(ang2, 0, 1, 0); TurnY(); end;
                           3 : begin glRotatef(ang3, 0, 0, 1); TurnZ(); end;
                        end;
                        glPushMatrix;
                                 glCallList(1);
                                 Case Order[2] of
                                     1 : begin glRotatef(ang1, 1, 0, 0); TurnX(); end;
                                     2 : begin glRotatef(ang2, 0, 1, 0); TurnY(); end;
                                     3 : begin glRotatef(ang3, 0, 0, 1); TurnZ(); end;
                                 end;
                                 glCallList(1);
                        glPopMatrix;
               glPopMatrix;
         glPopMatrix;




   glPopMatrix;

   SwapBuffers(DC);
end;

procedure TfrmMain.CreateList();
var
  TempAngle : Extended;
begin
//  glEnable(GL_LINE_SMOOTH);
  glNewList(1, GL_COMPILE);
         glLineWidth(MainLineWidth);
         glColor3f (0,0,0);

         glBegin (GL_Lines); glVertex3f( 0, 0, 0); glVertex3f( x.x, x.y, x.z); glEnd;
            if ArrowEnabled then begin
               TempAngle := 0;
               glLineWidth(MinorLineWidth);
               while TempAngle < 2*pi do begin
                  glBegin (GL_Lines); glVertex3f( x.x, x.y, x.z); glVertex3f( x.x - LengthStrelka, x.y+CoefStrelka*sin(TempAngle), x.z+CoefStrelka*cos(TempAngle)); glEnd;
                  TempAngle := TempAngle + 0.1;
               end;
            end;

         glLineWidth(MainLineWidth);
         glBegin (GL_Lines); glVertex3f( 0, 0, 0); glVertex3f( y.x, y.y, y.z); glEnd;
            if ArrowEnabled then begin
               TempAngle := 0;
               glLineWidth(MinorLineWidth);
               while TempAngle < 2*pi do begin
                 glBegin (GL_Lines); glVertex3f( y.x, y.y, y.z); glVertex3f( y.x+CoefStrelka*cos(TempAngle), y.y-coef*LengthStrelka, y.z+CoefStrelka*sin(TempAngle)); glEnd;
                  TempAngle := TempAngle + 0.1;
               end;
            end;

         glLineWidth(MainLineWidth);
         glBegin (GL_Lines); glVertex3f( 0, 0, 0); glVertex3f( z.x, z.y, z.z); glEnd;
            if ArrowEnabled then begin
               TempAngle := 0;
               glLineWidth(MinorLineWidth);
               while TempAngle < 2*pi do begin
                  glBegin (GL_Lines); glVertex3f( z.x, z.y, z.z); glVertex3f( z.x+CoefStrelka*sin(TempAngle), z.y+CoefStrelka*cos(TempAngle), z.z-LengthStrelka); glEnd;
                  TempAngle := TempAngle + 0.1;
               end;
            end;
  glEndList();
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
end;

procedure TfrmMain.N111111111Click(Sender: TObject);
begin
   if NumberTurn = 3 then exit;

   if frmParam.RadioGroup1.ItemIndex = 1 then ang1 :=  RotationAngle;
   if frmParam.RadioGroup1.ItemIndex = 0 then ang1 := -RotationAngle;

   Order[NumberTurn] := 1;
   inc(NumberTurn);
end;

procedure TfrmMain.N2222222221Click(Sender: TObject);
begin
   if NumberTurn = 3 then exit;

   if frmParam.RadioGroup2.ItemIndex = 1 then ang2 :=  RotationAngle;
   if frmParam.RadioGroup2.ItemIndex = 0 then ang2 := -RotationAngle;

   Order[NumberTurn] := 2;
   inc(NumberTurn);
end;

procedure TfrmMain.N333333331Click(Sender: TObject);
begin
   if NumberTurn = 3 then exit;

   if frmParam.RadioGroup3.ItemIndex = 1 then ang3 :=  RotationAngle;
   if frmParam.RadioGroup3.ItemIndex = 0 then ang3 := -RotationAngle;

   Order[NumberTurn] := 3;
   inc(NumberTurn);
end;

procedure TfrmMain.TurnX;
var TempAngle : Extended;
    TempVector : TVector;
    EndAngle   : Extended;
begin
   // ------------ Определение Начала участка и конца участка кривой -----------
   TempAngle := 0;
   if Coef = 1 then TempAngle := - ang1;
   if Coef =-1 then TempAngle := - ang1 + 90;

   EndAngle  := TempAngle + ang1 + 90;
   // ----- Проверка на отрицательный угол поворота -------
   if ang1 < 0 then TempAngle := TempAngle + ang1;
   if ang1 < 0 then EndAngle  := EndAngle  - ang1;
   // ------------ Отрисовка кривой -----------
   TempVector.x := 0;
   TempVector.y := L1*cos(TempAngle*pi/180);
   TempVector.z := L1*sin(TempAngle*pi/180);
   TempAngle := TempAngle - DiscretStep;

   glLineWidth(MinorLineWidth);
   glBegin (GL_Line_Strip);
         while TempAngle <= EndAngle do begin
               TempAngle := TempAngle + DiscretStep;
               TempVector.y := L1*cos(TempAngle*pi/180);
               TempVector.z := L1*sin(TempAngle*pi/180);
               glVertex3f( TempVector.x, TempVector.y, TempVector.z);
        end;
   glEnd;
   // ------------ Отрисовка стрелок  -----------
   if ArrowEnabled then begin
         TempAngle := 0;
         glLineWidth(MinorLineWidth);
         while TempAngle < 2*pi do begin
             // ------------ Отрисовка стрелки на главной оси -----------
             glBegin (GL_Lines);
                  glVertex3f( L2, 0, 0);
                  glVertex3f( L2 - LengthStrelka, CoefStrelka*cos(TempAngle) , CoefStrelka*sin(TempAngle));
             glEnd;
             // ------------ Отрисовка стрелок на кривой -----------
             glBegin (GL_Lines);
                     glVertex3f( 0, Coef*L1, 0);
                     glVertex3f( CoefStrelka*sin(TempAngle),Coef*L1 + CoefStrelka*cos(TempAngle) , -Coef*0.2*ang1 * cos(0.2*ang1*pi/180));
             glEnd;
             glBegin (GL_Lines);
                     glVertex3f( 0, 0, L1);
                     glVertex3f( CoefStrelka*sin(TempAngle), 0.2*ang1 * cos(0.2*ang1*pi/180), L1 - CoefStrelka*cos(TempAngle));
             glEnd;
             TempAngle := TempAngle + 0.1;
         end;
   end;
end;

procedure TfrmMain.TurnY;
var TempAngle : Extended;
    TempVector : TVector;
    EndAngle   : Extended;
begin
   // ------------ Определение Начала участка и конца участка кривой -----------
   TempAngle := - ang2;
   EndAngle := TempAngle + ang2 + 90;
   // ----- Проверка на отрицательный угол поворота -------
   if ang2 < 0 then TempAngle := 0;
   if ang2 < 0 then EndAngle  := TempAngle - ang2 + 90;
   // ------------ Отрисовка кривой -----------
   TempVector.x := L1*sin(TempAngle*pi/180);
   TempVector.y := 0;
   TempVector.z := L1*cos(TempAngle*pi/180);
   TempAngle := TempAngle - DiscretStep;

   glLineWidth(MinorLineWidth);
   glBegin (GL_Line_Strip);
         while TempAngle <= EndAngle do begin
               TempAngle := TempAngle + DiscretStep;
               TempVector.x := L1*sin(TempAngle*pi/180);
               TempVector.z := L1*cos(TempAngle*pi/180);
               glVertex3f( TempVector.x, TempVector.y, TempVector.z);
         end;
   glEnd;
   // ------------ Отрисовка стрелок  -----------
   ////////////////////////////////////////////////////////////////////////////////
   if ArrowEnabled then begin
         TempAngle := 0;
         glLineWidth(MinorLineWidth);
         while TempAngle < 2*pi do begin
             // ------------ Отрисовка стрелки на главной оси -----------
             glBegin (GL_Lines);
                  glVertex3f( 0, Coef*L2, 0);
                  glVertex3f( CoefStrelka*sin(TempAngle), Coef*L2 - Coef*LengthStrelka, CoefStrelka*cos(TempAngle));
             glEnd;
             // ------------ Отрисовка стрелок на кривой -----------
               glBegin (GL_Lines);
                     glVertex3f( 0, 0, L1);
                     glVertex3f( -0.2*ang2 * cos(0.2*ang2*pi/180), CoefStrelka*sin(TempAngle), L1 + CoefStrelka*cos(TempAngle));
               glEnd;
               glBegin (GL_Lines);
                     glVertex3f( L1, 0, 0);
                     glVertex3f( L1 - CoefStrelka*cos(TempAngle), CoefStrelka*sin(TempAngle), 0.2*ang2 * cos(0.2*ang2*pi/180));
               glEnd;
               TempAngle := TempAngle + 0.1;
         end;
    end;
end;

procedure TfrmMain.TurnZ;
var TempAngle : Extended;
    TempVector : TVector;
    EndAngle   : Extended;
begin
   // ------------ Определение Начала участка и конца участка кривой -----------
   TempAngle := 0;
   if Coef = 1 then TempAngle := - ang3;
   if Coef =-1 then TempAngle := - ang3 - 90;
   EndAngle := TempAngle + ang3 + 90;

   // ----- Проверка на отрицательный угол поворота -------
   if ang3 < 0 then TempAngle := TempAngle + ang3;
   if ang3 < 0 then EndAngle  := EndAngle  - ang3;
   // ------------ Отрисовка кривой -----------
   TempVector.x := L1*cos(TempAngle*pi/180);
   TempVector.y := L1*sin(TempAngle*pi/180);
   TempVector.z := 0;
   TempAngle := TempAngle - DiscretStep;

   glLineWidth(MinorLineWidth);
   glBegin (GL_Line_Strip);
         while TempAngle <= EndAngle do begin
               TempAngle := TempAngle + DiscretStep;
               TempVector.x := L1*cos(TempAngle*pi/180);
               TempVector.y := L1*sin(TempAngle*pi/180);
               glVertex3f( TempVector.x, TempVector.y, TempVector.z);
         end;
   glEnd;
   // ------------ Отрисовка стрелок  -----------
   if ArrowEnabled then begin
         ////////////////////////////////////////////////////////////////////////////////
         TempAngle := 0;
         glLineWidth(MinorLineWidth);
         while TempAngle < 2*pi do begin
             // ------------ Отрисовка стрелки на глвной оси -----------
             glBegin (GL_Lines);
                  glVertex3f( 0, 0, L2);
                  glVertex3f( CoefStrelka*cos(TempAngle), CoefStrelka*sin(TempAngle), L2 - LengthStrelka);
             glEnd;
             // ------------ Отрисовка стрелок на кривой -----------
               glBegin (GL_Lines);
                     glVertex3f( L1, 0, 0);
                     glVertex3f( L1 + CoefStrelka*cos(TempAngle) , -0.2*ang3 * cos(0.2*ang3*pi/180), CoefStrelka*sin(TempAngle));
               glEnd;
               glBegin (GL_Lines);
                     glVertex3f( 0, Coef*L1, 0);
                     glVertex3f( Coef*0.2*ang3 * cos(0.2*ang3*pi/180), Coef*L1 - CoefStrelka*cos(TempAngle), CoefStrelka*sin(TempAngle));
               glEnd;
               TempAngle := TempAngle + 0.1;
         end;
   end;
end;

procedure TfrmMain.N444441Click(Sender: TObject);
begin
  FillChar(Order, SizeOf(Order),0);
  NumberTurn := 0;
  ang1 := 0;
  ang2 := 0;
  ang3 := 0;
  YAngelCamera := 25;
  XAngelCamera := 25;

  Draw_GL();
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
 frmParam.Show
end;

procedure TfrmMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDown := true;
  StartPosYMouse := Y;
  StartPosXMouse := X;
end;


procedure TfrmMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDown := false;
end;

procedure TfrmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if MouseDown then begin
     YAngelCamera   :=    YAngelCamera -( StartPosYMouse - Y);
     XAngelCamera   :=    XAngelCamera +( StartPosXMouse - X);
     StartPosYMouse := Y;
     StartPosXMouse := X;
 end;
end;

procedure TfrmMain.N2Click(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.z1Click(Sender: TObject);
begin

//  caption := 'asd' + pc[1];

//  frmMain.Handle
end;

end.
