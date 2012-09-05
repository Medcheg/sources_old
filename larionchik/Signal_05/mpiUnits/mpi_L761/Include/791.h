class DaqL791: public LDaqBoard
{
public:
   // Base functions
      // Service functions
   IFC(ULONG) PlataTest();


   IFC(ULONG)  ReadFlashWord(USHORT Addr, PUSHORT Data);
   IFC(ULONG)  WriteFlashWord(USHORT Addr, USHORT Data);
   IFC(ULONG)  ReadPlataDescr(LPVOID pd);
   IFC(ULONG)  WritePlataDescr(LPVOID pd, USHORT Ena);
   IFC(ULONG)  EnableFlashWrite(USHORT Flag);   

public:
   DaqL791(ULONG Slot) :LDaqBoard(Slot) {}

   ULONG csCloseLDevice(ULONG status);
   ULONG csRequestBufferStream(ULONG *Size, ULONG StreamId, ULONG status); //in words
   ULONG csSetParametersStream(PDAQ_PAR sp, PULONG UsedSize, void** Data, void** Sync, ULONG StreamId, ULONG status);

   ULONG  FillADCparameters(PDAQ_PAR sp);
   ULONG  FillDACparameters(PDAQ_PAR sp);

   ULONG InputTTL(PDAQ_PAR sp);  //2 in 1 all
   ULONG OutputTTL(PDAQ_PAR sp);  // in each set channel
   ULONG ConfigTTL(PDAQ_PAR sp); // 1221 and 1450 780C 791

   ULONG OutputDAC(PDAQ_PAR sp); //2 in 1

   ULONG InputADC(PDAQ_PAR sp);

protected:
};

/* Трактовка полей для платы L791

typedef struct _DAQ_PARAM_
{
   USHORT s_Type;
   USHORT FIFO;              // глубина фифо на плате до 128 отсчетов
   USHORT IrqStep;           //
   USHORT Pages;             // произведениеи их будет задавать счетчик генерации прерываний
} DAQ_PAR, *PDAQ_PAR;


typedef struct _ADC_PARAM_U_ : public DAQ_PAR
{
   USHORT AutoInit; // циклическая работа при пдп

   double dRate;    // задаем частоту АЦП
   double dKadr;    //интервал межу кадрами
   double dScale;   // не используем
   USHORT Rate;     // код для платы
   USHORT Kadr;     // код для платы
   USHORT Scale;    // код для платы
   USHORT FPDelay;  // код для платы

   USHORT SynchroType;
   USHORT SynchroSensitivity;
   USHORT SynchroMode;
   USHORT AdChannel;
   USHORT AdPorog;
   USHORT NCh;        // колво каналов
   USHORT Chn[128];   // логические номера
//   USHORT FIFO;
//   USHORT IrqStep;
//   USHORT Pages;
   USHORT IrqEna;     // разрешение прерываний
   USHORT AdcEna;     // разрешение ацп
} ADC_PAR, *PADC_PAR;
*/