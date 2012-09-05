#ifndef __EXAMPLE_H
#define __EXAMPLE_H

enum { INPUT_PANEL, DISK_PANEL, DAC_PANEL, TTL_PANEL, EXIT};
enum { CONST, SINUS, MEANDR, PILA, TRIAL};
enum {VISIBLE, HIDDEN};
enum {DISABLE, ENABLE};
enum {LED_OFF, LED_ON};

void Load_LBIOS(int Pnl);
void SetAllGain(void);
int AdcParamPanel(void);
int InputPanel(void);
int DiskPanel(void);
int DacPanel(void);
int TtlPanel(void);
void InitKeybRoutine(void);
void RestoreKeybRoutine(void);
void ShowNameInTitle(int Pnl);

#define CHANNEL_QUANTITY		0x4
#define KEYB_INTR 				0x9

#endif
