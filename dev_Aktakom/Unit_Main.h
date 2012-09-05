//---------------------------------------------------------------------------

#ifndef Unit_MainH
#define Unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
#include "AME1204.h"
#include <Grids.hpp>
#include <ValEdit.hpp>
#include <ComCtrls.hpp>
//---------------------------------------------------------------------------
/****************************************************************************
 *  ���������� ����������
 ****************************************************************************/
ViChar       err_mess[1024];           /* ������ ��� ��������� �� �������    */
ViStatus     error;                    /* ��� ������                         */
ViSession    devHandle = INVALID_VIHANDLER_VALUE;  /* ���������� �������     */
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TTimer *Timer1;
        TValueListEditor *ValueListEditor1;
        TGroupBox *NetBox;
        TLabeledEdit *ServerName;
        TLabeledEdit *ServerPort;
        TUpDown *ServerPortUD;
        TUpDown *ServerTimeoutUD;
        TLabeledEdit *ServerTimeout;
        TButton *ServerConnect;
        void __fastcall Timer1Timer(TObject *Sender);
        void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
        void __fastcall FormShow(TObject *Sender);
        void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
private:	// User declarations
        HANDLE   h_file;
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
