@ECHO OFF

rem Building architecture file

rem compiling internal memory segment
asm21 -2181 l783
if errorlevel==1 goto ERROR

rem linking all in exe file
ld21 l783  -a l783 -g -e l783 -l
if errorlevel==1 goto ERROR

rem creating .bio file
bin3pci l783.exe
if errorlevel==1 goto ERROR

rem copying file
rem copy l783.bio ..\..\l7xxtest\*.*

if exist *.cde del *.cde
if exist *.int del *.int
if exist *.bak del *.bak
if exist *.obj del *.obj
if exist l783.sym del l783.sym
if exist l783.exe del l783.exe

ECHO -
ECHO #####################################################################
ECHO   	      S U C C E S S ! ! !  Файл l783.bio сформирован
ECHO #####################################################################
ECHO -
goto END

:ERROR
ECHO -
ECHO #####################################################################
ECHO          E R R O R ! ! !  Ошибка формирования файла l783.bio
ECHO #####################################################################
ECHO - 

:END
