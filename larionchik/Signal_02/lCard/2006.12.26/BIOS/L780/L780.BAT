@ECHO OFF

rem Building architecture file

rem compiling internal memory segment
asm21 -2181 l780
if errorlevel==1 goto ERROR

rem linking all in exe file
ld21 l780  -a l780 -g -e l780 -l
if errorlevel==1 goto ERROR

rem creating .bio file
bin3pci l780.exe
if errorlevel==1 goto ERROR

rem copying file
rem copy l780.bio ..\..\l7xxtest\*.*

if exist *.cde del *.cde
if exist *.int del *.int
if exist *.bak del *.bak
if exist *.obj del *.obj
rem if exist l780.exe del l780.exe
if exist l780.sym del l780.sym

ECHO -
ECHO #####################################################################
ECHO   	      S U C C E S S ! ! !  Файл l780.bio сформирован
ECHO #####################################################################
ECHO -
goto END

:ERROR
ECHO -
ECHO #####################################################################
ECHO          E R R O R ! ! !  Ошибка формирования файла l780.bio
ECHO #####################################################################
ECHO - 

:END
