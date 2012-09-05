//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "unnit_main.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm6 *Form6;
//---------------------------------------------------------------------------
__fastcall TForm6::TForm6(TComponent* Owner)
	: TForm(Owner)
{
}
//---------------------------------------------------------------------------
#include "math.h"
void __fastcall TForm6::FormCreate(TObject *Sender)
{
	char  BuffPoint_05 = 0;
	char  BuffPoint_10 = 0;
    char  Counter_32   = 0;
    float cursin;
    float AntiNodeBuffer[128] = {0};
    float NodeBuffer[128] = {0};

        for ( int i = 0; i < 164; i++ )
        {
            cursin = sin (i / 20.0 * 2.0 * 3.14);

            BuffPoint_10 = Counter_32 - 10;  BuffPoint_10 &= 0x3f;
            BuffPoint_05 = Counter_32 -  5;  BuffPoint_05 &= 0x3f;

                //pGyro->AntiNodeBuffer[Counter_32] = New_Antinode_s;
                //pGyro->NodeBuffer    [Counter_32] = New_Node_s;
                AntiNodeBuffer[Counter_32] = cursin;
                NodeBuffer    [Counter_32] = i;

                ListBox1->Items->Add((int)Counter_32  );
                ListBox2->Items->Add((int)BuffPoint_05);
                ListBox3->Items->Add((int)BuffPoint_10);
                Chart1->Series[0]->Add(AntiNodeBuffer[Counter_32]);
                Chart1->Series[1]->Add(AntiNodeBuffer[BuffPoint_05]);
                Chart1->Series[2]->Add(AntiNodeBuffer[BuffPoint_10]);



                //pGyro->AntiNode_sign [0]          = ( pGyro->AntiNodeBuffer[BuffPoint_10] >= 0 ) ? 1 : -1;
                //pGyro->Node_sign     [0]          = ( pGyro->NodeBuffer    [BuffPoint_10] >= 0 ) ? 1 : -1;

            Counter_32++; Counter_32 &= 0x3f;
        }



///////// Variables //////////////////
//        int   X_DelayPoint  =  20;

//////////////////////////////////////
//        float X_Buffer[128]     = {0};
//        int   X_BufferPoint     =   0;
//        int   Current_BuffPoint =   0;

///////// Algo  /////////////////                        -

//        X_Buffer[Current_BuffPoint] = InputValue;
//
//        X_BufferPoint = Current_BuffPoint - X_DelayPoint;
//        X_BufferPoint &= 0x3f;
//
//        Current_BuffPoint++;
//        Current_BuffPoint &= 0x3f;


        //X_Buffer[X_BufferPoint]
}
//---------------------------------------------------------------------------
