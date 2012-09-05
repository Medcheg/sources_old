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
class TfrmResult_2 : public TForm
{
__published:	// IDE-managed Components
    TPanel *pChart1;
    TLabel *Label1;
    TLabel *Label2;
    TCheckBox *CheckBox1;
    TChart *Chart1;
    TLineSeries *Series1;
    TListBox *ListBox1;
    TLabel *Label3;
    TPanel *Panel1;
    TLabel *Label4;
    TComboBox *ComboBox1;
    TCheckBox *CheckBox2;
    TEdit *Edit1;
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
    __fastcall TfrmResult_2(TComponent* Owner);
};
//===========================================================================
extern PACKAGE TfrmResult_2 *frmResult_2;
//===========================================================================
#endif
