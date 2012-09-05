unit dlgTable;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, ComCtrls, DeclPasha, Buttons;

Const
  HeadStr : array [0..14] of String[20] = ('            Время, с',
                                           '      Килевая  качка',
                                           '      Бортовая качка',
                                           '       Заданный курс',
                                           '          Угол места',
                                           '    Рыскание корабля',
                                           '                 Q_k',
                                           '               Eps_K',
                                           '   Привод КУ (выход)',
                                           '  Привод КУ (ошибка)',
                                           '   Привод УM (выход)',
                                           '  Привод УM (ошибка)',
                                           '                P_ca',
                                           '              Eps_ca',
                                           '               Kappa');
type
  TfrmTable = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    BitBtn1: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure PageControl1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar2Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure BitBtn1Click(Sender: TObject);
  private
     Procedure OutDataToStringGrid  (strGrid   : TStringGrid; Plat : TPPlatform; pos : integer);
     Procedure SaveStringGridToFile (fileName  : String; Plat : TPPlatform);
     Function GetRealString(Data : Single):String;

  public
    { Public declarations }
  end;

var
  frmTable: TfrmTable;

implementation

Uses Main;

{$R *.DFM}

procedure TfrmTable.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmTable.FormCreate(Sender: TObject);
var
 i : byte;
begin
  SaveDialog1.Title:='AdaptiveDTS - Сохранение таблици в файл ...';
  SaveDialog1.Filter:='Табличные файлы(*.tab)|*.tab';
  SaveDialog1.DefaultExt := '.tab';
  for i:=0 to 14 do StringGrid1.Cells[i,0] := HeadStr[i];
  for i:=0 to 14 do StringGrid2.Cells[i,0] := HeadStr[i];
end;

procedure TfrmTable.OutDataToStringGrid(strGrid : TStringGrid; Plat: TPPlatform; pos : integer);
var
  i : integer;
begin
  for i:=0 to 10 do begin
      strGrid.Cells[0 ,i+1] := FloatToStrF((i+pos)/GrTakt                             , ffFixed, 10,6);
      strGrid.Cells[1 ,i+1] := FloatToStrF(Plat.Kachka_Ksi. GrArray^.PrGr^[i+pos]     , ffFixed, 10,6);
      strGrid.Cells[2 ,i+1] := FloatToStrF(Plat.Kachka_Teta.GrArray^.PrGr^[i+pos]     , ffFixed, 10,6);
      strGrid.Cells[3 ,i+1] := FloatToStrF(Plat.k_k_GrArray^.PrGr^[i+pos]             , ffFixed, 10,6);
      strGrid.Cells[4 ,i+1] := FloatToStrF(Plat.Eps_C_GrArray^.PrGr^[i+pos]           , ffFixed, 10,6);
      strGrid.Cells[5 ,i+1] := FloatToStrF(Plat.Riskanie_GrArray^.PrGr^[i+pos]        , ffFixed, 10,6);
      strGrid.Cells[6 ,i+1] := FloatToStrF(Plat.PC1.GrArray1^.PrGr^[i+pos]            , ffFixed, 10,6);
      strGrid.Cells[7 ,i+1] := FloatToStrF(Plat.PC1.GrArray2^.PrGr^[i+pos]            , ffFixed, 10,6);
      strGrid.Cells[8 ,i+1] := FloatToStrF(Plat.PrivodKU.GrArrayOut^.PrGr^[i+pos]     , ffFixed, 10,6);
      strGrid.Cells[9 ,i+1] := FloatToStrF(Plat.PrivodKU.GrArrayOshibka^.PrGr^[i+pos] , ffFixed, 10,6);
      strGrid.Cells[10,i+1] := FloatToStrF(Plat.PrivodUM.GrArrayOut^.PrGr^[i+pos]     , ffFixed, 10,6);
      strGrid.Cells[11,i+1] := FloatToStrF(Plat.PrivodUM.GrArrayOshibka^.PrGr^[i+pos] , ffFixed, 10,6);
      strGrid.Cells[12,i+1] := FloatToStrF(Plat.PC2.GrArray1^.PrGr^[i+pos]            , ffFixed, 10,6);
      strGrid.Cells[13,i+1] := FloatToStrF(Plat.PC2.GrArray2^.PrGr^[i+pos]            , ffFixed, 10,6);
      strGrid.Cells[14,i+1] := FloatToStrF(Plat.PC2.GrArray3^.PrGr^[i+pos]            , ffFixed, 10,6);
  end;
end;

