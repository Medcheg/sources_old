unit unitnew1;
interface
 type littleint=0..15;
     ver=array [1..8] of littleint;
     nver=array [1..8] of real;
 const
      arver:ver=(8,1,9,3,11,2,10,14);  {все цвета}
{      arver:ver=(0,0,8,3,11,11,11,11); } {все цвета}
{      arver:ver=(0,0,9,9,9,9,9,9);}   {вероятность 0.5}
      arnver:nver=(0.5,0.5,0.5,0.8,0.8,0.8,0.8,0.8);
{     arnver:nver=(0.1,0.3,0.5,0.7,0.9,0.95,0.99,0.999);}
      arnerr:nver=(0.0,0.001,0.005,0.01,0.05,0.1,0.3,0.5);
 function pol1(x:real):real;   {точность 1e-3}   {mfl=1}
 function pol2(x:real):real;                     {mfl=2}
 function pol3(x:real):real;                     {mfl=3}
 function pol4(x:real):real;                     {mfl=4}
 function pol5(x:real):real;                     {mfl=5}
 function calccolnum(aff:real):integer;
 function calccolnum1(aff:real):integer;
implementation
function pol1(x:real):real;
begin
  if x<3.0 then pol1:=0.0
  else if x<6.2 then pol1:=1.342673E-3*x*x-9.239463E-3*x+1.735042E-2
  else if x<8.3 then pol1:=1.091361E-2*x*x-1.309274E-1*x+4.057139E-1
  else if x<10.2 then pol1:=3.189780E-2*x*x-4.7998827E-1*x+1.858516
  else if x<11.5 then pol1:=2.425861E-2*x*x-3.1100149E-1*x+9.294289E-1
  else if x<12.6 then pol1:=-2.241454E-2*x*x+7.648720E-1*x-5.271382
  else if x<14.2 then pol1:=-4.910253E-2*x*x+1.424077*x-9.340443
  else if x<15.9 then pol1:=-9.833719E-3*x*x+3.060937E-1*x-1.381593
  else pol1:=1.0
end;
function pol2(x:real):real;
begin
  if x<0 then pol2:=1e-6
  else if x<4.40 then pol2:=1.553236e-3*x*x-1.720542e-3*x+1.813923e-3
  else if x<9.85 then pol2:=5.926593e-3*x*x-3.886899e-2*x+8.228876e-2
  else if x<13.4 then pol2:=-2.493077e-3*x*x+8.322135e-2*x-5.227854e-1
  else if x<20.74 then pol2:=-3.526431e-3*x*x+1.670642e-1*x-1.058115
  else if x<27.77 then pol2:=-1.264281e-3*x*x+7.333338e-2*x-8.523522e-1
  else if x<42.11 then pol2:=-1.516156e-4*x*x+1.198797e-2*x+7.621939e-1
  else pol2:=1.0
end;
function pol3(x:real):real;
begin
  if x<1 then pol3:=1e-6
  else if x<5.25 then pol3:=1.726660e-3*x*x-5.705767e-3*x+5.628254e-3
  else if x<9.30 then pol3:=9.219555e-3*x*x-8.480297e-2*x+2.161233e-1
  else if x<11.99 then pol3:=3.653789e-3*x*x+2.621840e-2*x-3.347513e-1
  else if x<15.91 then pol3:=-7.085122e-3*x*x+2.829502e-1*x-{1.871041}1.871043
  else if x<20.10 then pol3:=-4.979408e-3*x*x+2.099234e-1*x-1.242053
  else if x<26.10 then pol3:=-9.590711e-4*x*x+4.912277e-2*x+3.677557e-1
  else if x<28.50 then pol3:=-1.410667e-4*x*x+8.372024e-3*x+8.751273e-1
  else pol3:=1.0
end;
function pol4(x:real):real;
begin
  if x<0 then pol4:=1e-6
  else if x<4.60 then pol4:=1.736950e-3*x*x-2.354008e-3*x+1.953611e-3
  else if x<10.20 then pol4:=5.645676e-3*x*x-3.480053e-2*x+6.839605e-2
  else if x<14.15 then pol4:=-1.101113e-3*x*x+1.031678e-1*x-6.388569e-1
  else if x<21.1246 then pol4:=-3.418469e-3*x*x+1.633310e-1*x-1.026228
  else if x<28.38 then pol4:=-1.145715e-3*x*x+6.755435e-2*x-1.520622e-2
  else if x<42.00 then pol4:=-1.344592e-4*x*x+1.072303e-2*x+7.850797e-1
  else pol4:=1.0
end;

function pol5(x:real):real;
begin
  if x<1 then pol5:=1e-6
  else if x<5.265 then pol5:=1.726660e-3*x*x-5.705767e-3*x+5.628254e-3
  else if x<9.304 then pol5:=9.265373e-3*x*x-8.553662e-2*x+2.189347e-1
  else if x<12.08 then pol5:=3.359370e-3*x*x+3.240536e-2*x-3.671419e-1
  else if x<18.10 then pol5:=-7.290859e-3*x*x+2.886132e-1*x-1.909890
  else if x<22.90 then pol5:=-2.392877e-3*x*x+1.110103e-1*x-2.982624e-1
  else if x<28.20 then pol5:=-3.499555e-4*x*x+1.948319e-2*x+7.275065e-1
  else pol5:=1.0
end;
function calccolnum(aff:real):integer;
  begin
           if aff<0.05 then calccolnum:=0 else
           if aff<arnver[2] then calccolnum:=arver[1] else
           if aff<arnver[3] then calccolnum:=arver[2] else
           if aff<arnver[4] then calccolnum:=arver[3]  else
           if aff<arnver[5] then calccolnum:=arver[4]  else
           if aff<arnver[6] then calccolnum:=arver[5]  else
           if aff<arnver[7] then calccolnum:=arver[6] else
           if aff<arnver[8] then calccolnum:=arver[7] else
                          calccolnum:=arver[8];
  end;
function calccolnum1(aff:real):integer;
  begin
           if aff<0.0005 then calccolnum1:=0 else
           if aff<arnerr[1] then calccolnum1:=arver[1] else
           if aff<arnerr[2] then calccolnum1:=arver[2] else
           if aff<arnerr[3] then calccolnum1:=arver[3] else
           if aff<arnerr[4] then calccolnum1:=arver[4] else
           if aff<arnerr[5] then calccolnum1:=arver[5] else
           if aff<arnerr[6] then calccolnum1:=arver[6] else
           if aff<arnerr[7] then calccolnum1:=arver[7] else
                            calccolnum1:=arver[8];
  end;


BEGIN
END.