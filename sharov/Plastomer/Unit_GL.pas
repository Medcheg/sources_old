unit Unit_GL;

interface

uses
  Windows, Messages, Classes, Graphics, Forms, ExtCtrls, Controls,
  SysUtils, Dialogs, OpenGL, Math, Menus, MPILasFile, MPIDeclaration,
  StdCtrls, ComCtrls, mpiLibrary;

type
  TfrmGL = class(TForm)
    MainMenu1: TMainMenu;
    N3: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    pnCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lb4: TLabel;
    lb5: TLabel;
    lb6: TLabel;
    pnUpLenght: TPanel;
    lb7: TLabel;
    pnDownLenght: TPanel;
    lb8: TLabel;
    N1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure NSettingsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure pnUpLenghtMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnUpLenghtMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N2Click(Sender: TObject);


 private
    DC                     : HDC;
    hrc                    : HGLRC;

    procedure SetDCPixelFormat;


 public
    R1, R2, R3, R4, R5, R6 : TSeries;
    Az, Zen, Dept          : TSeries;

    RGB1                  : array [1..3] of GLFloat;
    RGB2                  : array [1..3] of GLFloat;


    Alpha, Beta, Radius   : GLFloat;
    _x, _y, _z            : GLFloat;
    Centery               : GLFloat;
    Down                  : Boolean;
    wrkx                  : Integer;
    wrky                  : Integer;
    PointSize             : GLFloat;
    SegRasst              : GLFloat;
    Leftbtn               : Boolean;
    Rightbtn              : Boolean;
    Glub                  : TFloat;
    oldy                  : GLFloat;
    FogFront1, FogFront2  : Single;
    Start                 : Single;
    Flag_Fog              : Boolean;
    IKS                   : Integer;
    st                    : integer;
    fin                   : integer;
    pnUpLenghtDown        : Boolean;
    pnDownLenghtDown      : Boolean;
    pnUpLenghtwrky        : Integer;
    panclck               : boolean;
    autoLinearSpeed       : Boolean;
    AutoAngle             : Boolean;
    AngleSpeed            : GLFloat;
    LinearSpeed           : Integer;
    pos                   : Array [0..3]  of GLFloat;
    pos1                  : Array [0..3]  of GLFloat;

    Procedure DrawKern(R1:GLFloat;R2:GLFloat;R3:GLFloat;R4:GLFloat;R5:GLFloat;R6:GLFloat;Sdvig:GLFloat;mode:GLEnum;sr:Boolean);
    procedure VectorToNormal(Radius : GLFloat; Alpha : GLFloat; Beta : GLFloat);
    procedure NormalToVector(_x : GLFloat; _y : GLFloat; _z : GLFloat);
    procedure DrawKoordinatLines;
    procedure DisplayKompass;
    procedure DrawZaboy;
    procedure DisplayUp;
    procedure myinit;


 protected
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
end;

const red      : Array [0..3] of GLfloat  = (1, 0 ,0, 1);
      blue     : Array [0..3] of GLfloat  = (0, 0 ,1, 1);
      black    : Array [0..3] of GLfloat  = (0, 0 ,0, 1);

      ambFront : Array [0..3]  of GLfloat = (0.0, 0.0, 1.0, 1.0);
      ambBack  : Array [0..3]  of GLfloat = (1.0, 0.0, 0.0, 1.0);


var
  frmGL : TfrmGL;
implementation

uses  YMKLibrary, Unit_Main, Unit_GLVizualZaboyParams, Unit_GLAutoSet,
  Unit_GLSearchDepthValue, Unit_GLSetColor, mpiReportClass;
{$R *.DFM}

