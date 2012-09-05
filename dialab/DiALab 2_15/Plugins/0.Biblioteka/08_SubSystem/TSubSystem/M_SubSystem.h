//===========================================================================
#ifndef M_SubSystemH
#define M_SubSystemH
//===========================================================================
#ifndef mpiElementH
#include "mpiElement.h"
#endif
//===========================================================================
class TfrmEditorManager ;
class TSubSystem : public TElement {
private:
       bool               fOpen;
       TfrmEditorManager *frmEditorManager;
       TRect              fWindowPosition;
       TList             *fInputList;  // ---- Список входных элементов типа "TSubSystemIn" ----
       TList             *fOutputList; // ---- Список входных элементов типа "TSubSystemOut" ----
     // -----------
       int                fEditorManagerWidth;
       int                fEditorManagerHeight;
       int                fEditorManagerLeft;
       int                fEditorManagerTop;
     // -----------
       void  __fastcall   Set_Open(bool aOpen);
       void  __fastcall   Set_WindowPosition(TRect aRect);
public:
        TSubSystem();
       ~TSubSystem();

/*       void   Run ();
       void   Init();
       void PrepareElementBitmaps(Graphics::TBitmap *aBitmap);*/

   // --------
        void   Add_Input    (TElement *aElement);
        void   Add_OutPut   (TElement *aElement);
        void   Delete_Input (TElement *aElement);
        void   Delete_OutPut(TElement *aElement);
   // --------
        virtual void     LoadFromStream(TStream *aStream);
        virtual void     SaveToStream  (TStream *aStream);
        virtual void     Edit();
        virtual void     Copy(void *aElement);
        virtual void     Init(){TElement::Init();};
        virtual void     InitBeforeRun(){};
        virtual void     Run(){};
        virtual void     DrawElementFace();
        virtual void     DoneRun(){};
        static TSubSystem *Create() { return new TSubSystem(); };

      __property bool               Open           = { read = fOpen           , write = Set_Open         };
      __property TRect              WindowPosition = { read = fWindowPosition , write = Set_WindowPosition  };
      __property TfrmEditorManager *EditorManager  = { read = frmEditorManager, write = frmEditorManager };
      __property TList             *InputList      = { read = fInputList      , write = fInputList       };
      __property TList             *OutputList     = { read = fOutputList     , write = fOutputList      };
};
//===========================================================================
#endif

