unit Unit_ReportOfWell2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, Menus, mpiDeclaration, StdCtrls, mpiLibrary;

type
  TDraw    = (dWindow, dBitmap);
  TriPoint = record
     Depth, Azim, Offset : TFloat;
  end;

  TfrmReportOfWell2 = class(TForm)
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    tbSaveToFile: TToolButton;
    Panel1: TPanel;
    tbZeroSettings: TToolButton;
    tbParam: TToolButton;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure N1231Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbZeroSettingsClick(Sender: TObject);
    procedure tbSaveToFileClick(Sender: TObject);
    procedure tbPrintScreenClick(Sender: TObject);
    procedure tbParamClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    gl_DC  : Hdc;
    gl_hrc : hGlrc;


    sDepth : TSeries;
    sAzim  : TSeries;
    sDevi  : TSeries;

    MaxRadius : TFloat;
    MinRadius : TFloat;

    nBitmap   : TBitmap;

    YRotateAngle : TFloat;
    //StepRotationAngle : TFloat;

    MouseDown    : Boolean;
    PosXWhenDown : Integer;

    GLPointArray : array of TriPoint;

    procedure CalcOutPutArray(aBeginDepthIndex, aEndDepthIndex : Integer);

    procedure glEllipse(aPenWidth : Integer; aRadius, AngleStep : TFloat);

    procedure CreateGL(aDraw : TDraw; aHDC : HDC);
    procedure DetroyGL();
    procedure InitializeGL(aLeft, aTop, aWidth, aHeight : Integer);
    procedure CreateList();

  public
    BeginDepth : TFloat;
    EndDepth   : TFloat;
    CountVualLine : TFloat;
    VualCoef      : TFloat;

    procedure DrawGL();
  end;

var
  frmReportOfWell2: TfrmReportOfWell2;

implementation

uses OpenGl, dglut, mpiLasFile, math, Unit_ReportOfWell2_Param,
  mpiGuardantStealth;

const pi_del_180 = pi/180;

{$R *.DFM}

procedure TfrmReportOfWell2.glEllipse(aPenWidth : Integer; aRadius, AngleStep : TFloat);
var
  CurAngle : TFloat;
begin
  angleStep := AngleStep * pi_del_180;
  glLineWidth (aPenWidth);
  glBegin (GL_Line_Loop);
    glVertex3f(aRadius, 0, 0);
    CurAngle := 0;
    while CurAngle < 2*pi do begin
       glVertex3f(aRadius*cos(CurAngle), 0, aRadius*sin(CurAngle));
       curAngle := curAngle + AngleStep
    end;
  glEnd();
end;

procedure TfrmReportOfWell2.CreateList();
var
 i : integer;
  ColorStep : TFloat;
  PositionColor : TFloat;

  DepthStep     : TFloat;
  PointStep     : TFloat;
  Ind1          : Integer;
  Ind2          : Integer;
begin
  glNewList(1, gl_Compile);
     glLineWidth(1);
     glColor3f(0.7,0.7,0.7);
     glEllipse(1,  1            , 1.5);
     glEllipse(1,  0.1*MaxRadius, 1.5);
     glEllipse(1,  0.2*MaxRadius, 1.5);
     glEllipse(1,  0.3*MaxRadius, 1.5);
     glEllipse(1,  0.4*MaxRadius, 1.5);
     glEllipse(1,  0.5*MaxRadius, 1.5);
     glEllipse(1,  0.6*MaxRadius, 1.5);
     glEllipse(1,  0.7*MaxRadius, 1.5);
     glEllipse(1,  0.8*MaxRadius, 1.5);
     glEllipse(1,  0.9*MaxRadius, 1.5);
     glBegin(gl_Lines);
          glVertex3f(-MaxRadius,0,0);  glVertex3f(MaxRadius,0,0);
          glVertex3f(0,0,-MaxRadius);  glVertex3f(0,0,MaxRadius);
     glend();
     glColor3f(0,0,0);
     glEllipse(2,    1*MaxRadius, 1.5);
  glEndList();
 // ---------------
  glNewList(2, gl_Compile);
     glLineWidth(1);
     glColor3f(0.0,0.0,0.7);

     glBegin(GL_TRIANGLES);
         glVertex3f(-MaxRadius*0.05,0,MaxRadius);
         glVertex3f( MaxRadius*0.05,0,MaxRadius);
         glVertex3f(0,0,MaxRadius*1.15);

         //glRasterPos3i(20,0,20);
         //glutBitmapCherarter(glut_Bitrmap_8_by_13)