{===============================================================================
}
procedure TfrmGL.DisplayUp;
begin
   glViewPort (8, 133, 104, 105);
   glScissor  (8, 133, 104, 105);
   glClearColor(0.2, 0, 0.8, 0);
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

   glViewPort (9, 134, 102, 102);
   glScissor  (9, 134, 102, 102);
   glClearColor(0.6, 0.6, 1.0, 0);
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

   glViewPort (10, 135, 100, 100);
   glScissor  (10, 135, 100, 100);
   glClearColor(0.6, 0.6, 0.6, 0.8);
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  glPushMatrix;
    //gluPerspective(30,ClientWidth/ClientHeight,1,15);
    gluLookAt(0, -2, 2,   0,0,0,   0.0,1.0,0.0);
    glRotatef (180,0,1,0);
    glRotatef (-(Beta*180/Pi),0,1,0);
    glScale(0.5,0.5,0.5);
    glColor4f (1,0,0,1);
    glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, @red);
    glBegin (GL_TRIANGLE_STRIP);
      glVertex4f (0.2,  -0.1,    0, 1);
      glVertex4f (0,    -0.1,   -1, 1);
      glVertex4f (-0.2, -0.1,    0, 1);
    glEnd;

    glDisable(GL_Lighting);
    glColor4f (0,0,1,1);
    glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, @blue);
////////////////////////////////////quadric
{   glPushMatrix;
    gluQuadricDrawStyle (quadObj, GLU_FILL);
    glColor3f (1.0, 1.0, 1.0);

    glRotatef (90,1,0,0);
//    glRotatef (30,0,1,0);
//    glRotatef (30,0,0,1);

    gluDisk (quadObj, 0.0, 0.8, 360, 1);
   glPopMatrix; }
///////////////////////endQuadric


     glColor3f(0,0,1);
    glBegin (GL_TRIANGLE_STRIP);
      glVertex4f ( 0.2,  -0.1,  0, 1);
      glVertex4f (-0.2,  -0.1,  0, 1);
      glVertex4f ( 0,    -0.1,  1, 1);
    glEnd;
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightfv (GL_LIGHT0, GL_POSITION, @Position );

    glRotatef ((Beta*180/Pi),0,1,0);
    glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, @black);
    glColor4f(0.3,0.3,0.3,1);
    glBegin (GL_QUAD_STRIP);
      glVertex4f (1,  0, -1, 0.5);
      glVertex4f (-1, 0, -1, 0.5);
      glVertex4f (1,  0,  1, 0.5);
      glVertex4f (-1, 0,  1, 0.5);
    glEnd;

    glScale(2,2,2);
  glPopMatrix;
  glEnable(GL_Lighting);
end;

{===============================================================================
}
procedure TfrmGL.DisplayKompass;
begin
//  glViewPort (8, 8, 104, 105);
 // glScissor  (8, 8, 104, 105);
 // glClearColor(0.2, 0, 0.8, 0);
 // glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

 // glViewPort (9, 9, 102, 102);
  //glScissor  (9, 9, 102, 102);
 // glClearColor(0.6, 0.6, 1.0, 0);
 // glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

 // glViewPort (10, 10, 100, 100);
  //glScissor  (10, 10, 100, 100);
 // glClearColor(0.1, 0.1, 0.1, 1);
 // glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

{  glPushMatrix;
    gluLookAt(0, -3, 1,   0,0,0,   0.0,1.0,0.0);
    glRotatef (90,0,1,0);
    glRotatef (-(Beta*180/Pi),0,1,0);
    glScale(2,2,2);
    glColor4f (1,0,0,1);
    glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, @red);
    glBegin (GL_TRIANGLE_STRIP);
      glVertex4f (0.2,  -0.1,    0, 1);
      glVertex4f (0,    -0.1,   -1, 1);
      glVertex4f (-0.2, -0.1,    0, 1);
    glEnd;

    glColor4f (0,0,1,1);
    glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, @blue);
    glBegin (GL_TRIANGLE_STRIP);
      glVertex4f ( 0.2,  -0.1,  0, 1);
      glVertex4f (-0.2,  -0.1,  0, 1);
      glVertex4f ( 0,    -0.1,  1, 1);
    glEnd;
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightfv (GL_LIGHT0, GL_POSITION, @Position );


    glRotatef ((Beta*180/Pi),0,1,0);
    glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, @black);
    glColor4f(0.3,0.3,0.3,1);
    glBegin (GL_QUAD_STRIP);
      glVertex4f (1,  0, -1, 0.5);
      glVertex4f (-1, 0, -1, 0.5);
      glVertex4f (1,  0,  1, 0.5);
      glVertex4f (-1, 0,  1, 0.5);
    glEnd;

    glScale(0.5,0.5,0.5);
  glPopMatrix; }
end;