procedure TfrmTable.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:=TabSheet1;
  ScrollBar1.Min      := 0;
  ScrollBar2.Min      := 0;
  if frmMain.FPlatform1.CurrentGraphicPoint = 0 then ScrollBar1.Max := 1
                                                else ScrollBar1.Max := frmMain.FPlatform1.CurrentGraphicPoint-1;
  if frmMain.FPlatform1.CurrentGraphicPoint = 0 then ScrollBar2.Max := 1
                                                else ScrollBar2.Max := frmMain.FPlatform1.CurrentGraphicPoint-1;
  ScrollBar1.Position := 0;
  ScrollBar2.Position := 0;
  OutDataToStringGrid(StringGrid1, frmMain.FPlatform1, ScrollBar1.Position);
end;

procedure TfrmTable.ScrollBar1Change(Sender: TObject);
begin
  OutDataToStringGrid(StringGrid1, frmMain.FPlatform1, ScrollBar1.Position);
end;

procedure TfrmTable.ScrollBar1Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  OutDataToStringGrid(StringGrid1, frmMain.FPlatform1, ScrollPos);
end;

procedure TfrmTable.ScrollBar2Change(Sender: TObject);
begin
  OutDataToStringGrid(StringGrid2, frmMain.FPlatform2, ScrollBar2.Position);
end;

procedure TfrmTable.ScrollBar2Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  OutDataToStringGrid(StringGrid2, frmMain.FPlatform2, ScrollPos);
end;

procedure TfrmTable.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheet1 then OutDataToStringGrid(StringGrid1, frmMain.FPlatform1, ScrollBar1.Position);
  if PageControl1.ActivePage = TabSheet2 then OutDataToStringGrid(StringGrid2, frmMain.FPlatform2, ScrollBar2.Position);

end;


function TfrmTable.GetRealString(Data: Single): String;
var
  Temp      : String;
  TempSpace : String;
  i         : byte;
begin
  temp := FloatToStrF(Data, ffFixed, 21,8);
  TempSpace:='';
  For i:=20-Length(Temp) DownTo 1 do TempSpace := TempSpace +' ';

  Result:= TempSpace + Temp;
end;

procedure TfrmTable.SaveStringGridToFile(fileName  : String; Plat: TPPlatform);
var
 f         : TextFile;
 i         : integer;
 CurString : AnsiString;
begin
      AssignFile(f, FileName);
      ReWrite(f);
      //------- Записываю заголовок файла ---------
      CurString:='';
      For i:=0 to 14 do CurString := CurString + HeadStr[i];
      WriteLn(f, CurString);
      //------- Записываю Данные ---------
      For i:=0 to frmMain.FPlatform1.CurrentGraphicPoint-1 do begin
           CurString:='';
           CurString := CurString + GetRealString((i)/GrTakt                            );
           CurString := CurString + GetRealString(Plat.Kachka_Ksi. GrArray^.PrGr^[i]    );
           CurString := CurString + GetRealString(Plat.Kachka_Teta.GrArray^.PrGr^[i]    );
           CurString := CurString + GetRealString(Plat.k_k_GrArray^.PrGr^[i]            );
           CurString := CurString + GetRealString(Plat.Eps_C_GrArray^.PrGr^[i]          );
           CurString := CurString + GetRealString(Plat.Riskanie_GrArray^.PrGr^[i]       );
           CurString := CurString + GetRealString(Plat.PC1.GrArray1^.PrGr^[i]           );
           CurString := CurString + GetRealString(Plat.PC1.GrArray2^.PrGr^[i]           );
           CurString := CurString + GetRealString(Plat.PrivodKU.GrArrayOut^.PrGr^[i]    );
           CurString := CurString + GetRealString(Plat.PrivodKU.GrArrayOshibka^.PrGr^[i]);
           CurString := CurString + GetRealString(Plat.PrivodUM.GrArrayOut^.PrGr^[i]    );
           CurString := CurString + GetRealString(Plat.PrivodUM.GrArrayOshibka^.PrGr^[i]);
           CurString := CurString + GetRealString(Plat.PC2.GrArray1^.PrGr^[i]           );
           CurString := CurString + GetRealString(Plat.PC2.GrArray2^.PrGr^[i]           );
           CurString := CurString + GetRealString(Plat.PC2.GrArray3^.PrGr^[i]           );
           WriteLn(f, CurString);
      end;
      CloseFile(f);
end;

procedure TfrmTable.BitBtn1Click(Sender: TObject);
begin
   if SaveDialog1.Execute then begin
      if PageControl1.ActivePage = TabSheet1 then SaveStringGridToFile (SaveDialog1.FileName, frmMain.FPlatform1);
      if PageControl1.ActivePage = TabSheet2 then SaveStringGridToFile (SaveDialog1.FileName, frmMain.FPlatform2);
   end;

end;

end.
