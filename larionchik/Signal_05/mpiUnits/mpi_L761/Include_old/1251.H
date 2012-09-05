class DaqL1251: public LDaqBoard
{
public:
   // Base functions
   IFC(ULONG) GetWord_DM(USHORT Addr, PUSHORT Data);
   IFC(ULONG) PutWord_DM(USHORT Addr, USHORT Data);

   IFC(ULONG) SendCommand(USHORT cmd);
      
   // Service functions
   IFC(ULONG) LoadBios(char *FileName);

   IFC(ULONG) PlataTest();


   IFC(ULONG) GetParameter(ULONG name, PULONG param);


public:
   DaqL1251(ULONG Slot) :LDaqBoard(Slot) {}
   ULONG FillADCparameters(PDAQ_PAR sp);
   ULONG FillDACparameters(PDAQ_PAR sp);

   ULONG InputTTL(PDAQ_PAR sp); //2 in 1 all
   ULONG OutputTTL(PDAQ_PAR sp);  // in each set channel

   ULONG ConfigDAC(PDAQ_PAR sp);
   ULONG OutputDAC(PDAQ_PAR sp); //2 in 1

   ULONG InputADC(PDAQ_PAR sp);


protected:
   ULONG fill(ULONG *LP, LONG n);

};

