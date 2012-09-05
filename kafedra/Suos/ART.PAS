function ArTn(sa,ca:real):real;
begin
 if ca=0 then
         if sa>0 then artn:=pi/2 else artn:=-pi/2
         else artn:=arctan(sa/ca);
 if (ca<0) and (sa<0) then artn:=arctan(sa/ca)-pi;
 if (ca<0) and (sa>0) then artn:=arctan(sa/ca)+pi;
end;  {function ArTn}
