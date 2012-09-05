void TfrmMain::ReadDataFromRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = ExtractFileName(Application->ExeName);
           appName.SetLength(appName.Length() - 4);

           Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
           Reg->OpenKey("Software\\pm\\Signal", true); //create a new key >> .ext

           //CanalsCount         = Reg->ReadInteger("CanalCount");
           //TermometrPortIndex  = Reg->ReadInteger("TermometrPortIndex");
           //CountSumPoint       = Reg->ReadFloat  ("CountSumPoint");
       } catch ( ... ){
            //TermometrPortIndex = -1;
            //CountSumPoint      = 100;
            SaveDataToRegistry();
        }
    } __finally {
        if (Reg != NULL) delete Reg;
    }
}

//---------------------------------------------------------------------------
void TfrmMain::SaveDataToRegistry()
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = ExtractFileName(Application->ExeName);//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);
         appName.SetLength(appName.Length() - 4);

         Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
         Reg->OpenKey("Software\\pm\\Signal", true); //create a new key >> .ext

         //Reg->WriteInteger("TermometrPortIndex", TermometrPortIndex );
         //Reg->WriteFloat  ("CountSumPoint"     , CountSumPoint      );
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

