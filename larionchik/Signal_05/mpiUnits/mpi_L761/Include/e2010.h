class DaqE2010: public LDaqBoard
{
public:
   // Base functions NO

   // Service functions
   IFC(ULONG) PlataTest();
   //IFC(ULONG) EnableCorrection(USHORT Ena);
      
   IFC(ULONG)  LoadBios(char *FileName);

   IFC(ULONG)  ReadPlataDescr(LPVOID pd);
   IFC(ULONG)  WritePlataDescr(LPVOID pd, USHORT Ena);

public:
   DaqE2010(ULONG Slot) :LDaqBoard(Slot) {}
   ULONG  FillADCparameters(PDAQ_PAR sp);

   ULONG InputTTL(PDAQ_PAR sp);  //2 in 1 all
   ULONG OutputTTL(PDAQ_PAR sp);  // in each set channel
   ULONG ConfigTTL(PDAQ_PAR sp); // 1221 and 1450 780C e440

   ULONG OutputDAC(PDAQ_PAR sp); //2 in 1
//   ULONG InputADC(PDAQ_PAR sp);

protected:
};
