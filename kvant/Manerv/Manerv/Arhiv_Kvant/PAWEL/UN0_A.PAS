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
 OutTextXY(16,35,' ИССЛЕДОВАТЕЛЬСКАЯ ');
 OutTextXY(50,100,'    ПРОГРАММА ');
  SetTextStyle(DefaultFont,HorizDir,3);
 OutTextXY(1,170,'    проверки получения    ');
 OutTextXY(1,210,' точностных характеристик ');
 OutTextXY(1,250,'  сопровождения в режиме  ');
 OutTextXY(1,290,'  точного сопровождения   ');
 OutTextXY(1,330,'    при вращении ФАР      ');
 readln;
 CloseGraph;
end;
end;
END.