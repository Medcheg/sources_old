@ECHO OFF
rem Building architecture file

rem compiling internal memory segment
asm21 -2181 l761
if errorlevel==1 goto ERROR

rem linking all in exe file
ld21 l761  -a l761 -g -e l761 -l
if errorlevel==1 goto ERROR

rem creating .bio file
bin3pci l761.exe
if errorlevel==1 goto ERROR

rem copying file
rem copy l761.bio ..\..\l7xxtest\*.*

if exist *.cde del *.cde
if exist *.int del *.int
if exist *.bak del *.bak
if exist *.obj del *.obj
if exist l761.exe del l761.exe
if exist l761.sym del l761.sym

ECHO -
ECHO #####################################################################
ECHO   	    S U C C E S S ! ! !  Файл l761.bio сформирован
ECHO #####################################################################
ECHO -
goto END

:ERROR
ECHO -
ECHO #####################################################################
ECHO        E R R O R ! ! !  Ошибка формирования файла l761.bio
ECHO #####################################################################
ECHO -

:END
