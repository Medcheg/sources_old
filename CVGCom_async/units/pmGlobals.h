//===========================================================================
#ifndef pmGlobalsH
#define pmGlobalsH
//===========================================================================
typedef struct tag_SelectPart
{
    int x1;
    int x2;
} TSelectPart;
//===========================================================================

extern bool isShowAllanButton;
extern bool isShowAnalisButton;

extern char ProjectCaption[1024];
extern char DeviceNames[][255];

extern bool isDebugMode;
extern bool isUsedPasha;
extern AnsiString ApplicationFolder;


//===========================================================================
#endif
