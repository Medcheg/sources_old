//===========================================================================
#ifndef Unit_Result_2H
#define Unit_Result_2H
//===========================================================================
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Buttons.hpp>
#include <Chart.hpp>
#include <ExtCtrls.hpp>
#include <Series.hpp>
#include <TeEngine.hpp>
#include <TeeProcs.hpp>
//===========================================================================
class Tform_Result_2 : public TForm
{
__published:	// IDE-managed Components
    TPanel *pChart1;
    TLabel *Label1;
    TLabel *Label2;
    TCheckBox *CheckBox1;
    TChart *Chart1;
    TLineSeries *Series1;
    TLineSeries *Series2;
    TLineSeries *Series3;
    TLineSeries *Series4;
    TLineSeries *Series5;
    TLineSeries *Series6;
    TLineSeries *Series7;
    TLineSeries *Series8;
    TLineSeries *Series9;
    TListBox *ListBox1;
    void __fastcall FormShow(TObject *Sender);
    void __fastcall Chart1MouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
    void __fastcall Chart1Click(TObject *Sender);
    void __fastcall Chart1MouseDown(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
    void __fastcall Chart1MouseUp(TObject *Sender, TMouseButton Button,
          TShiftState Shift, int X, int Y);
    void __fastcall CheckBox1Click(TObject *Sender);
    void __fastcall ListBox1Click(TObject *Sender);
    void __fastcall CheckListBox_onDraw(Controls::TWinControl* Control, int Index, const Types::TRect &aRect, TOwnerDrawState State);
    void __fastcall Chart1Zoom(TObject *Sender);
    void __fastcall Chart1UndoZoom(TObject *Sender);
private:	// User declarations
    int  MousePosX1, MousePosX2;
    int  Cursor_ArrayItemIndex;
    bool isMouseDown;
public:		// User declarations
    __fastcall Tform_Result_2(TComponent* Owner);
};
//===========================================================================
extern PACKAGE Tform_Result_2 *form_Result_2;
//===========================================================================
#endif
