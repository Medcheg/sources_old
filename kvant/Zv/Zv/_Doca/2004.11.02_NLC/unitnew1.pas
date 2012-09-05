unit unitnew1;
interface
uses graphics;
type
     ver=array [1..8] of TColor;
     nver=array [1..8] of real;
 const
      arver:ver=(clGray,clNavy,clBlue,clOlive,clAqua,clGreen,clLime,clYellow);
      arnver:nver=(0.1,0.3,0.5,0.7,0.9,0.95,0.99,0.999);
function calccolnum(aff:real):TColor;
implementation
function calccolnum(aff:real):TColor;
  begin
           if aff<0.005 then calccolnum:=0 else
           if aff<arnver[2] then calccolnum:=arver[1] else
           if aff<arnver[3] then calccolnum:=arver[2] else
           if aff<arnver[4] then calccolnum:=arver[3]  else
           if aff<arnver[5] then calccolnum:=arver[4]  else
           if aff<arnver[6] then calccolnum:=arver[5]  else
           if aff<arnver[7] then calccolnum:=arver[6] else
           if aff<arnver[8] then calccolnum:=arver[7] else
           calccolnum:=arver[8];
           if (aff>arnver[8]) AND (aff<=1) then calccolnum:=arver[8];
             end;
BEGIN
END.