unit unit_GL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, OpenGL;

type
  Float = Single;

  TfrmGL = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    DC                     : HDC;
    hrc                    : HGLRC;
  public
    Procedure Draw_GL(ang1, ang2, ang3 : Float);
  end;

var
  frmGL: TfrmGL;

implementation

{$R *.DFM}

procedure TfrmGL.Draw_GL(ang1, ang2, ang3: Float);
begin
   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

   glPushMatrix;
         gluLookAt(25,10,30, 0,0,0, 0,1,0);

         glPushMatrix;
               glRotatef(30*sin(ang1*90*pi/180+ 0.13*sin(ang1*3 + 45*pi/180)), 1,  0, 0);

               glColor3f (1,1,0);
               glBegin (GL_Lines);  glVertex3f(20, 0, 0); glVertex3f(35,0,0); glEnd;
               glBegin (GL_Lines);  glVertex3f(-20, 0, 0); glVertex3f(-35,0,0); glEnd;

               glBegin (GL_Line_Loop);
                     glColor3f (1,0,0);
                     glVertex3f( 20, 0, 20);
                     glVertex3f( 20, 0,-20);
                     glVertex3f(-20, 0,-20);
                     glVertex3f(-20, 0, 20);
               glEnd;

               glPushMatrix;
                     glRotatef(30*sin(ang2*90*pi/180 + 0.13*sin(ang2*5) + 45*pi/180), 0,  0, 1);

                     glColor3f (1,1,0);
                     glBegin (GL_Lines);  glVertex3f(0,0, 10); glVertex3f(0,0, 20); glEnd;
                     glBegin (GL_Lines);  glVertex3f(0,0,-10); glVertex3f(0,0,-20); glEnd;

                     glBegin (GL_Line_Loop);
                           glColor3f (0,0,1);
                           glVertex3f( 10, 0, 10);
                           glVertex3f( 10, 0,-10);
                           glVertex3f(-10, 0,-10);
                           glVertex3f(-10, 0, 10);
                     glEnd;
                      glPushMatrix;
                           glRotatef(ang3*150, 0,  1, 0);
                           glColor3f (0,  1, 0);
                           glBegin (GL_Lines); glVertex3f( 0, 0, 0); glVertex3f( 0, 20,0); glEnd;
                           glBegin (GL_Lines); glVertex3f(5, 20,0); glVertex3f(-5, 20,0); glEnd;

                           glColor3f (0,  0.5, 0.5);
                           glBegin (GL_Lines);
                               glVertex3f( 7, 27,0); glVertex3f( 5, 20,0);
                               glVertex3f( 5, 20,0); glVertex3f( 7, 13,0);
                           glEnd;

                           glBegin(GL_QUADS);
                               glVertex3f(-4, 25, 6);
                               glVertex3f(-6, 15, 6);
                               glVertex3f(-6, 15,-6);
                               glVertex3f(-4, 25,-6);
                           glEnd();
                     glPopMatrix;
               glPopMatrix;
         glPopMatrix;




   glPopMatrix;

   SwapBuffers(DC);
end;

procedure TfrmGL.FormCreate(Sender: TObject);
var nPixelFormat: Integer;
    pfd: TPixelFormatDescriptor;
begin
  DC  := GetDC(Handle);

  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags   := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  nPixelFormat  := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);

  hrc := wglCreateContext(DC); wglMakeCurrent(DC, hrc);
end;

procedure TfrmGL.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC (DC);
end;

procedure TfrmGL.FormShow(Sender: TObject);
begin
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 glOrtho(-40,40,-40,40,-70,70);
// gluPerspective (1000.0, ClientWidth / ClientHeight, 1.0, 1000.0);
 glMatrixMode (GL_MODELVIEW);
 glLoadIdentity;
 InvalidateRect(Handle, nil, False);

  glViewport(0, 0, ClientWidth, ClientHeight);
  glClearColor(0, 0, 0,1);
  glEnable(GL_DEPTH_TEST);

  glLineWidth(3);
end;

end.
