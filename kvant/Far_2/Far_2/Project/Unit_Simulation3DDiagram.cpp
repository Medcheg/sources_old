//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit_Simulation3DDiagram.h"
#include "mpiDeclaration.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmSimulation3DDiagram *frmSimulation3DDiagram;

typedef struct { float x, y, z; }Vector3D;
//---------------------------------------------------------------------------
__fastcall TfrmSimulation3DDiagram::TfrmSimulation3DDiagram(TComponent* Owner)
        : TForm(Owner)
{
}

//---------------------------------------------------------------------------
void __fastcall TfrmSimulation3DDiagram::FormShow(TObject *Sender)
{
   xOffset = 0;
   yOffset = 0;
   zOffset = 0;

   xAngle = 25;
   zAngle = 0;

   OldMouseX = -1;
   OldMouseY = -1;

   MouseDown = false;
   CreateGLContex();
   CreateList();
   FormResize(Sender);

}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulation3DDiagram::FormClose(TObject *Sender,
      TCloseAction &Action)
{
    wglMakeCurrent  (0, 0);
    wglDeleteContext(hrc);
    ReleaseDC       (Handle, hdc);
    DeleteDC        (hdc);
}
//---------------------------------------------------------------------------


void __fastcall TfrmSimulation3DDiagram::FormResize(TObject *Sender)
{
    int w = ClientWidth;
    int h = ClientHeight;

    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    glOrtho (-7, 7, -3, 8, -7, 7);
//    glOrtho (-15, 15, -15, 15, -15, 15);

    glMatrixMode(GL_MODELVIEW);

    glClearColor(0.3, 0.3, 0.3,1);


//    glViewport(0, 0, w, h);
//    glMatrixMode(GL_PROJECTION);
//    glLoadIdentity();
//    glMatrixMode(GL_MODELVIEW);
//    glMatrixMode(GL_MODELVIEW);
    //++++++++++++++++++++++++++++++++++++++++++
    //++++++++++++++++++++++++++++++++++++++++++
    //++++++++++++++++++++++++++++++++++++++++++
//    GLfloat AmbientLightPosition[] = {14.5, 15.0, 10.0, 0.0};
//    glLightfv(GL_LIGHT0, GL_POSITION, AmbientLightPosition);
 //     GLfloat LightAmbient[] = {0.5, 0.5, 0.5, 1.0};

      glEnable(GL_LIGHTING);
      glEnable(GL_LIGHT0);
//      glEnable(GL_COLOR_MATERIAL);

 //     glLightModelfv (GL_LIGHT_MODEL_AMBIENT, LightAmbient);
 //     glColorMaterial(GL_FRONT, GL_AMBIENT_AND_DIFFUSE);

      glEnable(GL_NORMALIZE);
//      glEnable(GL_CULL_FACE);
      glEnable(GL_DEPTH_TEST);
    //++++++++++++++++++++++++++++++++++++++++++
    //++++++++++++++++++++++++++++++++++++++++++
    //++++++++++++++++++++++++++++++++++++++++++

//  glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
//    BlueSphere = gluNewQuadric();
}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulation3DDiagram::FormMouseDown(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
   MouseDown = true;
}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulation3DDiagram::FormMouseUp(TObject *Sender,
      TMouseButton Button, TShiftState Shift, int X, int Y)
{
   MouseDown = false;
}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulation3DDiagram::FormMouseMove(TObject *Sender,
      TShiftState Shift, int X, int Y)
{
   if (MouseDown){
       if (OldMouseX == -1) OldMouseX = X;
       if (OldMouseY == -1) OldMouseY = Y;

       xAngle = xAngle + Y - OldMouseY;   OldMouseY = Y;
       zAngle = zAngle + OldMouseX - X;   OldMouseX = X;

       Draw();
   }

}
//---------------------------------------------------------------------------

void __fastcall TfrmSimulation3DDiagram::FormPaint(TObject *Sender)
{
    Draw();
}

//---------------------------------------------------------------------------
void TfrmSimulation3DDiagram::CreateGLContex()
{
    hdc = GetDC(Handle);

    PIXELFORMATDESCRIPTOR pfd = {
    	sizeof(PIXELFORMATDESCRIPTOR),
        1,
        PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER,
        PFD_TYPE_RGBA,
        24,
        0,0,0,0,0,0,
        0,0,
        0,0,0,0,0,
        32,
        0,
        0,
        PFD_MAIN_PLANE,
        0,
        0,0,
    };

    PixelFormat = ChoosePixelFormat(hdc, &pfd);
    SetPixelFormat(hdc, PixelFormat, &pfd);
    hrc = wglCreateContext(hdc);
    if(hrc == NULL)                       ShowMessage(":-)~ hrc == NULL");
    if(wglMakeCurrent(hdc, hrc) == false) ShowMessage("Could not MakeCurrent");
    //-------------------------------------------------------------------------------
    //-------------------------------------------------------------------------------

/*
    glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
    glRotatef   (-8,1.0,0.0,0.0);
    glRotatef   ( -19.0,0.0,1.0,0.0);
//    glTranslatef(-0.45f,0.0f,0.45f);

*/

}
//---------------------------------------------------------------------------

