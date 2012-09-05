# Generated by the VisualDSP++ IDDE

# Note:  Any changes made to this Makefile will be lost the next time the
# matching project file is loaded into the IDDE.  If you wish to preserve
# changes, rename this file and run it externally to the IDDE.

# The syntax of this Makefile is such that GNU Make v3.77 or higher is
# required.

# The current working directory should be the directory in which this
# Makefile resides.

# Supported targets:
#     cvg_pm_811_InvertPhase_Release
#     cvg_pm_811_InvertPhase_Release_clean

# Define this variable if you wish to run this Makefile on a host
# other than the host that created it and VisualDSP++ may be installed
# in a different directory.

ADI_DSP=C:\Program Files\Analog Devices\VisualDSP 5.0


# $VDSP is a gmake-friendly version of ADI_DIR

empty:=
space:= $(empty) $(empty)
VDSP_INTERMEDIATE=$(subst \,/,$(ADI_DSP))
VDSP=$(subst $(space),\$(space),$(VDSP_INTERMEDIATE))

RM=cmd /C del /F /Q

#
# Begin "cvg_pm_811_InvertPhase_Release" configuration
#

ifeq ($(MAKECMDGOALS),cvg_pm_811_InvertPhase_Release)

cvg_pm_811_InvertPhase_Release : ./Release/cvg_pm_811_InvertPhase.ldr 

Release/gc.doj :gc.c gclib.h $(VDSP)/213xx/include/cdef21364.h $(VDSP)/213xx/include/Cdef21363.h $(VDSP)/213xx/include/def21364.h $(VDSP)/213xx/include/def21363.h $(VDSP)/213xx/include/signal.h $(VDSP)/213xx/include/21364.h $(VDSP)/213xx/include/platform_include.h $(VDSP)/213xx/include/builtins.h $(VDSP)/213xx/include/sys/builtins_support.h $(VDSP)/213xx/include/stdio.h $(VDSP)/213xx/include/stdio_21xxx.h $(VDSP)/213xx/include/sysreg.h pmTypes.h pmSinCos.h pmInit.h pmMath.h kff.h $(VDSP)/213xx/include/def21363.h $(VDSP)/213xx/include/def21364.h $(VDSP)/213xx/include/platform_include.h 
	@echo ".\gc.c"
	$(VDSP)/cc21k.exe -c .\gc.c -file-attr ProjectName=cvg_pm_811_InvertPhase -O -Ov22 -no-annotate -Oa -structs-do-not-overlap -no-multiline -double-size-32 -warn-protos -proc ADSP-21364 -o .\Release\gc.doj -MM

Release/pmInit.doj :pmInit.c pmInit.h pmTypes.h KFF.h pmSinCos.h pmMath.h $(VDSP)/213xx/include/Math.h $(VDSP)/213xx/include/math_21xxx.h 
	@echo ".\pmInit.c"
	$(VDSP)/cc21k.exe -c .\pmInit.c -file-attr ProjectName=cvg_pm_811_InvertPhase -O -Ov22 -no-annotate -Oa -structs-do-not-overlap -no-multiline -double-size-32 -warn-protos -proc ADSP-21364 -o .\Release\pmInit.doj -MM

Release/pmMath.doj :pmMath.c $(VDSP)/213xx/include/string.h gclib.h $(VDSP)/213xx/include/cdef21364.h $(VDSP)/213xx/include/Cdef21363.h $(VDSP)/213xx/include/def21364.h $(VDSP)/213xx/include/def21363.h $(VDSP)/213xx/include/signal.h pmSinCos.h pmTypes.h kff.h pmMath.h $(VDSP)/213xx/include/Math.h $(VDSP)/213xx/include/math_21xxx.h 
	@echo ".\pmMath.c"
	$(VDSP)/cc21k.exe -c .\pmMath.c -file-attr ProjectName=cvg_pm_811_InvertPhase -O -Ov22 -no-annotate -Oa -structs-do-not-overlap -no-multiline -double-size-32 -warn-protos -proc ADSP-21364 -o .\Release\pmMath.doj -MM

