//---------------------------------------------------------------------------

#ifndef Unit_Simulation3DDiagramH
#define Unit_Simulation3DDiagramH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <gl\gl.h>
#include <gl\glu.h>
//---------------------------------------------------------------------------
class TfrmSimulation3DDiagram : public TForm
{
__published:	// IDE-managed Components
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall FormMouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
        void __fastcall FormMouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
        void __fastcall FormMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
        void __fastcall FormPaint(TObject *Sender);
private:
        HDC           hdc;
        HGLRC         hrc;
        int           PixelFormat;

        int           xOffset, yOffset, zOffset, xAngle, zAngle;
        int           OldMouseX, OldMouseY;
        bool          MouseDown;

        void CreateGLContex();
        void Draw();
        void CreateList();	// User declarations
public:		// User declarations
        __fastcall TfrmSimulation3DDiagram(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmSimulation3DDiagram *frmSimulation3DDiagram;
//---------------------------------------------------------------------------
#endif