{===============================================================================
FOG}
procedure TfrmGL.myinit;
const
 fogColor : Array [0..3] of GLFloat = (0.0, 0.0, 0.0, 1.0);
begin
{ glEnable(GL_FOG);
 glFogi (GL_FOG_MODE, GL_LINEAR);
 glHint (GL_FOG_HINT, GL_NICEST);  //  per pixel
 glFogf (GL_FOG_START, FogFront1);
 glFogf (GL_FOG_END, FogFront2);
 glFogfv (GL_FOG_COLOR, @fogColor);
 glClearColor(0.0, 0.0, 0.0, 1.0);

 glDepthFunc(GL_LESS);
 glEnable(GL_DEPTH_TEST);
 glShadeModel(GL_FLAT);   }
end;

{===============================================================================
Draw Zaboy}
procedure TFrmGL.DrawZaboy;
var  i    : Integer;
     diam :  Extended;
     rad : EXTENDED;
begin
  diam := TMidleRadius(ReportClass.PoleList.Items[3]).NominalDiametr;
  rad := diam /2;
  Glub := 0;

  glBegin (GL_LINES);
    glVertex3f (0,0,0);
    glVertex3f (0,0,150);
  glEnd;


  for i := st to  fin do begin
    if (R1.Data^[i]  <> R1.NullValue)AND
       (R2.Data^[i]  <> R2.NullValue)AND
       (R3.Data^[i]  <> R3.NullValue)AND
       (R4.Data^[i]  <> R4.NullValue)AND
       (R5.Data^[i]  <> R5.NullValue)AND
       (Az.Data^[i]  <> Az.NullValue)AND
       (Zen.Data^[i] <> Zen.NullValue)AND
       (Dept.Data^[i]<> Dept.NullValue)AND
       (R6.Data^[i]  <> R6.NullValue) AND

       (R1.Data^[i]  <> 0)AND
       (R2.Data^[i]  <> 0)AND
       (R3.Data^[i]  <> 0)AND
       (R4.Data^[i]  <> 0)AND
       (R5.Data^[i]  <> 0)AND
       (Az.Data^[i]  <> 0)AND
       (Zen.Data^[i] <> 0)AND
       (Dept.Data^[i]<> 0)AND
       (R6.Data^[i]  <> 0) then begin



       if N7.Checked = true then begin
           glPushMatrix;
           glRotatef (Az.Data^[i],0,1,0);
           glRotatef (Zen.Data^[i],0,0,1);
       end;

       Glub := Glub + SegRasst;
       if i = ((st+300) ) then  begin
       ScrollBar1.Position := i;
       Panel1.Caption := FloatToStr(trunc((i+300)/LasFile.XValue.Count*100))+' %';
          glColor3f(1,0,0);
          DrawKern((R1.Data^[i])*2,
                   (R2.Data^[i])*2,
                   (R3.Data^[i])*2,
                   (R4.Data^[i])*2,
                   (R5.Data^[i])*2,
                   (R6.Data^[i])*2,Glub,GL_Points,true);

//          ColorToGL (frmGLSetColor.ColorDialog2.Color, RGB2[1],RGB2[2],RGB2[3]);
          glColor3f (0,1,0);
       end;

       DrawKern((R1.Data^[i]),
                (R2.Data^[i]),
                (R3.Data^[i]),
                (R4.Data^[i]),
                (R5.Data^[i]),
                (R6.Data^[i]),Glub,GL_Line_Strip,False);
          glColor3f (0,1,0);

        glDisable (GL_Lighting);
       glColor3f (1,0,0);
       DrawKern(rad,
                rad,
                rad,
                rad,
                rad,
                rad,Glub,GL_Line_Strip,False);
       glColor3f (0,1,0);
       glEnable (GL_Lighting);

       if N7.Checked = true then begin
          glPopMatrix;
       end;

    end;
  end;
end;

