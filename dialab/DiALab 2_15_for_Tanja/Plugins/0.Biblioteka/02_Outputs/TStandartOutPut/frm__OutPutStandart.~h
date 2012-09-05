//---------------------------------------------------------------------------

#ifndef frm__OutPutStandartH
#define frm__OutPutStandartH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
//---------------------------------------------------------------------------
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Buttons.hpp>

enum TmyWindowState {wsShort, wsFull};

class TfrmOutPutStandart : public TForm
{
__published:    // IDE-managed Components
        TPanel *Panel1;
        TTrackBar *TrackBar1;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TTrackBar *TrackBar2;
        TLabel *Label4;
        TLabel *Label5;
        TLabel *Label6;
        TLabel *Label12;
        TLabel *Label13;
        TLabel *Label14;
        TLabel *Label15;
        TTrackBar *TrackBar4;
        TLabel *Label16;
        TLabel *Label17;
        TLabel *Label18;
        TLabel *Label19;
        TTrackBar *TrackBar3;
        TSpeedButton *SpeedButton1;
        TPanel *Panel2;
        TPaintBox *PaintBox1;
        TPanel *Panel3;
        TPanel *pCaption;
        TLabel *lCaption1;
        TLabel *lCaption2;
        TLabel *lValue1;
        TLabel *lValue2;
        TLabel *lCaption3;
        TLabel *lCaption4;
        TLabel *lValue3;
        TLabel *lValue4;
        TLabel *lCaption5;
        TLabel *lCaption6;
        TLabel *lValue5;
        TLabel *lValue6;
        TSpeedButton *SpeedButton2;
        TSpeedButton *SpeedButton3;
        TBevel *Bevel1;
        TSpeedButton *SpeedButton5;
        TLabel *lTime;
        void __fastcall FormActivate(TObject *Sender);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall SpeedButton5Click(TObject *Sender);
        void __fastcall FormDestroy(TObject *Sender);
        void __fastcall PaintBox1Paint(TObject *Sender);
        void __fastcall FormResize(TObject *Sender);
        void __fastcall SpeedButton3Click(TObject *Sender);
        void __fastcall PaintBox1MouseMove(TObject *Sender,
          TShiftState Shift, int X, int Y);
        void __fastcall TrackBar1Change(TObject *Sender);
private:        // User declarations
        TmyWindowState fmyWindowState;
        TRect          GraphRect; // ---  оординаты самого окна вывда графиков (чистые координаты )---
        bool           EnabledCursor;  // ----  можно ли передвигать курсором ------

        long double    CoefX, CoefY;
        int            ZeroPos;
        int            OldXPositionMouseCursor;

        void           PrepareRedrawBitmap_and_coeff();
        void           PrepareGraphicMassive();
        TPoint         *Values[6];
        double          TimeScale;

        void __fastcall Set_myWindowState(TmyWindowState amyWindowState);
public:         // User declarations
        Graphics::TBitmap  *FonBitmap;
        Graphics::TBitmap  *RedrawBitmap;
        TLabel             *lCaption[6];
        TLabel             *lValue[6];

        void      **mpiSeries;
        void       *Element;
        long double     *pMinY, *pMaxY;

        void  AddXYValue(int NumberInput, int ValueIndex, bool DrawToPaintBox); // --- true
        void  Init();


        __fastcall TfrmOutPutStandart(TComponent* Owner);
        __property TmyWindowState myWindowState = { read = fmyWindowState, write = Set_myWindowState };
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmOutPutStandart *frmOutPutStandart;
//---------------------------------------------------------------------------
#endif
