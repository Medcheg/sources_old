% function c=mm
clear;
load BMK1;
x=BMK1(1:2048);
%********************************
s = x';
% Perform the decomposition of s at level 5, using coif3.
w = 'haar'
[c,l] = wavedec(s,5,w);
% Reconstruct the approximation signals and detail signals at
% levels 1 to 5, using the wavelet decomposition structure [c,l].
for i = 1:5
Ab(i,:) = wrcoef('a',c,l,w,i);
Db(i,:) = wrcoef('d',c,l,w,i);
end
% Note This loop replaces 10 separate wrcoef statements defining
% approximations and details. The variable A contains the five approximations
% and the variable D contains the five details.
t = 1:length(s);
Ab1=Ab(1,t)';
Ab2=Ab(2,t)';
Ab3=Ab(3,t)';
Ab4=Ab(4,t)';
Ab5=Ab(5,t)';
%******************************************************************
b0=7.0711e-001;
b1=7.0711e-001;
% [ccA1,ccD1] = dwt(x,'haar');
% l_s = length(x);
% AA1 = upcoef('a',ccA1,'haar',1,l_s);
% DD1 = upcoef('d',ccD1,'haar',1,l_s);
%*******************************************
% Step 1
for n=2:length(x)
    y1(n)=(b0*x(n)+b1*x(n-1));    %L1-filtr
end
for k=1:length(x)/2          
    Dy1(k)=y1(2*k);              %Decimation 1
%******************************************************
end
for n1=1:length(x)/2                 
    z1(2*n1-1:2*n1)=[Dy1(n1);0];    %Input zerros 1 
end
a1(1)=b0*z1(1);
for n2=2:length(x)
    a1(n2)=b1*z1(n2)+b0*z1(n2-1);    %L1^(-1) Approx A1
end                                  %Reconstraction A1
BB1=[a1(1:20)',Ab1(1:20)]
%****************************************
%*******************************************
%Step 2
for m=2:length(x)/2
    y2(m)=(b0*Dy1(m)+b1*Dy1(m-1));  %L2-filtr
end
for m1=1:length(x)/4
    Dy2(m1)=y2(2*m1);               %Decimation 2
end
%***************************************************
for k1=1:length(x)/4                   
    z2(2*k1-1:2*k1)=[Dy2(k1);0];    %Input zerros 2
end
a21(1)=b0*z2(1);
for n2=2:length(x)/2
    a21(n2)=b1*z2(n2)+b0*z2(n2-1);   %L2^(-1)
end
for kk1=1:length(x)/2
    z22(2*kk1-1:2*kk1)=[a21(kk1);0];     %Input zerros 1
end                                  
a2(1)=b1*z22(1)
for nn2=2:length(x)
    a2(nn2)=b1*z22(nn2)+b0*z22(nn2-1);   %L1^(-1) Approx A2
end                                      %Reconstraction A2
BB2=[a2(1:20)',Ab2(1:20)]
%******************************************************
%*****************************************************
%step 3
for m=2:length(x)/4
    y3(m)=(b0*Dy2(m)+b1*Dy2(m-1));     %L3-filtr
end
for m1=1:length(x)/8
    Dy3(m1)=y3(2*m1);                  %Decimation 3
end
%****************************************************
for k1=1:length(x)/8
    z3(2*k1-1:2*k1)=[Dy3(k1);0];       %Input zerros 3
end
z31(1)=b1*z3(1);
for n2=2:length(x)/4
    z31(n2)=b0*z3(n2)+b1*z3(n2-1);     %L3^(-1) 
end
%**************************************************
for kk1=1:length(x)/4
    z32(2*kk1-1:2*kk1)=[z31(kk1);0];  %Input zerros 2
end
z33(1)=b0*z32(1)
for nn2=2:length(x)/2
    z33(nn2)=b0*z32(nn2)+b1*z32(nn2-1);  %L2^(-1) 
end
%**************************************************
for kk1=1:length(x)/2
    za3(2*kk1-1:2*kk1)=[z33(kk1);0];  %Input zerros 1
end
a3(1)=b0*za3(1)
for nn2=2:length(x)
    a3(nn2)=b0*za3(nn2)+b1*za3(nn2-1);    %L1^(-1) 
end                                      %Reconstraction A3 
BB3=[a3(1:20)',Ab3(1:20)]
%step 4