{===============================================================================
Рисование рельефа забоя}
procedure TfrmGL.DrawKern(R1:GLFloat;R2:GLFloat;R3:GLFloat;R4:GLFloat;R5:GLFloat;R6:GLFloat;Sdvig:GLFloat;mode:GLenum;sr:Boolean);
begin
  glLineWidth (2);
  glBegin(GL_Points);
   glNormal3f(0,0,1);
    glVertex3f(R1*sin(Pi*1/3), Sdvig, R1*cos(Pi*1/3));
    glVertex3f(R2*sin(Pi*2/3), Sdvig, R2*cos(Pi*2/3));
    glVertex3f(R3*sin(Pi*3/3), Sdvig, R3*cos(Pi*3/3));
    glVertex3f(R4*sin(Pi*4/3), Sdvig, R4*cos(Pi*4/3));
    glVertex3f(R5*sin(Pi*5/3), Sdvig, R5*cos(Pi*5/3));
    glVertex3f(R6*sin(Pi*6/3), Sdvig, R6*cos(Pi*6/3));
  glEnd;

  if (frmGLVizualZaboyParams.Radius_Enabled[1]) OR (sr = true) then begin
  glBegin(mode);
  glNormal3f(0,0,1);
    glVertex3f(R1*sin(Pi*1/3), Sdvig, R1*cos(Pi*1/3));
    glVertex3f(((R1+R1+R2)/3)*sin(Pi*1.25/3), Sdvig, ((R1+R1+R2)/3)*cos(Pi*1.25/3));
    glVertex3f(((R1+R2)/2)*sin(Pi*1.5/3),     Sdvig, ((R1+R2)/2)*cos(Pi*1.5/3));
    glVertex3f(((R1+R2+R2)/3)*sin(Pi*1.75/3), Sdvig, ((R1+R2+R2)/3)*cos(Pi*1.75/3));
    glVertex3f(R2*sin(Pi*2/3), Sdvig, R2*cos(Pi*2/3));
  glEnd;
  end;

  if (frmGLVizualZaboyParams.Radius_Enabled[2]) OR (sr = true) then begin
  glBegin(mode);
  glNormal3f(0,0,1);
    glVertex3f(R2*sin(Pi*2/3), Sdvig, R2*cos(Pi*2/3));
    glVertex3f(((R2+R2+R3)/3)*sin(Pi*2.25/3), Sdvig, ((R2+R2+R3)/3)*cos(Pi*2.25/3));
    glVertex3f(((R2+R3)/2)*sin(Pi*2.5/3),     Sdvig, ((R2+R3)/2)*cos(Pi*2.5/3));
    glVertex3f(((R2+R3+R3)/3)*sin(Pi*2.75/3), Sdvig, ((R2+R3+R3)/3)*cos(Pi*2.75/3));
    glVertex3f(R3*sin(Pi*3/3), Sdvig, R3*cos(Pi*3/3));
  glend;
  end;

  if (frmGLVizualZaboyParams.Radius_Enabled[3]) OR (sr = true) then begin
  glBegin(mode);
  glNormal3f(0,0,1);
    glVertex3f(R3*sin(Pi*3/3), Sdvig, R3*cos(Pi*3/3));
    glVertex3f(((R3+R3+R4)/3)*sin(Pi*3.25/3), Sdvig, ((R3+R3+R4)/3)*cos(Pi*3.25/3));
    glVertex3f(((R3+R4)/2)*sin(Pi*3.5/3),     Sdvig, ((R3+R4)/2)*cos(Pi*3.5/3));
    glVertex3f(((R3+R4+R4)/3)*sin(Pi*3.75/3), Sdvig, ((R3+R4+R4)/3)*cos(Pi*3.75/3));
    glVertex3f(R4*sin(Pi*4/3), Sdvig, R4*cos(Pi*4/3));
  glend;
  end;

  if (frmGLVizualZaboyParams.Radius_Enabled[4]) OR (sr = true) then begin
  glBegin(mode);
  glNormal3f(0,0,1);
    glVertex3f(R4*sin(Pi*4/3), Sdvig, R4*cos(Pi*4/3));
    glVertex3f(((R4+R4+R5)/3)*sin(Pi*4.25/3), Sdvig, ((R4+R4+R5)/3)*cos(Pi*4.25/3));
    glVertex3f(((R4+R5)/2)*sin(Pi*4.5/3),     Sdvig, ((R4+R5)/2)*cos(Pi*4.5/3));
    glVertex3f(((R4+R5+R5)/3)*sin(Pi*4.75/3), Sdvig, ((R4+R5+R5)/3)*cos(Pi*4.75/3));
    glVertex3f(R5*sin(Pi*5/3), Sdvig, R5*cos(Pi*5/3));
  glend;
  end;

  if (frmGLVizualZaboyParams.Radius_Enabled[5]) OR (sr = true) then begin
  glBegin(mode);
  glNormal3f(0,0,1);
    glVertex3f(R5*sin(Pi*5/3), Sdvig, R5*cos(Pi*5/3));
    glVertex3f(((R5+R5+R6)/3)*sin(Pi*5.25/3), Sdvig, ((R5+R5+R6)/3)*cos(Pi*5.25/3));
    glVertex3f(((R5+R6)/2)*sin(Pi*5.5/3),     Sdvig, ((R5+R6)/2)*cos(Pi*5.5/3));
    glVertex3f(((R5+R6+R6)/3)*sin(Pi*5.75/3), Sdvig, ((R5+R6+R6)/3)*cos(Pi*5.75/3));
    glVertex3f(R6*sin(Pi*6/3), Sdvig, R6*cos(Pi*6/3));
  glEnd;
  end;

  if (frmGLVizualZaboyParams.Radius_Enabled[6]) OR (sr = true) then begin
  glBegin(mode);
  glNormal3f(0,0,1);
    glVertex3f(R6*sin(Pi*6/3), Sdvig, R6*cos(Pi*6/3));
    glVertex3f(((R6+R6+R1)/3)*sin(Pi*6.25/3), Sdvig, ((R6+R6+R1)/3)*cos(Pi*6.25/3));
    glVertex3f(((R6+R1)/2)*sin(Pi*6.5/3),     Sdvig, ((R6+R1)/2)*cos(Pi*6.5/3));
    glVertex3f(((R6+R1+R1)/3)*sin(Pi*6.75/3), Sdvig, ((R6+R1+R1)/3)*cos(Pi*6.75/3));
    glVertex3f(R1*sin(Pi*1/3), Sdvig, R1*cos(Pi*1/3));
  glEnd;
  end;