{          glColor3f(0,0,1);
          glVertex3f(0,0,0);         glVertex3f(0,0,MaxRadius*1.22);
          glVertex3f(0,0,MaxRadius*1.22); glVertex3f(-MaxRadius*0.025,0,MaxRadius*1.03);
          glVertex3f(0,0,MaxRadius*1.22); glVertex3f( MaxRadius*0.024,0,MaxRadius*1.03);

          glColor3f(1,0,0);
          glVertex3f(0,0,0);
          glVertex3f(0,0,-MaxRadius);
}     glend();
  glEndList();
 // --------------------
  PositionColor := 0;
  ColorStep     := 255/Length(GLPointArray);
  DepthStep     := 2*MaxRadius/(GLPointArray[Length(GLPointArray) - 1].Depth - GLPointArray[0].Depth);
  glNewList(3, gl_Compile);
              glBegin (GL_Line_Strip);
                i := 1;
                while i <= Length(GLPointArray) - 1 do begin
                    glColor3f((255-PositionColor)/255,  0,  PositionColor/255);

                    Repeat ind1 := i-1; i:= i + 1; until GLPointArray[ind1].Offset <> sAzim.NullValue;
                    Repeat ind2 := i-1; i:= i + 1; until GLPointArray[ind2].Offset <> sAzim.NullValue;
                    i := i + 1;

                    if ind2 >= Length(GLPointArray) - 1 then break;

                    glVertex3f(GLPointArray[ind1].Offset*cos(GLPointArray[ind1].Azim), -(GLPointArray[ind1].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[ind1].Offset*sin(GLPointArray[ind1].Azim));
                    glVertex3f(GLPointArray[ind2].Offset*cos(GLPointArray[ind2].Azim), -(GLPointArray[ind2].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[ind2].Offset*sin(GLPointArray[ind2].Azim));

                    PositionColor := ColorStep*i;
                end;

                {for i := 1 to Length(GLPointArray) - 1 do begin
                     glColor3f((255-PositionColor)/255,  0,  PositionColor/255);
                     if (GLPointArray[i].Offset <> sAzim.NullValue) and ((GLPointArray[i-1].Offset <> sAzim.NullValue)) then begin
                        glVertex3f(GLPointArray[i-1].Offset*cos(GLPointArray[i-1].Azim), -(GLPointArray[i-1].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[i-1].Offset*sin(GLPointArray[i-1].Azim));
                        glVertex3f(GLPointArray[i  ].Offset*cos(GLPointArray[i  ].Azim), -(GLPointArray[i  ].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[i  ].Offset*sin(GLPointArray[i  ].Azim));
                     end;
                     PositionColor := PositionColor + ColorStep;
                end;}

              glEnd();
  glEndList();
 // --------------------
  PositionColor := 255;
  glNewList(4, gl_Compile);
              glBegin (GL_Line_Strip);
                i := 1;
                while i <= Length(GLPointArray) - 1 do begin
                    glColor3f((255-PositionColor)/255,  0,  PositionColor/255);

                    Repeat ind1 := i-1; i:= i + 1; until GLPointArray[ind1].Offset <> sAzim.NullValue;
                    Repeat ind2 := i-1; i:= i + 1; until GLPointArray[ind2].Offset <> sAzim.NullValue;
                    i := i + 1;

                    if ind2 >= Length(GLPointArray) - 1 then break;

                    glVertex3f(GLPointArray[ind1].Offset*cos(GLPointArray[ind1].Azim), 0, GLPointArray[ind1].Offset*sin(GLPointArray[ind1].Azim));
                    glVertex3f(GLPointArray[ind2].Offset*cos(GLPointArray[ind2].Azim), 0, GLPointArray[ind2].Offset*sin(GLPointArray[ind2].Azim));

                    PositionColor := ColorStep*i;
                end;
               { for i := Length(GLPointArray) - 1 downto 1 do begin
                     glColor3f((255-PositionColor)/255,  0,  PositionColor/255);
                     if (GLPointArray[i].Offset <> sAzim.NullValue) and ((GLPointArray[i-1].Offset <> sAzim.NullValue)) then begin
                        glVertex3f(GLPointArray[i-1].Offset*cos(GLPointArray[i-1].Azim), 0, GLPointArray[i-1].Offset*sin(GLPointArray[i-1].Azim));
                        glVertex3f(GLPointArray[i  ].Offset*cos(GLPointArray[i  ].Azim), 0, GLPointArray[i  ].Offset*sin(GLPointArray[i  ].Azim));
                     end;

                     PositionColor := PositionColor - ColorStep;
                end;}
              glEnd();
  glEndList();
 // --------------------
  PointStep := Length(GLPointArray) / StrToFloat(frmReportOfWell2_Param.Edit1.Text);

  glNewList(5, gl_Compile);
              glBegin (GL_Lines);
              //glBegin (GL_Quads);
                glColor4f(0.0, 0.0, 0.0, VualCoef);
                i := 1;
                while i <= Length(GLPointArray) - 1 do begin
                    Repeat ind1 := i-1; i:= i + 1; until GLPointArray[ind1].Offset <> sAzim.NullValue;
                    Repeat ind2 := i-1; i:= i + 1; until GLPointArray[ind2].Offset <> sAzim.NullValue;
                    i := i + Round(PointStep);

                    if ind2 >= Length(GLPointArray) - 1 then break;

                    glVertex3f(GLPointArray[ind1].Offset*cos(GLPointArray[ind1].Azim), 0                                                            , GLPointArray[ind1].Offset*sin(GLPointArray[ind1].Azim));
                    glVertex3f(GLPointArray[ind2].Offset*cos(GLPointArray[ind2].Azim), -(GLPointArray[ind2].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[ind2].Offset*sin(GLPointArray[ind2].Azim));

                end;

                {PointCounter := 0;
                while PointCounter <= Length(GLPointArray) - 1 do begin
                     i := Round(PointCounter);
                     if (GLPointArray[i].Offset <> sAzim.NullValue) and ((GLPointArray[i-1].Offset <> sAzim.NullValue)) then begin
                            glVertex3f(GLPointArray[i].Offset*cos(GLPointArray[i].Azim), 0                                                         , GLPointArray[i].Offset*sin(GLPointArray[i].Azim));
                            glVertex3f(GLPointArray[i].Offset*cos(GLPointArray[i].Azim), -(GLPointArray[i].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[i].Offset*sin(GLPointArray[i].Azim));
                     end;
                     PointCounter := PointCounter + PointStep;
                end;}


{                for i := 1 to Length(GLPointArray) - 1 do begin
                     if (GLPointArray[i].Offset <> sAzim.NullValue) and ((GLPointArray[i-1].Offset <> sAzim.NullValue)) then begin
                            glVertex3f(GLPointArray[i-1].Offset*cos(GLPointArray[i-1].Azim), 0                                                           , GLPointArray[i-1].Offset*sin(GLPointArray[i-1].Azim));
                            glVertex3f(GLPointArray[i-1].Offset*cos(GLPointArray[i-1].Azim), -(GLPointArray[i-1].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[i-1].Offset*sin(GLPointArray[i-1].Azim));

                            glVertex3f(GLPointArray[i].Offset*cos(GLPointArray[i].Azim), -(GLPointArray[i].Depth - GLPointArray[0].Depth)*DepthStep, GLPointArray[i].Offset*sin(GLPointArray[i].Azim));
                            glVertex3f(GLPointArray[i].Offset*cos(GLPointArray[i].Azim), 0                                                         , GLPointArray[i].Offset*sin(GLPointArray[i].Azim));
                     end;
                end;
}              glEnd();
  glEndList();
end;

procedure TfrmReportOfWell2.InitializeGL(aLeft, aTop, aWidth, aHeight : Integer);
var
 aspect : TFloat;
begin
   aspect := aWidth / aHeight;

   glMatrixMode(GL_PROJECTION);
   glLoadIdentity;
   glOrtho(-MaxRadius*2.5, MaxRadius*2.5, -MaxRadius*2.5/aspect, MaxRadius*2.5/aspect, -MaxRadius*2.5, MaxRadius*2.5);

   glMatrixMode (GL_MODELVIEW);
   glLoadIdentity;
   InvalidateRect(Handle, nil, False);

   glViewport(aLeft, aTop, aWidth, aHeight);
   glClearColor(1, 1, 1,1);

   glEnable(Gl_Line_Stipple);
//   glEnable(GL_CULL_FACE);
//   glCullFace(GL_Back);
//   glEnable(GL_Depth_Test);
//   glBlendFunc(GL_SRC_COLOR, GL_ONE_MINUS_SRC_ALPHA);

   glEnable(GL_Blend);
   glBlendFunc(GL_SRC_COLOR, GL_ONE_MINUS_SRC_ALPHA);
end;

procedure TfrmReportOfWell2.CreateGL(aDraw: TDraw; aHDC: HDC);
var nPixelFormat: Integer;
    pfd: TPixelFormatDescriptor;
begin
  Gl_dc := aHDC;

  FillChar(pfd, SizeOf(pfd), 0);
  pfd.dwFlags    := Pfd_Draw_To_Window or Pfd_Draw_To_Bitmap or Pfd_Support_OpenGl;
  if aDraw = dWindow then  pfd.dwFlags := pfd.dwFlags or Pfd_DoubleBuffer;
  pfd.cColorBits := 32;
  pfd.cDepthBits := 32;
  nPixelFormat   := ChoosePixelFormat(Gl_dc, @pfd);
  SetPixelFormat(Gl_dc, nPixelFormat, @pfd);

  GL_Hrc := wglCreateContext(Gl_dc); wglMakeCurrent  (Gl_dc, Gl_Hrc);

  CreateList();
end;

procedure TfrmReportOfWell2.DetroyGL();
begin
   wglMakeCurrent(0, 0);
   wglDeleteContext(Gl_Hrc);
   ReleaseDC(Handle, Gl_Dc);
   DeleteDC (Gl_Dc);
end;

procedure TfrmReportOfWell2.FormShow(Sender: TObject);
begin
  // ----------------------------
      Caption := frmMainCaption + 'Отчет по скважине №2' + ' - ' + '[' + LasFile.FileName + ']';
  // ---------------------------
      Width  := 739;
      Height := 518;
  // ---------------------------
      YRotateAngle := 0;
      PosXWhenDown := 0;
      sDepth := TSeries(LasFile.SeriesList.Items[0]);
      //sAzim  := TSeries(LasFile.SeriesList.Items[LasFile.GetSeriesIndex(LasFile.GetSeries('Azim'))]);
      sAzim  := TSeries(LasFile.SeriesList.Items[LasFile.GetSeriesIndex(LasFile.GetSeries('Azim'))]);
      sDevi  := TSeries(LasFile.SeriesList.Items[LasFile.GetSeriesIndex(LasFile.GetSeries('Devi'))]);
      if sAzim = nil then begin
        MessageDlg('Невозможно построение отчетной формы'#10#13'В Las-e отсутствует кривая с именем '#39'Azim'#39' ...', mtError, [mbOk],0);
        Close;
      end;
      if sDevi = nil then begin
        MessageDlg('Невозможно построение отчетной формы'#10#13'В Las-e отсутствует кривая с именем '#39'Devi'#39' ...', mtError, [mbOk],0);
        Close;
      end;
  // ---------------------------
   CalcOutPutArray(0, sDepth.Count - 1);
  // ---------------------------
   CreateGL(dWindow, GetDC(Handle));
   InitializeGL(ControlBar1.Height , 0, ClientWidth, ClientHeight - ControlBar1.Height - StatusBar1.Height);
  // ---------------------------
end;

procedure TfrmReportOfWell2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DetroyGL();
end;

procedure TfrmReportOfWell2.FormCreate(Sender: TObject);
begin
  frmReportOfWell2_Param := TfrmReportOfWell2_param.Create(self);


  nBitmap := TBitmap.Create;
  nBitmap.Width:= 30;
  nBitmap.Height:= 30;
  nBitmap.Canvas.FillRect(rect(0,0,nBitmap.Width ,nBitmap.Height));
end;

procedure TfrmReportOfWell2.FormDestroy(Sender: TObject);
begin
  frmReportOfWell2_Param.free;
  nBitmap.Free;
end;

procedure TfrmReportOfWell2.FormPaint(Sender: TObject);
begin
  DrawGL();
end;

procedure TfrmReportOfWell2.FormResize(Sender: TObject);
begin
   InitializeGL(ControlBar1.Height , 0, ClientWidth, ClientHeight - ControlBar1.Height);
   DrawGL();
end;

procedure TfrmReportOfWell2.N1231Click(Sender: TObject);
begin
  ShowMessage('1');
end;

procedure TfrmReportOfWell2.CalcOutPutArray(aBeginDepthIndex, aEndDepthIndex : Integer);
var
  i          : integer;
  LengthArray : Integer;
begin
   LengthArray := aEndDepthIndex - aBeginDepthIndex + 1;
   SetLength(GLPointArray, LengthArray);
   MaxRadius  := 0;
   MinRadius  := 100000000;

   for i := aBeginDepthIndex to aEndDepthIndex do begin
     GLPointArray[i - aBeginDepthIndex].Depth  := sDepth.data^[i];
     GLPointArray[i - aBeginDepthIndex].Azim   := (-sAzim.data^[i] + 90)*pi_del_180;
     if (sDevi .data^[i]  <> sDevi.NullValue) and
        (sDepth.data^[i]  <> sDepth.NullValue) and
        (sAzim. data^[i]  <> sAzim.NullValue) then begin

        GLPointArray[i - aBeginDepthIndex].Offset := sDepth.data^[i]*tan(sDevi.data^[i]*pi_del_180);
        if MaxRadius < GLPointArray[i - aBeginDepthIndex].Offset then MaxRadius := GLPointArray[i - aBeginDepthIndex].Offset;
        if MinRadius > GLPointArray[i - aBeginDepthIndex].Offset then MinRadius := GLPointArray[i - aBeginDepthIndex].Offset;


     end else GLPointArray[i - aBeginDepthIndex].Offset := sAzim.NullValue;
   end;
   MaxRadius := MaxRadius*1.2;
   MaxRadius := Round(MaxRadius / 10) * 10;
   StatusBar1.Panels.Items[0].Text := '  Максимальное значение шкалы : ' + FLoatToStr(MaxRadius) + ' м.';
   StatusBar1.Panels.Items[1].Text := '  Диапазон глубин : (' + FLoatToStr(sDepth.data^[aBeginDepthIndex]) + ' ... ' + FLoatToStr(sDepth.data^[aEndDepthIndex]) + ') м.';
end;

procedure TfrmReportOfWell2.DrawGL();
var
   ps  : TPaintStruct;
begin
    BeginPaint(Handle, ps);
   // -----------
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
   // -----------------------
    glPushMatrix;
          gluLookAt(0.0, 0.0, 1.0, 0, 0, 0, 0, 1, 0.0);
              glTranslate(MaxRadius, 0, 0);
              glRotate   (-12 ,1,0,0);
              glRotatef(YRotateAngle, 0,1,0);

              glColor3f(0,0,0);
              glTranslate(0,  MaxRadius  , 0); glCallList(1); glCallList(2);
              glBegin(GL_Lines); glColor3f(0.7,0.7,0.7); glVertex3f(0,0,0); glVertex3f(0, -MaxRadius*2, 0); glEnd();
              glTranslate(0, -MaxRadius*2, 0); glCallList(1); glCallList(2);
              glTranslate(0,  MaxRadius*2, 0);

               if frmReportOfWell2_Param.CheckBox1.Checked then glCallList(5);
               glLineWidth(3);  glCallList(3);
               if frmReportOfWell2_Param.CheckBox2.Checked then begin glLineWidth(1);  glCallList(4); end;
    glPopMatrix;
   // -----------------------
    glPushMatrix;
          gluLookAt(0.0, -1, 0.0, 0, 0, 0, 0, 1, 0.01);
          glTranslate(-MaxRadius*1.4, 0, 0);
          glCallList(1);
          glCallList(2);
          glLineWidth(3); glCallList(4);
    glPopMatrix;
   // -----------------------
    SwapBuffers(Gl_Dc);
   // -----------------------
    EndPaint(Handle, ps);
//    InvalidateRect(Handle, nil, False);
end;

procedure TfrmReportOfWell2.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseDown := true;
  PosXWhenDown := x;
end;

procedure TfrmReportOfWell2.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if MouseDown then begin
    YRotateAngle      := YRotateAngle - (x-PosXWhenDown) div 2;
    PosXWhenDown      := x;
    DrawGL();
  end;
end;

procedure TfrmReportOfWell2.FormMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MouseDown := false;
end;

procedure TfrmReportOfWell2.tbZeroSettingsClick(Sender: TObject);
begin
  YRotateAngle   := 0;
  DrawGL();
{  YRotateAngle := Frac(Abs(YRotateAngle)/360)*360;
  if YRotateAngle > 180 then StepRotationAngle := (YRotateAngle - 360)/5
                        else StepRotationAngle := YRotateAngle/5;

  Timer1.Enabled := True;}
end;

procedure TfrmReportOfWell2.tbSaveToFileClick(Sender: TObject);
var
 FileName : String;
 Bitmap   : TBitmap;
begin
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6           then prov7 := Check_Guardant_Stealth_9();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 then prov8 := Check_Guardant_Stealth_10();
   if prov1 and prov2 and prov3 and prov4 and prov5 and prov6 and prov7 and prov8 then begin
        {$I-} MkDir(ExtractFilePath(Application.ExeName) + '_BMP_'); {$I+}
        // --- Параметры Save Диалога ----
        SaveDialog1.Title         := frmMainCaption + 'Запись текущего изображения';
        SaveDialog1.InitialDir    := ExtractFilePath(Application.ExeName) + '_BMP_';
        SaveDialog1.Filter        := 'Файлы изображений (*.bmp)|*.bmp';
        SaveDialog1.FileEditStyle := fsComboBox;
        //------------------------------
        if SaveDialog1.Execute then begin
             FileName := SaveDialog1.FileName;
             if ExtractFileExt(FileName) = '' then FileName := FileName + '.bmp';
           // -----------
            Bitmap := TBitmap.Create;
            Bitmap.Width  := ClientWidth;
            Bitmap.Height := ClientHeight - ControlBar1.Height - StatusBar1.Height;

            CreateGL(dBitmap, Bitmap.Canvas.Handle);
            InitializeGL(ControlBar1.Height , 0, ClientWidth, ClientHeight - ControlBar1.Height - StatusBar1.Height);
            DrawGL();
            DetroyGL();
           // -----------
            CreateGL(dWindow, GetDC(Handle));
            InitializeGL(ControlBar1.Height , 0, ClientWidth, ClientHeight - ControlBar1.Height - StatusBar1.Height);
           // -----------
            Bitmap.SaveToFile(FileName);
            Bitmap.Free;
        end;
   end else begin
      MessageDlg('Запись в демо режиме отключена'#10#13'Для отмены демо режима необходимо:'#10#13'   1. Закрыть программу.'#10#13'   2. Вставить электронный ключ поставляемый с программой в USB разъем компьютера.'#10#13'   3. Запустить программу.', mtWarning, [mbok], 0);
   end;
end;

procedure TfrmReportOfWell2.tbPrintScreenClick(Sender: TObject);
begin
//
end;

procedure TfrmReportOfWell2.tbParamClick(Sender: TObject);
begin
  frmReportOfWell2_Param.ShowModal;
  CalcOutPutArray(LasFile.GetDepthIndex(BeginDepth), LasFile.GetDepthIndex(EndDepth));


//  DetroyGL();
//  CreateGL(dWindow, GetDC(Handle));
  InitializeGL(ControlBar1.Height , 0, ClientWidth, ClientHeight - ControlBar1.Height - StatusBar1.Height);
  CreateList();
//}
  DrawGl();
end;

procedure TfrmReportOfWell2.Timer1Timer(Sender: TObject);
begin
{  YRotateAngle := YRotateAngle - StepRotationAngle;
  if (YRotateAngle < 0.1) or (YRotateAngle > 359.9) then begin
     YRotateAngle   := 0;
     Timer1.Enabled := False;
  end;
  DrawGL();}
end;

procedure TfrmReportOfWell2.FormActivate(Sender: TObject);
begin
  DecimalSeparator := '.';
end;

end.
