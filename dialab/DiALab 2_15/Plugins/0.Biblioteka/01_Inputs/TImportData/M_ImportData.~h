//==========================================================================
#ifndef M_ImportDataH
#define M_ImportDataH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================
#pragma pack( push, 1 )
typedef struct
{
   char           Name[250];
   long  double  *Value;
} TmySeries;

typedef struct _TiData
{
     char         *FileName;
     int           LengthFileName;
     bool          FileLoaded;

     int           CoundDataInOneCurve;
     long double   T0;
     int           SeriesCount;
     TmySeries    *Series; //

     void Init(){
         CoundDataInOneCurve = 0;
         T0                  = 0;
         ReleaseArrays();
     }
     // --------------------
     void ReleaseArrays(){
           if (Series != NULL) {
              for (int k = 0; k < SeriesCount; k++){
                  free (Series[k].Value);
                  Series[k].Value = NULL;
              }
              free (Series);
              free (FileName);
              Series       = NULL;
              FileName     = NULL;
              SeriesCount  = 0;
           }
           FileLoaded = false;
     }
    _TiData() { Series = NULL; FileName = NULL;}
   ~_TiData() { ReleaseArrays(); }
} TiData;
#pragma pack( pop ) ;
//===========================================================================

class TImportData : public TElement {
private:
        long double ArrayIndex;
        long double ArrayIndexStep;
        bool        FixedStep;
public:
        TiData iData;

         TImportData();
        ~TImportData();

        virtual void     SaveToStream(TStream *aStream);
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     DrawElementFace();
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init();
        virtual void     InitBeforeRun();
        virtual void     Run();
        virtual void     DoneRun(){};
        static  TImportData *Create() { return new TImportData(); };
};
//===========================================================================
#endif