end;

{===============================================================================
Процедура перевода из декартовой в полярную систему}
procedure TfrmGL.NormalToVector(_x : GLFloat; _y : GLFloat; _z : GLFloat);
var Rad_z_x : GLFloat;

begin
  Radius  := sqrt   (_x*_x + _y*_y + _z*_z);
  Rad_Z_X := sqrt   (_z*_z + _x*_x);
  Alpha   := arccos (Rad_z_x/Radius);
  Beta    := arccos (_x/Rad_z_x);

  if _z > 0 then Beta  := 2*Pi -Beta;
  if _y < 0 then Alpha := 2*Pi -Alpha;
end;

{===============================================================================
Процедура перевода из полярной в декартову систему}
procedure TfrmGL.VectorToNormal(Radius : GLFloat; Alpha : GLFloat; Beta : GLFloat);
begin
  _x :=  Radius*cos(Alpha)*cos(beta);
  _y :=  Radius*sin(Alpha);
  _z := -Radius*cos(Alpha)*sin(beta);
end;

{===============================================================================
Рисование координат}
procedure TfrmGL.DrawKoordinatLines;
begin
   glBegin (GL_Lines);
    glColor3f (1,0,0);
    glVertex3f(0,0,0);
    glVertex3f(20,0,0);
  glEnd;

  glBegin (GL_Lines);
    glColor3f (0,1,0);
    glVertex3f(0,0,0);
    glVertex3f(0,20,0);
  glEnd;

  glBegin (GL_Lines);
    glColor3f (0,0,1);
    glVertex3f(0,0,0);
    glVertex3f(0,0,20);
  glEnd;
  glColor3f (0,1,0);
end;

