#ifndef _pmSerialInfoH_
#define _pmSerialInfoH_
// -----------------------------------
namespace nsPortInfo
{
    #define NAMESIZE 127
    // ---------
        typedef struct tag_SerialPortInfo {
          unsigned int  uiPortID;
          char          pcPortName[NAMESIZE];
          char          pcWindowsPortName[NAMESIZE];
          char          pcFriendlyName[NAMESIZE];
          char          pcPortName_FriendlyName[NAMESIZE];

          bool          isPortAlreadyConnected;
        } TSerialPortInfo;

    // ---------
        extern int  GetPortInfo ( unsigned int uiIndexFromZero, TSerialPortInfo *pPortInfoOut);
        extern void Set_FTDIBUS_LatemcyTime( unsigned int uiLatencyTime);

        extern void Get_SerialPorts(Classes::TStrings *aStrings, bool bCheckConnected);

    // ------------------  Ёти параметры заполн€ютьс€, при вызове функции, Get_SerialPorts() ----------
        extern TSerialPortInfo PortInfoArray[255];
        extern int             CountPortInfo; /// -----
}
// -----------------------------------
extern void SetupPortsLatencyTime(int aLatencyTime);
extern void LoadSystemCOMName             (char **&COMArray, int &COMCount); // ---- QueryDosDevice ---
extern void LoadSystemCOMName_fromRegistry(char **&COMArray, int &COMCount);
// -----------------------------------
#endif
