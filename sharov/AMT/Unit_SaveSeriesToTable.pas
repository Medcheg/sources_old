unit Unit_SaveSeriesToTable;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ComObj, MPIDeclaration;

type
  TfrmSaveSeriesToTable = class(TForm)
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    MySeries    : TMySeries;
    FirstPoint  : Integer;
    SecondPoint : Integer;
  public
    procedure Set_Param(aSeries : TMySeries; aFirstPoint, aSecondPoint : integer);
  end;

var
  frmSaveSeriesToTable: TfrmSaveSeriesToTable;

implementation

{$R *.DFM}

{ TfrmSaveSeriesToTable }

procedure TfrmSaveSeriesToTable.Set_Param(aSeries: TMySeries;
  aFirstPoint, aSecondPoint: integer);
var
  TempValue : Integer;
begin
  FirstPoint  := aFirstPoint;
  SecondPoint := aSecondPoint;
  MySeries    := ASeries;
  TempValue   := Trunc((MySeries.TimeData[10]-MySeries.TimeData[9])/TimeInOneSecond)+1;
  if TempValue < 1 then TempValue := 1;
  SpinEdit1.Value := TempValue;
end;

procedure TfrmSaveSeriesToTable.BitBtn1Click(Sender: TObject);
var MyExcel                : Variant;
    i                      : Integer;
    CurrentStep            : Integer;
    CurrentPosTableInExcel : Integer;
begin
    Try
      MyExcel:=CreateOleObject('Excel.Application');
    except
      beep;
      MessageDlg('Выполнение этой операции не допустимо.  Установите Microsoft Excel', mtError, [mbOk],0);
      close;
      Exit;
    end;
    MyExcel.Visible:=true;
    MyExcel.WorkBooks.Add;
    MyExcel.Sheets.item[1].name := 'АМТ-9000';
    MyExcel.Sheets.item[1].Cells[1,1].Value := 'Абсолютное время';
    MyExcel.Sheets.item[1].Cells[1,3].Value := 'Реальное время';
    MyExcel.Sheets.item[1].Cells[1,6].Value :=  MySeries.Name;

    CurrentStep            := FirstPoint;
    CurrentPosTableInExcel := 1;

    For i := FirstPoint to SecondPoint do begin
       if MySeries.TimeData[i] - MySeries.TimeData[CurrentStep] > SpinEdit1.Value*TimeInOneSecond then begin
          try
            MyExcel.Sheets.item[1].Cells[CurrentPosTableInExcel+2, 1].Value := TimeToStr(MySeries.TimeData[CurrentStep]-MySeries.TimeData[FirstPoint]);
            MyExcel.Sheets.item[1].Cells[CurrentPosTableInExcel+2, 3].Value := DateTimeToStr(MySeries.StartDateTime + MySeries.TimeData[CurrentStep]);
            MyExcel.Sheets.item[1].Cells[CurrentPosTableInExcel+2, 6].Value := MySeries.Data[CurrentStep];
            inc(CurrentPosTableInExcel);
            CurrentStep := i;
          except end;
       end;
    end;
    close;
end;

end.