{===============================================================================
Перерисовка окна}
procedure TfrmGL.WMPaint(var Msg: TWMPaint);
var ps  : TPaintStruct;
begin
  BeginPaint(Handle, ps);

  glPushMatrix;
    glViewPort (0, 0, frmGL.Width, frmGL.Height);
    glScissor  (0, 0, frmGL.Width, frmGL.Height);

    glClearColor(0.5, 0.5, 0.5,1);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);


  glPushMatrix;
    if AutoAngle = true then begin
       NormalToVector(_x,_y,_z);
       Beta := Beta - AngleSpeed;
       VectorToNormal(Radius, Alpha, Beta);
    end;

    if AutoLinearSpeed = true then begin
       st := st+ LinearSpeed;
       if st >= R1.Count-1-600 then st := R1.Count-1-600;
       _y :=  0;
       Centery := 0;
       fin := fin +LinearSpeed;
       if fin >= R1.Count-1 then fin := R1.Count-1;
    end;

    gluLookAt (_x, 200, _z,   IKS, 200, 0,   0,1,0);
     glScalef (0.1, 0.1, 0.1);
 ////////////////////////////////////////////////////////

     glMaterialfv(GL_Front, GL_Diffuse, @Black);
     glMaterialfv(GL_Back,  GL_Diffuse,  @blue);

     glMatrixMode (GL_Projection);

     pos[0] := 10;
     pos[1] := -1;
     pos[2] := 10;
     pos[3] := 1;

     pos1[0] :=  -10;
     pos1[1] := -0.5;
     pos1[2] :=  -10;
     pos1[3] :=    1;


     glLightfv(GL_Light0, GL_POSITION, @pos);
     glLightfv(GL_Light1, GL_POSITION, @pos1);
     glMatrixMode (GL_Modelview);


/////////////////////////////////////////////////


     GLEnable(GL_POINT_SMOOTH);
     glColor3f(0,0.8,0.0);

     GLPointSize(PointSize);
     glPushMatrix;
     DrawZaboy;
     glPopmatrix;
     glScalef (10,10,10);
   glPopmatrix;

//  if N8.Checked =true then begin
    DisplayUp;
//  end;

    GLDisable(GL_POINT_SMOOTH);
  glPopMatrix;


  Caption := 'Трехмерная модель скважины- '+frmMain.Caption;// +FloatToStr(_z);

  SwapBuffers(DC);

  lb4.Caption := FloatToStr (Az.  Data^[st+300]);
  lb5.Caption := FloatToStr (Zen. Data^[st+300]);
  lb6.Caption := FloatToStr (Dept.Data^[st+300]);
  lb7.Caption := FloatToStr (Dept.Data^[st]);
  lb8.Caption := FloatToStr (Dept.Data^[fin]);

  EndPaint(Handle, ps);
  InvalidateRect(Handle, nil, False);


  Label1.Refresh;
  Label2.Refresh;
  Label3.Refresh;
  lb4.Refresh;
  lb5.Refresh;
  lb6.Refresh;
  lb7.Refresh;
  lb8.Refresh;
  panel1.refresh;
  ScrollBar1.Refresh;
end;

{===============================================================================
Создание окна}
procedure TfrmGL.FormCreate(Sender: TObject);

const amb_dif : Array [0..3] of GLfloat = (0.2,0.8,1.0,1.0);
      spec    : Array [0..3] of GLfloat = (1.0,1.0,1.0,1.0);

begin

  ScrollBar1.Position := 300;

  st  := ScrollBar1.Position -300;
  fin := ScrollBar1.Position +300;

  AngleSpeed := 0.1;
  LinearSpeed := 10;

  panclck  := false;
  pnUpLenghtDown    := false;
  pnDownLenghtDown  := false;
  _X := 0;
  _Y := 0;
  _Z := 580;//80
  IKS:= 0;

  Start := 80;
  st := 0;
  fin := 600;

  fogFront1 :=65; //355;
  fogFront2 :=85;//375;

  Centery := 0;

  Flag_Fog := false;

  DC := GetDC(Handle);
  try
    SetDCPixelFormat;
    hrc := wglCreateContext(DC);
    wglMakeCurrent(DC, hrc);
  except   MessageDlg('Конфигурация вашего компьютера не поддерживает отображение в трехмерном режиме скважины, смотрите руководство пользователя -> Kонфигурация оборудования.', mtError, [mbOk], 0);
  end;

  glEnable(GL_SCISSOR_TEST);
  glEnable (GL_COLOR_MATERIAL);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glEnable(GL_DEPTH_TEST);
  gLEnable(GL_Light1);
end;

