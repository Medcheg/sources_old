//---------------------------------------------------------------------------

#ifndef Unit_AchFchH
#define Unit_AchFchH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
#include "mpiTypes.h"
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <Dialogs.hpp>
//---------------------------------------------------------------------------
typedef struct{
    int x, y, w, h;
}TPosImage;


class TfrmAchFch : public TForm
{
__published:	// IDE-managed Components
        TControlBar *ControlBar1;
        TToolBar *ToolBar1;
        TToolButton *tbClose;
        TToolButton *tbParam;
        TToolButton *tbSaveImage;
        TBevel *Bevel1;
        TBevel *Bevel2;
        TLabel *Label7;
        TLabel *lAchValue;
        TLabel *Label8;
        TLabel *lFchValue;
        TLabel *Label11;
        TLabel *lFreqValue;
        TSaveDialog *SaveDialog1;
        TProgressBar *ProgressBar1;
        void __fastcall tbCloseClick(TObject *Sender);
        void __fastcall tbParamClick(TObject *Sender);
        void __fastcall tbSaveImageClick(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormPaint(TObject *Sender);
        void __fastcall FormMouseMove(TObject *Sender, TShiftState Shift,
          int X, int Y);
private:
        TFloat  *a;  int aItemsCount;  // ---- Коэфициенты числителя --------
        TFloat  *b;  int bItemsCount;  // ---- Коэфициенты знаменателя --------
        TFloat  T0;

        TFloat    *FreqArray;           // -------- Масив частот на графике ---------
        TFloat    *AchArray;            // -------- Масив АЧХ значений --------
        TFloat    *FchArray;            // -------- Масив ФЧХ значений -------
        TPoint    *AchPointArray;       // -------- Масив АЧХ значений на графике --------
        TPoint    *FchPointArray;       // -------- Масив ФЧХ значений на графике --------
        int        CountGraphPoint;     // -------- Количество точек на графике --------

        Graphics::TBitmap *Bitmap;

        TPosImage  ImagePos;
        TPosImage  BitmapPos;

        int  CountDecad;
        int  BeginDecad;
        int  EndDecad;

        bool FirstPaint;

        int     CountPixelInOneDecada;
        int     ZeroPos;
        int     Max, Min;
        TFloat  CoefY;
        void Prepare_Bitmap();
        void ClearArray();
        void ClearCaptionText();
        void Prepare_FreqArray();
        TTwoFloat Get_Ach_FchValue(TFloat aHezh);
        void Correct_FchValue();
        void Draw_Labels();
        TFloat Get_PosInFreqAray(TFloat aValue);
        void DrawCircle(TCanvas * aCanvas, TFloat x, TFloat y);

public:		// User declarations
        TColor       AchFchBackGroundColor;
        TColor       AchColor;
        TColor       FchColor;
        int          AchPenWidth;
        int          FchPenWidth;
        TPenStyle    AchPenStyle;
        TPenStyle    FchPenStyle;

        TFloat       EndFreq;
        TFloat       BeginFreq;
        bool         AchEnabled;
        bool         FchEnabled;
        bool         RamkaEnabled;
        bool         Enable_Label_T0;         
        __fastcall TfrmAchFch(TComponent* AOwner, TFloat aT0, TFloat *aa, int aaItemsCount, TFloat *ab, int abItemsCount);
        void Draw();
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmAchFch *frmAchFch;
//---------------------------------------------------------------------------
#endif
