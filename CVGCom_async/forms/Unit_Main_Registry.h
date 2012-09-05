//===========================================================================
void Tform_Main::ReadDataFromRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);

           Reg->RootKey = HKEY_LOCAL_MACHINE;
           Reg->OpenKey("Software\\InnalabsUA\\CVGCom", true);
       } catch ( ... ){
           SaveDataToRegistry();
        }
    } __finally {
        if (Reg != NULL) delete Reg; Reg = NULL;
    }
}

//===========================================================================
void Tform_Main::SaveDataToRegistry()
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = ExtractFileName(Application->ExeName);
         appName.SetLength(appName.Length() - 4);

         Reg->RootKey = HKEY_LOCAL_MACHINE;
         Reg->OpenKey("Software\\InnalabsUA\\CVGCom", true);
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

//===========================================================================