{===============================================================================
Обработка нажатия клавиши}
procedure TfrmGL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : Close;

    VK_UP     : begin
                  oldy := _y;
                  NormalToVector(_x,0,_z);
                  radius := radius -20;
                  if Radius  < 20 then Radius := 20;
                  VectorToNormal(Radius, Alpha, Beta);
                  _Y := oldy;
                  centery := _y;
                end;

    VK_Down   : begin
                  oldy := _y;
                  NormalToVector(_x,0,_z);
                  radius := radius +20;
                  VectorToNormal(Radius, Alpha, Beta);
                  _Y := oldy;
                  centery := _y;
               end;

    VK_Left   : begin

                end;

    VK_Right   : begin

                end;

  end;
end;

{===============================================================================
Устанавливаем формат пикселей}
procedure TfrmGL.SetDCPixelFormat;
var nPixelFormat: Integer;
    pfd: TPixelFormatDescriptor;

begin
  try
    FillChar(pfd, SizeOf(pfd), 0);
    pfd.dwFlags   := PFD_DRAW_TO_WINDOW or
                     PFD_SUPPORT_OPENGL or
                     PFD_DOUBLEBUFFER;
    pfd.cDepthBits:= 32;


    nPixelFormat := ChoosePixelFormat(DC, @pfd);
    SetPixelFormat(DC, nPixelFormat, @pfd);
  except
    MessageDlg('Конфигурация вашего компьютера не поддерживает отображение в трехмерном режиме скважины, смотрите руководство пользователя -> Kонфигурация оборудования.', mtError, [mbOk], 0);
  end;
end;

{===============================================================================
Изменение размеров окна}
procedure TfrmGL.FormResize(Sender: TObject);
begin
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  glViewport(0,0,frmGL.Width-28, frmGL.ClientHeight);
  gluPerspective (-30.0, ClientWidth / ClientHeight, 1.0, 2000.0);
  glMatrixMode (GL_MODELVIEW);
  glLoadIdentity;
  InvalidateRect(Handle, nil, False);
end;

{===============================================================================
Мыша нажата}
procedure TfrmGL.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  case Button of
       mbRight : begin
                   Leftbtn  := false;
                   Rightbtn :=  true;
                   Down := true;
                   Wrkx := x;
                   wrky := y;
                   frmGLSearchDepthValue.Showmodal;
                 end;

       mbLeft  : begin
                   Leftbtn  := true;
                   Rightbtn := false;
                   Down := true;
                   Wrkx := x;
                   wrky := y;
                 end;
  end;
end;

{===============================================================================
Мышу отпустили}
procedure TfrmGL.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Down := false;
end;

{===============================================================================
Движение мышей}
procedure TfrmGL.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
//var ch : integer;
begin
//  ch := 30;
  if (Down) AND (Leftbtn) then begin
    NormalToVector(_x,_y,_z);
    Beta := Beta + (x-wrkx)/70;
    VectorToNormal(Radius, Alpha, Beta);
    centery := _y;
    wrkX := X;

  end
    else
     { if (Down) AND (Rightbtn) then begin
       if y > wrky then begin
         st      := st-ch;
         if st <0 then st := 0;
         _y      := 0;
         Centery := 0;
         fin     := fin -ch;
         if fin <600 then fin := 600;
       end else
            if y < wrky then begin
              st := st+ch;
              if st >= LasFile.XValue.Count-1-600 then st := LasFile.XValue.Count-1-600;
              _y :=  0;
              Centery := 0;
              fin := fin +ch;
              if fin >= LasFile.XValue.Count-1 then fin := LasFile.XValue.Count-1;
            end;
       wrky := y;
      end; }
end;

{===============================================================================
Настройки}
procedure TfrmGL.NSettingsClick(Sender: TObject);
begin
end;

{===============================================================================
frmGL Form Show}
procedure TfrmGL.FormShow(Sender: TObject);

var i      : integer;
    Series : TSeries;
