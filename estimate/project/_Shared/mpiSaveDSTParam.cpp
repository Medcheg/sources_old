//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include <registry.hpp>
#include "mpiSaveDSTParam.h"

//---------------------------------------------------------------------------
void SaveDTSParam()
{
  TRegistry *Reg = NULL;
  try {
     Reg = new TRegistry;
     AnsiString appName = ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);

     ExtractFileName(Application->ExeName);
     Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
     Reg->OpenKey("Software\\Digital Systems & Technologies\\" + appName, true); //create a new key >> .ext

     Reg->WriteString("_0_ Program Name", appName);
     Reg->WriteString("_1_ Program Location", ExtractFilePath(Application->ExeName));
     Reg->WriteString("_2_ Company Name", "Digital Systems & Technologies");
     Reg->WriteString("_3_ e-mail", "info@dst.com.ua");
     Reg->WriteString("_4_ e-mail", "dst@modus.net.ua");
     Reg->WriteString("_5_ WEB address", "http://dst.com.ua");
     Reg->WriteString("_6_ WEB address", "http://dst.modus.net.ua");
  } __finally {
    if (Reg != NULL) delete Reg;
  }
}

#pragma package(smart_init)
