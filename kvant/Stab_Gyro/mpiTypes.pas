unit mpiTypes;

interface

type
  // ----- Тип данных для аэродинамического момента по оси КУ --------------
  TAirVozm = record
     h1_big, h2, h, a, ro, Vb, b1, h1_small, b :Extended;
     l1, l2, l3, l4, r11, cx, cx1, m1, m2, m3, m4, result : Extended;
  end;

var
 AirVozm : TAirVozm;

implementation


begin
  // ------------------
     with AirVozm do begin
           h1_big   := 1.323;
           h2       := 1.155;
           h        := 1.376;
           a        := 0.71;
           ro       := 0.125;
           Vb       := 50;
           b1       := 0.472;
           h1_small := 1.192;
           b        := 0.472;
     end;
  // ------------------
  
end.
