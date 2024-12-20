//===========================================================================
void TfrmMain::LoadManagerParamFromRegistry()
{
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;
           AnsiString appName = MainRegistryKeyValue;//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);

           //ExtractFileName(Application->ExeName);
           Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- ����������� � Uses Windows
           Reg->OpenKey("Software\\Digital Systems & Technologies\\" + appName + "\\Manager Parameters", true); //create a new key >> .ext

           ManagerParam.FonColor      =  (TColor) Reg->ReadInteger("Fon Color");
           ManagerParam.NetColor      =  (TColor) Reg->ReadInteger("Net Color");
           ManagerParam.NetEnabled    =           Reg->ReadBool   ("Net Enabled");
           ManagerParam.AutoLinkColor =           Reg->ReadBool   ("AutoLinkColor");
        } catch ( ... ){
           SetDefaultManagerParam();
        }
    } __finally {
        if (Reg != NULL) delete Reg;
    }
}

//===========================================================================
void TfrmMain::SetDefaultManagerParam()
{
    ManagerParam.FonColor      = clWhite;
    ManagerParam.NetColor      = (TColor) RGB(132, 132, 132);
    ManagerParam.NetEnabled    = true;
    ManagerParam.AutoLinkColor = true;
}

//===========================================================================
void TfrmMain::SaveManagerParamToRegistry()
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = MainRegistryKeyValue;//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);

         //ExtractFileName(Application->ExeName);
         Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- ����������� � Uses Windows
         Reg->OpenKey("Software\\Digital Systems & Technologies\\" + appName + "\\Manager Parameters", true); //create a new key >> .ext

         Reg->WriteInteger("Fon Color"    , ManagerParam.FonColor);
         Reg->WriteInteger("Net Color"    , ManagerParam.NetColor);
         Reg->WriteBool   ("Net Enabled"  , ManagerParam.NetEnabled );
         Reg->WriteBool   ("AutoLinkColor", ManagerParam.AutoLinkColor );
      } __finally {
        if (Reg != NULL) delete Reg;
      }
}

//===========================================================================
void TfrmMain::RegisterFileType(AnsiString prefix, AnsiString exepfad, int IconIndex)
{
      TRegistry  *reg = new TRegistry;
    //AnsiString  aKeyValue = "DiALab scheme file";
      AnsiString  aKeyValue = prefix+"file";

      try {
          reg->RootKey = HKEY_CLASSES_ROOT;
          reg->CreateKey("."+prefix); //create a new key >> extfile
          reg->OpenKey("."+prefix,true); //create a new key >> .ext
          reg->WriteString("", aKeyValue); //create a new value for this key >> extfile
          reg->CloseKey();

          reg->CreateKey(aKeyValue); //create a new key >> extfile

          reg->OpenKey(aKeyValue + "\\DefaultIcon",true);  //create a new key extfile\DefaultIcon
          reg->WriteString("",exepfad+","+IntToStr(IconIndex));  //and create a value where the icon is stored >> c:\project1.exe,0
          reg->CloseKey();

          reg->OpenKey(aKeyValue + "\\Shell\\DiALab - ������� �����\\Command",true);
          reg->WriteString("",exepfad + " '%1'");  //create value where exefile is stored --> c:\project1.exe "%1"
          reg->CloseKey();
      } __finally {
          delete reg;
      }
}

//===========================================================================
void TfrmMain::SaveDTSParam()
{
      TRegistry *Reg = NULL;
      try {
         Reg = new TRegistry;
         AnsiString appName = MainRegistryKeyValue;//"DiALab - Digital & Analog Laboratory";//ExtractFileName(Application->ExeName); appName.SetLength(appName.Length() - 4);

         ExtractFileName(Application->ExeName);
         Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- ����������� � Uses Windows
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
