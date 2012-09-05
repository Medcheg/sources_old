//---------------------------------------------------------------------------
#ifndef mpiBlackBoxH
#define mpiBlackBoxH
//---------------------------------------------------------------------------
#include "Forms.hpp"

//---------------------------------------------------------------------------
#define COUNT_CONTROL_VALUES 10
#define COUNT_VALUES         20000

#define COUNT_VIDEO_FRAME    80
#define VIDEO_FRAME_SIZE     51200
class CComPort;

// -------
#pragma pack(push, 1)
typedef struct _SVideoHeader
{
  char               Description[2]; // ---- ���� ������ BB  (BB = BlackBox) ----
  unsigned char      Version;        // ---- ������������ ����� "������ �����"
  unsigned char      FrameFrequency;  // ����� ������ � �������
  int                reserved;
  unsigned short int FrameWdth;   // ������ �����
  unsigned short int FrameHeight;  // ������ �����
  unsigned int       FramesCount;  // ����� ������
} SVideoHeader;
#pragma pack(pop)

// -------
class TBEvent{
public:
    // ------------
       int               day;
       int               month;
       int               year;
       int               hour;
       int               min;
       int               sec;
    // ------------
       short int         zero_time;
       bool              isCorrectEvent;
    // ------------
       unsigned long int Events_point;
       unsigned long int Number_of_byte_after_event;
       unsigned short int values[COUNT_VALUES][COUNT_CONTROL_VALUES];
       unsigned short int true_values[COUNT_VALUES][COUNT_CONTROL_VALUES];
       int                BlocksCount;
       int                RealBlockCount;

    // ------
       unsigned char      VideoData[COUNT_VIDEO_FRAME][VIDEO_FRAME_SIZE];  // ----- 80 ������ �� 512000 ���� -------
       int                FrameNumber[COUNT_VIDEO_FRAME];
    // ------
       int                CurrentTemp;
       AnsiString         ExportFolderName;
    // ------------
       TBEvent();
};


//---------------------------------------------------------------------------
class CBlackBox
{
public:
    unsigned int   BytesRead;   // ----- ���������� ����������� ���� � ��� ����� ------
    unsigned char *ReadBuffer;

    bool           isDataReading;

    CBlackBox();
   ~CBlackBox();
    void SendCommand(CComPort *aComPort, unsigned char *aCommand);
};
                                                                                                                                       
//---------------------------------------------------------------------------
extern CBlackBox *BlackBox;
extern int        EventCount;
extern TBEvent   *Events;
extern SVideoHeader  VideoHeader;
extern char          LogFileName[4096];
//---------------------------------------------------------------------------
#endif
