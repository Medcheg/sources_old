unit UN0_A;
interface
uses graph;
procedure PART0;
var  ee,driver,regim: integer;
implementation
 procedure PART0;
BEGIN;
driver:=detect;
initgraph(driver,regim,'C:\BP\bgi');
setbkcolor(blue);setcolor(white);
ee:=graphresult;
if ee<>grok then writeln(grapherrormsg(ee)) else
begin
 SetTextStyle(DefaultFont,HorizDir,4);
 OutTextXY(16,35,' ����������������� ');
 OutTextXY(50,100,'    ��������� ');
  SetTextStyle(DefaultFont,HorizDir,3);
 OutTextXY(1,170,'    �஢�ન ����祭��    ');
 OutTextXY(1,210,' �筮���� �ࠪ���⨪ ');
 OutTextXY(1,250,'  ᮯ஢������� � ०���  ');
 OutTextXY(1,290,'  �筮�� ᮯ஢�������   ');
 OutTextXY(1,330,'    �� ��饭�� ���      ');
 readln;
 CloseGraph;
end;
end;
END.