void TfrmSimulation3DDiagram::CreateList()
{

/*   TFloat k   = 7.0;
   TFloat kk  = 1.0;
   int    kkk = 200;
   Vector3D VertexArray[4];

//   glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

   glNewList(10,GL_COMPILE);
      //glBegin(GL_POINTS);
      glBegin(GL_QUADS);
         for (int z = 0; z < Diagram->CountPointDiagram / kkk - 1 ; z++){
            for (int x = 0; x < Diagram->CountPointDiagram / kkk - 1 ; x++){

                 VertexArray[0].x = Diagram->HValues[x * kkk].Offset * _180_del_Pi * kk;
                 VertexArray[0].y = Diagram->HValues[x * kkk].VoltValue * Diagram->VValues[z * kkk].VoltValue * k;
                 VertexArray[0].z = Diagram->VValues[z * kkk].Offset* _180_del_Pi * kk;

                 VertexArray[1].x = Diagram->HValues[x * kkk    ].Offset * _180_del_Pi * kk;
                 VertexArray[1].y = Diagram->HValues[x * kkk    ].VoltValue * Diagram->VValues[(z+1) * kkk].VoltValue * k;
                 VertexArray[1].z = Diagram->VValues[(z+1) * kkk].Offset * _180_del_Pi * kk;

                 VertexArray[2].x = Diagram->HValues[(x+1) * kkk].Offset * _180_del_Pi * kk;
                 VertexArray[2].y = Diagram->HValues[(x+1) * kkk].VoltValue * Diagram->VValues[z * kkk].VoltValue * k;
                 VertexArray[2].z = Diagram->VValues[z * kkk    ].Offset * _180_del_Pi * kk;

                 VertexArray[3].x = Diagram->HValues[(x+1) * kkk].Offset * _180_del_Pi * kk;
                 VertexArray[3].y = Diagram->HValues[(x+1) * kkk].VoltValue * Diagram->VValues[(z+1) * kkk].VoltValue * k;
                 VertexArray[3].z = Diagram->VValues[(z+1) * kkk].Offset * _180_del_Pi * kk;

                 float x1 = VertexArray[1].x - VertexArray[0].x;
                 float y1 = VertexArray[1].y - VertexArray[0].y;
                 float z1 = VertexArray[1].z - VertexArray[0].z;
                 float x2 = VertexArray[2].x - VertexArray[1].x;
                 float y2 = VertexArray[2].y - VertexArray[1].y;
                 float z2 = VertexArray[2].z - VertexArray[1].z;

                 float i  =  y1*z2 - z1*y2;
                 float j  =  x2*z1 - x1*z2;
                 float k  = -x2*y1 + x1*y2;

                 glColor3f(VertexArray[0].y, VertexArray[0].y, VertexArray[0].y);
                 glVertex3f(VertexArray[0].x, VertexArray[0].y, VertexArray[0].z);

                 glColor3f(VertexArray[1].y, VertexArray[1].y, VertexArray[1].y);
                 glVertex3f(VertexArray[1].x, VertexArray[1].y, VertexArray[1].z);

                 glColor3f(VertexArray[2].y, VertexArray[2].y, VertexArray[2].y);
                 glVertex3f(VertexArray[3].x, VertexArray[3].y, VertexArray[3].z);

                 glColor3f(VertexArray[3].y*30.0, VertexArray[3].y*30.0, VertexArray[3].y*30.0);
                 glVertex3f(VertexArray[2].x, VertexArray[2].y, VertexArray[2].z);

                 glNormal3f(i, j, k);
             }
         }
      glEnd();
   glEndList();*/
}
//---------------------------------------------------------------------------
void TfrmSimulation3DDiagram::Draw()
{
   glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

   glPushMatrix();
      glTranslatef(xOffset, yOffset, zOffset);
           glPushMatrix();
              glRotatef(xAngle, 1, 0, 0);
              glRotatef(zAngle, 0, 0, 1);
              glRotatef(25    , 0, 1, 0);

/*              TFloat BaseOffsetX = DiagramArray[0].Alfa;
              TFloat BaseOffsetY = DiagramArray[0].Betta;

              glTranslatef(-0.5, 0, -0.5);

              for (int i = 0; i < aFar->Beam_Count; i++){
                  glTranslatef((DiagramArray[i].Alfa - BaseOffsetX) * _180_del_Pi, 0, (aFar->DiagramArray[i].Betta - BaseOffsetY) * _180_del_Pi);
                  glCallList(10);

                  BaseOffsetX = DiagramArray[i].Alfa;
                  BaseOffsetY = DiagramArray[i].Betta;
              }
  */
           glPopMatrix();
   glPopMatrix();

//    glPushMatrix();
/*    glTranslatef(-CountElementPlane /3.3f*WidthPolygonPlane + CamX,
                 -10.0f + CamY,
                 -CountElementPlane /2.0f*WidthPolygonPlane + CamZ);
//    gluLookAt(-10.0f + CamX, 2.1f + CamY, 102 - 5.0f + CamZ,
//              0.0f       , 0.0f         , -60.0f,
//              0.0f       , 1.0f         , 0.0f);
   // -----     Otrisovka  -------------
      my_GLPreparePlane(CountElementPlane, Angle, *MainPlane, *Plane);
      my_GLDrawPlane   (CountElementPlane, *Plane);

//      gluSphere(BlueSphere, 6, 35, 35);
   // -----  end of Otrisovka ----------
    glPopMatrix();

   Angle = Angle + 2.0;
//   glRotatef(-0.15,0.0,1.0,0.0);
   Caption = FloatToStr(CamX) + ' ' + FloatToStr(CamY) + ' ' + FloatToStr(CamZ);

  */

   SwapBuffers(hdc);
}