begin
  LoadIniFile;
  frmGL.WindowState := wsMaximized;
  pnCentral.Left := 9;
  frmGL.pnCentral.Top  := frmGL.ClientHeight-frmGL.pnCentral.Height -12;

  pnUpLenght.Top := 0;
  pnDownLenght.Top := frmGL.Height-(pnDownLenght.Width+1);

  pnUpLenght.Left := ((frmGL.Height div 2) + (pnUpLenght.Height div 2)) div 2;
  pnDownLenght.Left := ((frmGL.Height div 2) + (pnUpLenght.Height div 2)) div 2;

  lb4.Width := 50;
  lb5.Width := 50;
  lb6.Width := 50;

  PointSize := StrToInt(frmGLVizualZaboyParams.edPointSize.Text);
  SegRasst := StrToInt (frmGLVizualZaboyParams.edSegmentRasst.Text);
  for i := 0 to LasFile.SeriesList.Count - 1 do begin
    Series := TSeries(LasFile.SeriesList.Items[i]);

    if UpperCase(Series.Name) = 'RAD1' then R1    := Series;
    if UpperCase(Series.Name) = 'RAD2' then R2    := Series;
    if UpperCase(Series.Name) = 'RAD3' then R3    := Series;
    if UpperCase(Series.Name) = 'RAD4' then R4    := Series;
    if UpperCase(Series.Name) = 'RAD5' then R5    := Series;
    if UpperCase(Series.Name) = 'RAD6' then R6    := Series;
    if UpperCase(Series.Name) = 'AZIM' then Az    := Series;
    if UpperCase(Series.Name) = 'DEVI' then Zen   := Series;
    if UpperCase(Series.Name) = 'DEPT' then Dept  := Series;
  end;
end;

{===============================================================================
Close form}
procedure TfrmGL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveIniFile;
end;

{===============================================================================
}
procedure TfrmGL.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC (DC);
end;

{===============================================================================
}
procedure TfrmGL.N15Click(Sender: TObject);
begin
end;

{===============================================================================
}
procedure TfrmGL.N6Click(Sender: TObject);
begin
  frmGLAutoSet.ShowModal;
end;

{===============================================================================
}
procedure TfrmGL.N5Click(Sender: TObject);
begin
  if autoLinearSpeed = false then begin
    autoLinearSpeed := true;
    frmGL.N5.Checked := true;
  end
  else begin
         autoLinearSpeed := false;
         frmGL.N5.Checked:= false;
       end;
end;

{===============================================================================
}
procedure TfrmGL.N8Click(Sender: TObject);
begin

end;

{===============================================================================
}
procedure TfrmGL.N7Click(Sender: TObject);
begin
    if N7.Checked = true then N7.Checked := false
    else if N7.Checked = false then N7.Checked := true;

end;

{===============================================================================
}
procedure TfrmGL.N22Click(Sender: TObject);
begin
  frmGLVizualZaboyParams.ShowModal;
end;

{===============================================================================
}
procedure TfrmGL.pnUpLenghtMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

{===============================================================================
}
procedure TfrmGL.pnUpLenghtMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

{===============================================================================
}
procedure TfrmGL.N1Click(Sender: TObject);
begin
  if autoAngle = false then begin
    autoAngle := true;
    frmGL.N1.Checked := true;
  end

  else begin autoAngle := false;
             frmGL.N1.Checked := false;
  end;

end;

{===============================================================================
}
procedure TfrmGL.ScrollBar1Change(Sender: TObject);
begin
///////////////
  ScrollBar1.Enabled := true;

  ScrollBar1.Min         := 0;
  ScrollBar1.Max         := LasFile.XValue.Count-300;
  ScrollBar1.LargeChange := Round(ScrollBar1.Max/100);

  if ScrollBar1.Position <=300 then ScrollBar1.Position := 300;


  st  := ScrollBar1.Position -300;
  fin := ScrollBar1.Position +300;

  InvalidateRect(Handle, nil, False);
//////////////
end;

{===============================================================================
}
procedure TfrmGL.ScrollBar1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE : Close;
///
    VK_UP     : begin
                  oldy := _y;
                  NormalToVector(_x,0,_z);
                  radius := radius -20;
                  if Radius  < 20 then Radius := 20;
                  VectorToNormal(Radius, Alpha, Beta);
                  _Y := oldy;
                  centery := _y;
                end;
///
    VK_Down   : begin
                  oldy := _y;
                  NormalToVector(_x,0,_z);
                  radius := radius +20;
                  VectorToNormal(Radius, Alpha, Beta);
                  _Y := oldy;
                  centery := _y;
                end;
///
    VK_Left   : begin

                end;
///
    VK_Right  : begin

                end;

  end;

end;

{===============================================================================
}
procedure TfrmGL.N2Click(Sender: TObject);
begin
  frmGLSetColor.ShowModal;
end;

{===============================================================================
}
end.

