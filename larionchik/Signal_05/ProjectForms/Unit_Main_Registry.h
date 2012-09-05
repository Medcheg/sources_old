void TfrmMain::ReadDataFromRegistry()
{
    AnsiString Name;
    TRegistry *Reg = NULL;
    try {
        try {
           Reg = new TRegistry;

           Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows

           Reg->OpenKey("Software\\pm\\Signal", true);
               ChartBeginFreq    = Reg->ReadFloat("ChartFFTBeginFreq");
               ChartEndFreq      = Reg->ReadFloat("ChartFFTEndFreq");
               cbFindFFTMaximums = Reg->ReadBool("cbFindFFTMaximums");
           Reg->CloseKey();

           Reg->OpenKey("Software\\pm\\Signal\\L-761", true);
               // ---- Каналы АЦП ------
                 bool isConnect = false;;
                 L761->ChanelsID.Clear();
                 for ( int i = 0; i < 32; i++)
                 {
                     isConnect = Reg->ReadBool("canal_" + IntToStr(i));
                     if ( isConnect == true )
                        L761->ChanelsID.Add(i);
                 }
               // ---- Доп параметры ------
                L761->is16CanalConect   = Reg->ReadBool   ("is16CanalConect");
                L761->isPhaseCorrection = Reg->ReadBool   ("isPhaseCorrection");
                L761->UsilIndex         = Reg->ReadInteger("UsilIndex");
                L761->AcpCanalFreq      = Reg->ReadFloat  ("ACPCanalFreq");
                L761->WorkTime          = Reg->ReadFloat  ("WorkTime");
           Reg->CloseKey();

           //CanalsCount         = Reg->ReadInteger("CanalCount");
           //TermometrPortIndex  = Reg->ReadInteger("TermometrPortIndex");
           //CountSumPoint       = Reg->ReadFloat  ("CountSumPoint");
       } catch ( ... ){
            ChartBeginFreq = 200;
            ChartEndFreq   = 1200;
            cbFindFFTMaximums = true;
            // --- L-761 ----
            L761->ChanelsID.Clear();
            L761->ChanelsID.Add(12);
            L761->ChanelsID.Add(13);
            L761->ChanelsID.Add(14);
            L761->ChanelsID.Add(15);
            L761->is16CanalConect   = true;
            L761->isPhaseCorrection = true;

            L761->UsilIndex       = 0;
            L761->AcpCanalFreq    = 20000;
            L761->WorkTime        = 60;
            // ----------
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

         Reg->RootKey = HKEY_LOCAL_MACHINE;  /// ---- Находитться в Uses Windows
         Reg->OpenKey("Software\\pm\\Signal", true);
             Reg->WriteFloat("ChartFFTBeginFreq", ChartBeginFreq);
             Reg->WriteFloat("ChartFFTEndFreq", ChartEndFreq);
             Reg->WriteBool ("cbFindFFTMaximums", cbFindFFTMaximums);
         Reg->CloseKey();

         Reg->OpenKey("Software\\pm\\Signal\\L-761", true);
               // ---- Каналы АЦП ------
                 for ( int i = 0; i < 32; i++)
                 {
                      bool isTrue = false;
                      for ( int k = 0; k < L761->ChanelsID.Count; k++)
                            if ( L761->ChanelsID.Values[k] == i ) isTrue = true;

                      Reg->WriteBool("canal_" + IntToStr(i), isTrue);      
                 }
               // ---- Доп параметры ------
                 Reg->WriteBool   ("is16CanalConect"  , L761->is16CanalConect);
                 Reg->WriteBool   ("isPhaseCorrection", L761->isPhaseCorrection);
                 Reg->WriteInteger("UsilIndex"        , L761->UsilIndex);
                 Reg->WriteFloat  ("ACPCanalFreq"     , L761->AcpCanalFreq);
                 Reg->WriteFloat  ("WorkTime"         , L761->WorkTime);
         Reg->CloseKey();

      } __finally {
        if (Reg != NULL) delete Reg;
      }
}


