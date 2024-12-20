//===========================================================================
#include <vcl.h>
#pragma hdrstop

#include "mpiBaseClass.h"
//===========================================================================
/*void TBaseClass_init() { Beep(); }
#pragma startup TBaseClass_init 110 // default 100*/
//===========================================================================
//===========================================================================
void SaveAnsiSringToStream(TStream *aStream, AnsiString &aString)
{
   int   aLengthString = aString.Length();
//   char *aChar = aString.c_str();

   aStream->Write(&aLengthString , sizeof(aLengthString));
   aStream->Write(aString.c_str(),        aLengthString);
}

//===========================================================================
void LoadAnsiSringFromStream(TStream *aStream, AnsiString &aString)
{
    char *aChar = NULL;

    try {
        int   aLengthString = 0;
        aStream->Read(&aLengthString, sizeof(aLengthString));

        aChar = (char*) malloc (aLengthString + 1);
        aStream->Read(aChar         , aLengthString);
        aChar[aLengthString] = 0;

        aString = aChar;
    } __finally {
        free (aChar);
    }
}

//===========================================================================
__TSelectedParam  TSelectedParam(bool aSelected, TCanvas *aCanvas)
{
   __TSelectedParam sp;

   sp.Selected = aSelected;
   sp.Canvas   = aCanvas;
                                   
   return sp;
}

//===========================================================================
TBaseClass::TBaseClass()
{
//   ParentLayer = NULL;

   fDefaultName  = "no name";
   fCaption      = "no caption";
   fClassName    = "no class";
   fNote         = "... ��� ������ ...";
   fCreateDate   = "99.99.9999";
   fShowCaption  =  true;

   fId         = -1;
   fParentId   = -1;

   fSelectedParam.Selected  = false;

   pManagerParam = NULL;
   pProjectParam = NULL;
   pCurModelTime = NULL;
}

//===========================================================================
TBaseClass::~TBaseClass()
{
}

//===========================================================================
void __fastcall TBaseClass::Set_SelectedParam(__TSelectedParam aValue)
{
   if (fSelectedParam.Selected == aValue.Selected) return;
   fSelectedParam = aValue;

   Draw_SelectedElement(aValue.Canvas);
};

//===========================================================================
void TBaseClass::LoadFromStream(TStream *aStream)
{
    LoadAnsiSringFromStream(aStream, fDefaultName);
    LoadAnsiSringFromStream(aStream, fCaption    );
    LoadAnsiSringFromStream(aStream, fClassName  );
    LoadAnsiSringFromStream(aStream, fNote       );
    LoadAnsiSringFromStream(aStream, fCreateDate );

    aStream->Read(&fParentId          , sizeof(fParentId)    );
    aStream->Read(&fId                , sizeof(fId)          );
    aStream->Read(&fShowCaption       , sizeof(fShowCaption) );
    aStream->Read(&fIndex             , sizeof(fIndex)       );
}

//===========================================================================
void TBaseClass::SaveToStream(TStream *aStream)
{
    SaveAnsiSringToStream(aStream, fDefaultName);
    SaveAnsiSringToStream(aStream, fCaption    );
    SaveAnsiSringToStream(aStream, fClassName  );
    SaveAnsiSringToStream(aStream, fNote       );
    SaveAnsiSringToStream(aStream, fCreateDate );

    aStream->Write(&fParentId          , sizeof(fParentId)    );
    aStream->Write(&fId                , sizeof(fId)          );
    aStream->Write(&fShowCaption       , sizeof(fShowCaption) );
    aStream->Write(&fIndex             , sizeof(fIndex)       );
}

//===========================================================================
void TBaseClass::Copy(void *aElement)
{
   TBaseClass *el = (TBaseClass*)aElement;

    // --- ����� �������� (�� ������ "����������� ������") ---
        el->DefaultName = DefaultName;
        el->Caption     = Caption;
        el->ClassName   = ClassName;
        el->Note        = Note;
        el->CreateDate  = CreateDate;
        el->ParentId    = ParentId;

        el->CreateAdress  = CreateAdress;

        el->pManagerParam = pManagerParam;
        el->pProjectParam = pProjectParam;
        el->pCurModelTime = pCurModelTime;
        el->ShowCaption   = fShowCaption;
}