Release/pmSinCos.doj :pmSinCos.c pmSinCos.h pmTypes.h $(VDSP)/213xx/include/Math.h $(VDSP)/213xx/include/math_21xxx.h 
	@echo ".\pmSinCos.c"
	$(VDSP)/cc21k.exe -c .\pmSinCos.c -file-attr ProjectName=cvg_pm_811_InvertPhase -O -Ov22 -no-annotate -Oa -structs-do-not-overlap -no-multiline -double-size-32 -warn-protos -proc ADSP-21364 -o .\Release\pmSinCos.doj -MM

Release/pmTypes.doj :pmTypes.c pmTypes.h 
	@echo ".\pmTypes.c"
	$(VDSP)/cc21k.exe -c .\pmTypes.c -file-attr ProjectName=cvg_pm_811_InvertPhase -O -Ov22 -no-annotate -Oa -structs-do-not-overlap -no-multiline -double-size-32 -warn-protos -proc ADSP-21364 -o .\Release\pmTypes.doj -MM

Release/Readme.doj :Readme.c 
	@echo ".\Readme.c"
	$(VDSP)/cc21k.exe -c .\Readme.c -file-attr ProjectName=cvg_pm_811_InvertPhase -O -Ov22 -no-annotate -Oa -structs-do-not-overlap -no-multiline -double-size-32 -warn-protos -proc ADSP-21364 -o .\Release\Readme.doj -MM

./Release/cvg_pm_811_InvertPhase.dxe :$(VDSP)/213xx/ldf/ADSP-21364.LDF $(VDSP)/213xx/lib/2136x_rev_0.0/364_hdr.doj ./Release/gc.doj ./gclib.doj ./Release/pmInit.doj ./Release/pmMath.doj ./Release/pmSinCos.doj ./Release/pmTypes.doj ./Release/Readme.doj $(VDSP)/213xx/lib/2136x_rev_0.0/libc36x.dlb $(VDSP)/213xx/lib/2136x_rev_0.0/libio.dlb $(VDSP)/213xx/lib/2136x_rev_0.0/libdsp36x.dlb $(VDSP)/213xx/lib/2136x_rev_0.0/libcpp.dlb $(VDSP)/213xx/lib/2136x_rev_0.0/libeh.dlb $(VDSP)/213xx/lib/2136x_rev_0.0/libcpprt.dlb 
	@echo "Linking..."
	$(VDSP)/cc21k.exe .\Release\gc.doj .\gclib.doj .\Release\pmInit.doj .\Release\pmMath.doj .\Release\pmSinCos.doj .\Release\pmTypes.doj .\Release\Readme.doj -flags-link -ip -L .\Release -L ..\CVG_cpp -flags-link -e -flags-link -od,.\Release -o .\Release\cvg_pm_811_InvertPhase.dxe -proc ADSP-21364 -MM

./Release/cvg_pm_811_InvertPhase.ldr :./Release/cvg_pm_811_InvertPhase.dxe $(VDSP)/213xx/ldr/36x_spi.dxe 
	@echo "Creating loader file..."
	$(VDSP)/elfloader.exe -bspislave -fBinary -HostWidth8 -l $(VDSP)\213xx\ldr\36x_spi.dxe .\Release\cvg_pm_811_InvertPhase.dxe -o .\Release\cvg_pm_811_InvertPhase.ldr -proc ADSP-21364 -MM

endif

ifeq ($(MAKECMDGOALS),cvg_pm_811_InvertPhase_Release_clean)

cvg_pm_811_InvertPhase_Release_clean:
	-$(RM) "Release\gc.doj"
	-$(RM) "Release\pmInit.doj"
	-$(RM) "Release\pmMath.doj"
	-$(RM) "Release\pmSinCos.doj"
	-$(RM) "Release\pmTypes.doj"
	-$(RM) "Release\Readme.doj"
	-$(RM) ".\Release\cvg_pm_811_InvertPhase.dxe"
	-$(RM) ".\Release\cvg_pm_811_InvertPhase.ldr"
	-$(RM) ".\Release\*.ipa"
	-$(RM) ".\Release\*.opa"
	-$(RM) ".\Release\*.ti"
	-$(RM) ".\Release\*.pgi"
	-$(RM) ".\*.rbld"

endif


