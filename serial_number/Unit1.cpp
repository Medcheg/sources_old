//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
  try {
      //Привязка к серийному номеру винта.
        unsigned long  aa = MAX_PATH;
        char  VolumeName[MAX_PATH], FileSystemName[MAX_PATH];
        unsigned long  VolumeSerialNo;
        unsigned long  MaxComponentLength, FileSystemFlags;

        GetVolumeInformation("C:\\", VolumeName, aa, &VolumeSerialNo,
                             &MaxComponentLength,&FileSystemFlags,
                             FileSystemName,aa);

        AnsiString as1 = "VName = "; as1 = as1 +  + VolumeName;
        AnsiString as2 = "FSName = "; as2 = as2 +  + FileSystemName;

        Memo1->Clear();
        Memo1->Lines->Add("C:\\");
      //  Memo1->Lines->Add(as1);
        Memo1->Lines->Add("SerialNo = $"+IntToHex((int)VolumeSerialNo,8));
      /*  Memo1->Lines->Add("CompLen = "+IntToStr(MaxComponentLength));
        Memo1->Lines->Add("Flags = $"+IntToHex((int)FileSystemFlags,4));
        Memo1->Lines->Add(as2);*/
        Memo1->Lines->Add("");
        Memo1->Lines->Add("");


        GetVolumeInformation("D:\\", VolumeName, aa, &VolumeSerialNo,
                             &MaxComponentLength,&FileSystemFlags,
                             FileSystemName,aa);

        as1 = "VName = "; as1 = as1 +  + VolumeName;
        as2 = "FSName = "; as2 = as2 +  + FileSystemName;

        Memo1->Lines->Add("D:\\");
      //  Memo1->Lines->Add(as1);
        Memo1->Lines->Add("SerialNo = $"+IntToHex((int)VolumeSerialNo,8));
      /*  Memo1->Lines->Add("CompLen = "+IntToStr(MaxComponentLength));
        Memo1->Lines->Add("Flags = $"+IntToHex((int)FileSystemFlags,4));
        Memo1->Lines->Add(as2);*/
  } catch ( ... ) {
  }
}
//---------------------------------------------------------------------------
 