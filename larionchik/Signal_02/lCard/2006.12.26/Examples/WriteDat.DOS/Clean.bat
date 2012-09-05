echo off
@echo ##### Delete unused files #####
@if exist *.bak del *.bak
@if exist *.swp del *.swp
@if exist *.~*  del *.~*
@if exist *.obj del *.obj
@if exist *.obr del *.obr
@if exist *.res del *.res
@if exist *.rws del *.rws
@if exist *.csm del *.csm
@if exist *.ilc del *.ilc
@if exist *.ild del *.ild
@if exist *.ilf del *.ilf
@if exist *.ils del *.ils
@if exist *.mbt del *.mbt
@if exist *.mrt del *.mrt
@if exist *.r$p del *.r$p
@if exist *.tds del *.tds

@echo ##### for VxD #####
@if exist *.map del *.map
@if exist *.pel del *.pel

@echo ##### for Delphi ####
@if exist *.dcu del *.dcu

@echo ##### Work complete #####
