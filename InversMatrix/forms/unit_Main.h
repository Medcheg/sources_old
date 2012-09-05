//---------------------------------------------------------------------------

#ifndef unit_MainH
#define unit_MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Grids.hpp>
//---------------------------------------------------------------------------
typedef void (*TCallInvMethod)(int aSize, TFloat *inMatrix, TFloat *outMatrix);

class TForm19 : public TForm
{
__published:	// IDE-managed Components
    TStringGrid *StringGrid1;
    TStringGrid *StringGrid2;
    TLabel *Label1;
    TLabel *Label2;
    TButton *Button1;
    TLabel *Label3;
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall StringGrid2Exit(TObject *Sender);
    void __fastcall FormShow(TObject *Sender);
private:	// User declarations
    void PrintMatrix(TStringGrid *sg, bool LongSize, unsigned int RowCount, unsigned int ColumCount, char *aCaption, TFloat *m, double coef);
    void CalcFunction (TCallInvMethod aCallFunc, int aSize, TFloat* inMatrix, char *Caption);
public:		// User declarations
    __fastcall TForm19(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm19 *Form19;
//---------------------------------------------------------------------------
#endif
