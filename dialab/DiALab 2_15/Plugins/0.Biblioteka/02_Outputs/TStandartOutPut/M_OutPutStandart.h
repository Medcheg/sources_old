//===========================================================================
#ifndef M_OutPutStandartH
#define M_OutPutStandartH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
class TfrmOutPutStandart ;
//===========================================================================
typedef struct TmpiSeries{
    TColor      Color;
    TPenStyle   PenStyle;
    int         PenWidth;
    AnsiString  Name;

    TFloat     *XValues;
    TFloat     *YValues;
    int         Values_Count;

    int         OldValueScreenX, OldValueScreenY;

    void Init(){
          if (XValues != NULL) free (XValues);
          if (YValues != NULL) free (YValues);

          XValues      = NULL;
          YValues      = NULL;
          Values_Count = 0;

          OldValueScreenX = 0;
          OldValueScreenY = 0;
    }
    void AddXYValue(TFloat x, TFloat y){
        Values_Count ++;
        XValues[Values_Count - 1] = x;
        YValues[Values_Count - 1] = y;
    }
    TmpiSeries(){
        XValues      = NULL;
        YValues      = NULL;
        Values_Count = 0;
        PenStyle     = psSolid;
        PenWidth     = 1;
    };
   ~TmpiSeries(){ Init(); };
}TmpiSeries;

class TOutElementStandart : public TElement {
private:
        int                  fCountInput;

        void                *Draw_AddXYValue;
        void __fastcall Set_CountInput(int aCountInput);
public:
        TfrmOutPutStandart *frmOutPut;

        TFloat   MinY, MaxY;
        bool     DrawDots;

        TmpiSeries **mpiSeries;

        TOutElementStandart();
       ~TOutElementStandart();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun(){};
        virtual void     Run();
        virtual void     DoneRun(){};

        static TOutElementStandart *Create() { return new TOutElementStandart(); };

        __property int     CountInput      = { read = fCountInput     , write = Set_CountInput   };
//        __property TList  *SeriesParamList = { read = fSeriesParamList, write = fSeriesParamList };
};
//===========================================================================
#endif
