	.386p
	ifdef ??version
	if    ??version GT 500H
	.mmx
	endif
	endif
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "D:\_Programs\Work\_Estimate_\project\_Shared\frmAbout\Unit_About.cpp"
	?debug	T "D:\_Programs\Work\_Estimate_\project\_Shared\frmAbout\Unit_About.cpp"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
$$BSYMS	segment byte public use32 'DEBSYM'
$$BSYMS	ends
$$BTYPES	segment byte public use32 'DEBTYP'
$$BTYPES	ends
$$BNAMES	segment byte public use32 'DEBNAM'
$$BNAMES	ends
$$BROWSE	segment byte public use32 'DEBSYM'
$$BROWSE	ends
$$BROWFILE	segment byte public use32 'DEBSYM'
$$BROWFILE	ends
 ?debug  C FB0C0100600000
DGROUP	group	_BSS,_DATA
_BSS	segment dword public use32 'BSS'
	align	4
_frmAbout	label	dword
	db	4	dup(?)
_BSS	ends
_DATA	segment dword public use32 'DATA'
@_$DCFE$@TfrmAbout@$bctr$qqrp18Classes@TComponent	segment virtual
	align	2
@@_$DCFE$@TfrmAbout@$bctr$qqrp18Classes@TComponent	label	dword
	dd	@@$xt$p9TfrmAbout
	dd	1029
	dd	-4
	dd	0
@_$DCFE$@TfrmAbout@$bctr$qqrp18Classes@TComponent	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTGE$@TfrmAbout@$bctr$qqrp18Classes@TComponent	segment virtual
	align	2
@@_$ECTGE$@TfrmAbout@$bctr$qqrp18Classes@TComponent	label	dword
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	@@_$DCFE$@TfrmAbout@$bctr$qqrp18Classes@TComponent
@_$ECTGE$@TfrmAbout@$bctr$qqrp18Classes@TComponent	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@$bctr$qqrp18Classes@TComponent	segment virtual
@@TfrmAbout@$bctr$qqrp18Classes@TComponent	proc	near
?live16385@0:
	?debug L 12
	push      ebp
	mov       ebp,esp
	add       esp,-48
	mov       byte ptr [ebp-8],dl
	test      dl,dl
	jle       short @1
	call      __ClassCreate
@1:
	mov       dword ptr [ebp-48],ecx
	mov       byte ptr [ebp-41],dl
	mov       dword ptr [ebp-4],eax
@2:
	mov       eax,offset @@_$ECTGE$@TfrmAbout@$bctr$qqrp18Classes@TComponent
	call      @__InitExceptBlockLDTC
	?debug L 13
	mov       word ptr [ebp-24],8
	mov       ecx,dword ptr [ebp-48]
	xor       edx,edx
	mov       eax,dword ptr [ebp-4]
	call      @@Forms@TForm@$bctr$qqrp18Classes@TComponent
	add       dword ptr [ebp-12],15
	?debug L 15
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],edx
	mov       eax,dword ptr [ebp-4]
@4:
@3:
	cmp       byte ptr [ebp-41],0
	je        short @5
	call      __AfterConstruction
	?debug L 15
@5:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@TfrmAbout@$bctr$qqrp18Classes@TComponent	endp
@TfrmAbout@$bctr$qqrp18Classes@TComponent	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	db	2
	db	0
	db	0
	db	0
	dw	88
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch1
	dd	?patch2
	dd	?patch3
	df	@@TfrmAbout@$bctr$qqrp18Classes@TComponent
	dw	0
	dw	4112
	dw	0
	dw	20
	dw	0
	dw	0
	dw	0
	db	41
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	36
	db	98
	db	99
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	56
	db	67
	db	108
	db	97
	db	115
	db	115
	db	101
	db	115
	db	64
	db	84
	db	67
	db	111
	db	109
	db	112
	db	111
	db	110
	db	101
	db	110
	db	116
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4102
	dw	0
	dw	21
	dw	0
	dw	0
	dw	0
	dw	?patch4
	dw	529
	dw	?patch5
	dd	?live16385@0-@@TfrmAbout@$bctr$qqrp18Classes@TComponent
	dd	?live16385@0-?live16385@0
	dw	17
?patch5	equ	1
?patch4	equ	14
	dw	18
	dw	512
	dw	65488
	dw	65535
	dw	65529
	dw	65535
	dw	22
	dw	0
	dw	0
	dw	0
	dw	?patch6
	dw	529
	dw	?patch7
	dd	?live16385@0-@@TfrmAbout@$bctr$qqrp18Classes@TComponent
	dd	?live16385@0-?live16385@0
	dw	18
?patch7	equ	1
?patch6	equ	14
?patch1	equ	@4-@@TfrmAbout@$bctr$qqrp18Classes@TComponent+15
?patch2	equ	0
?patch3	equ	@4-@@TfrmAbout@$bctr$qqrp18Classes@TComponent
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$CHHE$@TfrmAbout@Label3Click$qqrp14System@TObject	segment virtual
	align	2
@@_$CHHE$@TfrmAbout@Label3Click$qqrp14System@TObject	label	dword
	dd	0
	dd	0
	dd	@6
	dd	0
	dd	0
	dd	0
	dd	0
	dd	0
@_$CHHE$@TfrmAbout@Label3Click$qqrp14System@TObject	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$DCIE$@TfrmAbout@Label3Click$qqrp14System@TObject	segment virtual
	align	2
@@_$DCIE$@TfrmAbout@Label3Click$qqrp14System@TObject	label	dword
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-4
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-8
	dd	0
@_$DCIE$@TfrmAbout@Label3Click$qqrp14System@TObject	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTJE$@TfrmAbout@Label3Click$qqrp14System@TObject	segment virtual
	align	2
@@_$ECTJE$@TfrmAbout@Label3Click$qqrp14System@TObject	label	dword
	dd	0
	dd	-44
	dw	0
	dw	3
	dd	@@_$CHHE$@TfrmAbout@Label3Click$qqrp14System@TObject
	dw	0
	dw	4
	dw	8
	dw	5
	dd	0
	dd	0
	dw	20
	dw	5
	dd	0
	dd	@@_$DCIE$@TfrmAbout@Label3Click$qqrp14System@TObject
	dw	16
	dw	5
	dd	0
	dd	@@_$DCIE$@TfrmAbout@Label3Click$qqrp14System@TObject+16
@_$ECTJE$@TfrmAbout@Label3Click$qqrp14System@TObject	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@Label3Click$qqrp14System@TObject	segment virtual
@@TfrmAbout@Label3Click$qqrp14System@TObject	proc	near
?live16390@0:
	?debug L 18
	push      ebp
	mov       ebp,esp
	add       esp,-60
	push      ebx
	push      esi
	push      edi
	mov       dword ptr [ebp-52],edx
	mov       dword ptr [ebp-48],eax
@7:
	mov       eax,offset @@_$ECTJE$@TfrmAbout@Label3Click$qqrp14System@TObject
	call      @__InitExceptBlockLDTC
	?debug L 20
	mov       word ptr [ebp-28],8
	?debug L 21
@8:
	mov       word ptr [ebp-28],32
	lea       eax,dword ptr [ebp-4]
	call      @@System@AnsiString@$bctr$qqrv
	mov       edx,eax
	inc       dword ptr [ebp-16]
	mov       eax,dword ptr [ebp-52]
	call      @@Controls@TControl@GetText$qqrv
	lea       eax,dword ptr [ebp-4]
	call      @@System@AnsiString@c_str$xqqrv
	mov       dword ptr [ebp-56],eax
	dec       dword ptr [ebp-16]
	lea       eax,dword ptr [ebp-4]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	mov       word ptr [ebp-28],20
	?debug L 22
	push      5
	push      0
	push      0
	push      dword ptr [ebp-56]
	push      offset s@
	mov       eax,dword ptr [ebp-48]
	call      @@Controls@TWinControl@GetHandle$qqrv
	push      eax
	call      @ShellExecuteA
	?debug L 23
	mov       word ptr [ebp-28],8
@9:
	mov       word ptr [ebp-28],0
	jmp       short @10
	?debug L 24
@11:
@6:
	push      0
	lea       eax,dword ptr [ebp-58]
	call      @@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv
	mov       dl,2
	call      @@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn
	mov       cx,word ptr [eax]
	push      ecx
	mov       word ptr [ebp-28],44
	mov       edx,offset s@+5
	lea       eax,dword ptr [ebp-8]
	call      @@System@AnsiString@$bctr$qqrpxc
	inc       dword ptr [ebp-16]
	mov       eax,dword ptr [eax]
	mov       dl,1
	pop       ecx
	call      @@Dialogs@MessageDlg$qqrx17System@AnsiString19Dialogs@TMsgDlgType47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%i
	dec       dword ptr [ebp-16]
	lea       eax,dword ptr [ebp-8]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	?debug L 25
	xor       ecx,ecx
	mov       dword ptr [ebp-16],ecx
	lea       eax,dword ptr [ebp-44]
	push      eax
	call      __Return_unwind
	pop       ecx
	jmp       short @12
	?debug L 26
@13:
	mov       word ptr [ebp-28],16
	call      @@_CatchCleanup$qv
	?debug L 27
@10:
	mov       edx,dword ptr [ebp-44]
	mov       dword ptr fs:[0],edx
	?debug L 27
@14:
@12:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@TfrmAbout@Label3Click$qqrp14System@TObject	endp
@TfrmAbout@Label3Click$qqrp14System@TObject	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	90
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch8
	dd	?patch9
	dd	?patch10
	df	@@TfrmAbout@Label3Click$qqrp14System@TObject
	dw	0
	dw	4133
	dw	0
	dw	23
	dw	0
	dw	0
	dw	0
	db	43
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	76
	db	97
	db	98
	db	101
	db	108
	db	51
	db	67
	db	108
	db	105
	db	99
	db	107
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	52
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	84
	db	79
	db	98
	db	106
	db	101
	db	99
	db	116
	dw	18
	dw	512
	dw	65488
	dw	65535
	dw	4102
	dw	0
	dw	24
	dw	0
	dw	0
	dw	0
	dw	?patch11
	dw	529
	dw	?patch12
	dd	?live16390@0-@@TfrmAbout@Label3Click$qqrp14System@TObject
	dd	?live16390@0-?live16390@0
	dw	17
?patch12	equ	1
?patch11	equ	14
	dw	18
	dw	512
	dw	65484
	dw	65535
	dw	65530
	dw	65535
	dw	25
	dw	0
	dw	0
	dw	0
	dw	?patch13
	dw	529
	dw	?patch14
	dd	?live16390@0-@@TfrmAbout@Label3Click$qqrp14System@TObject
	dd	?live16390@0-?live16390@0
	dw	19
?patch14	equ	1
?patch13	equ	14
	dw	24
	dw	519
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch15
	df	@8
	dw	0
	dw	0
	dw	18
	dw	512
	dw	65480
	dw	65535
	dw	1136
	dw	0
	dw	26
	dw	0
	dw	0
	dw	0
?patch15	equ	@9-@8
	dw	2
	dw	6
	dw	24
	dw	519
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch16
	df	@11
	dw	0
	dw	0
?patch16	equ	@13-@11
	dw	2
	dw	6
?patch8	equ	@14-@@TfrmAbout@Label3Click$qqrp14System@TObject+7
?patch9	equ	0
?patch10	equ	@14-@@TfrmAbout@Label3Click$qqrp14System@TObject
	dw	2
	dw	6
	dw	8
	dw	531
	dw	7
	dw	65464
	dw	65535
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$ECTKE$@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	segment virtual
	align	2
@@_$ECTKE$@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	label	dword
	dd	0
	dd	-36
@_$ECTKE$@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	segment virtual
@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	proc	near
?live16397@0:
	?debug	T "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysset.h"
	?debug L 36
	push      ebp
	mov       ebp,esp
	add       esp,-40
	mov       dword ptr [ebp-40],eax
@15:
	mov       eax,offset @@_$ECTKE$@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv
	call      @__InitExceptBlockLDTC
	push      2
	push      0
	push      dword ptr [ebp-40]
	call      @_memset
	add       esp,12
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
	mov       eax,dword ptr [ebp-40]
	?debug L 36
@17:
@16:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	endp
@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	106
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch17
	dd	?patch18
	dd	?patch19
	df	@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv
	dw	0
	dw	4141
	dw	0
	dw	45
	dw	0
	dw	0
	dw	0
	db	59
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	37
	db	83
	db	101
	db	116
	db	36
	db	116
	db	49
	db	56
	db	68
	db	105
	db	97
	db	108
	db	111
	db	103
	db	115
	db	64
	db	84
	db	77
	db	115
	db	103
	db	68
	db	108
	db	103
	db	66
	db	116
	db	110
	db	36
	db	105
	db	117
	db	99
	db	36
	db	48
	db	36
	db	105
	db	117
	db	99
	db	36
	db	49
	db	48
	db	37
	db	64
	db	36
	db	98
	db	99
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65496
	dw	65535
	dw	4142
	dw	0
	dw	46
	dw	0
	dw	0
	dw	0
	dw	?patch20
	dw	529
	dw	?patch21
	dd	?live16397@0-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv
	dd	?live16397@0-?live16397@0
	dw	17
?patch21	equ	1
?patch20	equ	14
?patch17	equ	@17-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv+4
?patch18	equ	0
?patch19	equ	@17-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn	segment virtual
@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn	proc	near
?live16399@0:
	?debug L 110
	push      ebp
	mov       ebp,esp
	add       esp,-8
	mov       byte ptr [ebp-5],dl
	mov       dword ptr [ebp-4],eax
	?debug L 113
@18:
	cmp       byte ptr [ebp-5],0
	jl        short @19
	cmp       byte ptr [ebp-5],10
	jg        short @19
	?debug L 116
	movsx     ecx,byte ptr [ebp-5]
	and       ecx,-2147483641
	jns       short @20
	dec       ecx
	or        ecx,-8
	inc       ecx
@20:
	mov       al,1
	shl       al,cl
	movsx     edx,byte ptr [ebp-5]
	test      edx,edx
	jns       short @21
	add       edx,7
@21:
	sar       edx,3
	mov       ecx,dword ptr [ebp-4]
	or        byte ptr [ecx+edx],al
	?debug L 118
@19:
	mov       eax,dword ptr [ebp-4]
	?debug L 119
@23:
@22:
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn	endp
@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	126
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch22
	dd	?patch23
	dd	?patch24
	df	@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn
	dw	0
	dw	4193
	dw	0
	dw	47
	dw	0
	dw	0
	dw	0
	db	79
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	37
	db	83
	db	101
	db	116
	db	36
	db	116
	db	49
	db	56
	db	68
	db	105
	db	97
	db	108
	db	111
	db	103
	db	115
	db	64
	db	84
	db	77
	db	115
	db	103
	db	68
	db	108
	db	103
	db	66
	db	116
	db	110
	db	36
	db	105
	db	117
	db	99
	db	36
	db	48
	db	36
	db	105
	db	117
	db	99
	db	36
	db	49
	db	48
	db	37
	db	64
	db	36
	db	98
	db	108
	db	115
	db	104
	db	36
	db	113
	db	113
	db	114
	db	120
	db	49
	db	56
	db	68
	db	105
	db	97
	db	108
	db	111
	db	103
	db	115
	db	64
	db	84
	db	77
	db	115
	db	103
	db	68
	db	108
	db	103
	db	66
	db	116
	db	110
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4142
	dw	0
	dw	48
	dw	0
	dw	0
	dw	0
	dw	?patch25
	dw	529
	dw	?patch26
	dd	?live16399@0-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn
	dd	?live16399@0-?live16399@0
	dw	17
?patch26	equ	1
?patch25	equ	14
	dw	18
	dw	512
	dw	65531
	dw	65535
	dw	4165
	dw	0
	dw	49
	dw	0
	dw	0
	dw	0
	dw	?patch27
	dw	529
	dw	?patch28
	dd	?live16399@0-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn
	dd	?live16399@0-?live16399@0
	dw	19
?patch28	equ	1
?patch27	equ	14
?patch22	equ	@23-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn+4
?patch23	equ	0
?patch24	equ	@23-@@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@OKButtonClick$qqrp14System@TObject	segment virtual
@@TfrmAbout@OKButtonClick$qqrp14System@TObject	proc	near
?live16400@0:
	?debug	T "D:\_Programs\Work\_Estimate_\project\_Shared\frmAbout\Unit_About.cpp"
	?debug L 30
	push      ebp
	mov       ebp,esp
	add       esp,-8
	mov       dword ptr [ebp-8],edx
	mov       dword ptr [ebp-4],eax
	?debug L 32
@24:
	mov       eax,dword ptr [ebp-4]
	call      @@Forms@TCustomForm@Close$qqrv
	?debug L 33
@25:
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@TfrmAbout@OKButtonClick$qqrp14System@TObject	endp
@TfrmAbout@OKButtonClick$qqrp14System@TObject	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	92
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch29
	dd	?patch30
	dd	?patch31
	df	@@TfrmAbout@OKButtonClick$qqrp14System@TObject
	dw	0
	dw	4195
	dw	0
	dw	50
	dw	0
	dw	0
	dw	0
	db	45
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	79
	db	75
	db	66
	db	117
	db	116
	db	116
	db	111
	db	110
	db	67
	db	108
	db	105
	db	99
	db	107
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	52
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	84
	db	79
	db	98
	db	106
	db	101
	db	99
	db	116
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4102
	dw	0
	dw	51
	dw	0
	dw	0
	dw	0
	dw	?patch32
	dw	529
	dw	?patch33
	dd	?live16400@0-@@TfrmAbout@OKButtonClick$qqrp14System@TObject
	dd	?live16400@0-?live16400@0
	dw	17
?patch33	equ	1
?patch32	equ	14
	dw	18
	dw	512
	dw	65528
	dw	65535
	dw	65530
	dw	65535
	dw	52
	dw	0
	dw	0
	dw	0
	dw	?patch34
	dw	529
	dw	?patch35
	dd	?live16400@0-@@TfrmAbout@OKButtonClick$qqrp14System@TObject
	dd	?live16400@0-?live16400@0
	dw	19
?patch35	equ	1
?patch34	equ	14
?patch29	equ	@25-@@TfrmAbout@OKButtonClick$qqrp14System@TObject+4
?patch30	equ	0
?patch31	equ	@25-@@TfrmAbout@OKButtonClick$qqrp14System@TObject
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@GetCPUSpeed$qqrv	segment virtual
@@TfrmAbout@GetCPUSpeed$qqrv	proc	near
?live16401@0:
	?debug L 35
	push      ebp
	mov       ebp,esp
	add       esp,-32
	mov       dword ptr [ebp-4],eax
	?debug L 37
@26:
	mov       dword ptr [ebp-8],200
	?debug L 41
	push      offset @GetCurrentProcess
	call      @GetPriorityClass
	mov       dword ptr [ebp-20],eax
	?debug L 42
	push      offset @GetCurrentThread
	call      @GetThreadPriority
	mov       dword ptr [ebp-24],eax
	?debug L 44
	push      256
	push      offset @GetCurrentProcess
	call      @SetPriorityClass
	?debug L 45
	push      15
	push      offset @GetCurrentThread
	call      @SetThreadPriority
	?debug L 47
	push      10
	call      @Sleep
	?debug L 50
	dw	  0310FH 
	?debug L 51
	mov	 dword ptr [ebp-16], eax
	?debug L 52
	mov	 dword ptr [ebp-12], EDX
	?debug L 55
	push      dword ptr [ebp-8]
	call      @Sleep
	?debug L 58
	dw	  0310FH 
	?debug L 59
	sub	 eax, dword ptr [ebp-16]
	?debug L 60
	sbb	 edx, dword ptr [ebp-12]
	?debug L 61
	mov	 dword ptr [ebp-16], eax
	?debug L 62
	mov	 dword ptr [ebp-12], edx
	?debug L 65
	push      dword ptr [ebp-24]
	push      offset @GetCurrentThread
	call      @SetThreadPriority
	?debug L 66
	push      dword ptr [ebp-20]
	push      offset @GetCurrentProcess
	call      @SetPriorityClass
	?debug L 68
	fild      dword ptr [ebp-8]
	fmul      dword ptr [@27]
	mov       eax,dword ptr [ebp-16]
	mov       dword ptr [ebp-32],eax
	xor       edx,edx
	mov       dword ptr [ebp-28],edx
	fild      qword ptr [ebp-32]
	fdivrp     st(1),st
	?debug L 69
@29:
@28:
	mov       esp,ebp
	pop       ebp
	ret 
	align 4        
@27:
	db        0,0,122,68
	?debug L 0
@@TfrmAbout@GetCPUSpeed$qqrv	endp
@TfrmAbout@GetCPUSpeed$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	74
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch36
	dd	?patch37
	dd	?patch38
	df	@@TfrmAbout@GetCPUSpeed$qqrv
	dw	0
	dw	4197
	dw	0
	dw	53
	dw	0
	dw	0
	dw	0
	db	27
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	71
	db	101
	db	116
	db	67
	db	80
	db	85
	db	83
	db	112
	db	101
	db	101
	db	100
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4102
	dw	0
	dw	54
	dw	0
	dw	0
	dw	0
	dw	?patch39
	dw	529
	dw	?patch40
	dd	?live16401@0-@@TfrmAbout@GetCPUSpeed$qqrv
	dd	?live16401@0-?live16401@0
	dw	17
?patch40	equ	1
?patch39	equ	14
	dw	18
	dw	512
	dw	65512
	dw	65535
	dw	116
	dw	0
	dw	55
	dw	0
	dw	0
	dw	0
	dw	18
	dw	512
	dw	65516
	dw	65535
	dw	116
	dw	0
	dw	56
	dw	0
	dw	0
	dw	0
	dw	18
	dw	512
	dw	65520
	dw	65535
	dw	117
	dw	0
	dw	57
	dw	0
	dw	0
	dw	0
	dw	18
	dw	512
	dw	65524
	dw	65535
	dw	117
	dw	0
	dw	58
	dw	0
	dw	0
	dw	0
	dw	18
	dw	512
	dw	65528
	dw	65535
	dw	116
	dw	0
	dw	59
	dw	0
	dw	0
	dw	0
?patch36	equ	@29-@@TfrmAbout@GetCPUSpeed$qqrv+9
?patch37	equ	0
?patch38	equ	@29-@@TfrmAbout@GetCPUSpeed$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject	segment virtual
	align	2
@@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject	label	dword
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-4
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-8
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-12
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-16
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-20
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-24
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-28
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-32
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-36
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-40
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-44
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-48
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-52
	dd	0
@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTME$@TfrmAbout@FormActivate$qqrp14System@TObject	segment virtual
	align	2
@@_$ECTME$@TfrmAbout@FormActivate$qqrp14System@TObject	label	dword
	dd	0
	dd	-88
	dw	0
	dw	5
	dd	0
	dd	@@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject
	dw	0
	dw	5
	dd	0
	dd	@@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject+40
	dw	0
	dw	5
	dd	0
	dd	@@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject+92
	dw	0
	dw	5
	dd	0
	dd	@@_$DCLE$@TfrmAbout@FormActivate$qqrp14System@TObject+108
@_$ECTME$@TfrmAbout@FormActivate$qqrp14System@TObject	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@FormActivate$qqrp14System@TObject	segment virtual
@@TfrmAbout@FormActivate$qqrp14System@TObject	proc	near
?live16402@0:
	?debug L 72
	push      ebp
	mov       ebp,esp
	add       esp,-136
	mov       dword ptr [ebp-96],edx
	mov       dword ptr [ebp-92],eax
@30:
	mov       eax,offset @@_$ECTME$@TfrmAbout@FormActivate$qqrp14System@TObject
	call      @__InitExceptBlockLDTC
	?debug L 76
	lea       edx,dword ptr [ebp-128]
	push      edx
	call      @GlobalMemoryStatus
	?debug L 78
	mov       word ptr [ebp-72],8
	mov       ecx,dword ptr [ebp-120]
	mov       dword ptr [ebp-136],ecx
	xor       eax,eax
	mov       dword ptr [ebp-132],eax
	fild      qword ptr [ebp-136]
	fmul      dword ptr [@31]
	add       esp,-12
	fstp      tbyte ptr [esp]
	lea       eax,dword ptr [ebp-8]
	call      @@System@AnsiString@$bctr$qqrv
	push      eax
	inc       dword ptr [ebp-60]
	mov       edx,offset s@+57
	lea       eax,dword ptr [ebp-4]
	call      @@System@AnsiString@$bctr$qqrpxc
	inc       dword ptr [ebp-60]
	mov       eax,dword ptr [eax]
	pop       edx
	call      @@Sysutils@FormatFloat$qqrx17System@AnsiStringg
	lea       ecx,dword ptr [ebp-8]
	push      ecx
	lea       eax,dword ptr [ebp-12]
	call      @@System@AnsiString@$bctr$qqrv
	mov       ecx,eax
	inc       dword ptr [ebp-60]
	mov       eax,offset s@+30
	pop       edx
	call      @@System@$badd$qqrpxcrx17System@AnsiString
	lea       edx,dword ptr [ebp-12]
	mov       edx,dword ptr [edx]
	mov       eax,dword ptr [ebp-92]
	mov       eax,dword ptr [eax+740]
	call      @@Controls@TControl@SetText$qqrx17System@AnsiString
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-12]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-8]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-4]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	?debug L 79
	mov       word ptr [ebp-72],20
	lea       eax,dword ptr [ebp-16]
	call      @@System@AnsiString@$bctr$qqrv
	mov       edx,eax
	inc       dword ptr [ebp-60]
	mov       eax,dword ptr [ebp-124]
	call      @@IntToStr$qqrul
	lea       edx,dword ptr [ebp-16]
	push      edx
	lea       eax,dword ptr [ebp-20]
	call      @@System@AnsiString@$bctr$qqrv
	mov       ecx,eax
	inc       dword ptr [ebp-60]
	mov       eax,offset s@+68
	pop       edx
	call      @@System@$badd$qqrpxcrx17System@AnsiString
	lea       ecx,dword ptr [ebp-20]
	push      ecx
	lea       eax,dword ptr [ebp-28]
	call      @@System@AnsiString@$bctr$qqrv
	push      eax
	inc       dword ptr [ebp-60]
	mov       edx,offset s@+100
	lea       eax,dword ptr [ebp-24]
	call      @@System@AnsiString@$bctr$qqrpxc
	inc       dword ptr [ebp-60]
	lea       edx,dword ptr [ebp-24]
	pop       ecx
	pop       eax
	call      @@System@AnsiString@$badd$xqqrrx17System@AnsiString
	lea       edx,dword ptr [ebp-28]
	mov       edx,dword ptr [edx]
	mov       eax,dword ptr [ebp-92]
	mov       eax,dword ptr [eax+744]
	call      @@Controls@TControl@SetText$qqrx17System@AnsiString
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-28]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-24]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-20]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-16]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	?debug L 80
	mov       word ptr [ebp-72],32
	mov       edx,offset s@+103
	lea       eax,dword ptr [ebp-32]
	call      @@System@AnsiString@$bctr$qqrpxc
	inc       dword ptr [ebp-60]
	mov       edx,dword ptr [eax]
	mov       eax,dword ptr [ebp-92]
	mov       eax,dword ptr [eax+748]
	call      @@Controls@TControl@SetText$qqrx17System@AnsiString
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-32]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	?debug L 82
	mov       word ptr [ebp-72],44
	lea       eax,dword ptr [ebp-36]
	call      @@System@AnsiString@$bctr$qqrv
	mov       edx,eax
	inc       dword ptr [ebp-60]
	mov       ecx,dword ptr [ebp-92]
	mov       eax,dword ptr [ecx+748]
	call      @@Controls@TControl@GetText$qqrv
	lea       edx,dword ptr [ebp-36]
	push      edx
	mov       eax,dword ptr [ebp-92]
	call      @@TfrmAbout@GetCPUSpeed$qqrv
	fmul      qword ptr [@31+4]
	fmul      dword ptr [@31+12]
	call      __ftol
	mov       dword ptr [ebp-132],eax
	fild      dword ptr [ebp-132]
	fld       tbyte ptr [@31+16]
	fmulp      st(1),st
	add       esp,-12
	fstp      tbyte ptr [esp]
	lea       eax,dword ptr [ebp-40]
	call      @@System@AnsiString@$bctr$qqrv
	inc       dword ptr [ebp-60]
	call      @@Sysutils@FloatToStr$qqrg
	lea       edx,dword ptr [ebp-40]
	push      edx
	lea       eax,dword ptr [ebp-44]
	call      @@System@AnsiString@$bctr$qqrv
	mov       ecx,eax
	inc       dword ptr [ebp-60]
	pop       edx
	pop       eax
	call      @@System@AnsiString@$badd$xqqrrx17System@AnsiString
	lea       edx,dword ptr [ebp-44]
	push      edx
	lea       eax,dword ptr [ebp-52]
	call      @@System@AnsiString@$bctr$qqrv
	push      eax
	inc       dword ptr [ebp-60]
	mov       edx,offset s@+125
	lea       eax,dword ptr [ebp-48]
	call      @@System@AnsiString@$bctr$qqrpxc
	inc       dword ptr [ebp-60]
	lea       edx,dword ptr [ebp-48]
	pop       ecx
	pop       eax
	call      @@System@AnsiString@$badd$xqqrrx17System@AnsiString
	lea       edx,dword ptr [ebp-52]
	mov       edx,dword ptr [edx]
	mov       eax,dword ptr [ebp-92]
	mov       eax,dword ptr [eax+748]
	call      @@Controls@TControl@SetText$qqrx17System@AnsiString
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-52]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-48]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-44]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-36]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-60]
	lea       eax,dword ptr [ebp-40]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	?debug L 84
	mov       ecx,dword ptr [@Sysutils@DecimalSeparator]
	mov       byte ptr [ecx],46
	?debug L 85
	mov       eax,dword ptr [ebp-88]
	mov       dword ptr fs:[0],eax
	?debug L 85
@32:
	mov       esp,ebp
	pop       ebp
	ret 
	align 4        
@31:
	db        0,0,128,58,74,176,79,56,111,247,239,63,0,0,32,65
	db        205,204,204,204,204,204,204,204,251,63,0,0
	?debug L 0
@@TfrmAbout@FormActivate$qqrp14System@TObject	endp
@TfrmAbout@FormActivate$qqrp14System@TObject	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	91
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch41
	dd	?patch42
	dd	?patch43
	df	@@TfrmAbout@FormActivate$qqrp14System@TObject
	dw	0
	dw	4199
	dw	0
	dw	60
	dw	0
	dw	0
	dw	0
	db	44
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	70
	db	111
	db	114
	db	109
	db	65
	db	99
	db	116
	db	105
	db	118
	db	97
	db	116
	db	101
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	52
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	84
	db	79
	db	98
	db	106
	db	101
	db	99
	db	116
	dw	18
	dw	512
	dw	65444
	dw	65535
	dw	4102
	dw	0
	dw	61
	dw	0
	dw	0
	dw	0
	dw	?patch44
	dw	529
	dw	?patch45
	dd	?live16402@0-@@TfrmAbout@FormActivate$qqrp14System@TObject
	dd	?live16402@0-?live16402@0
	dw	17
?patch45	equ	1
?patch44	equ	14
	dw	18
	dw	512
	dw	65440
	dw	65535
	dw	65530
	dw	65535
	dw	62
	dw	0
	dw	0
	dw	0
	dw	?patch46
	dw	529
	dw	?patch47
	dd	?live16402@0-@@TfrmAbout@FormActivate$qqrp14System@TObject
	dd	?live16402@0-?live16402@0
	dw	19
?patch47	equ	1
?patch46	equ	14
	dw	18
	dw	512
	dw	65408
	dw	65535
	dw	65527
	dw	65535
	dw	63
	dw	0
	dw	0
	dw	0
?patch41	equ	@32-@@TfrmAbout@FormActivate$qqrp14System@TObject+33
?patch42	equ	0
?patch43	equ	@32-@@TfrmAbout@FormActivate$qqrp14System@TObject
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@FormShow$qqrp14System@TObject	segment virtual
@@TfrmAbout@FormShow$qqrp14System@TObject	proc	near
?live16406@0:
	?debug L 88
	push      ebp
	mov       ebp,esp
	add       esp,-8
	mov       dword ptr [ebp-8],edx
	mov       dword ptr [ebp-4],eax
	?debug L 90
@33:
	mov       dl,1
	mov       eax,dword ptr [ebp-4]
	mov       eax,dword ptr [eax+756]
	call      @@Extctrls@TImage@SetTransparent$qqro
	?debug L 91
	mov       edx,dword ptr [ebp-4]
	mov       ecx,dword ptr [edx+756]
	mov       eax,dword ptr [ecx+296]
	call      @@Graphics@TPicture@GetBitmap$qqrv
	mov       edx,16777215
	call      @@Graphics@TBitmap@SetTransparentColor$qqr15Graphics@TColor
	?debug L 95
@34:
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@TfrmAbout@FormShow$qqrp14System@TObject	endp
@TfrmAbout@FormShow$qqrp14System@TObject	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	87
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch48
	dd	?patch49
	dd	?patch50
	df	@@TfrmAbout@FormShow$qqrp14System@TObject
	dw	0
	dw	4201
	dw	0
	dw	64
	dw	0
	dw	0
	dw	0
	db	40
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	70
	db	111
	db	114
	db	109
	db	83
	db	104
	db	111
	db	119
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	52
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	84
	db	79
	db	98
	db	106
	db	101
	db	99
	db	116
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4102
	dw	0
	dw	65
	dw	0
	dw	0
	dw	0
	dw	?patch51
	dw	529
	dw	?patch52
	dd	?live16406@0-@@TfrmAbout@FormShow$qqrp14System@TObject
	dd	?live16406@0-?live16406@0
	dw	17
?patch52	equ	1
?patch51	equ	14
	dw	18
	dw	512
	dw	65528
	dw	65535
	dw	65530
	dw	65535
	dw	66
	dw	0
	dw	0
	dw	0
	dw	?patch53
	dw	529
	dw	?patch54
	dd	?live16406@0-@@TfrmAbout@FormShow$qqrp14System@TObject
	dd	?live16406@0-?live16406@0
	dw	19
?patch54	equ	1
?patch53	equ	14
?patch48	equ	@34-@@TfrmAbout@FormShow$qqrp14System@TObject+4
?patch49	equ	0
?patch50	equ	@34-@@TfrmAbout@FormShow$qqrp14System@TObject
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCNE$@Forms@TForm@$bctr$qqrp18Classes@TComponent	segment virtual
	align	2
@@_$DCNE$@Forms@TForm@$bctr$qqrp18Classes@TComponent	label	dword
	dd	@@$xt$p11Forms@TForm
	dd	1029
	dd	-4
	dd	0
@_$DCNE$@Forms@TForm@$bctr$qqrp18Classes@TComponent	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTOE$@Forms@TForm@$bctr$qqrp18Classes@TComponent	segment virtual
	align	2
@@_$ECTOE$@Forms@TForm@$bctr$qqrp18Classes@TComponent	label	dword
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	@@_$DCNE$@Forms@TForm@$bctr$qqrp18Classes@TComponent
@_$ECTOE$@Forms@TForm@$bctr$qqrp18Classes@TComponent	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@Forms@TForm@$bctr$qqrp18Classes@TComponent	segment virtual
@@Forms@TForm@$bctr$qqrp18Classes@TComponent	proc	near
?live16386@0:
	?debug	T "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\forms.hpp"
	?debug L 932
	push      ebp
	mov       ebp,esp
	add       esp,-48
	mov       byte ptr [ebp-8],dl
	test      dl,dl
	jle       short @35
	call      __ClassCreate
@35:
	mov       dword ptr [ebp-48],ecx
	mov       byte ptr [ebp-41],dl
	mov       dword ptr [ebp-4],eax
@36:
	mov       eax,offset @@_$ECTOE$@Forms@TForm@$bctr$qqrp18Classes@TComponent
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-24],8
	mov       ecx,dword ptr [ebp-48]
	xor       edx,edx
	mov       eax,dword ptr [ebp-4]
	call      @@Forms@TCustomForm@$bctr$qqrp18Classes@TComponent
	add       dword ptr [ebp-12],14
	?debug L 933
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],edx
	mov       eax,dword ptr [ebp-4]
@38:
@37:
	cmp       byte ptr [ebp-41],0
	je        short @39
	call      __AfterConstruction
	?debug L 933
@39:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@Forms@TForm@$bctr$qqrp18Classes@TComponent	endp
@Forms@TForm@$bctr$qqrp18Classes@TComponent	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	90
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch55
	dd	?patch56
	dd	?patch57
	df	@@Forms@TForm@$bctr$qqrp18Classes@TComponent
	dw	0
	dw	4203
	dw	0
	dw	67
	dw	0
	dw	0
	dw	0
	db	43
	db	64
	db	70
	db	111
	db	114
	db	109
	db	115
	db	64
	db	84
	db	70
	db	111
	db	114
	db	109
	db	64
	db	36
	db	98
	db	99
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	56
	db	67
	db	108
	db	97
	db	115
	db	115
	db	101
	db	115
	db	64
	db	84
	db	67
	db	111
	db	109
	db	112
	db	111
	db	110
	db	101
	db	110
	db	116
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4204
	dw	0
	dw	68
	dw	0
	dw	0
	dw	0
	dw	?patch58
	dw	529
	dw	?patch59
	dd	?live16386@0-@@Forms@TForm@$bctr$qqrp18Classes@TComponent
	dd	?live16386@0-?live16386@0
	dw	17
?patch59	equ	1
?patch58	equ	14
	dw	18
	dw	512
	dw	65488
	dw	65535
	dw	65529
	dw	65535
	dw	69
	dw	0
	dw	0
	dw	0
	dw	?patch60
	dw	529
	dw	?patch61
	dd	?live16386@0-@@Forms@TForm@$bctr$qqrp18Classes@TComponent
	dd	?live16386@0-?live16386@0
	dw	18
?patch61	equ	1
?patch60	equ	14
?patch55	equ	@38-@@Forms@TForm@$bctr$qqrp18Classes@TComponent+15
?patch56	equ	0
?patch57	equ	@38-@@Forms@TForm@$bctr$qqrp18Classes@TComponent
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCPE$@System@AnsiString@$bctr$qqrv	segment virtual
	align	2
@@_$DCPE$@System@AnsiString@$bctr$qqrv	label	dword
	dd	@@$xt$p17System@AnsiString
	dd	5
	dd	-4
	dd	0
@_$DCPE$@System@AnsiString@$bctr$qqrv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTQE$@System@AnsiString@$bctr$qqrv	segment virtual
	align	2
@@_$ECTQE$@System@AnsiString@$bctr$qqrv	label	dword
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	@@_$DCPE$@System@AnsiString@$bctr$qqrv
@_$ECTQE$@System@AnsiString@$bctr$qqrv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@System@AnsiString@$bctr$qqrv	segment virtual
@@System@AnsiString@$bctr$qqrv	proc	near
?live16391@0:
	?debug	T "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\dstring.h"
	?debug L 68
	push      ebp
	mov       ebp,esp
	add       esp,-40
	mov       dword ptr [ebp-4],eax
@40:
	mov       eax,offset @@_$ECTQE$@System@AnsiString@$bctr$qqrv
	call      @__InitExceptBlockLDTC
	mov       word ptr [ebp-24],8
	mov       edx,dword ptr [ebp-4]
	xor       ecx,ecx
	mov       dword ptr [edx],ecx
	mov       eax,dword ptr [ebp-40]
	mov       dword ptr fs:[0],eax
	mov       eax,dword ptr [ebp-4]
	?debug L 68
@42:
@41:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@System@AnsiString@$bctr$qqrv	endp
@System@AnsiString@$bctr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	76
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch62
	dd	?patch63
	dd	?patch64
	df	@@System@AnsiString@$bctr$qqrv
	dw	0
	dw	4206
	dw	0
	dw	70
	dw	0
	dw	0
	dw	0
	db	29
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	65
	db	110
	db	115
	db	105
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	64
	db	36
	db	98
	db	99
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4207
	dw	0
	dw	71
	dw	0
	dw	0
	dw	0
	dw	?patch65
	dw	529
	dw	?patch66
	dd	?live16391@0-@@System@AnsiString@$bctr$qqrv
	dd	?live16391@0-?live16391@0
	dw	17
?patch66	equ	1
?patch65	equ	14
?patch62	equ	@42-@@System@AnsiString@$bctr$qqrv+4
?patch63	equ	0
?patch64	equ	@42-@@System@AnsiString@$bctr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@System@AnsiString@c_str$xqqrv	segment virtual
@@System@AnsiString@c_str$xqqrv	proc	near
?live16392@0:
	?debug L 161
	push      ebp
	mov       ebp,esp
	push      ecx
	mov       dword ptr [ebp-4],eax
@43:
	mov       eax,dword ptr [ebp-4]
	cmp       dword ptr [eax],0
	je        short @44
	mov       edx,dword ptr [ebp-4]
	mov       eax,dword ptr [edx]
	jmp       short @46
@44:
	mov       eax,offset s@+130
	?debug L 161
@47:
@46:
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@System@AnsiString@c_str$xqqrv	endp
@System@AnsiString@c_str$xqqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	77
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch67
	dd	?patch68
	dd	?patch69
	df	@@System@AnsiString@c_str$xqqrv
	dw	0
	dw	4209
	dw	0
	dw	72
	dw	0
	dw	0
	dw	0
	db	30
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	65
	db	110
	db	115
	db	105
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	64
	db	99
	db	95
	db	115
	db	116
	db	114
	db	36
	db	120
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4210
	dw	0
	dw	73
	dw	0
	dw	0
	dw	0
	dw	?patch70
	dw	529
	dw	?patch71
	dd	?live16392@0-@@System@AnsiString@c_str$xqqrv
	dd	?live16392@0-?live16392@0
	dw	17
?patch71	equ	1
?patch70	equ	14
?patch67	equ	@47-@@System@AnsiString@c_str$xqqrv+3
?patch68	equ	0
?patch69	equ	@47-@@System@AnsiString@c_str$xqqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCRE$@IntToStr$qqrul	segment virtual
	align	2
@@_$DCRE$@IntToStr$qqrul	label	dword
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-4
	dd	@@$xt$p17System@AnsiString
	dd	20
	dd	-8
	dd	0
	dd	@@$xt$p17System@AnsiString
	dd	52
	dd	-8
	dd	0
@_$DCRE$@IntToStr$qqrul	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTSE$@IntToStr$qqrul	segment virtual
	align	2
@@_$ECTSE$@IntToStr$qqrul	label	dword
	dd	0
	dd	-44
	dw	0
	dw	5
	dd	0
	dd	@@_$DCRE$@IntToStr$qqrul
	dw	8
	dw	5
	dd	1
	dd	@@_$DCRE$@IntToStr$qqrul+28
@_$ECTSE$@IntToStr$qqrul	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@IntToStr$qqrul	segment virtual
@@IntToStr$qqrul	proc	near
?live16403@0:
	?debug L 372
	push      ebp
	mov       ebp,esp
	add       esp,-48
	mov       dword ptr [ebp-8],edx
	mov       dword ptr [ebp-48],eax
@48:
	mov       eax,offset @@_$ECTSE$@IntToStr$qqrul
	call      @__InitExceptBlockLDTC
	?debug L 374
	mov       word ptr [ebp-28],8
	lea       eax,dword ptr [ebp-4]
	call      @@System@AnsiString@$bctr$qqrv
	mov       edx,eax
	inc       dword ptr [ebp-16]
	mov       eax,dword ptr [ebp-48]
	call      @@Sysutils@IntToStr$qqri
	lea       edx,dword ptr [ebp-4]
	mov       eax,dword ptr [ebp-8]
	call      @@System@AnsiString@$basg$qqrrx17System@AnsiString
	mov       eax,dword ptr [ebp-8]
	mov       word ptr [ebp-28],20
	push      eax
	dec       dword ptr [ebp-16]
	lea       eax,dword ptr [ebp-4]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	pop       eax
	mov       word ptr [ebp-28],8
	inc       dword ptr [ebp-16]
	mov       edx,dword ptr [ebp-44]
	mov       dword ptr fs:[0],edx
	?debug L 375
@50:
@49:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@IntToStr$qqrul	endp
@IntToStr$qqrul	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	62
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch72
	dd	?patch73
	dd	?patch74
	df	@@IntToStr$qqrul
	dw	0
	dw	4213
	dw	0
	dw	74
	dw	0
	dw	0
	dw	0
	db	15
	db	64
	db	73
	db	110
	db	116
	db	84
	db	111
	db	83
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	117
	db	108
	dw	18
	dw	512
	dw	65528
	dw	65535
	dw	65525
	dw	65535
	dw	75
	dw	0
	dw	0
	dw	0
	dw	?patch75
	dw	529
	dw	?patch76
	dd	?live16403@0-@@IntToStr$qqrul
	dd	?live16403@0-?live16403@0
	dw	19
?patch76	equ	1
?patch75	equ	14
	dw	18
	dw	512
	dw	65488
	dw	65535
	dw	34
	dw	0
	dw	76
	dw	0
	dw	0
	dw	0
	dw	?patch77
	dw	529
	dw	?patch78
	dd	?live16403@0-@@IntToStr$qqrul
	dd	?live16403@0-?live16403@0
	dw	17
?patch78	equ	1
?patch77	equ	14
?patch72	equ	@50-@@IntToStr$qqrul+4
?patch73	equ	0
?patch74	equ	@50-@@IntToStr$qqrul
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p17System@AnsiString	segment virtual
	align	2
@@$xt$p17System@AnsiString	label	dword
	dd	4
	dw	16
	dw	12
	dd	@@$xt$17System@AnsiString
	db	65
	db	110
	db	115
	db	105
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	32
	db	42
	db	0
@$xt$p17System@AnsiString	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p11Forms@TForm	segment virtual
	align	2
@@$xt$p11Forms@TForm	label	dword
	dd	4
	dw	144
	dw	12
	dd	@@$xt$11Forms@TForm
	db	84
	db	70
	db	111
	db	114
	db	109
	db	32
	db	42
	db	0
@$xt$p11Forms@TForm	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$17System@AnsiString	segment virtual
	align	2
@@$xt$17System@AnsiString	label	byte
	dd	4
	dw	3
	dw	48
	dd	-1
	dd	3
	dw	68
	dw	72
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@System@AnsiString@$bdtr$qqrv
	dw	3
	dw	76
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	58
	db	58
	db	65
	db	110
	db	115
	db	105
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	0
	db	0
	dd	0
	dd	0
	dd	0
@$xt$17System@AnsiString	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$p9TfrmAbout	segment virtual
	align	2
@@$xt$p9TfrmAbout	label	dword
	dd	4
	dw	144
	dw	12
	dd	@@$xt$9TfrmAbout
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	32
	db	42
	db	0
@$xt$p9TfrmAbout	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@TfrmAbout@	segment virtual
	align	2
@@TfrmAbout@	label	byte
	dd	@@TfrmAbout@+76
	dd	0
	dd	0
	dd	0
	dd	@@$xp$9TfrmAbout+4
	dd	@@TfrmAbout@+300
	dd	@@TfrmAbout@+450
	dd	0
	dd	@@TfrmAbout@+524
	dd	760
	dd	@Forms@TForm@
	dd	@@Classes@TComponent@SafeCallException$qqrp14System@TObjectpv
	dd	@@Forms@TCustomForm@AfterConstruction$qqrv
	dd	@@Forms@TCustomForm@BeforeDestruction$qqrv
	dd	@@System@TObject@Dispatch$qqrpv
	dd	@@Forms@TCustomForm@DefaultHandler$qqrpv
	dd	@@System@TObject@NewInstance$qqrp17System@TMetaClass
	dd	@@System@TObject@FreeInstance$qqrv
	dd	@@TfrmAbout@$bdtr$qqrv
	dd	@@Controls@TWinControl@AssignTo$qqrp19Classes@TPersistent
	dd	@@Forms@TCustomForm@DefineProperties$qqrp14Classes@TFiler
	dd	@@Classes@TPersistent@Assign$qqrp19Classes@TPersistent
	dd	@@Forms@TCustomForm@Loaded$qqrv
	dd	@@Forms@TCustomForm@Notification$qqrp18Classes@TComponent18Classes@TOperation
	dd	@@Forms@TCustomForm@ReadState$qqrp15Classes@TReader
	dd	@@Controls@TControl@SetName$qqrx17System@AnsiString
	dd	@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dd	@@Forms@TCustomForm@ValidateRename$qqrp18Classes@TComponentx17System@AnsiStringt2
	dd	@@Classes@TComponent@WriteState$qqrp15Classes@TWriter
	dd	@@Forms@TCustomForm@QueryInterface$qqsrx5_GUIDpv
	dd	@@TfrmAbout@$bctr$qqrp18Classes@TComponent
	dd	@@Controls@TWinControl@CanResize$qqrrit1
	dd	@@Controls@TWinControl@CanAutoSize$qqrrit1
	dd	@@Controls@TWinControl@ConstrainedResize$qqrrit1t1t1
	dd	@@Controls@TWinControl@GetClientOrigin$qqrv
	dd	@@Forms@TCustomForm@GetClientRect$qqrv
	dd	@@Controls@TWinControl@GetDeviceContext$qqrrpv
	dd	@@Controls@TControl@GetDragImages$qqrv
	dd	@@Controls@TControl@GetEnabled$qqrv
	dd	@@Forms@TCustomForm@GetFloating$qqrv
	dd	@@Controls@TControl@GetFloatingDockSiteClass$qqrv
	dd	@@Controls@TControl@SetDragMode$qqr18Controls@TDragMode
	dd	@@Controls@TControl@SetEnabled$qqro
	dd	@@Forms@TCustomForm@SetParent$qqrp20Controls@TWinControl
	dd	@@Forms@TCustomForm@SetParentBiDiMode$qqro
	dd	@@Controls@TControl@SetBiDiMode$qqr17Classes@TBiDiMode
	dd	@@Forms@TCustomForm@WndProc$qqrr17Messages@TMessage
	dd	@@Controls@TControl@InitiateAction$qqrv
	dd	@@Controls@TWinControl@Invalidate$qqrv
	dd	@@Controls@TWinControl@Repaint$qqrv
	dd	@@Controls@TWinControl@SetBounds$qqriiii
	dd	@@Controls@TWinControl@Update$qqrv
	dd	@@Forms@TScrollingWinControl@AdjustClientRect$qqrr13Windows@TRect
	dd	@@Forms@TCustomForm@AlignControls$qqrp17Controls@TControlr13Windows@TRect
	dd	@@Controls@TWinControl@CreateHandle$qqrv
	dd	@@Forms@TCustomForm@CreateParams$qqrr22Controls@TCreateParams
	dd	@@Forms@TCustomForm@CreateWindowHandle$qqrrx22Controls@TCreateParams
	dd	@@Forms@TCustomForm@CreateWnd$qqrv
	dd	@@Forms@TCustomForm@DestroyWindowHandle$qqrv
	dd	@@Controls@TWinControl@DestroyWnd$qqrv
	dd	@@Controls@TWinControl@GetControlExtents$qqrv
	dd	@@Forms@TCustomForm@PaintWindow$qqrpv
	dd	@@Controls@TWinControl@ShowControl$qqrp17Controls@TControl
	dd	@@Forms@TCustomForm@SetFocus$qqrv
	dd	@@Forms@TScrollingWinControl@AutoScrollEnabled$qqrv
	dd	@@Forms@TScrollingWinControl@AutoScrollInView$qqrp17Controls@TControl
	dd	@@Forms@TCustomForm@Resizing$qqr18Forms@TWindowState
	dd	@@Forms@TCustomForm@DoCreate$qqrv
	dd	@@Forms@TCustomForm@DoDestroy$qqrv
	dd	@@Forms@TCustomForm@UpdateActions$qqrv
	dd	@@Forms@TForm@$bctr$qqrp18Classes@TComponenti
	dd	@@Forms@TCustomForm@CloseQuery$qqrv
	dd	@@Forms@TCustomForm@SetFocusedControl$qqrp20Controls@TWinControl
	dd	@@Forms@TCustomForm@ShowModal$qqrv
	dd	@@Forms@TCustomForm@WantChildKey$qqrp17Controls@TControlr17Messages@TMessage
	dw	10
	dd	@@TfrmAbout@+534
	dd	720
	dw	0
	db	6
	db        80,97,110,101,108,49
	dd	724
	dw	1
	db	11
	db        80,114,111,100,117,99,116,78,97,109,101
	dd	728
	dw	1
	db	7
	db        86,101,114,115,105,111,110
	dd	732
	dw	1
	db	8
	db        67,111,109,109,101,110,116,115
	dd	736
	dw	1
	db	6
	db        76,97,98,101,108,51
	dd	740
	dw	1
	db	7
	db        80,104,121,115,77,101,109
	dd	744
	dw	1
	db	7
	db        70,114,101,101,82,101,115
	dd	748
	dw	1
	db	8
	db        67,112,117,76,97,98,101,108
	dd	752
	dw	2
	db	8
	db        79,75,66,117,116,116,111,110
	dd	756
	dw	3
	db	6
	db        73,109,97,103,101,49
	dw	4
	dw	18
	dd	@@TfrmAbout@Label3Click$qqrp14System@TObject
	db	11
	db        76,97,98,101,108,51,67,108,105,99,107
	dw	20
	dd	@@TfrmAbout@OKButtonClick$qqrp14System@TObject
	db	13
	db        79,75,66,117,116,116,111,110,67,108,105,99,107
	dw	19
	dd	@@TfrmAbout@FormActivate$qqrp14System@TObject
	db	12
	db        70,111,114,109,65,99,116,105,118,97,116,101
	dw	15
	dd	@@TfrmAbout@FormShow$qqrp14System@TObject
	db	8
	db        70,111,114,109,83,104,111,119
	db	9
	db        84,102,114,109,65,98,111,117,116
	dw	4
	dd	@Extctrls@TPanel@
	dd	@Stdctrls@TLabel@
	dd	@Stdctrls@TButton@
	dd	@Extctrls@TImage@
@TfrmAbout@	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@$xp$9TfrmAbout	segment virtual
	align	2
@@$xp$9TfrmAbout	label	byte
	dd	@@$xp$9TfrmAbout+4
	db	7
	db	9
	db        84,102,114,109,65,98,111,117,116
	dd	@@TfrmAbout@+76
	dd	@$xp$11Forms@TForm
	dw	86
	db	10
	db        85,110,105,116,95,65,98,111,117,116
	dw	0
@$xp$9TfrmAbout	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$9TfrmAbout	segment virtual
	align	2
@@$xt$9TfrmAbout	label	byte
	dd	760
	dw	3
	dw	48
	dd	0
	dd	183
	dw	60
	dw	76
	dd	0
	dw	0
	dw	0
	dd	0
	dd	16
	dd	16
	dd	@@TfrmAbout@$bdtr$qqrv
	dw	3
	dw	80
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	0
	db	0
	db	0
	dd	@@$xt$11Forms@TForm
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$9TfrmAbout	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$11Forms@TForm	segment virtual
	align	2
@@$xt$11Forms@TForm	label	byte
	dd	720
	dw	3
	dw	48
	dd	0
	dd	183
	dw	64
	dw	80
	dd	0
	dw	0
	dw	0
	dd	0
	dd	15
	dd	15
	dd	@@Forms@TForm@$bdtr$qqrv
	dw	3
	dw	84
	db	70
	db	111
	db	114
	db	109
	db	115
	db	58
	db	58
	db	84
	db	70
	db	111
	db	114
	db	109
	db	0
	db	0
	db	0
	db	0
	dd	@@$xt$17Forms@TCustomForm
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$11Forms@TForm	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
@_$ECTTE$@TfrmAbout@$bdtr$qqrv	segment virtual
	align	2
@@_$ECTTE$@TfrmAbout@$bdtr$qqrv	label	dword
	dd	0
	dd	-36
@_$ECTTE$@TfrmAbout@$bdtr$qqrv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@TfrmAbout@$bdtr$qqrv	segment virtual
@@TfrmAbout@$bdtr$qqrv	proc	near
?live16419@0:
	?debug L 0
	push      ebp
	mov       ebp,esp
	add       esp,-44
	call      __BeforeDestruction
	mov       byte ptr [ebp-41],dl
	mov       dword ptr [ebp-40],eax
@51:
	mov       eax,offset @@_$ECTTE$@TfrmAbout@$bdtr$qqrv
	call      @__InitExceptBlockLDTC
	cmp       byte ptr [ebp-41],0
	jl        short @52
	sub       dword ptr [ebp-8],15
	xor       edx,edx
	mov       eax,dword ptr [ebp-40]
	call      @@Forms@TForm@$bdtr$qqrv
@52:
@53:
	mov       edx,dword ptr [ebp-36]
	mov       dword ptr fs:[0],edx
@55:
@54:
	cmp       byte ptr [ebp-41],0
	jle       short @56
	mov       eax,dword ptr [ebp-40]
	call      __ClassDestroy
	?debug L 375
@56:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@TfrmAbout@$bdtr$qqrv	endp
@TfrmAbout@$bdtr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	68
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch79
	dd	?patch80
	dd	?patch81
	df	@@TfrmAbout@$bdtr$qqrv
	dw	0
	dw	4215
	dw	0
	dw	77
	dw	0
	dw	0
	dw	0
	db	21
	db	64
	db	84
	db	102
	db	114
	db	109
	db	65
	db	98
	db	111
	db	117
	db	116
	db	64
	db	36
	db	98
	db	100
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65496
	dw	65535
	dw	4102
	dw	0
	dw	78
	dw	0
	dw	0
	dw	0
	dw	?patch82
	dw	529
	dw	?patch83
	dd	?live16419@0-@@TfrmAbout@$bdtr$qqrv
	dd	?live16419@0-?live16419@0
	dw	17
?patch83	equ	1
?patch82	equ	14
?patch79	equ	@55-@@TfrmAbout@$bdtr$qqrv+18
?patch80	equ	0
?patch81	equ	@55-@@TfrmAbout@$bdtr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCUE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	segment virtual
	align	2
@@_$DCUE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	label	dword
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-4
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	8
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-8
	dd	@@$xt$17System@AnsiString
	dd	4
	dd	-12
	dd	0
@_$DCUE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTVE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	segment virtual
	align	2
@@_$ECTVE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	label	dword
	dd	0
	dd	-48
	dw	0
	dw	5
	dd	2
	dd	@@_$DCUE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dw	8
	dw	5
	dd	4
	dd	@@_$DCUE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2+28
@_$ECTVE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	segment virtual
@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	proc	near
?live16420@0:
	?debug	T "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\classes.hpp"
	?debug L 2068
	push      ebp
	mov       ebp,esp
	add       esp,-56
	mov       dword ptr [ebp-4],ecx
	mov       byte ptr [ebp-53],dl
	mov       dword ptr [ebp-52],eax
@57:
	mov       eax,offset @@_$ECTVE$@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	call      @__InitExceptBlockLDTC
	mov       dword ptr [ebp-20],2
	lea       edx,dword ptr [ebp-4]
	lea       eax,dword ptr [ebp-4]
	call      @@System@AnsiString@$bctr$qqrrx17System@AnsiString
	inc       dword ptr [ebp-20]
	?debug L 2069
	mov       word ptr [ebp-32],8
	lea       edx,dword ptr [ebp+8]
	lea       eax,dword ptr [ebp+8]
	call      @@System@AnsiString@$bctr$qqrrx17System@AnsiString
	inc       dword ptr [ebp-20]
	lea       edx,dword ptr [ebp+8]
	lea       eax,dword ptr [ebp-12]
	call      @@System@AnsiString@$bctr$qqrrx17System@AnsiString
	inc       dword ptr [ebp-20]
	push      dword ptr [eax]
	mov       word ptr [ebp-32],20
	lea       edx,dword ptr [ebp-4]
	lea       eax,dword ptr [ebp-8]
	call      @@System@AnsiString@$bctr$qqrrx17System@AnsiString
	inc       dword ptr [ebp-20]
	mov       ecx,dword ptr [eax]
	mov       dl,byte ptr [ebp-53]
	mov       eax,dword ptr [@Classes@TComponent@]
	call      @@Classes@TComponent@UpdateRegistry$qqrp17System@TMetaClassox17System@AnsiStringt3
	dec       dword ptr [ebp-20]
	lea       eax,dword ptr [ebp-12]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-20]
	lea       eax,dword ptr [ebp-8]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-20]
	lea       eax,dword ptr [ebp+8]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	dec       dword ptr [ebp-20]
	lea       eax,dword ptr [ebp-4]
	mov       edx,2
	call      @@System@AnsiString@$bdtr$qqrv
	mov       ecx,dword ptr [ebp-48]
	mov       dword ptr fs:[0],ecx
	?debug L 2069
@58:
	mov       esp,ebp
	pop       ebp
	ret       4
	?debug L 0
@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	endp
@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	108
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch84
	dd	?patch85
	dd	?patch86
	df	@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dw	0
	dw	4217
	dw	0
	dw	79
	dw	0
	dw	0
	dw	0
	db	61
	db	64
	db	67
	db	108
	db	97
	db	115
	db	115
	db	101
	db	115
	db	64
	db	84
	db	67
	db	111
	db	109
	db	112
	db	111
	db	110
	db	101
	db	110
	db	116
	db	64
	db	85
	db	112
	db	100
	db	97
	db	116
	db	101
	db	82
	db	101
	db	103
	db	105
	db	115
	db	116
	db	114
	db	121
	db	36
	db	113
	db	113
	db	114
	db	111
	db	120
	db	49
	db	55
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	65
	db	110
	db	115
	db	105
	db	83
	db	116
	db	114
	db	105
	db	110
	db	103
	db	116
	db	50
	dw	18
	dw	512
	dw	65484
	dw	65535
	dw	4218
	dw	0
	dw	80
	dw	0
	dw	0
	dw	0
	dw	?patch87
	dw	529
	dw	?patch88
	dd	?live16420@0-@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dd	?live16420@0-?live16420@0
	dw	17
?patch88	equ	1
?patch87	equ	14
	dw	18
	dw	512
	dw	65483
	dw	65535
	dw	48
	dw	0
	dw	81
	dw	0
	dw	0
	dw	0
	dw	?patch89
	dw	529
	dw	?patch90
	dd	?live16420@0-@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dd	?live16420@0-?live16420@0
	dw	3
?patch90	equ	1
?patch89	equ	14
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4211
	dw	0
	dw	82
	dw	0
	dw	0
	dw	0
	dw	?patch91
	dw	529
	dw	?patch92
	dd	?live16420@0-@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dd	?live16420@0-?live16420@0
	dw	0
?patch92	equ	1
?patch91	equ	14
	dw	18
	dw	512
	dw	8
	dw	0
	dw	4211
	dw	0
	dw	83
	dw	0
	dw	0
	dw	0
?patch84	equ	@58-@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2+6
?patch85	equ	0
?patch86	equ	@58-@@Classes@TComponent@UpdateRegistry$qqrox17System@AnsiStringt2
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCWE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti	segment virtual
	align	2
@@_$DCWE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti	label	dword
	dd	@@$xt$p11Forms@TForm
	dd	1029
	dd	-4
	dd	0
@_$DCWE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTXE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti	segment virtual
	align	2
@@_$ECTXE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti	label	dword
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	@@_$DCWE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti
@_$ECTXE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@Forms@TForm@$bctr$qqrp18Classes@TComponenti	segment virtual
@@Forms@TForm@$bctr$qqrp18Classes@TComponenti	proc	near
?live16421@0:
	?debug	T "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\forms.hpp"
	?debug L 936
	push      ebp
	mov       ebp,esp
	add       esp,-48
	mov       byte ptr [ebp-8],dl
	test      dl,dl
	jle       short @59
	call      __ClassCreate
@59:
	mov       dword ptr [ebp-48],ecx
	mov       byte ptr [ebp-41],dl
	mov       dword ptr [ebp-4],eax
@60:
	mov       eax,offset @@_$ECTXE$@Forms@TForm@$bctr$qqrp18Classes@TComponenti
	call      @__InitExceptBlockLDTC
	?debug L 937
	mov       word ptr [ebp-24],8
	push      dword ptr [ebp+8]
	mov       ecx,dword ptr [ebp-48]
	xor       edx,edx
	mov       eax,dword ptr [ebp-4]
	call      @@Forms@TCustomForm@$bctr$qqrp18Classes@TComponenti
	add       dword ptr [ebp-12],14
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],edx
	mov       eax,dword ptr [ebp-4]
@62:
@61:
	cmp       byte ptr [ebp-41],0
	je        short @63
	call      __AfterConstruction
	?debug L 937
@63:
	mov       esp,ebp
	pop       ebp
	ret       4
	?debug L 0
@@Forms@TForm@$bctr$qqrp18Classes@TComponenti	endp
@Forms@TForm@$bctr$qqrp18Classes@TComponenti	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	91
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch93
	dd	?patch94
	dd	?patch95
	df	@@Forms@TForm@$bctr$qqrp18Classes@TComponenti
	dw	0
	dw	4220
	dw	0
	dw	84
	dw	0
	dw	0
	dw	0
	db	44
	db	64
	db	70
	db	111
	db	114
	db	109
	db	115
	db	64
	db	84
	db	70
	db	111
	db	114
	db	109
	db	64
	db	36
	db	98
	db	99
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	112
	db	49
	db	56
	db	67
	db	108
	db	97
	db	115
	db	115
	db	101
	db	115
	db	64
	db	84
	db	67
	db	111
	db	109
	db	112
	db	111
	db	110
	db	101
	db	110
	db	116
	db	105
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4204
	dw	0
	dw	85
	dw	0
	dw	0
	dw	0
	dw	?patch96
	dw	529
	dw	?patch97
	dd	?live16421@0-@@Forms@TForm@$bctr$qqrp18Classes@TComponenti
	dd	?live16421@0-?live16421@0
	dw	17
?patch97	equ	1
?patch96	equ	14
	dw	18
	dw	512
	dw	65488
	dw	65535
	dw	65529
	dw	65535
	dw	86
	dw	0
	dw	0
	dw	0
	dw	?patch98
	dw	529
	dw	?patch99
	dd	?live16421@0-@@Forms@TForm@$bctr$qqrp18Classes@TComponenti
	dd	?live16421@0-?live16421@0
	dw	18
?patch99	equ	1
?patch98	equ	14
	dw	18
	dw	512
	dw	8
	dw	0
	dw	116
	dw	0
	dw	87
	dw	0
	dw	0
	dw	0
?patch93	equ	@62-@@Forms@TForm@$bctr$qqrp18Classes@TComponenti+17
?patch94	equ	0
?patch95	equ	@62-@@Forms@TForm@$bctr$qqrp18Classes@TComponenti
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_DATA	segment dword public use32 'DATA'
@_$DCYE$@Forms@TForm@$bdtr$qqrv	segment virtual
	align	2
@@_$DCYE$@Forms@TForm@$bdtr$qqrv	label	dword
	dd	@@$xt$p11Forms@TForm
	dd	1029
	dd	-4
	dd	0
@_$DCYE$@Forms@TForm@$bdtr$qqrv	ends
_DATA	ends
_DATA	segment dword public use32 'DATA'
@_$ECTZE$@Forms@TForm@$bdtr$qqrv	segment virtual
	align	2
@@_$ECTZE$@Forms@TForm@$bdtr$qqrv	label	dword
	dd	0
	dd	-40
	dw	0
	dw	5
	dd	0
	dd	@@_$DCYE$@Forms@TForm@$bdtr$qqrv
@_$ECTZE$@Forms@TForm@$bdtr$qqrv	ends
_DATA	ends
_TEXT	segment dword public use32 'CODE'
@Forms@TForm@$bdtr$qqrv	segment virtual
@@Forms@TForm@$bdtr$qqrv	proc	near
?live16422@0:
	?debug L 940
	push      ebp
	mov       ebp,esp
	add       esp,-44
	call      __BeforeDestruction
	mov       byte ptr [ebp-41],dl
	mov       dword ptr [ebp-4],eax
@64:
	mov       eax,offset @@_$ECTZE$@Forms@TForm@$bdtr$qqrv
	call      @__InitExceptBlockLDTC
	mov       dword ptr [ebp-12],14
	cmp       byte ptr [ebp-41],0
	jl        short @65
	mov       word ptr [ebp-24],8
	sub       dword ptr [ebp-12],14
	xor       edx,edx
	mov       eax,dword ptr [ebp-4]
	call      @@Forms@TCustomForm@$bdtr$qqrv
@65:
	mov       edx,dword ptr [ebp-40]
	mov       dword ptr fs:[0],edx
@66:
	cmp       byte ptr [ebp-41],0
	jle       short @67
	mov       eax,dword ptr [ebp-4]
	call      __ClassDestroy
	?debug L 940
@67:
	mov       esp,ebp
	pop       ebp
	ret 
	?debug L 0
@@Forms@TForm@$bdtr$qqrv	endp
@Forms@TForm@$bdtr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	70
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch100
	dd	?patch101
	dd	?patch102
	df	@@Forms@TForm@$bdtr$qqrv
	dw	0
	dw	4222
	dw	0
	dw	88
	dw	0
	dw	0
	dw	0
	db	23
	db	64
	db	70
	db	111
	db	114
	db	109
	db	115
	db	64
	db	84
	db	70
	db	111
	db	114
	db	109
	db	64
	db	36
	db	98
	db	100
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4204
	dw	0
	dw	89
	dw	0
	dw	0
	dw	0
	dw	?patch103
	dw	529
	dw	?patch104
	dd	?live16422@0-@@Forms@TForm@$bdtr$qqrv
	dd	?live16422@0-?live16422@0
	dw	17
?patch104	equ	1
?patch103	equ	14
?patch100	equ	@66-@@Forms@TForm@$bdtr$qqrv+18
?patch101	equ	0
?patch102	equ	@66-@@Forms@TForm@$bdtr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@$xt$17Forms@TCustomForm	segment virtual
	align	2
@@$xt$17Forms@TCustomForm	label	byte
	dd	720
	dw	3
	dw	48
	dd	0
	dd	183
	dw	68
	dw	84
	dd	0
	dw	0
	dw	0
	dd	0
	dd	14
	dd	14
	dd	@@Forms@TCustomForm@$bdtr$qqrv
	dw	3
	dw	88
	db	70
	db	111
	db	114
	db	109
	db	115
	db	58
	db	58
	db	84
	db	67
	db	117
	db	115
	db	116
	db	111
	db	109
	db	70
	db	111
	db	114
	db	109
	db	0
	db	0
	dd	@@$xt$26Forms@TScrollingWinControl
	dd	0
	dd	3
	dd	0
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	548
	dd	@@$xt$43System@%DelphiInterface$t15Forms@IDesigner%
	dd	568
	dd	@@$xt$42System@%DelphiInterface$t14Forms@IOleForm%
	dd	588
	dd	0
@$xt$17Forms@TCustomForm	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$42System@%DelphiInterface$t14Forms@IOleForm%	segment virtual
	align	2
@@$xt$42System@%DelphiInterface$t14Forms@IOleForm%	label	byte
	dd	4
	dw	3
	dw	48
	dd	-1
	dd	3
	dw	92
	dw	96
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv
	dw	3
	dw	100
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	58
	db	58
	db	68
	db	101
	db	108
	db	112
	db	104
	db	105
	db	73
	db	110
	db	116
	db	101
	db	114
	db	102
	db	97
	db	99
	db	101
	db	60
	db	70
	db	111
	db	114
	db	109
	db	115
	db	58
	db	58
	db	73
	db	79
	db	108
	db	101
	db	70
	db	111
	db	114
	db	109
	db	62
	db	0
	db	0
	db	0
	db	0
	dd	0
	dd	0
	dd	0
@$xt$42System@%DelphiInterface$t14Forms@IOleForm%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$43System@%DelphiInterface$t15Forms@IDesigner%	segment virtual
	align	2
@@$xt$43System@%DelphiInterface$t15Forms@IDesigner%	label	byte
	dd	4
	dw	3
	dw	48
	dd	-1
	dd	3
	dw	92
	dw	96
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv
	dw	3
	dw	100
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	58
	db	58
	db	68
	db	101
	db	108
	db	112
	db	104
	db	105
	db	73
	db	110
	db	116
	db	101
	db	114
	db	102
	db	97
	db	99
	db	101
	db	60
	db	70
	db	111
	db	114
	db	109
	db	115
	db	58
	db	58
	db	73
	db	68
	db	101
	db	115
	db	105
	db	103
	db	110
	db	101
	db	114
	db	62
	db	0
	db	0
	db	0
	dd	0
	dd	0
	dd	0
@$xt$43System@%DelphiInterface$t15Forms@IDesigner%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$26Forms@TScrollingWinControl	segment virtual
	align	2
@@$xt$26Forms@TScrollingWinControl	label	byte
	dd	520
	dw	3
	dw	48
	dd	0
	dd	183
	dw	76
	dw	92
	dd	0
	dw	0
	dw	0
	dd	0
	dd	10
	dd	10
	dd	@@Forms@TScrollingWinControl@$bdtr$qqrv
	dw	3
	dw	96
	db	70
	db	111
	db	114
	db	109
	db	115
	db	58
	db	58
	db	84
	db	83
	db	99
	db	114
	db	111
	db	108
	db	108
	db	105
	db	110
	db	103
	db	87
	db	105
	db	110
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	0
	dd	@@$xt$20Controls@TWinControl
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$26Forms@TScrollingWinControl	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv	segment virtual
@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv	proc	near
?live16435@0:
	?debug	T "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\systobj.h"
	?debug L 240
	push      ebp
	mov       ebp,esp
	add       esp,-8
	mov       dword ptr [ebp-8],edx
	mov       dword ptr [ebp-4],eax
@68:
	cmp       dword ptr [ebp-4],0
	je        short @69
	?debug L 241
	mov       eax,dword ptr [ebp-4]
	cmp       dword ptr [eax],0
	je        short @70
	?debug L 242
	mov       edx,dword ptr [ebp-4]
	mov       ecx,dword ptr [edx]
	push      ecx
	mov       eax,dword ptr [ecx]
	call      dword ptr [eax+8]
	?debug L 243
@70:
	mov       edx,dword ptr [ebp-4]
	xor       ecx,ecx
	mov       dword ptr [edx],ecx
	test      byte ptr [ebp-8],1
	je        short @71
	push      dword ptr [ebp-4]
	call      @$bdele$qpv
	pop       ecx
	?debug L 244
@71:
@69:
@72:
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv	endp
@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	101
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch105
	dd	?patch106
	dd	?patch107
	df	@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv
	dw	0
	dw	4236
	dw	0
	dw	101
	dw	0
	dw	0
	dw	0
	db	54
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	37
	db	68
	db	101
	db	108
	db	112
	db	104
	db	105
	db	73
	db	110
	db	116
	db	101
	db	114
	db	102
	db	97
	db	99
	db	101
	db	36
	db	116
	db	49
	db	52
	db	70
	db	111
	db	114
	db	109
	db	115
	db	64
	db	73
	db	79
	db	108
	db	101
	db	70
	db	111
	db	114
	db	109
	db	37
	db	64
	db	36
	db	98
	db	100
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4228
	dw	0
	dw	102
	dw	0
	dw	0
	dw	0
	dw	?patch108
	dw	529
	dw	?patch109
	dd	?live16435@0-@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv
	dd	?live16435@0-?live16435@0
	dw	17
?patch109	equ	1
?patch108	equ	14
?patch105	equ	@72-@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv+4
?patch106	equ	0
?patch107	equ	@72-@@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv	segment virtual
@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv	proc	near
?live16436@0:
	?debug L 240
	push      ebp
	mov       ebp,esp
	add       esp,-8
	mov       dword ptr [ebp-8],edx
	mov       dword ptr [ebp-4],eax
@73:
	cmp       dword ptr [ebp-4],0
	je        short @74
	?debug L 241
	mov       eax,dword ptr [ebp-4]
	cmp       dword ptr [eax],0
	je        short @75
	?debug L 242
	mov       edx,dword ptr [ebp-4]
	mov       ecx,dword ptr [edx]
	push      ecx
	mov       eax,dword ptr [ecx]
	call      dword ptr [eax+8]
	?debug L 243
@75:
	mov       edx,dword ptr [ebp-4]
	xor       ecx,ecx
	mov       dword ptr [edx],ecx
	test      byte ptr [ebp-8],1
	je        short @76
	push      dword ptr [ebp-4]
	call      @$bdele$qpv
	pop       ecx
	?debug L 244
@76:
@74:
@77:
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv	endp
@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	102
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch110
	dd	?patch111
	dd	?patch112
	df	@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv
	dw	0
	dw	4279
	dw	0
	dw	114
	dw	0
	dw	0
	dw	0
	db	55
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	37
	db	68
	db	101
	db	108
	db	112
	db	104
	db	105
	db	73
	db	110
	db	116
	db	101
	db	114
	db	102
	db	97
	db	99
	db	101
	db	36
	db	116
	db	49
	db	53
	db	70
	db	111
	db	114
	db	109
	db	115
	db	64
	db	73
	db	68
	db	101
	db	115
	db	105
	db	103
	db	110
	db	101
	db	114
	db	37
	db	64
	db	36
	db	98
	db	100
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4271
	dw	0
	dw	115
	dw	0
	dw	0
	dw	0
	dw	?patch113
	dw	529
	dw	?patch114
	dd	?live16436@0-@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv
	dd	?live16436@0-?live16436@0
	dw	17
?patch114	equ	1
?patch113	equ	14
?patch110	equ	@77-@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv+4
?patch111	equ	0
?patch112	equ	@77-@@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@$xt$20Controls@TWinControl	segment virtual
	align	2
@@$xt$20Controls@TWinControl	label	byte
	dd	496
	dw	3
	dw	48
	dd	0
	dd	183
	dw	72
	dw	88
	dd	0
	dw	0
	dw	0
	dd	0
	dd	9
	dd	9
	dd	@@Controls@TWinControl@$bdtr$qqrv
	dw	3
	dw	92
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	115
	db	58
	db	58
	db	84
	db	87
	db	105
	db	110
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	0
	db	0
	db	0
	dd	@@$xt$17Controls@TControl
	dd	0
	dd	3
	dd	0
	dd	0
	dd	@@$xt$49System@%DelphiInterface$t21Controls@IDockManager%
	dd	328
	dd	@@$xt$17System@AnsiString
	dd	344
	dd	0
@$xt$20Controls@TWinControl	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$49System@%DelphiInterface$t21Controls@IDockManager%	segment virtual
	align	2
@@$xt$49System@%DelphiInterface$t21Controls@IDockManager%	label	byte
	dd	4
	dw	3
	dw	48
	dd	-1
	dd	3
	dw	96
	dw	100
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv
	dw	3
	dw	104
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	58
	db	58
	db	68
	db	101
	db	108
	db	112
	db	104
	db	105
	db	73
	db	110
	db	116
	db	101
	db	114
	db	102
	db	97
	db	99
	db	101
	db	60
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	115
	db	58
	db	58
	db	73
	db	68
	db	111
	db	99
	db	107
	db	77
	db	97
	db	110
	db	97
	db	103
	db	101
	db	114
	db	62
	db	0
	dd	0
	dd	0
	dd	0
@$xt$49System@%DelphiInterface$t21Controls@IDockManager%	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$17Controls@TControl	segment virtual
	align	2
@@$xt$17Controls@TControl	label	byte
	dd	288
	dw	3
	dw	48
	dd	0
	dd	183
	dw	68
	dw	84
	dd	0
	dw	0
	dw	0
	dd	0
	dd	6
	dd	6
	dd	@@Controls@TControl@$bdtr$qqrv
	dw	3
	dw	88
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	115
	db	58
	db	58
	db	84
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	0
	db	0
	dd	@@$xt$18Classes@TComponent
	dd	0
	dd	3
	dd	0
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	112
	dd	0
@$xt$17Controls@TControl	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv	segment virtual
@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv	proc	near
?live16440@0:
	?debug L 240
	push      ebp
	mov       ebp,esp
	add       esp,-8
	mov       dword ptr [ebp-8],edx
	mov       dword ptr [ebp-4],eax
@78:
	cmp       dword ptr [ebp-4],0
	je        short @79
	?debug L 241
	mov       eax,dword ptr [ebp-4]
	cmp       dword ptr [eax],0
	je        short @80
	?debug L 242
	mov       edx,dword ptr [ebp-4]
	mov       ecx,dword ptr [edx]
	push      ecx
	mov       eax,dword ptr [ecx]
	call      dword ptr [eax+8]
	?debug L 243
@80:
	mov       edx,dword ptr [ebp-4]
	xor       ecx,ecx
	mov       dword ptr [edx],ecx
	test      byte ptr [ebp-8],1
	je        short @81
	push      dword ptr [ebp-4]
	call      @$bdele$qpv
	pop       ecx
	?debug L 244
@81:
@79:
@82:
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
	?debug L 0
@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv	endp
@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv	ends
_TEXT	ends
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	108
	dw	517
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dw	0
	dd	?patch115
	dd	?patch116
	dd	?patch117
	df	@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv
	dw	0
	dw	4322
	dw	0
	dw	127
	dw	0
	dw	0
	dw	0
	db	61
	db	64
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	64
	db	37
	db	68
	db	101
	db	108
	db	112
	db	104
	db	105
	db	73
	db	110
	db	116
	db	101
	db	114
	db	102
	db	97
	db	99
	db	101
	db	36
	db	116
	db	50
	db	49
	db	67
	db	111
	db	110
	db	116
	db	114
	db	111
	db	108
	db	115
	db	64
	db	73
	db	68
	db	111
	db	99
	db	107
	db	77
	db	97
	db	110
	db	97
	db	103
	db	101
	db	114
	db	37
	db	64
	db	36
	db	98
	db	100
	db	116
	db	114
	db	36
	db	113
	db	113
	db	114
	db	118
	dw	18
	dw	512
	dw	65532
	dw	65535
	dw	4314
	dw	0
	dw	128
	dw	0
	dw	0
	dw	0
	dw	?patch118
	dw	529
	dw	?patch119
	dd	?live16440@0-@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv
	dd	?live16440@0-?live16440@0
	dw	17
?patch119	equ	1
?patch118	equ	14
?patch115	equ	@82-@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv+4
?patch116	equ	0
?patch117	equ	@82-@@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv
	dw	2
	dw	6
	dw	4
	dw	531
	dw	0
$$BSYMS	ends
_TEXT	segment dword public use32 'CODE'
@$xt$18Classes@TComponent	segment virtual
	align	2
@@$xt$18Classes@TComponent	label	byte
	dd	36
	dw	3
	dw	48
	dd	0
	dd	183
	dw	68
	dw	84
	dd	0
	dw	0
	dw	0
	dd	0
	dd	4
	dd	4
	dd	@@Classes@TComponent@$bdtr$qqrv
	dw	3
	dw	88
	db	67
	db	108
	db	97
	db	115
	db	115
	db	101
	db	115
	db	58
	db	58
	db	84
	db	67
	db	111
	db	109
	db	112
	db	111
	db	110
	db	101
	db	110
	db	116
	db	0
	dd	@@$xt$19Classes@TPersistent
	dd	0
	dd	3
	dd	0
	dd	0
	dd	@@$xt$17System@AnsiString
	dd	8
	dd	0
@$xt$18Classes@TComponent	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$19Classes@TPersistent	segment virtual
	align	2
@@$xt$19Classes@TPersistent	label	byte
	dd	4
	dw	3
	dw	48
	dd	0
	dd	183
	dw	72
	dw	88
	dd	0
	dw	0
	dw	0
	dd	0
	dd	2
	dd	2
	dd	@@Classes@TPersistent@$bdtr$qqrv
	dw	3
	dw	92
	db	67
	db	108
	db	97
	db	115
	db	115
	db	101
	db	115
	db	58
	db	58
	db	84
	db	80
	db	101
	db	114
	db	115
	db	105
	db	115
	db	116
	db	101
	db	110
	db	116
	db	0
	db	0
	db	0
	db	0
	dd	@@$xt$14System@TObject
	dd	0
	dd	3
	dd	0
	dd	0
	dd	0
@$xt$19Classes@TPersistent	ends
_TEXT	ends
_TEXT	segment dword public use32 'CODE'
@$xt$14System@TObject	segment virtual
	align	2
@@$xt$14System@TObject	label	byte
	dd	4
	dw	3
	dw	48
	dd	0
	dd	179
	dw	64
	dw	68
	dd	0
	dw	0
	dw	0
	dd	0
	dd	1
	dd	1
	dd	@@System@TObject@$bdtr$qqrv
	dw	3
	dw	72
	db	83
	db	121
	db	115
	db	116
	db	101
	db	109
	db	58
	db	58
	db	84
	db	79
	db	98
	db	106
	db	101
	db	99
	db	116
	db	0
	dd	0
	dd	0
	dd	0
@$xt$14System@TObject	ends
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	;	s@+0:
	db	"open",0,206,248,232,225,234,224
	;	s@+11:
	db	" ",238,242,234,240,251,242,232,255
	;	s@+20:
	db	" ",225,240,224,243,231,229,240,224,0,194,241,229,227,238
	;	s@+35:
	db	" ",244,232,231,232,247,229,241,234,238,233
	;	s@+46:
	db	" ",239,224,236,255,242,232
	;	s@+53:
	db	" : ",0
	;	s@+57:
	db	"#,###' KB'",0,200,241,239,238,235,252,231,243,229,242,241
	db	255
	;	s@+80:
	db	" ",226
	;	s@+82:
	db	" ",228,224,237,237,251,233
	;	s@+89:
	db	" ",236,238,236,229,237,242
	;	s@+96:
	db	" : ",0
	;	s@+100:
	db	" %",0,215,224,241,242,238,242,224
	;	s@+110:
	db	" ",239,240,238,246,229,241,241,238,240,224
	;	s@+121:
	db	" : ",0
	;	s@+125:
	db	" ",204,195,246,0,0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
 ?debug  C FB041A405379737574696C7340446563696D616C536570617261746F7201000000
 ?debug  C FB040B405466726D41626F75744004000000
 ?debug  C FB040F4024787024395466726D41626F757404000000
 ?debug  C FB040D40466F726D734054466F726D4004000000
 ?debug  C FB0411404578746374726C73405450616E656C4004000000
 ?debug  C FB0411405374646374726C7340544C6162656C4004000000
 ?debug  C FB0412405374646374726C734054427574746F6E4004000000
 ?debug  C FB0411404578746374726C734054496D6167654004000000
 ?debug  C FB041240247870243131466F726D734054466F726D04000000
 ?debug  C FB045140436C61737365734054436F6D706F6E656E744055706461746552656769737472792471717270313753797374656D40544D657461436C6173736F78313753797374656D40416E7369537472696E67743302000000
 ?debug  C FB041440436C61737365734054436F6D706F6E656E744004000000
	publicdll	_frmAbout
 extrn   __Exception_list:dword
 extrn   @__InitExceptBlockLDTC:near
 extrn   __ClassCreate:near
 extrn   __AfterConstruction:near
@@Controls@TControl@GetText$qqrv equ @Controls@TControl@GetText$qqrv
 extrn   @Controls@TControl@GetText$qqrv:near
@@System@AnsiString@$bdtr$qqrv equ @System@AnsiString@$bdtr$qqrv
 extrn   @System@AnsiString@$bdtr$qqrv:near
@ShellExecuteA equ ShellExecuteA
 extrn   ShellExecuteA:near
@@Controls@TWinControl@GetHandle$qqrv equ @Controls@TWinControl@GetHandle$qqrv
 extrn   @Controls@TWinControl@GetHandle$qqrv:near
@@Dialogs@MessageDlg$qqrx17System@AnsiString19Dialogs@TMsgDlgType47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%i equ @Dialogs@MessageDlg$qqrx17System@AnsiString19Dialogs@TMsgDlgType47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%i
 extrn   @Dialogs@MessageDlg$qqrx17System@AnsiString19Dialogs@TMsgDlgType47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%i:near
@@System@AnsiString@$bctr$qqrpxc equ @System@AnsiString@$bctr$qqrpxc
 extrn   @System@AnsiString@$bctr$qqrpxc:near
 extrn   __Return_unwind:near
@@_CatchCleanup$qv equ @_CatchCleanup$qv
 extrn   @_CatchCleanup$qv:near
@_memset equ _memset
 extrn   _memset:near
@@Forms@TCustomForm@Close$qqrv equ @Forms@TCustomForm@Close$qqrv
 extrn   @Forms@TCustomForm@Close$qqrv:near
@GetPriorityClass equ GetPriorityClass
 extrn   GetPriorityClass:near
@GetCurrentProcess equ GetCurrentProcess
 extrn   GetCurrentProcess:near
@GetThreadPriority equ GetThreadPriority
 extrn   GetThreadPriority:near
@GetCurrentThread equ GetCurrentThread
 extrn   GetCurrentThread:near
@SetPriorityClass equ SetPriorityClass
 extrn   SetPriorityClass:near
@SetThreadPriority equ SetThreadPriority
 extrn   SetThreadPriority:near
@Sleep equ Sleep
 extrn   Sleep:near
@GlobalMemoryStatus equ GlobalMemoryStatus
 extrn   GlobalMemoryStatus:near
@@Controls@TControl@SetText$qqrx17System@AnsiString equ @Controls@TControl@SetText$qqrx17System@AnsiString
 extrn   @Controls@TControl@SetText$qqrx17System@AnsiString:near
@@System@$badd$qqrpxcrx17System@AnsiString equ @System@$badd$qqrpxcrx17System@AnsiString
 extrn   @System@$badd$qqrpxcrx17System@AnsiString:near
@@Sysutils@FormatFloat$qqrx17System@AnsiStringg equ @Sysutils@FormatFloat$qqrx17System@AnsiStringg
 extrn   @Sysutils@FormatFloat$qqrx17System@AnsiStringg:near
@@System@AnsiString@$badd$xqqrrx17System@AnsiString equ @System@AnsiString@$badd$xqqrrx17System@AnsiString
 extrn   @System@AnsiString@$badd$xqqrrx17System@AnsiString:near
@@Sysutils@FloatToStr$qqrg equ @Sysutils@FloatToStr$qqrg
 extrn   @Sysutils@FloatToStr$qqrg:near
 extrn   @Sysutils@DecimalSeparator:byte
 extrn   __ftol:near
@@Extctrls@TImage@SetTransparent$qqro equ @Extctrls@TImage@SetTransparent$qqro
 extrn   @Extctrls@TImage@SetTransparent$qqro:near
@@Graphics@TBitmap@SetTransparentColor$qqr15Graphics@TColor equ @Graphics@TBitmap@SetTransparentColor$qqr15Graphics@TColor
 extrn   @Graphics@TBitmap@SetTransparentColor$qqr15Graphics@TColor:near
@@Graphics@TPicture@GetBitmap$qqrv equ @Graphics@TPicture@GetBitmap$qqrv
 extrn   @Graphics@TPicture@GetBitmap$qqrv:near
@@Forms@TCustomForm@$bctr$qqrp18Classes@TComponent equ @Forms@TCustomForm@$bctr$qqrp18Classes@TComponent
 extrn   @Forms@TCustomForm@$bctr$qqrp18Classes@TComponent:near
@@System@AnsiString@$basg$qqrrx17System@AnsiString equ @System@AnsiString@$basg$qqrrx17System@AnsiString
 extrn   @System@AnsiString@$basg$qqrrx17System@AnsiString:near
@@Sysutils@IntToStr$qqri equ @Sysutils@IntToStr$qqri
 extrn   @Sysutils@IntToStr$qqri:near
 extrn   @Forms@TForm@:byte
@@Classes@TComponent@SafeCallException$qqrp14System@TObjectpv equ @Classes@TComponent@SafeCallException$qqrp14System@TObjectpv
 extrn   @Classes@TComponent@SafeCallException$qqrp14System@TObjectpv:near
@@Forms@TCustomForm@AfterConstruction$qqrv equ @Forms@TCustomForm@AfterConstruction$qqrv
 extrn   @Forms@TCustomForm@AfterConstruction$qqrv:near
@@Forms@TCustomForm@BeforeDestruction$qqrv equ @Forms@TCustomForm@BeforeDestruction$qqrv
 extrn   @Forms@TCustomForm@BeforeDestruction$qqrv:near
@@System@TObject@Dispatch$qqrpv equ @System@TObject@Dispatch$qqrpv
 extrn   @System@TObject@Dispatch$qqrpv:near
@@Forms@TCustomForm@DefaultHandler$qqrpv equ @Forms@TCustomForm@DefaultHandler$qqrpv
 extrn   @Forms@TCustomForm@DefaultHandler$qqrpv:near
@@System@TObject@NewInstance$qqrp17System@TMetaClass equ @System@TObject@NewInstance$qqrp17System@TMetaClass
 extrn   @System@TObject@NewInstance$qqrp17System@TMetaClass:near
@@System@TObject@FreeInstance$qqrv equ @System@TObject@FreeInstance$qqrv
 extrn   @System@TObject@FreeInstance$qqrv:near
@@Controls@TWinControl@AssignTo$qqrp19Classes@TPersistent equ @Controls@TWinControl@AssignTo$qqrp19Classes@TPersistent
 extrn   @Controls@TWinControl@AssignTo$qqrp19Classes@TPersistent:near
@@Forms@TCustomForm@DefineProperties$qqrp14Classes@TFiler equ @Forms@TCustomForm@DefineProperties$qqrp14Classes@TFiler
 extrn   @Forms@TCustomForm@DefineProperties$qqrp14Classes@TFiler:near
@@Classes@TPersistent@Assign$qqrp19Classes@TPersistent equ @Classes@TPersistent@Assign$qqrp19Classes@TPersistent
 extrn   @Classes@TPersistent@Assign$qqrp19Classes@TPersistent:near
@@Forms@TCustomForm@Loaded$qqrv equ @Forms@TCustomForm@Loaded$qqrv
 extrn   @Forms@TCustomForm@Loaded$qqrv:near
@@Forms@TCustomForm@Notification$qqrp18Classes@TComponent18Classes@TOperation equ @Forms@TCustomForm@Notification$qqrp18Classes@TComponent18Classes@TOperation
 extrn   @Forms@TCustomForm@Notification$qqrp18Classes@TComponent18Classes@TOperation:near
@@Forms@TCustomForm@ReadState$qqrp15Classes@TReader equ @Forms@TCustomForm@ReadState$qqrp15Classes@TReader
 extrn   @Forms@TCustomForm@ReadState$qqrp15Classes@TReader:near
@@Controls@TControl@SetName$qqrx17System@AnsiString equ @Controls@TControl@SetName$qqrx17System@AnsiString
 extrn   @Controls@TControl@SetName$qqrx17System@AnsiString:near
@@Forms@TCustomForm@ValidateRename$qqrp18Classes@TComponentx17System@AnsiStringt2 equ @Forms@TCustomForm@ValidateRename$qqrp18Classes@TComponentx17System@AnsiStringt2
 extrn   @Forms@TCustomForm@ValidateRename$qqrp18Classes@TComponentx17System@AnsiStringt2:near
@@Classes@TComponent@WriteState$qqrp15Classes@TWriter equ @Classes@TComponent@WriteState$qqrp15Classes@TWriter
 extrn   @Classes@TComponent@WriteState$qqrp15Classes@TWriter:near
@@Forms@TCustomForm@QueryInterface$qqsrx5_GUIDpv equ @Forms@TCustomForm@QueryInterface$qqsrx5_GUIDpv
 extrn   @Forms@TCustomForm@QueryInterface$qqsrx5_GUIDpv:near
@@Controls@TWinControl@CanResize$qqrrit1 equ @Controls@TWinControl@CanResize$qqrrit1
 extrn   @Controls@TWinControl@CanResize$qqrrit1:near
@@Controls@TWinControl@CanAutoSize$qqrrit1 equ @Controls@TWinControl@CanAutoSize$qqrrit1
 extrn   @Controls@TWinControl@CanAutoSize$qqrrit1:near
@@Controls@TWinControl@ConstrainedResize$qqrrit1t1t1 equ @Controls@TWinControl@ConstrainedResize$qqrrit1t1t1
 extrn   @Controls@TWinControl@ConstrainedResize$qqrrit1t1t1:near
@@Controls@TWinControl@GetClientOrigin$qqrv equ @Controls@TWinControl@GetClientOrigin$qqrv
 extrn   @Controls@TWinControl@GetClientOrigin$qqrv:near
@@Forms@TCustomForm@GetClientRect$qqrv equ @Forms@TCustomForm@GetClientRect$qqrv
 extrn   @Forms@TCustomForm@GetClientRect$qqrv:near
@@Controls@TWinControl@GetDeviceContext$qqrrpv equ @Controls@TWinControl@GetDeviceContext$qqrrpv
 extrn   @Controls@TWinControl@GetDeviceContext$qqrrpv:near
@@Controls@TControl@GetDragImages$qqrv equ @Controls@TControl@GetDragImages$qqrv
 extrn   @Controls@TControl@GetDragImages$qqrv:near
@@Controls@TControl@GetEnabled$qqrv equ @Controls@TControl@GetEnabled$qqrv
 extrn   @Controls@TControl@GetEnabled$qqrv:near
@@Forms@TCustomForm@GetFloating$qqrv equ @Forms@TCustomForm@GetFloating$qqrv
 extrn   @Forms@TCustomForm@GetFloating$qqrv:near
@@Controls@TControl@GetFloatingDockSiteClass$qqrv equ @Controls@TControl@GetFloatingDockSiteClass$qqrv
 extrn   @Controls@TControl@GetFloatingDockSiteClass$qqrv:near
@@Controls@TControl@SetDragMode$qqr18Controls@TDragMode equ @Controls@TControl@SetDragMode$qqr18Controls@TDragMode
 extrn   @Controls@TControl@SetDragMode$qqr18Controls@TDragMode:near
@@Controls@TControl@SetEnabled$qqro equ @Controls@TControl@SetEnabled$qqro
 extrn   @Controls@TControl@SetEnabled$qqro:near
@@Forms@TCustomForm@SetParent$qqrp20Controls@TWinControl equ @Forms@TCustomForm@SetParent$qqrp20Controls@TWinControl
 extrn   @Forms@TCustomForm@SetParent$qqrp20Controls@TWinControl:near
@@Forms@TCustomForm@SetParentBiDiMode$qqro equ @Forms@TCustomForm@SetParentBiDiMode$qqro
 extrn   @Forms@TCustomForm@SetParentBiDiMode$qqro:near
@@Controls@TControl@SetBiDiMode$qqr17Classes@TBiDiMode equ @Controls@TControl@SetBiDiMode$qqr17Classes@TBiDiMode
 extrn   @Controls@TControl@SetBiDiMode$qqr17Classes@TBiDiMode:near
@@Forms@TCustomForm@WndProc$qqrr17Messages@TMessage equ @Forms@TCustomForm@WndProc$qqrr17Messages@TMessage
 extrn   @Forms@TCustomForm@WndProc$qqrr17Messages@TMessage:near
@@Controls@TControl@InitiateAction$qqrv equ @Controls@TControl@InitiateAction$qqrv
 extrn   @Controls@TControl@InitiateAction$qqrv:near
@@Controls@TWinControl@Invalidate$qqrv equ @Controls@TWinControl@Invalidate$qqrv
 extrn   @Controls@TWinControl@Invalidate$qqrv:near
@@Controls@TWinControl@Repaint$qqrv equ @Controls@TWinControl@Repaint$qqrv
 extrn   @Controls@TWinControl@Repaint$qqrv:near
@@Controls@TWinControl@SetBounds$qqriiii equ @Controls@TWinControl@SetBounds$qqriiii
 extrn   @Controls@TWinControl@SetBounds$qqriiii:near
@@Controls@TWinControl@Update$qqrv equ @Controls@TWinControl@Update$qqrv
 extrn   @Controls@TWinControl@Update$qqrv:near
@@Forms@TScrollingWinControl@AdjustClientRect$qqrr13Windows@TRect equ @Forms@TScrollingWinControl@AdjustClientRect$qqrr13Windows@TRect
 extrn   @Forms@TScrollingWinControl@AdjustClientRect$qqrr13Windows@TRect:near
@@Forms@TCustomForm@AlignControls$qqrp17Controls@TControlr13Windows@TRect equ @Forms@TCustomForm@AlignControls$qqrp17Controls@TControlr13Windows@TRect
 extrn   @Forms@TCustomForm@AlignControls$qqrp17Controls@TControlr13Windows@TRect:near
@@Controls@TWinControl@CreateHandle$qqrv equ @Controls@TWinControl@CreateHandle$qqrv
 extrn   @Controls@TWinControl@CreateHandle$qqrv:near
@@Forms@TCustomForm@CreateParams$qqrr22Controls@TCreateParams equ @Forms@TCustomForm@CreateParams$qqrr22Controls@TCreateParams
 extrn   @Forms@TCustomForm@CreateParams$qqrr22Controls@TCreateParams:near
@@Forms@TCustomForm@CreateWindowHandle$qqrrx22Controls@TCreateParams equ @Forms@TCustomForm@CreateWindowHandle$qqrrx22Controls@TCreateParams
 extrn   @Forms@TCustomForm@CreateWindowHandle$qqrrx22Controls@TCreateParams:near
@@Forms@TCustomForm@CreateWnd$qqrv equ @Forms@TCustomForm@CreateWnd$qqrv
 extrn   @Forms@TCustomForm@CreateWnd$qqrv:near
@@Forms@TCustomForm@DestroyWindowHandle$qqrv equ @Forms@TCustomForm@DestroyWindowHandle$qqrv
 extrn   @Forms@TCustomForm@DestroyWindowHandle$qqrv:near
@@Controls@TWinControl@DestroyWnd$qqrv equ @Controls@TWinControl@DestroyWnd$qqrv
 extrn   @Controls@TWinControl@DestroyWnd$qqrv:near
@@Controls@TWinControl@GetControlExtents$qqrv equ @Controls@TWinControl@GetControlExtents$qqrv
 extrn   @Controls@TWinControl@GetControlExtents$qqrv:near
@@Forms@TCustomForm@PaintWindow$qqrpv equ @Forms@TCustomForm@PaintWindow$qqrpv
 extrn   @Forms@TCustomForm@PaintWindow$qqrpv:near
@@Controls@TWinControl@ShowControl$qqrp17Controls@TControl equ @Controls@TWinControl@ShowControl$qqrp17Controls@TControl
 extrn   @Controls@TWinControl@ShowControl$qqrp17Controls@TControl:near
@@Forms@TCustomForm@SetFocus$qqrv equ @Forms@TCustomForm@SetFocus$qqrv
 extrn   @Forms@TCustomForm@SetFocus$qqrv:near
@@Forms@TScrollingWinControl@AutoScrollEnabled$qqrv equ @Forms@TScrollingWinControl@AutoScrollEnabled$qqrv
 extrn   @Forms@TScrollingWinControl@AutoScrollEnabled$qqrv:near
@@Forms@TScrollingWinControl@AutoScrollInView$qqrp17Controls@TControl equ @Forms@TScrollingWinControl@AutoScrollInView$qqrp17Controls@TControl
 extrn   @Forms@TScrollingWinControl@AutoScrollInView$qqrp17Controls@TControl:near
@@Forms@TCustomForm@Resizing$qqr18Forms@TWindowState equ @Forms@TCustomForm@Resizing$qqr18Forms@TWindowState
 extrn   @Forms@TCustomForm@Resizing$qqr18Forms@TWindowState:near
@@Forms@TCustomForm@DoCreate$qqrv equ @Forms@TCustomForm@DoCreate$qqrv
 extrn   @Forms@TCustomForm@DoCreate$qqrv:near
@@Forms@TCustomForm@DoDestroy$qqrv equ @Forms@TCustomForm@DoDestroy$qqrv
 extrn   @Forms@TCustomForm@DoDestroy$qqrv:near
@@Forms@TCustomForm@UpdateActions$qqrv equ @Forms@TCustomForm@UpdateActions$qqrv
 extrn   @Forms@TCustomForm@UpdateActions$qqrv:near
@@Forms@TCustomForm@CloseQuery$qqrv equ @Forms@TCustomForm@CloseQuery$qqrv
 extrn   @Forms@TCustomForm@CloseQuery$qqrv:near
@@Forms@TCustomForm@SetFocusedControl$qqrp20Controls@TWinControl equ @Forms@TCustomForm@SetFocusedControl$qqrp20Controls@TWinControl
 extrn   @Forms@TCustomForm@SetFocusedControl$qqrp20Controls@TWinControl:near
@@Forms@TCustomForm@ShowModal$qqrv equ @Forms@TCustomForm@ShowModal$qqrv
 extrn   @Forms@TCustomForm@ShowModal$qqrv:near
@@Forms@TCustomForm@WantChildKey$qqrp17Controls@TControlr17Messages@TMessage equ @Forms@TCustomForm@WantChildKey$qqrp17Controls@TControlr17Messages@TMessage
 extrn   @Forms@TCustomForm@WantChildKey$qqrp17Controls@TControlr17Messages@TMessage:near
 extrn   @Extctrls@TPanel@:byte
 extrn   @Stdctrls@TLabel@:byte
 extrn   @Stdctrls@TButton@:byte
 extrn   @Extctrls@TImage@:byte
 extrn   @$xp$11Forms@TForm:byte
 extrn   __BeforeDestruction:near
 extrn   __ClassDestroy:near
@@System@AnsiString@$bctr$qqrrx17System@AnsiString equ @System@AnsiString@$bctr$qqrrx17System@AnsiString
 extrn   @System@AnsiString@$bctr$qqrrx17System@AnsiString:near
@@Classes@TComponent@UpdateRegistry$qqrp17System@TMetaClassox17System@AnsiStringt3 equ @Classes@TComponent@UpdateRegistry$qqrp17System@TMetaClassox17System@AnsiStringt3
 extrn   @Classes@TComponent@UpdateRegistry$qqrp17System@TMetaClassox17System@AnsiStringt3:near
 extrn   @Classes@TComponent@:byte
@@Forms@TCustomForm@$bctr$qqrp18Classes@TComponenti equ @Forms@TCustomForm@$bctr$qqrp18Classes@TComponenti
 extrn   @Forms@TCustomForm@$bctr$qqrp18Classes@TComponenti:near
@@Forms@TCustomForm@$bdtr$qqrv equ @Forms@TCustomForm@$bdtr$qqrv
 extrn   @Forms@TCustomForm@$bdtr$qqrv:near
@@Forms@TScrollingWinControl@$bdtr$qqrv equ @Forms@TScrollingWinControl@$bdtr$qqrv
 extrn   @Forms@TScrollingWinControl@$bdtr$qqrv:near
 extrn   @$bdele$qpv:near
@@Controls@TWinControl@$bdtr$qqrv equ @Controls@TWinControl@$bdtr$qqrv
 extrn   @Controls@TWinControl@$bdtr$qqrv:near
@@Controls@TControl@$bdtr$qqrv equ @Controls@TControl@$bdtr$qqrv
 extrn   @Controls@TControl@$bdtr$qqrv:near
@@Classes@TComponent@$bdtr$qqrv equ @Classes@TComponent@$bdtr$qqrv
 extrn   @Classes@TComponent@$bdtr$qqrv:near
@@Classes@TPersistent@$bdtr$qqrv equ @Classes@TPersistent@$bdtr$qqrv
 extrn   @Classes@TPersistent@$bdtr$qqrv:near
@@System@TObject@$bdtr$qqrv equ @System@TObject@$bdtr$qqrv
 extrn   @System@TObject@$bdtr$qqrv:near
	extrn	__turboFloat:word
 ?debug  C FB09556E69745F41626F75742E64666D00
 ?debug  C FB0A556E69745F41626F757400
 ?debug  C 9F76636C6535302E6C6962
$$BSYMS	segment byte public use32 'DEBSYM'
	dw	22
	dw	514
	df	_frmAbout
	dw	0
	dw	4097
	dw	0
	dw	129
	dw	0
	dw	0
	dw	0
	dw	?patch120
	dw	37
	dw	130
	dw	0
	dw	0
	dw	0
	dw	0
?patch120	equ	12
	dw	?patch121
	dw	37
	dw	131
	dw	0
	dw	0
	dw	0
	dw	0
?patch121	equ	12
	dw	?patch122
	dw	3
	dw	4353
	dw	0
	dw	132
	dw	0
	dw	0
	dw	0
	dw	2
?patch122	equ	16
	dw	?patch123
	dw	3
	dw	4353
	dw	0
	dw	133
	dw	0
	dw	0
	dw	0
	dw	3
?patch123	equ	16
	dw	?patch124
	dw	3
	dw	4353
	dw	0
	dw	134
	dw	0
	dw	0
	dw	0
	dw	4
?patch124	equ	16
	dw	?patch125
	dw	3
	dw	4353
	dw	0
	dw	135
	dw	0
	dw	0
	dw	0
	dw	5
?patch125	equ	16
	dw	?patch126
	dw	3
	dw	4353
	dw	0
	dw	136
	dw	0
	dw	0
	dw	0
	dw	6
?patch126	equ	16
	dw	?patch127
	dw	3
	dw	4353
	dw	0
	dw	137
	dw	0
	dw	0
	dw	0
	dw	7
?patch127	equ	16
	dw	?patch128
	dw	3
	dw	4353
	dw	0
	dw	138
	dw	0
	dw	0
	dw	0
	dw	8
?patch128	equ	16
	dw	?patch129
	dw	3
	dw	4353
	dw	0
	dw	139
	dw	0
	dw	0
	dw	0
	dw	9
?patch129	equ	16
	dw	?patch130
	dw	3
	dw	4353
	dw	0
	dw	140
	dw	0
	dw	0
	dw	0
	dw	11
?patch130	equ	16
	dw	?patch131
	dw	3
	dw	4353
	dw	0
	dw	141
	dw	0
	dw	0
	dw	0
	dw	12
?patch131	equ	16
	dw	?patch132
	dw	3
	dw	4353
	dw	0
	dw	142
	dw	0
	dw	0
	dw	0
	dw	13
?patch132	equ	16
	dw	?patch133
	dw	3
	dw	4353
	dw	0
	dw	143
	dw	0
	dw	0
	dw	0
	dw	17
?patch133	equ	16
	dw	?patch134
	dw	3
	dw	4354
	dw	0
	dw	144
	dw	0
	dw	0
	dw	0
	dw	16384
?patch134	equ	16
	dw	?patch135
	dw	3
	dw	4353
	dw	0
	dw	145
	dw	0
	dw	0
	dw	0
	dw	0
?patch135	equ	16
	dw	?patch136
	dw	3
	dw	4353
	dw	0
	dw	146
	dw	0
	dw	0
	dw	0
	dw	1
?patch136	equ	16
	dw	?patch137
	dw	3
	dw	4353
	dw	0
	dw	147
	dw	0
	dw	0
	dw	0
	dw	2
?patch137	equ	16
	dw	?patch138
	dw	3
	dw	4353
	dw	0
	dw	148
	dw	0
	dw	0
	dw	0
	dw	3
?patch138	equ	16
	dw	?patch139
	dw	3
	dw	4353
	dw	0
	dw	149
	dw	0
	dw	0
	dw	0
	dw	4
?patch139	equ	16
	dw	?patch140
	dw	3
	dw	4353
	dw	0
	dw	150
	dw	0
	dw	0
	dw	0
	dw	5
?patch140	equ	16
	dw	?patch141
	dw	3
	dw	4353
	dw	0
	dw	151
	dw	0
	dw	0
	dw	0
	dw	6
?patch141	equ	16
	dw	?patch142
	dw	3
	dw	4353
	dw	0
	dw	152
	dw	0
	dw	0
	dw	0
	dw	7
?patch142	equ	16
	dw	?patch143
	dw	3
	dw	4353
	dw	0
	dw	153
	dw	0
	dw	0
	dw	0
	dw	8
?patch143	equ	16
	dw	?patch144
	dw	3
	dw	4353
	dw	0
	dw	154
	dw	0
	dw	0
	dw	0
	dw	9
?patch144	equ	16
	dw	?patch145
	dw	3
	dw	4353
	dw	0
	dw	155
	dw	0
	dw	0
	dw	0
	dw	10
?patch145	equ	16
	dw	?patch146
	dw	3
	dw	4353
	dw	0
	dw	156
	dw	0
	dw	0
	dw	0
	dw	11
?patch146	equ	16
	dw	?patch147
	dw	3
	dw	4353
	dw	0
	dw	157
	dw	0
	dw	0
	dw	0
	dw	12
?patch147	equ	16
	dw	?patch148
	dw	3
	dw	4353
	dw	0
	dw	158
	dw	0
	dw	0
	dw	0
	dw	13
?patch148	equ	16
	dw	?patch149
	dw	37
	dw	159
	dw	0
	dw	0
	dw	0
	dw	0
?patch149	equ	12
	dw	?patch150
	dw	37
	dw	160
	dw	0
	dw	0
	dw	0
	dw	0
?patch150	equ	12
	dw	?patch151
	dw	37
	dw	161
	dw	0
	dw	0
	dw	0
	dw	0
?patch151	equ	12
	dw	?patch152
	dw	37
	dw	162
	dw	0
	dw	0
	dw	0
	dw	0
?patch152	equ	12
	dw	?patch153
	dw	37
	dw	163
	dw	0
	dw	0
	dw	0
	dw	0
?patch153	equ	12
	dw	?patch154
	dw	37
	dw	164
	dw	0
	dw	0
	dw	0
	dw	0
?patch154	equ	12
	dw	?patch155
	dw	37
	dw	165
	dw	0
	dw	0
	dw	0
	dw	0
?patch155	equ	12
	dw	?patch156
	dw	3
	dw	4355
	dw	0
	dw	166
	dw	0
	dw	0
	dw	0
	dw	32772
	dw	65535
	dw	255
?patch156	equ	20
	dw	?patch157
	dw	37
	dw	167
	dw	0
	dw	0
	dw	0
	dw	0
?patch157	equ	12
	dw	?patch158
	dw	37
	dw	168
	dw	0
	dw	0
	dw	0
	dw	0
?patch158	equ	12
	dw	?patch159
	dw	37
	dw	169
	dw	0
	dw	0
	dw	0
	dw	0
?patch159	equ	12
	dw	?patch160
	dw	37
	dw	170
	dw	0
	dw	0
	dw	0
	dw	0
?patch160	equ	12
	dw	?patch161
	dw	37
	dw	171
	dw	0
	dw	0
	dw	0
	dw	0
?patch161	equ	12
	dw	?patch162
	dw	37
	dw	172
	dw	0
	dw	0
	dw	0
	dw	0
?patch162	equ	12
	dw	?patch163
	dw	37
	dw	173
	dw	0
	dw	0
	dw	0
	dw	0
?patch163	equ	12
	dw	?patch164
	dw	37
	dw	174
	dw	0
	dw	0
	dw	0
	dw	0
?patch164	equ	12
	dw	?patch165
	dw	37
	dw	175
	dw	0
	dw	0
	dw	0
	dw	0
?patch165	equ	12
	dw	?patch166
	dw	37
	dw	176
	dw	0
	dw	0
	dw	0
	dw	0
?patch166	equ	12
	dw	?patch167
	dw	37
	dw	177
	dw	0
	dw	0
	dw	0
	dw	0
?patch167	equ	12
	dw	?patch168
	dw	37
	dw	178
	dw	0
	dw	0
	dw	0
	dw	0
?patch168	equ	12
	dw	?patch169
	dw	37
	dw	179
	dw	0
	dw	0
	dw	0
	dw	0
?patch169	equ	12
	dw	?patch170
	dw	37
	dw	180
	dw	0
	dw	0
	dw	0
	dw	0
?patch170	equ	12
	dw	?patch171
	dw	37
	dw	181
	dw	0
	dw	0
	dw	0
	dw	0
?patch171	equ	12
	dw	?patch172
	dw	37
	dw	182
	dw	0
	dw	0
	dw	0
	dw	0
?patch172	equ	12
	dw	?patch173
	dw	37
	dw	183
	dw	0
	dw	0
	dw	0
	dw	0
?patch173	equ	12
	dw	?patch174
	dw	37
	dw	184
	dw	0
	dw	0
	dw	0
	dw	0
?patch174	equ	12
	dw	?patch175
	dw	37
	dw	185
	dw	0
	dw	0
	dw	0
	dw	0
?patch175	equ	12
	dw	?patch176
	dw	37
	dw	186
	dw	0
	dw	0
	dw	0
	dw	0
?patch176	equ	12
	dw	?patch177
	dw	37
	dw	187
	dw	0
	dw	0
	dw	0
	dw	0
?patch177	equ	12
	dw	?patch178
	dw	37
	dw	188
	dw	0
	dw	0
	dw	0
	dw	0
?patch178	equ	12
	dw	?patch179
	dw	37
	dw	189
	dw	0
	dw	0
	dw	0
	dw	0
?patch179	equ	12
	dw	?patch180
	dw	37
	dw	190
	dw	0
	dw	0
	dw	0
	dw	0
?patch180	equ	12
	dw	?patch181
	dw	37
	dw	191
	dw	0
	dw	0
	dw	0
	dw	0
?patch181	equ	12
	dw	?patch182
	dw	37
	dw	192
	dw	0
	dw	0
	dw	0
	dw	0
?patch182	equ	12
	dw	?patch183
	dw	37
	dw	193
	dw	0
	dw	0
	dw	0
	dw	0
?patch183	equ	12
	dw	?patch184
	dw	37
	dw	194
	dw	0
	dw	0
	dw	0
	dw	0
?patch184	equ	12
	dw	?patch185
	dw	37
	dw	195
	dw	0
	dw	0
	dw	0
	dw	0
?patch185	equ	12
	dw	?patch186
	dw	37
	dw	196
	dw	0
	dw	0
	dw	0
	dw	0
?patch186	equ	12
	dw	16
	dw	4
	dw	4098
	dw	0
	dw	1
	dw	197
	dw	0
	dw	0
	dw	0
	dw	16
	dw	4
	dw	4138
	dw	0
	dw	1
	dw	198
	dw	0
	dw	0
	dw	0
	dw	?patch187
	dw	38
	dw	278
	dw	199
	dw	0
	dw	200
	dw	0
	dw	201
	dw	0
	dw	202
	dw	0
	dw	203
	dw	0
	dw	204
	dw	0
	dw	205
	dw	0
	dw	206
	dw	0
	dw	207
	dw	0
	dw	208
	dw	0
	dw	209
	dw	0
	dw	210
	dw	0
	dw	211
	dw	0
	dw	212
	dw	0
	dw	213
	dw	0
	dw	214
	dw	0
	dw	215
	dw	0
	dw	216
	dw	0
	dw	217
	dw	0
	dw	218
	dw	0
	dw	219
	dw	0
	dw	220
	dw	0
	dw	221
	dw	0
	dw	222
	dw	0
	dw	223
	dw	0
	dw	224
	dw	0
	dw	225
	dw	0
	dw	226
	dw	0
	dw	227
	dw	0
	dw	228
	dw	0
	dw	229
	dw	0
	dw	230
	dw	0
	dw	231
	dw	0
	dw	232
	dw	0
	dw	233
	dw	0
	dw	234
	dw	0
	dw	235
	dw	0
	dw	236
	dw	0
	dw	237
	dw	0
	dw	238
	dw	0
	dw	239
	dw	0
	dw	240
	dw	0
	dw	241
	dw	0
	dw	242
	dw	0
	dw	243
	dw	0
	dw	244
	dw	0
	dw	245
	dw	0
	dw	246
	dw	0
	dw	247
	dw	0
	dw	248
	dw	0
	dw	249
	dw	0
	dw	250
	dw	0
	dw	251
	dw	0
	dw	252
	dw	0
	dw	253
	dw	0
	dw	254
	dw	0
	dw	255
	dw	0
	dw	256
	dw	0
	dw	257
	dw	0
	dw	258
	dw	0
	dw	259
	dw	0
	dw	260
	dw	0
	dw	261
	dw	0
	dw	262
	dw	0
	dw	263
	dw	0
	dw	264
	dw	0
	dw	265
	dw	0
	dw	266
	dw	0
	dw	267
	dw	0
	dw	268
	dw	0
	dw	269
	dw	0
	dw	270
	dw	0
	dw	271
	dw	0
	dw	272
	dw	0
	dw	273
	dw	0
	dw	274
	dw	0
	dw	275
	dw	0
	dw	276
	dw	0
	dw	277
	dw	0
	dw	278
	dw	0
	dw	279
	dw	0
	dw	280
	dw	0
	dw	281
	dw	0
	dw	282
	dw	0
	dw	283
	dw	0
	dw	284
	dw	0
	dw	285
	dw	0
	dw	286
	dw	0
	dw	287
	dw	0
	dw	288
	dw	0
	dw	289
	dw	0
	dw	290
	dw	0
	dw	291
	dw	0
	dw	292
	dw	0
	dw	293
	dw	0
	dw	294
	dw	0
	dw	295
	dw	0
	dw	296
	dw	0
	dw	297
	dw	0
	dw	298
	dw	0
	dw	299
	dw	0
	dw	300
	dw	0
	dw	301
	dw	0
	dw	302
	dw	0
	dw	303
	dw	0
	dw	304
	dw	0
	dw	305
	dw	0
	dw	306
	dw	0
	dw	307
	dw	0
	dw	308
	dw	0
	dw	309
	dw	0
	dw	310
	dw	0
	dw	311
	dw	0
	dw	312
	dw	0
	dw	313
	dw	0
	dw	314
	dw	0
	dw	315
	dw	0
	dw	316
	dw	0
	dw	317
	dw	0
	dw	318
	dw	0
	dw	319
	dw	0
	dw	320
	dw	0
	dw	321
	dw	0
	dw	322
	dw	0
	dw	323
	dw	0
	dw	324
	dw	0
	dw	325
	dw	0
	dw	326
	dw	0
	dw	327
	dw	0
	dw	328
	dw	0
	dw	329
	dw	0
	dw	330
	dw	0
	dw	331
	dw	0
	dw	332
	dw	0
	dw	333
	dw	0
	dw	334
	dw	0
	dw	335
	dw	0
	dw	336
	dw	0
	dw	337
	dw	0
	dw	338
	dw	0
	dw	339
	dw	0
	dw	340
	dw	0
	dw	341
	dw	0
	dw	342
	dw	0
	dw	343
	dw	0
	dw	344
	dw	0
	dw	345
	dw	0
	dw	346
	dw	0
	dw	347
	dw	0
	dw	348
	dw	0
	dw	349
	dw	0
	dw	350
	dw	0
	dw	351
	dw	0
	dw	352
	dw	0
	dw	353
	dw	0
	dw	354
	dw	0
	dw	355
	dw	0
	dw	356
	dw	0
	dw	357
	dw	0
	dw	358
	dw	0
	dw	359
	dw	0
	dw	360
	dw	0
	dw	361
	dw	0
	dw	362
	dw	0
	dw	363
	dw	0
	dw	364
	dw	0
	dw	365
	dw	0
	dw	366
	dw	0
	dw	367
	dw	0
	dw	368
	dw	0
	dw	369
	dw	0
	dw	370
	dw	0
	dw	371
	dw	0
	dw	372
	dw	0
	dw	373
	dw	0
	dw	374
	dw	0
	dw	375
	dw	0
	dw	376
	dw	0
	dw	377
	dw	0
	dw	378
	dw	0
	dw	379
	dw	0
	dw	380
	dw	0
	dw	381
	dw	0
	dw	382
	dw	0
	dw	383
	dw	0
	dw	384
	dw	0
	dw	385
	dw	0
	dw	386
	dw	0
	dw	387
	dw	0
	dw	388
	dw	0
	dw	389
	dw	0
	dw	390
	dw	0
	dw	391
	dw	0
	dw	392
	dw	0
	dw	393
	dw	0
	dw	394
	dw	0
	dw	395
	dw	0
	dw	396
	dw	0
	dw	397
	dw	0
	dw	398
	dw	0
	dw	399
	dw	0
	dw	400
	dw	0
	dw	401
	dw	0
	dw	402
	dw	0
	dw	403
	dw	0
	dw	404
	dw	0
	dw	405
	dw	0
	dw	406
	dw	0
	dw	407
	dw	0
	dw	408
	dw	0
	dw	409
	dw	0
	dw	410
	dw	0
	dw	411
	dw	0
	dw	412
	dw	0
	dw	413
	dw	0
	dw	414
	dw	0
	dw	415
	dw	0
	dw	416
	dw	0
	dw	417
	dw	0
	dw	418
	dw	0
	dw	419
	dw	0
	dw	420
	dw	0
	dw	421
	dw	0
	dw	422
	dw	0
	dw	423
	dw	0
	dw	424
	dw	0
	dw	425
	dw	0
	dw	426
	dw	0
	dw	427
	dw	0
	dw	428
	dw	0
	dw	429
	dw	0
	dw	430
	dw	0
	dw	431
	dw	0
	dw	432
	dw	0
	dw	433
	dw	0
	dw	434
	dw	0
	dw	435
	dw	0
	dw	436
	dw	0
	dw	437
	dw	0
	dw	438
	dw	0
	dw	439
	dw	0
	dw	440
	dw	0
	dw	441
	dw	0
	dw	442
	dw	0
	dw	443
	dw	0
	dw	444
	dw	0
	dw	445
	dw	0
	dw	446
	dw	0
	dw	447
	dw	0
	dw	448
	dw	0
	dw	449
	dw	0
	dw	450
	dw	0
	dw	451
	dw	0
	dw	452
	dw	0
	dw	453
	dw	0
	dw	454
	dw	0
	dw	455
	dw	0
	dw	456
	dw	0
	dw	457
	dw	0
	dw	458
	dw	0
	dw	459
	dw	0
	dw	460
	dw	0
	dw	461
	dw	0
	dw	462
	dw	0
	dw	463
	dw	0
	dw	464
	dw	0
	dw	465
	dw	0
	dw	466
	dw	0
	dw	467
	dw	0
	dw	468
	dw	0
	dw	469
	dw	0
	dw	470
	dw	0
	dw	471
	dw	0
	dw	472
	dw	0
	dw	473
	dw	0
	dw	474
	dw	0
	dw	475
	dw	0
	dw	476
	dw	0
?patch187	equ	1116
	dw	?patch188
	dw	1
	db	3
	db	1
	db	0
	db	24
	db	9
	db	66
	db	67
	db	67
	db	51
	db	50
	db	32
	db	53
	db	46
	db	53
?patch188	equ	16
$$BSYMS	ends
$$BTYPES	segment byte public use32 'DEBTYP'
	db        2,0,0,0,26,0,9,0,1,16,0,0,2,16,0,0
	db        6,16,0,0,4,0,1,0,36,16,0,0,0,0,0,0
	db        8,0,2,0,10,0,2,16,0,0,28,0,4,0,20,0
	db        35,16,0,0,34,1,0,0,0,0,0,0,0,0,3,16
	db        0,0,1,0,0,0,248,2,5,0,10,0,2,0,85,8
	db        0,2,0,10,0,3,16,0,0,26,0,9,0,3,0,0
	db        0,2,16,0,0,6,16,0,0,4,0,1,0,7,16,0
	db        0,0,0,0,0,8,0,2,0,10,4,2,16,0,0,8
	db        0,1,2,1,0,250,255,255,255,26,0,9,0,3,0,0
	db        0,2,16,0,0,6,16,0,0,4,0,1,0,9,16,0
	db        0,0,0,0,0,8,0,1,2,1,0,250,255,255,255,26
	db        0,9,0,3,0,0,0,2,16,0,0,6,16,0,0,4
	db        0,1,0,11,16,0,0,0,0,0,0,8,0,1,2,1
	db        0,250,255,255,255,26,0,9,0,3,0,0,0,2,16,0
	db        0,6,16,0,0,4,0,1,0,13,16,0,0,0,0,0
	db        0,8,0,1,2,1,0,250,255,255,255,26,0,9,0,65
	db        0,0,0,2,16,0,0,6,16,0,0,4,0,0,0,15
	db        16,0,0,0,0,0,0,4,0,1,2,0,0,26,0,9
	db        0,1,16,0,0,2,16,0,0,6,16,0,0,4,0,1
	db        0,17,16,0,0,0,0,0,0,8,0,1,2,1,0,249
	db        255,255,255,26,0,9,0,1,16,0,0,2,16,0,0,6
	db        16,0,0,0,0,1,0,21,16,0,0,0,0,0,0,8
	db        0,2,0,42,0,20,16,0,0,8,0,1,0,1,0,2
	db        16,0,0,8,0,1,2,1,0,19,16,0,0,26,0,9
	db        0,23,16,0,0,2,16,0,0,6,16,0,0,0,0,1
	db        0,24,16,0,0,0,0,0,0,8,0,2,0,42,0,2
	db        16,0,0,8,0,1,2,1,0,23,16,0,0,26,0,9
	db        0,3,0,0,0,2,16,0,0,6,16,0,0,4,0,0
	db        0,26,16,0,0,0,0,0,0,4,0,1,2,0,0,12
	db        0,7,2,3,0,5,16,0,0,0,0,0,0,12,0,7
	db        2,3,0,8,16,0,0,0,0,0,0,12,0,7,2,3
	db        0,10,16,0,0,0,0,0,0,12,0,7,2,3,0,12
	db        16,0,0,0,0,0,0,12,0,7,2,1,0,14,16,0
	db        0,0,0,0,0,26,0,7,2,19,4,16,16,0,0,0
	db        0,0,0,44,0,0,0,35,20,18,16,0,0,0,0,0
	db        0,12,0,7,2,35,17,22,16,0,0,0,0,0,0,16
	db        0,7,2,51,24,25,16,0,0,0,0,0,0,252,255,255
	db        255,62,1,4,2,10,4,4,16,0,0,0,0,0,4,255
	db        255,255,255,3,0,0,0,242,241,6,4,254,255,255,255,3
	db        0,2,0,0,0,0,0,0,0,208,2,242,241,6,4,253
	db        255,255,255,3,0,3,0,0,0,0,0,0,0,212,2,242
	db        241,6,4,253,255,255,255,3,0,4,0,0,0,0,0,0
	db        0,216,2,242,241,6,4,253,255,255,255,3,0,5,0,0
	db        0,0,0,0,0,220,2,242,241,6,4,253,255,255,255,3
	db        0,6,0,0,0,0,0,0,0,224,2,242,241,6,4,253
	db        255,255,255,3,0,7,0,0,0,0,0,0,0,228,2,242
	db        241,6,4,253,255,255,255,3,0,8,0,0,0,0,0,0
	db        0,232,2,242,241,6,4,253,255,255,255,3,0,9,0,0
	db        0,0,0,0,0,236,2,242,241,6,4,252,255,255,255,3
	db        0,10,0,0,0,0,0,0,0,240,2,242,241,6,4,251
	db        255,255,255,3,0,11,0,0,0,0,0,0,0,244,2,242
	db        241,8,4,1,0,27,16,0,0,12,0,0,0,8,4,1
	db        0,28,16,0,0,13,0,0,0,8,4,1,0,29,16,0
	db        0,14,0,0,0,8,4,1,0,30,16,0,0,15,0,0
	db        0,8,4,1,0,31,16,0,0,16,0,0,0,8,4,2
	db        0,32,16,0,0,17,0,0,0,8,4,1,0,33,16,0
	db        0,18,0,0,0,8,4,1,0,34,16,0,0,19,0,0
	db        0,8,0,1,2,1,0,249,255,255,255,26,0,9,0,3
	db        0,0,0,2,16,0,0,6,16,0,0,4,0,1,0,38
	db        16,0,0,0,0,0,0,8,0,1,2,1,0,250,255,255
	db        255,26,0,9,0,40,16,0,0,41,16,0,0,46,16,0
	db        0,4,0,0,0,96,16,0,0,0,0,0,0,8,0,2
	db        0,10,0,41,16,0,0,28,0,4,0,16,0,95,16,0
	db        0,34,0,0,0,0,0,0,0,0,0,0,0,0,0,27
	db        0,0,0,2,0,28,0,4,0,1,0,44,16,0,0,0
	db        0,0,0,0,0,0,0,0,0,0,0,0,0,28,0,0
	db        0,2,0,18,0,3,0,32,0,0,0,17,0,0,0,0
	db        0,0,0,2,0,2,0,20,0,4,2,6,4,43,16,0
	db        0,2,0,29,0,0,0,0,0,0,0,0,0,26,0,9
	db        0,40,16,0,0,41,16,0,0,46,16,0,0,4,0,0
	db        0,47,16,0,0,0,0,0,0,8,0,2,0,10,4,41
	db        16,0,0,4,0,1,2,0,0,26,0,9,0,40,16,0
	db        0,41,16,0,0,46,16,0,0,4,0,1,0,51,16,0
	db        0,0,0,0,0,8,0,2,0,42,0,50,16,0,0,8
	db        0,1,0,1,0,41,16,0,0,8,0,1,2,1,0,49
	db        16,0,0,26,0,9,0,53,16,0,0,41,16,0,0,46
	db        16,0,0,4,0,1,0,54,16,0,0,0,0,0,0,8
	db        0,2,0,42,0,41,16,0,0,8,0,1,2,1,0,49
	db        16,0,0,26,0,9,0,53,16,0,0,41,16,0,0,46
	db        16,0,0,4,0,1,0,56,16,0,0,0,0,0,0,8
	db        0,1,2,1,0,49,16,0,0,26,0,9,0,53,16,0
	db        0,41,16,0,0,46,16,0,0,4,0,1,0,58,16,0
	db        0,0,0,0,0,8,0,1,2,1,0,49,16,0,0,26
	db        0,9,0,53,16,0,0,41,16,0,0,46,16,0,0,4
	db        0,1,0,60,16,0,0,0,0,0,0,8,0,1,2,1
	db        0,49,16,0,0,26,0,9,0,41,16,0,0,41,16,0
	db        0,62,16,0,0,4,0,1,0,63,16,0,0,0,0,0
	db        0,8,0,2,0,10,4,50,16,0,0,8,0,1,2,1
	db        0,49,16,0,0,26,0,9,0,41,16,0,0,41,16,0
	db        0,62,16,0,0,4,0,1,0,65,16,0,0,0,0,0
	db        0,8,0,1,2,1,0,49,16,0,0,26,0,9,0,41
	db        16,0,0,41,16,0,0,62,16,0,0,4,0,1,0,67
	db        16,0,0,0,0,0,0,8,0,1,2,1,0,49,16,0
	db        0,26,0,9,0,53,16,0,0,41,16,0,0,46,16,0
	db        0,4,0,1,0,70,16,0,0,0,0,0,0,8,0,1
	db        0,1,0,248,255,255,255,8,0,1,2,1,0,69,16,0
	db        0,26,0,9,0,53,16,0,0,41,16,0,0,46,16,0
	db        0,4,0,1,0,72,16,0,0,0,0,0,0,8,0,1
	db        2,1,0,69,16,0,0,26,0,9,0,48,0,0,0,41
	db        16,0,0,62,16,0,0,4,0,1,0,74,16,0,0,0
	db        0,0,0,8,0,1,2,1,0,69,16,0,0,26,0,9
	db        0,53,16,0,0,41,16,0,0,46,16,0,0,4,0,0
	db        0,76,16,0,0,0,0,0,0,4,0,1,2,0,0,26
	db        0,9,0,48,0,0,0,41,16,0,0,62,16,0,0,4
	db        0,1,0,78,16,0,0,0,0,0,0,8,0,1,2,1
	db        0,49,16,0,0,26,0,9,0,48,0,0,0,41,16,0
	db        0,62,16,0,0,4,0,1,0,80,16,0,0,0,0,0
	db        0,8,0,1,2,1,0,49,16,0,0,22,0,7,2,3
	db        4,45,16,0,0,0,0,0,0,3,4,48,16,0,0,0
	db        0,0,0,12,0,7,2,3,1,52,16,0,0,0,0,0
	db        0,12,0,7,2,3,1,55,16,0,0,0,0,0,0,12
	db        0,7,2,3,1,57,16,0,0,0,0,0,0,12,0,7
	db        2,3,1,59,16,0,0,0,0,0,0,12,0,7,2,3
	db        1,61,16,0,0,0,0,0,0,12,0,7,2,3,1,64
	db        16,0,0,0,0,0,0,12,0,7,2,3,1,66,16,0
	db        0,0,0,0,0,12,0,7,2,3,1,68,16,0,0,0
	db        0,0,0,12,0,7,2,3,1,71,16,0,0,0,0,0
	db        0,12,0,7,2,3,0,73,16,0,0,0,0,0,0,12
	db        0,7,2,3,0,75,16,0,0,0,0,0,0,12,0,7
	db        2,3,1,77,16,0,0,0,0,0,0,12,0,7,2,3
	db        1,79,16,0,0,0,0,0,0,198,0,4,2,0,4,42
	db        16,0,0,3,0,0,0,242,241,9,4,248,255,255,255,30
	db        0,0,0,0,0,0,0,242,241,8,4,2,0,81,16,0
	db        0,31,0,0,0,8,4,1,0,82,16,0,0,32,0,0
	db        0,8,4,1,0,83,16,0,0,33,0,0,0,8,4,1
	db        0,84,16,0,0,34,0,0,0,8,4,1,0,85,16,0
	db        0,35,0,0,0,8,4,1,0,86,16,0,0,36,0,0
	db        0,8,4,1,0,87,16,0,0,37,0,0,0,8,4,1
	db        0,88,16,0,0,38,0,0,0,8,4,1,0,89,16,0
	db        0,39,0,0,0,8,4,1,0,90,16,0,0,40,0,0
	db        0,8,4,1,0,91,16,0,0,41,0,0,0,8,4,1
	db        0,92,16,0,0,42,0,0,0,8,4,1,0,93,16,0
	db        0,43,0,0,0,8,4,1,0,94,16,0,0,44,0,0
	db        0,4,0,1,2,0,0,26,0,9,0,53,16,0,0,41
	db        16,0,0,46,16,0,0,4,0,1,0,98,16,0,0,0
	db        0,0,0,8,0,1,2,1,0,69,16,0,0,26,0,9
	db        0,3,0,0,0,2,16,0,0,6,16,0,0,4,0,1
	db        0,100,16,0,0,0,0,0,0,8,0,1,2,1,0,250
	db        255,255,255,26,0,9,0,65,0,0,0,2,16,0,0,6
	db        16,0,0,4,0,0,0,102,16,0,0,0,0,0,0,4
	db        0,1,2,0,0,26,0,9,0,3,0,0,0,2,16,0
	db        0,6,16,0,0,4,0,1,0,104,16,0,0,0,0,0
	db        0,8,0,1,2,1,0,250,255,255,255,26,0,9,0,3
	db        0,0,0,2,16,0,0,6,16,0,0,4,0,1,0,106
	db        16,0,0,0,0,0,0,8,0,1,2,1,0,250,255,255
	db        255,26,0,9,0,246,255,255,255,255,255,255,255,108,16,0
	db        0,4,0,1,0,109,16,0,0,0,0,0,0,8,0,2
	db        0,10,4,255,255,255,255,8,0,1,2,1,0,249,255,255
	db        255,26,0,9,0,245,255,255,255,244,255,255,255,111,16,0
	db        0,4,0,0,0,112,16,0,0,0,0,0,0,8,0,2
	db        0,10,4,244,255,255,255,4,0,1,2,0,0,26,0,9
	db        0,112,4,0,0,244,255,255,255,114,16,0,0,4,0,0
	db        0,116,16,0,0,0,0,0,0,8,0,2,0,10,4,115
	db        16,0,0,8,0,1,0,1,0,244,255,255,255,4,0,1
	db        2,0,0,14,0,8,0,244,255,255,255,4,0,1,0,118
	db        16,0,0,8,0,1,2,1,0,34,0,0,0,26,0,9
	db        0,3,0,0,0,2,16,0,0,6,16,0,0,4,0,0
	db        0,120,16,0,0,0,0,0,0,4,0,1,2,0,0,26
	db        0,9,0,3,0,0,0,243,255,255,255,122,16,0,0,4
	db        0,3,0,123,16,0,0,0,0,0,0,8,0,2,0,10
	db        4,243,255,255,255,16,0,1,2,3,0,48,0,0,0,115
	db        16,0,0,115,16,0,0,26,0,9,0,246,255,255,255,255
	db        255,255,255,108,16,0,0,4,0,2,0,125,16,0,0,0
	db        0,0,0,12,0,1,2,2,0,249,255,255,255,116,0,0
	db        0,26,0,9,0,3,0,0,0,255,255,255,255,108,16,0
	db        0,4,0,0,0,127,16,0,0,0,0,0,0,4,0,1
	db        2,0,0,26,0,9,0,3,0,0,0,129,16,0,0,132
	db        16,0,0,4,0,0,0,170,16,0,0,0,0,0,0,28
	db        0,4,0,10,0,169,16,0,0,34,1,0,0,0,0,0
	db        0,0,0,0,0,0,0,90,0,0,0,4,0,26,0,9
	db        0,131,16,0,0,129,16,0,0,132,16,0,0,4,0,0
	db        0,133,16,0,0,0,0,0,0,8,0,2,0,10,0,129
	db        16,0,0,8,0,2,0,10,4,129,16,0,0,4,0,1
	db        2,0,0,26,0,9,0,131,16,0,0,129,16,0,0,132
	db        16,0,0,4,0,1,0,137,16,0,0,0,0,0,0,8
	db        0,2,0,42,0,136,16,0,0,8,0,1,0,1,0,129
	db        16,0,0,8,0,1,2,1,0,135,16,0,0,26,0,9
	db        0,131,16,0,0,129,16,0,0,132,16,0,0,4,0,1
	db        0,139,16,0,0,0,0,0,0,8,0,1,2,1,0,242
	db        255,255,255,26,0,9,0,3,0,0,0,129,16,0,0,132
	db        16,0,0,4,0,0,0,141,16,0,0,0,0,0,0,4
	db        0,1,2,0,0,26,0,9,0,143,16,0,0,129,16,0
	db        0,132,16,0,0,4,0,1,0,144,16,0,0,0,0,0
	db        0,8,0,2,0,42,0,129,16,0,0,8,0,1,2,1
	db        0,143,16,0,0,26,0,9,0,143,16,0,0,129,16,0
	db        0,132,16,0,0,4,0,1,0,146,16,0,0,0,0,0
	db        0,8,0,1,2,1,0,242,255,255,255,26,0,9,0,242
	db        255,255,255,129,16,0,0,148,16,0,0,4,0,0,0,149
	db        16,0,0,0,0,0,0,8,0,2,0,10,4,136,16,0
	db        0,4,0,1,2,0,0,26,0,9,0,48,0,0,0,129
	db        16,0,0,148,16,0,0,0,0,0,0,151,16,0,0,0
	db        0,0,0,4,0,1,2,0,0,26,0,9,0,242,255,255
	db        255,129,16,0,0,148,16,0,0,4,0,0,0,153,16,0
	db        0,0,0,0,0,4,0,1,2,0,0,26,0,9,0,241
	db        255,255,255,129,16,0,0,132,16,0,0,4,0,0,0,155
	db        16,0,0,0,0,0,0,4,0,1,2,0,0,26,0,9
	db        0,3,0,0,0,129,16,0,0,132,16,0,0,0,0,0
	db        0,157,16,0,0,0,0,0,0,4,0,1,2,0,0,26
	db        0,9,0,240,255,255,255,129,16,0,0,132,16,0,0,4
	db        0,0,0,159,16,0,0,0,0,0,0,4,0,1,2,0
	db        0,42,0,7,2,3,4,130,16,0,0,0,0,0,0,3
	db        4,0,0,0,0,0,0,0,0,3,4,134,16,0,0,0
	db        0,0,0,3,4,138,16,0,0,0,0,0,0,12,0,7
	db        2,3,8,140,16,0,0,0,0,0,0,22,0,7,2,3
	db        1,142,16,0,0,0,0,0,0,3,1,145,16,0,0,0
	db        0,0,0,12,0,7,2,3,1,147,16,0,0,0,0,0
	db        0,12,0,7,2,3,1,150,16,0,0,0,0,0,0,12
	db        0,7,2,3,2,152,16,0,0,0,0,0,0,12,0,7
	db        2,3,1,154,16,0,0,0,0,0,0,12,0,7,2,3
	db        0,156,16,0,0,0,0,0,0,12,0,7,2,3,1,158
	db        16,0,0,0,0,0,0,130,0,4,2,6,4,242,255,255
	db        255,1,0,91,0,0,0,0,0,0,0,0,0,242,241,8
	db        4,4,0,160,16,0,0,92,0,0,0,8,4,1,0,161
	db        16,0,0,93,0,0,0,8,4,2,0,162,16,0,0,94
	db        0,0,0,8,4,1,0,163,16,0,0,95,0,0,0,8
	db        4,1,0,164,16,0,0,96,0,0,0,8,4,1,0,165
	db        16,0,0,97,0,0,0,8,4,1,0,166,16,0,0,98
	db        0,0,0,8,4,1,0,167,16,0,0,99,0,0,0,8
	db        4,1,0,168,16,0,0,100,0,0,0,4,0,1,2,0
	db        0,26,0,9,0,3,0,0,0,172,16,0,0,175,16,0
	db        0,4,0,0,0,213,16,0,0,0,0,0,0,28,0,4
	db        0,10,0,212,16,0,0,34,1,0,0,0,0,0,0,0
	db        0,0,0,0,0,103,0,0,0,4,0,26,0,9,0,174
	db        16,0,0,172,16,0,0,175,16,0,0,4,0,0,0,176
	db        16,0,0,0,0,0,0,8,0,2,0,10,0,172,16,0
	db        0,8,0,2,0,10,4,172,16,0,0,4,0,1,2,0
	db        0,26,0,9,0,174,16,0,0,172,16,0,0,175,16,0
	db        0,4,0,1,0,180,16,0,0,0,0,0,0,8,0,2
	db        0,42,0,179,16,0,0,8,0,1,0,1,0,172,16,0
	db        0,8,0,1,2,1,0,178,16,0,0,26,0,9,0,174
	db        16,0,0,172,16,0,0,175,16,0,0,4,0,1,0,182
	db        16,0,0,0,0,0,0,8,0,1,2,1,0,239,255,255
	db        255,26,0,9,0,3,0,0,0,172,16,0,0,175,16,0
	db        0,4,0,0,0,184,16,0,0,0,0,0,0,4,0,1
	db        2,0,0,26,0,9,0,186,16,0,0,172,16,0,0,175
	db        16,0,0,4,0,1,0,187,16,0,0,0,0,0,0,8
	db        0,2,0,42,0,172,16,0,0,8,0,1,2,1,0,186
	db        16,0,0,26,0,9,0,186,16,0,0,172,16,0,0,175
	db        16,0,0,4,0,1,0,189,16,0,0,0,0,0,0,8
	db        0,1,2,1,0,239,255,255,255,26,0,9,0,239,255,255
	db        255,172,16,0,0,191,16,0,0,4,0,0,0,192,16,0
	db        0,0,0,0,0,8,0,2,0,10,4,179,16,0,0,4
	db        0,1,2,0,0,26,0,9,0,48,0,0,0,172,16,0
	db        0,191,16,0,0,0,0,0,0,194,16,0,0,0,0,0
	db        0,4,0,1,2,0,0,26,0,9,0,239,255,255,255,172
	db        16,0,0,191,16,0,0,4,0,0,0,196,16,0,0,0
	db        0,0,0,4,0,1,2,0,0,26,0,9,0,238,255,255
	db        255,172,16,0,0,175,16,0,0,4,0,0,0,198,16,0
	db        0,0,0,0,0,4,0,1,2,0,0,26,0,9,0,3
	db        0,0,0,172,16,0,0,175,16,0,0,0,0,0,0,200
	db        16,0,0,0,0,0,0,4,0,1,2,0,0,26,0,9
	db        0,237,255,255,255,172,16,0,0,175,16,0,0,4,0,0
	db        0,202,16,0,0,0,0,0,0,4,0,1,2,0,0,42
	db        0,7,2,3,4,173,16,0,0,0,0,0,0,3,4,0
	db        0,0,0,0,0,0,0,3,4,177,16,0,0,0,0,0
	db        0,3,4,181,16,0,0,0,0,0,0,12,0,7,2,3
	db        8,183,16,0,0,0,0,0,0,22,0,7,2,3,1,185
	db        16,0,0,0,0,0,0,3,1,188,16,0,0,0,0,0
	db        0,12,0,7,2,3,1,190,16,0,0,0,0,0,0,12
	db        0,7,2,3,1,193,16,0,0,0,0,0,0,12,0,7
	db        2,3,2,195,16,0,0,0,0,0,0,12,0,7,2,3
	db        1,197,16,0,0,0,0,0,0,12,0,7,2,3,0,199
	db        16,0,0,0,0,0,0,12,0,7,2,3,1,201,16,0
	db        0,0,0,0,0,130,0,4,2,6,4,239,255,255,255,1
	db        0,104,0,0,0,0,0,0,0,0,0,242,241,8,4,4
	db        0,203,16,0,0,105,0,0,0,8,4,1,0,204,16,0
	db        0,106,0,0,0,8,4,2,0,205,16,0,0,107,0,0
	db        0,8,4,1,0,206,16,0,0,108,0,0,0,8,4,1
	db        0,207,16,0,0,109,0,0,0,8,4,1,0,208,16,0
	db        0,110,0,0,0,8,4,1,0,209,16,0,0,111,0,0
	db        0,8,4,1,0,210,16,0,0,112,0,0,0,8,4,1
	db        0,211,16,0,0,113,0,0,0,4,0,1,2,0,0,26
	db        0,9,0,3,0,0,0,215,16,0,0,218,16,0,0,4
	db        0,0,0,0,17,0,0,0,0,0,0,28,0,4,0,10
	db        0,255,16,0,0,34,1,0,0,0,0,0,0,0,0,0
	db        0,0,0,116,0,0,0,4,0,26,0,9,0,217,16,0
	db        0,215,16,0,0,218,16,0,0,4,0,0,0,219,16,0
	db        0,0,0,0,0,8,0,2,0,10,0,215,16,0,0,8
	db        0,2,0,10,4,215,16,0,0,4,0,1,2,0,0,26
	db        0,9,0,217,16,0,0,215,16,0,0,218,16,0,0,4
	db        0,1,0,223,16,0,0,0,0,0,0,8,0,2,0,42
	db        0,222,16,0,0,8,0,1,0,1,0,215,16,0,0,8
	db        0,1,2,1,0,221,16,0,0,26,0,9,0,217,16,0
	db        0,215,16,0,0,218,16,0,0,4,0,1,0,225,16,0
	db        0,0,0,0,0,8,0,1,2,1,0,236,255,255,255,26
	db        0,9,0,3,0,0,0,215,16,0,0,218,16,0,0,4
	db        0,0,0,227,16,0,0,0,0,0,0,4,0,1,2,0
	db        0,26,0,9,0,229,16,0,0,215,16,0,0,218,16,0
	db        0,4,0,1,0,230,16,0,0,0,0,0,0,8,0,2
	db        0,42,0,215,16,0,0,8,0,1,2,1,0,229,16,0
	db        0,26,0,9,0,229,16,0,0,215,16,0,0,218,16,0
	db        0,4,0,1,0,232,16,0,0,0,0,0,0,8,0,1
	db        2,1,0,236,255,255,255,26,0,9,0,236,255,255,255,215
	db        16,0,0,234,16,0,0,4,0,0,0,235,16,0,0,0
	db        0,0,0,8,0,2,0,10,4,222,16,0,0,4,0,1
	db        2,0,0,26,0,9,0,48,0,0,0,215,16,0,0,234
	db        16,0,0,0,0,0,0,237,16,0,0,0,0,0,0,4
	db        0,1,2,0,0,26,0,9,0,236,255,255,255,215,16,0
	db        0,234,16,0,0,4,0,0,0,239,16,0,0,0,0,0
	db        0,4,0,1,2,0,0,26,0,9,0,235,255,255,255,215
	db        16,0,0,218,16,0,0,4,0,0,0,241,16,0,0,0
	db        0,0,0,4,0,1,2,0,0,26,0,9,0,3,0,0
	db        0,215,16,0,0,218,16,0,0,0,0,0,0,243,16,0
	db        0,0,0,0,0,4,0,1,2,0,0,26,0,9,0,234
	db        255,255,255,215,16,0,0,218,16,0,0,4,0,0,0,245
	db        16,0,0,0,0,0,0,4,0,1,2,0,0,42,0,7
	db        2,3,4,216,16,0,0,0,0,0,0,3,4,0,0,0
	db        0,0,0,0,0,3,4,220,16,0,0,0,0,0,0,3
	db        4,224,16,0,0,0,0,0,0,12,0,7,2,3,8,226
	db        16,0,0,0,0,0,0,22,0,7,2,3,1,228,16,0
	db        0,0,0,0,0,3,1,231,16,0,0,0,0,0,0,12
	db        0,7,2,3,1,233,16,0,0,0,0,0,0,12,0,7
	db        2,3,1,236,16,0,0,0,0,0,0,12,0,7,2,3
	db        2,238,16,0,0,0,0,0,0,12,0,7,2,3,1,240
	db        16,0,0,0,0,0,0,12,0,7,2,3,0,242,16,0
	db        0,0,0,0,0,12,0,7,2,3,1,244,16,0,0,0
	db        0,0,0,130,0,4,2,6,4,236,255,255,255,1,0,117
	db        0,0,0,0,0,0,0,0,0,242,241,8,4,4,0,246
	db        16,0,0,118,0,0,0,8,4,1,0,247,16,0,0,119
	db        0,0,0,8,4,2,0,248,16,0,0,120,0,0,0,8
	db        4,1,0,249,16,0,0,121,0,0,0,8,4,1,0,250
	db        16,0,0,122,0,0,0,8,4,1,0,251,16,0,0,123
	db        0,0,0,8,4,1,0,252,16,0,0,124,0,0,0,8
	db        4,1,0,253,16,0,0,125,0,0,0,8,4,1,0,254
	db        16,0,0,126,0,0,0,4,0,1,2,0,0,8,0,1
	db        0,1,0,16,0,0,0,8,0,1,0,1,0,33,0,0
	db        0,8,0,1,0,1,0,233,255,255,255,8,0,2,0,10
	db        2,3,0,0,0,14,0,8,0,3,0,0,0,4,0,1
	db        0,6,17,0,0,8,0,1,2,1,0,3,4,0,0,14
	db        0,8,0,116,0,0,0,2,0,0,0,8,17,0,0,4
	db        0,1,2,0,0,14,0,8,0,244,255,255,255,4,0,1
	db        0,11,17,0,0,8,0,2,0,10,4,232,255,255,255,8
	db        0,1,2,1,0,10,17,0,0,14,0,8,0,3,0,0
	db        0,4,0,2,0,13,17,0,0,12,0,1,2,2,0,111
	db        16,0,0,116,0,0,0,14,0,8,0,3,4,0,0,7
	db        0,6,0,17,17,0,0,8,0,2,0,10,0,16,17,0
	db        0,8,0,1,0,1,0,112,0,0,0,28,0,1,2,6
	db        0,3,4,0,0,15,17,0,0,15,17,0,0,15,17,0
	db        0,15,17,0,0,116,0,0,0,14,0,8,0,3,4,0
	db        0,4,0,1,0,20,17,0,0,8,0,2,0,10,4,231
	db        255,255,255,8,0,1,2,1,0,19,17,0,0,14,0,8
	db        0,116,0,0,0,4,0,4,0,22,17,0,0,20,0,1
	db        2,4,0,115,16,0,0,230,255,255,255,41,16,0,0,116
	db        0,0,0,14,0,8,0,245,255,255,255,4,0,2,0,24
	db        17,0,0,12,0,1,2,2,0,111,16,0,0,15,17,0
	db        0,14,0,8,0,3,0,0,0,0,0,1,0,26,17,0
	db        0,8,0,1,2,1,0,3,4,0,0,14,0,8,0,3
	db        0,0,0,0,0,0,0,28,17,0,0,4,0,1,2,0
	db        0,14,0,8,0,3,4,0,0,0,0,3,0,30,17,0
	db        0,16,0,1,2,3,0,3,4,0,0,116,0,0,0,117
	db        0,0,0,14,0,8,0,3,0,0,0,4,0,1,0,33
	db        17,0,0,8,0,2,0,10,4,229,255,255,255,8,0,1
	db        2,1,0,32,17,0,0,14,0,8,0,34,0,0,0,7
	db        0,1,0,35,17,0,0,8,0,1,2,1,0,3,4,0
	db        0,14,0,8,0,3,4,0,0,7,0,0,0,37,17,0
	db        0,4,0,1,2,0,0,14,0,8,0,116,0,0,0,7
	db        0,1,0,39,17,0,0,8,0,1,2,1,0,3,4,0
	db        0,14,0,8,0,3,4,0,0,7,0,0,0,41,17,0
	db        0,4,0,1,2,0,0,14,0,8,0,116,0,0,0,7
	db        0,2,0,43,17,0,0,12,0,1,2,2,0,3,4,0
	db        0,34,0,0,0,14,0,8,0,116,0,0,0,7,0,2
	db        0,45,17,0,0,12,0,1,2,2,0,3,4,0,0,116
	db        0,0,0,14,0,8,0,3,0,0,0,7,0,1,0,47
	db        17,0,0,8,0,1,2,1,0,34,0,0,0,14,0,8
	db        0,3,0,0,0,7,0,1,0,49,17,0,0,8,0,1
	db        2,1,0,228,255,255,255,14,0,8,0,3,0,0,0,4
	db        0,2,0,51,17,0,0,12,0,1,2,2,0,10,17,0
	db        0,115,16,0,0,14,0,8,0,244,255,255,255,4,0,2
	db        0,53,17,0,0,12,0,1,2,2,0,15,17,0,0,227
	db        255,255,255,14,0,8,0,244,255,255,255,4,0,2,0,55
	db        17,0,0,12,0,1,2,2,0,115,16,0,0,66,0,0
	db        0,8,0,1,0,1,0,57,17,0,0,14,0,8,0,244
	db        255,255,255,4,0,2,0,58,17,0,0,12,0,1,2,2
	db        0,114,16,0,0,227,255,255,255,14,0,8,0,244,255,255
	db        255,4,0,1,0,60,17,0,0,8,0,1,2,1,0,66
	db        0,0,0,14,0,8,0,3,0,0,0,4,0,2,0,63
	db        17,0,0,8,0,2,0,10,4,226,255,255,255,12,0,1
	db        2,2,0,62,17,0,0,48,0,0,0,14,0,8,0,3
	db        0,0,0,4,0,2,0,66,17,0,0,8,0,2,0,10
	db        4,225,255,255,255,12,0,1,2,2,0,65,17,0,0,233
	db        255,255,255,14,0,8,0,224,255,255,255,4,0,1,0,69
	db        17,0,0,8,0,2,0,10,4,223,255,255,255,8,0,1
	db        2,1,0,68,17,0,0,14,0,8,0,222,255,255,255,4
	db        0,3,0,71,17,0,0,16,0,1,2,3,0,32,17,0
	db        0,16,0,0,0,249,255,255,255,14,0,8,0,227,255,255
	db        255,4,0,2,0,73,17,0,0,12,0,1,2,2,0,111
	db        16,0,0,227,255,255,255,14,0,8,0,244,255,255,255,4
	db        0,1,0,75,17,0,0,8,0,1,2,1,0,116,0,0
	db        0,14,0,8,0,18,0,0,0,4,0,3,0,77,17,0
	db        0,16,0,1,2,3,0,122,16,0,0,250,255,255,255,3
	db        4,0,0,14,0,8,0,3,0,0,0,4,0,1,0,79
	db        17,0,0,8,0,1,2,1,0,32,17,0,0,14,0,8
	db        0,3,0,0,0,4,0,1,0,81,17,0,0,8,0,1
	db        2,1,0,32,17,0,0,14,0,8,0,3,0,0,0,4
	db        0,2,0,84,17,0,0,8,0,2,0,10,4,221,255,255
	db        255,12,0,1,2,2,0,83,17,0,0,3,4,0,0,14
	db        0,8,0,3,0,0,0,4,0,2,0,86,17,0,0,12
	db        0,1,2,2,0,32,17,0,0,3,4,0,0,14,0,8
	db        0,250,255,255,255,4,0,2,0,88,17,0,0,12,0,1
	db        2,2,0,83,17,0,0,220,255,255,255,14,0,8,0,3
	db        0,0,0,4,0,1,0,90,17,0,0,8,0,1,2,1
	db        0,83,17,0,0,14,0,8,0,3,0,0,0,4,0,2
	db        0,92,17,0,0,12,0,1,2,2,0,19,17,0,0,219
	db        255,255,255,14,0,8,0,3,0,0,0,4,0,2,0,94
	db        17,0,0,12,0,1,2,2,0,32,17,0,0,218,255,255
	db        255,14,0,8,0,3,0,0,0,4,0,2,0,97,17,0
	db        0,8,0,2,0,10,4,217,255,255,255,12,0,1,2,2
	db        0,96,17,0,0,219,255,255,255,14,0,8,0,3,0,0
	db        0,4,0,1,0,99,17,0,0,8,0,1,2,1,0,32
	db        17,0,0,14,0,8,0,3,0,0,0,4,0,3,0,101
	db        17,0,0,16,0,1,2,3,0,32,17,0,0,249,255,255
	db        255,216,255,255,255,14,0,8,0,3,0,0,0,4,0,2
	db        0,103,17,0,0,12,0,1,2,2,0,32,17,0,0,215
	db        255,255,255,14,0,8,0,3,0,0,0,4,0,2,0,105
	db        17,0,0,12,0,1,2,2,0,10,17,0,0,115,16,0
	db        0,14,0,8,0,3,0,0,0,4,0,4,0,107,17,0
	db        0,20,0,1,2,4,0,32,17,0,0,249,255,255,255,115
	db        16,0,0,115,16,0,0,14,0,8,0,3,0,0,0,4
	db        0,2,0,109,17,0,0,12,0,1,2,2,0,122,16,0
	db        0,214,255,255,255,14,0,8,0,18,0,0,0,7,0,3
	db        0,111,17,0,0,16,0,1,2,3,0,32,17,0,0,213
	db        255,255,255,3,4,0,0,14,0,8,0,48,0,0,0,4
	db        0,3,0,114,17,0,0,8,0,2,0,42,0,116,0,0
	db        0,16,0,1,2,3,0,19,17,0,0,113,17,0,0,113
	db        17,0,0,14,0,8,0,48,0,0,0,4,0,3,0,116
	db        17,0,0,16,0,1,2,3,0,19,17,0,0,113,17,0
	db        0,113,17,0,0,14,0,8,0,3,0,0,0,4,0,5
	db        0,118,17,0,0,24,0,1,2,5,0,19,17,0,0,113
	db        17,0,0,113,17,0,0,113,17,0,0,113,17,0,0,14
	db        0,8,0,212,255,255,255,4,0,1,0,120,17,0,0,8
	db        0,1,2,1,0,19,17,0,0,14,0,8,0,211,255,255
	db        255,4,0,1,0,122,17,0,0,8,0,1,2,1,0,32
	db        17,0,0,14,0,8,0,3,4,0,0,4,0,2,0,125
	db        17,0,0,8,0,2,0,42,0,3,4,0,0,12,0,1
	db        2,2,0,19,17,0,0,124,17,0,0,14,0,8,0,210
	db        255,255,255,4,0,1,0,127,17,0,0,8,0,1,2,1
	db        0,10,17,0,0,14,0,8,0,48,0,0,0,4,0,1
	db        0,129,17,0,0,8,0,1,2,1,0,10,17,0,0,14
	db        0,8,0,48,0,0,0,4,0,1,0,131,17,0,0,8
	db        0,1,2,1,0,32,17,0,0,14,0,8,0,220,255,255
	db        255,4,0,1,0,133,17,0,0,8,0,1,2,1,0,10
	db        17,0,0,14,0,8,0,3,0,0,0,4,0,2,0,135
	db        17,0,0,12,0,1,2,2,0,10,17,0,0,209,255,255
	db        255,14,0,8,0,3,0,0,0,4,0,2,0,137,17,0
	db        0,12,0,1,2,2,0,10,17,0,0,48,0,0,0,14
	db        0,8,0,3,0,0,0,4,0,2,0,139,17,0,0,12
	db        0,1,2,2,0,32,17,0,0,208,255,255,255,14,0,8
	db        0,3,0,0,0,4,0,2,0,141,17,0,0,12,0,1
	db        2,2,0,32,17,0,0,48,0,0,0,14,0,8,0,3
	db        0,0,0,4,0,2,0,143,17,0,0,12,0,1,2,2
	db        0,10,17,0,0,207,255,255,255,14,0,8,0,3,0,0
	db        0,4,0,2,0,145,17,0,0,12,0,1,2,2,0,32
	db        17,0,0,206,255,255,255,14,0,8,0,3,0,0,0,4
	db        0,1,0,147,17,0,0,8,0,1,2,1,0,10,17,0
	db        0,14,0,8,0,3,0,0,0,4,0,1,0,149,17,0
	db        0,8,0,1,2,1,0,19,17,0,0,14,0,8,0,3
	db        0,0,0,4,0,1,0,151,17,0,0,8,0,1,2,1
	db        0,19,17,0,0,14,0,8,0,3,0,0,0,4,0,5
	db        0,153,17,0,0,24,0,1,2,5,0,19,17,0,0,116
	db        0,0,0,116,0,0,0,116,0,0,0,116,0,0,0,14
	db        0,8,0,3,0,0,0,4,0,1,0,155,17,0,0,8
	db        0,1,2,1,0,19,17,0,0,14,0,8,0,3,0,0
	db        0,4,0,2,0,158,17,0,0,8,0,2,0,10,4,205
	db        255,255,255,12,0,1,2,2,0,157,17,0,0,204,255,255
	db        255,14,0,8,0,3,0,0,0,4,0,3,0,160,17,0
	db        0,16,0,1,2,3,0,32,17,0,0,203,255,255,255,204
	db        255,255,255,14,0,8,0,3,0,0,0,4,0,1,0,162
	db        17,0,0,8,0,1,2,1,0,19,17,0,0,14,0,8
	db        0,3,0,0,0,4,0,2,0,164,17,0,0,12,0,1
	db        2,2,0,32,17,0,0,202,255,255,255,14,0,8,0,3
	db        0,0,0,4,0,2,0,166,17,0,0,12,0,1,2,2
	db        0,32,17,0,0,202,255,255,255,14,0,8,0,3,0,0
	db        0,4,0,1,0,168,17,0,0,8,0,1,2,1,0,32
	db        17,0,0,14,0,8,0,3,0,0,0,4,0,1,0,170
	db        17,0,0,8,0,1,2,1,0,32,17,0,0,14,0,8
	db        0,3,0,0,0,4,0,1,0,172,17,0,0,8,0,1
	db        2,1,0,19,17,0,0,14,0,8,0,211,255,255,255,4
	db        0,1,0,174,17,0,0,8,0,1,2,1,0,19,17,0
	db        0,14,0,8,0,3,0,0,0,4,0,2,0,176,17,0
	db        0,12,0,1,2,2,0,32,17,0,0,3,4,0,0,14
	db        0,8,0,3,0,0,0,4,0,2,0,178,17,0,0,12
	db        0,1,2,2,0,19,17,0,0,203,255,255,255,14,0,8
	db        0,3,0,0,0,4,0,1,0,180,17,0,0,8,0,1
	db        2,1,0,32,17,0,0,14,0,8,0,48,0,0,0,4
	db        0,1,0,182,17,0,0,8,0,1,2,1,0,157,17,0
	db        0,14,0,8,0,3,0,0,0,4,0,2,0,184,17,0
	db        0,12,0,1,2,2,0,157,17,0,0,203,255,255,255,14
	db        0,8,0,3,0,0,0,4,0,2,0,186,17,0,0,12
	db        0,1,2,2,0,32,17,0,0,201,255,255,255,14,0,8
	db        0,3,0,0,0,4,0,1,0,188,17,0,0,8,0,1
	db        2,1,0,32,17,0,0,14,0,8,0,3,0,0,0,4
	db        0,1,0,190,17,0,0,8,0,1,2,1,0,32,17,0
	db        0,14,0,8,0,3,0,0,0,4,0,1,0,192,17,0
	db        0,8,0,1,2,1,0,32,17,0,0,14,0,8,0,48
	db        0,0,0,4,0,1,0,194,17,0,0,8,0,1,2,1
	db        0,32,17,0,0,14,0,8,0,48,0,0,0,4,0,2
	db        0,196,17,0,0,12,0,1,2,2,0,32,17,0,0,208
	db        255,255,255,14,0,8,0,116,0,0,0,4,0,1,0,198
	db        17,0,0,8,0,1,2,1,0,32,17,0,0,14,0,8
	db        0,48,0,0,0,4,0,3,0,200,17,0,0,16,0,1
	db        2,3,0,32,17,0,0,203,255,255,255,206,255,255,255,14
	db        0,8,0,245,255,255,255,4,0,2,0,202,17,0,0,12
	db        0,1,2,2,0,111,16,0,0,227,255,255,255,14,0,8
	db        0,3,0,0,0,4,0,4,0,204,17,0,0,20,0,1
	db        2,4,0,220,255,255,255,48,0,0,0,115,16,0,0,115
	db        16,0,0,14,0,8,0,222,255,255,255,4,0,4,0,206
	db        17,0,0,20,0,1,2,4,0,32,17,0,0,16,0,0
	db        0,249,255,255,255,116,0,0,0,14,0,8,0,3,0,0
	db        0,4,0,2,0,208,17,0,0,12,0,1,2,2,0,32
	db        17,0,0,16,0,0,0,14,0,8,0,3,0,0,0,4
	db        0,2,0,210,17,0,0,12,0,1,2,2,0,157,17,0
	db        0,16,0,0,0,14,0,8,0,3,0,0,0,0,0,1
	db        0,212,17,0,0,8,0,1,2,1,0,3,4,0,0,14
	db        0,8,0,3,0,0,0,4,0,2,0,214,17,0,0,12
	db        0,1,2,2,0,19,17,0,0,16,0,0,0,14,0,8
	db        0,3,0,0,0,4,0,2,0,216,17,0,0,12,0,1
	db        2,2,0,10,17,0,0,16,0,0,0,14,0,8,0,3
	db        0,0,0,4,0,2,0,218,17,0,0,12,0,1,2,2
	db        0,122,16,0,0,16,0,0,0,14,0,8,0,3,0,0
	db        0,4,0,2,0,220,17,0,0,12,0,1,2,2,0,96
	db        17,0,0,16,0,0,0,14,0,8,0,3,0,0,0,4
	db        0,2,0,222,17,0,0,12,0,1,2,2,0,83,17,0
	db        0,16,0,0,0
$$BTYPES	ends
$$BNAMES	segment byte public use32 'DEBNAM'
	db	9,'TfrmAbout'
	db	6,'Panel1'
	db	11,'ProductName'
	db	7,'Version'
	db	8,'Comments'
	db	6,'Label3'
	db	7,'PhysMem'
	db	7,'FreeRes'
	db	8,'CpuLabel'
	db	8,'OKButton'
	db	6,'Image1'
	db	11,'Label3Click'
	db	13,'OKButtonClick'
	db	12,'FormActivate'
	db	8,'FormShow'
	db	11,'GetCPUSpeed'
	db	41,'@TfrmAbout@$bctr$qqrp18Classes@TComponent'
	db	29,'@TfrmAbout@$basg$qr9TfrmAbout'
	db	21,'@TfrmAbout@$bdtr$qqrv'
	db	41,'@TfrmAbout@$bctr$qqrp18Classes@TComponent'
	db	4,'this'
	db	5,'Owner'
	db	22,'@TfrmAbout@Label3Click'
	db	4,'this'
	db	6,'Sender'
	db	3,'url'
	db	48,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	51,'@System@%SetBase$18Dialogs@TMsgDlgBtnuc$i0$uc$i10$%'
	db	4,'Data'
	db	12,'TSetTypeRTTI'
	db	59,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv'
	db	109,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$basg$qqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$brplu$qqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$brmin$qqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$brmul$qqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$badd$xqqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bsub$xqqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bmul$xqqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	79,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn'
	db	79,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$brsh$qqrx18Dialogs@TMsgDlgBtn'
	db	8,'Contains'
	db	5,'Clear'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$beql$xqqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	110,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bneq$xqqrrx47System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%'
	db	59,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$bctr$qqrv'
	db	4,'this'
	db	79,'@System@%Set$t18Dialogs@TMsgDlgBtn$iuc$0$iuc$10%@$blsh$qqrx18Dialogs@TMsgDlgBtn'
	db	4,'this'
	db	2,'el'
	db	24,'@TfrmAbout@OKButtonClick'
	db	4,'this'
	db	6,'Sender'
	db	22,'@TfrmAbout@GetCPUSpeed'
	db	4,'this'
	db	8,'Priority'
	db	13,'PriorityClass'
	db	7,'TimerLo'
	db	7,'TimerHi'
	db	9,'DelayTime'
	db	23,'@TfrmAbout@FormActivate'
	db	4,'this'
	db	6,'Sender'
	db	2,'MS'
	db	19,'@TfrmAbout@FormShow'
	db	4,'this'
	db	6,'Sender'
	db	43,'@Forms@TForm@$bctr$qqrp18Classes@TComponent'
	db	4,'this'
	db	6,'AOwner'
	db	29,'@System@AnsiString@$bctr$qqrv'
	db	4,'this'
	db	24,'@System@AnsiString@c_str'
	db	4,'this'
	db	8,'IntToStr'
	db	6,'return'
	db	5,'value'
	db	21,'@TfrmAbout@$bdtr$qqrv'
	db	4,'this'
	db	34,'@Classes@TComponent@UpdateRegistry'
	db	4,'this'
	db	8,'Register'
	db	7,'ClassID'
	db	6,'ProgID'
	db	44,'@Forms@TForm@$bctr$qqrp18Classes@TComponenti'
	db	4,'this'
	db	6,'AOwner'
	db	5,'Dummy'
	db	23,'@Forms@TForm@$bdtr$qqrv'
	db	4,'this'
	db	43,'@System@%DelphiInterface$t14Forms@IOleForm%'
	db	4,'intf'
	db	54,'@System@%DelphiInterface$t14Forms@IOleForm%@$bctr$qqrv'
	db	54,'@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv'
	db	98,'@System@%DelphiInterface$t14Forms@IOleForm%@$basg$qqrr42System@%DelphiInterface$t14Forms@IOleForm%'
	db	56,'@System@%DelphiInterface$t14Forms@IOleForm%@$barow$xqqrv'
	db	53,'@System@%DelphiInterface$t14Forms@IOleForm%@$bnot$xqv'
	db	19,'operator IOleForm *'
	db	54,'@System@%DelphiInterface$t14Forms@IOleForm%@$bind$qqrv'
	db	7,'Release'
	db	54,'@System@%DelphiInterface$t14Forms@IOleForm%@$badr$qqrv'
	db	54,'@System@%DelphiInterface$t14Forms@IOleForm%@$bdtr$qqrv'
	db	4,'this'
	db	44,'@System@%DelphiInterface$t15Forms@IDesigner%'
	db	4,'intf'
	db	55,'@System@%DelphiInterface$t15Forms@IDesigner%@$bctr$qqrv'
	db	55,'@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv'
	db	100,'@System@%DelphiInterface$t15Forms@IDesigner%@$basg$qqrr43System@%DelphiInterface$t15Forms@IDesigner%'
	db	57,'@System@%DelphiInterface$t15Forms@IDesigner%@$barow$xqqrv'
	db	54,'@System@%DelphiInterface$t15Forms@IDesigner%@$bnot$xqv'
	db	20,'operator IDesigner *'
	db	55,'@System@%DelphiInterface$t15Forms@IDesigner%@$bind$qqrv'
	db	7,'Release'
	db	55,'@System@%DelphiInterface$t15Forms@IDesigner%@$badr$qqrv'
	db	55,'@System@%DelphiInterface$t15Forms@IDesigner%@$bdtr$qqrv'
	db	4,'this'
	db	50,'@System@%DelphiInterface$t21Controls@IDockManager%'
	db	4,'intf'
	db	61,'@System@%DelphiInterface$t21Controls@IDockManager%@$bctr$qqrv'
	db	61,'@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv'
	db	112,'@System@%DelphiInterface$t21Controls@IDockManager%@$basg$qqrr49System@%DelphiInterface$t21Controls@IDockManager%'
	db	63,'@System@%DelphiInterface$t21Controls@IDockManager%@$barow$xqqrv'
	db	60,'@System@%DelphiInterface$t21Controls@IDockManager%@$bnot$xqv'
	db	23,'operator IDockManager *'
	db	61,'@System@%DelphiInterface$t21Controls@IDockManager%@$bind$qqrv'
	db	7,'Release'
	db	61,'@System@%DelphiInterface$t21Controls@IDockManager%@$badr$qqrv'
	db	61,'@System@%DelphiInterface$t21Controls@IDockManager%@$bdtr$qqrv'
	db	4,'this'
	db	8,'frmAbout'
	db	3,'std'
	db	6,'System'
	db	19,'@System@varSmallint'
	db	18,'@System@varInteger'
	db	17,'@System@varSingle'
	db	17,'@System@varDouble'
	db	19,'@System@varCurrency'
	db	15,'@System@varDate'
	db	17,'@System@varOleStr'
	db	19,'@System@varDispatch'
	db	18,'@System@varBoolean'
	db	18,'@System@varVariant'
	db	18,'@System@varUnknown'
	db	15,'@System@varByte'
	db	16,'@System@varByRef'
	db	17,'@System@vtInteger'
	db	17,'@System@vtBoolean'
	db	14,'@System@vtChar'
	db	18,'@System@vtExtended'
	db	16,'@System@vtString'
	db	17,'@System@vtPointer'
	db	15,'@System@vtPChar'
	db	16,'@System@vtObject'
	db	15,'@System@vtClass'
	db	18,'@System@vtWideChar'
	db	19,'@System@vtPWideChar'
	db	20,'@System@vtAnsiString'
	db	18,'@System@vtCurrency'
	db	17,'@System@vtVariant'
	db	8,'Sysutils'
	db	7,'Sysinit'
	db	7,'Windows'
	db	8,'Messages'
	db	8,'Sysconst'
	db	7,'Classes'
	db	8,'Graphics'
	db	17,'@Graphics@clWhite'
	db	8,'Commctrl'
	db	7,'Imglist'
	db	8,'Actnlist'
	db	3,'Imm'
	db	7,'Contnrs'
	db	5,'Menus'
	db	8,'Multimon'
	db	8,'Controls'
	db	5,'Forms'
	db	7,'Activex'
	db	6,'Urlmon'
	db	7,'Wininet'
	db	6,'Regstr'
	db	8,'Shellapi'
	db	6,'Shlobj'
	db	8,'Stdctrls'
	db	7,'Commdlg'
	db	7,'Dialogs'
	db	8,'Extctrls'
	db	2,'Db'
	db	7,'Toolwin'
	db	8,'Richedit'
	db	8,'Comctrls'
	db	7,'Buttons'
	db	4,'Mask'
	db	7,'Dbctrls'
	db	6,'Smintf'
	db	3,'Bde'
	db	8,'Dbcommon'
	db	8,'Dbtables'
	db	9,'TfrmAbout'
	db	51,'@System@%SetBase$18Dialogs@TMsgDlgBtnuc$i0$uc$i10$%'
	db	8,'Dbtables'
	db	8,'Dbcommon'
	db	3,'Bde'
	db	6,'Smintf'
	db	7,'Dbctrls'
	db	4,'Mask'
	db	7,'Buttons'
	db	8,'Comctrls'
	db	8,'Richedit'
	db	7,'Toolwin'
	db	2,'Db'
	db	8,'Extctrls'
	db	7,'Dialogs'
	db	7,'Commdlg'
	db	8,'Stdctrls'
	db	6,'Shlobj'
	db	8,'Shellapi'
	db	6,'Regstr'
	db	7,'Wininet'
	db	6,'Urlmon'
	db	7,'Activex'
	db	5,'Forms'
	db	8,'Controls'
	db	8,'Multimon'
	db	5,'Menus'
	db	7,'Contnrs'
	db	3,'Imm'
	db	8,'Actnlist'
	db	7,'Imglist'
	db	8,'Commctrl'
	db	8,'Graphics'
	db	7,'Classes'
	db	8,'Sysutils'
	db	8,'Sysconst'
	db	8,'Messages'
	db	7,'Windows'
	db	7,'Sysinit'
	db	6,'System'
	db	5,'_rotr'
	db	5,'_rotl'
	db	6,'_crotr'
	db	6,'_lrotr'
	db	6,'_lrotl'
	db	6,'_crotl'
	db	3,'abs'
	db	6,'wctomb'
	db	7,'wcstoul'
	db	8,'wcstombs'
	db	6,'wcstol'
	db	6,'wcstod'
	db	5,'ultoa'
	db	4,'time'
	db	6,'system'
	db	4,'swab'
	db	7,'strtoul'
	db	6,'strtol'
	db	6,'strtod'
	db	5,'srand'
	db	7,'realloc'
	db	4,'rand'
	db	6,'putenv'
	db	6,'perror'
	db	6,'mbtowc'
	db	8,'mbstowcs'
	db	5,'mblen'
	db	13,'_seterrormode'
	db	26,'@std@%max$T1%$qrxT1t1$rxT1'
	db	26,'@std@%min$T1%$qrxT1t1$rxT1'
	db	17,'@std@randomize$qv'
	db	14,'@std@random$qi'
	db	4,'ltoa'
	db	4,'gcvt'
	db	4,'fcvt'
	db	4,'ecvt'
	db	6,'malloc'
	db	4,'ldiv'
	db	4,'labs'
	db	4,'itoa'
	db	6,'getenv'
	db	4,'free'
	db	4,'exit'
	db	3,'div'
	db	6,'calloc'
	db	4,'atol'
	db	4,'atoi'
	db	4,'atof'
	db	6,'atexit'
	db	5,'abort'
	db	6,'_wtold'
	db	5,'_wtol'
	db	5,'_wtoi'
	db	5,'_wtof'
	db	8,'_wsystem'
	db	11,'_wsplitpath'
	db	11,'_wsearchstr'
	db	11,'_wsearchenv'
	db	8,'_wputenv'
	db	8,'_wperror'
	db	10,'_wmakepath'
	db	8,'_wgetenv'
	db	10,'_wfullpath'
	db	8,'_wcstold'
	db	8,'_strtold'
	db	10,'_splitpath'
	db	10,'_searchstr'
	db	10,'_searchenv'
	db	9,'_makepath'
	db	7,'_wtoi64'
	db	8,'_ui64tow'
	db	8,'_ui64toa'
	db	7,'_i64tow'
	db	7,'_i64toa'
	db	7,'_atoi64'
	db	5,'_ltow'
	db	5,'_ltoa'
	db	6,'_lrand'
	db	5,'_itow'
	db	6,'_ultow'
	db	5,'_gcvt'
	db	5,'_fcvt'
	db	9,'_fullpath'
	db	5,'_exit'
	db	6,'_atold'
	db	5,'_ecvt'
	db	7,'__errno'
	db	10,'__doserrno'
	db	5,'qsort'
	db	7,'lsearch'
	db	5,'lfind'
	db	7,'bsearch'
	db	7,'wcsxfrm'
	db	6,'wcstok'
	db	6,'wcsstr'
	db	6,'wcsspn'
	db	7,'wcsrchr'
	db	7,'wcspcpy'
	db	7,'wcspbrk'
	db	7,'wcsncpy'
	db	7,'wcsncmp'
	db	7,'wcsncat'
	db	6,'wcslen'
	db	7,'wcscspn'
	db	6,'wcscpy'
	db	7,'wcscoll'
	db	6,'wcscmp'
	db	6,'wcschr'
	db	6,'wcscat'
	db	6,'strtok'
	db	18,'@std@strstr$qpxct1'
	db	18,'@std@strstr$qpcpxc'
	db	6,'strspn'
	db	19,'@std@strpbrk$qpxct1'
	db	19,'@std@strpbrk$qpcpxc'
	db	8,'strerror'
	db	7,'strcspn'
	db	18,'@std@strrchr$qpxci'
	db	17,'@std@strrchr$qpci'
	db	7,'strncpy'
	db	7,'strncmp'
	db	7,'strncat'
	db	6,'strlen'
	db	6,'strcpy'
	db	6,'strcmp'
	db	17,'@std@strchr$qpxci'
	db	16,'@std@strchr$qpci'
	db	6,'strcat'
	db	6,'strset'
	db	6,'stpcpy'
	db	7,'strnset'
	db	7,'_wcsset'
	db	7,'_wcsrev'
	db	8,'_wcspcpy'
	db	8,'_wcsnset'
	db	10,'_wcsnicoll'
	db	9,'_wcsnicmp'
	db	9,'_wcsncoll'
	db	9,'_wcsicoll'
	db	8,'_wcsicmp'
	db	7,'_wcsdup'
	db	10,'_strnicoll'
	db	9,'_strncoll'
	db	9,'_stricoll'
	db	9,'_strerror'
	db	9,'_lwcsxfrm'
	db	8,'_lwcsupr'
	db	11,'_lwcsnicoll'
	db	10,'_lwcsncoll'
	db	8,'_lwcslwr'
	db	10,'_lwcsicoll'
	db	9,'_lwcscoll'
	db	9,'_lstrxfrm'
	db	11,'_lstrnicoll'
	db	10,'_lstrncoll'
	db	10,'_lstricoll'
	db	9,'_lstrcoll'
	db	6,'strrev'
	db	8,'strnicmp'
	db	7,'stricmp'
	db	6,'strdup'
	db	7,'_stpcpy'
	db	8,'_lstrupr'
	db	8,'_lstrlwr'
	db	12,'_lwsetlocale'
	db	11,'_wsetlocale'
	db	12,'_llocaleconv'
	db	10,'localeconv'
	db	11,'_lsetlocale'
	db	10,'_ltowlower'
	db	10,'_ltowupper'
	db	8,'towupper'
	db	8,'towlower'
	db	9,'_ltoupper'
	db	7,'toupper'
	db	9,'_ltolower'
	db	7,'tolower'
	db	8,'iswascii'
	db	9,'iswxdigit'
	db	8,'iswupper'
	db	8,'iswspace'
	db	8,'iswpunct'
	db	8,'iswprint'
	db	8,'iswlower'
	db	8,'iswgraph'
	db	8,'iswdigit'
	db	8,'iswcntrl'
	db	8,'iswalpha'
	db	8,'iswalnum'
	db	7,'isascii'
	db	8,'isxdigit'
	db	7,'isupper'
	db	7,'isspace'
	db	7,'ispunct'
	db	7,'isprint'
	db	7,'islower'
	db	7,'isgraph'
	db	7,'isdigit'
	db	7,'iscntrl'
	db	7,'isalpha'
	db	7,'isalnum'
	db	6,'memset'
	db	6,'memcpy'
	db	6,'memcmp'
	db	19,'@std@memchr$qpxviui'
	db	18,'@std@memchr$qpviui'
	db	7,'memmove'
	db	7,'memicmp'
	db	7,'memccpy'
	db	8,'_wmemset'
	db	8,'_wmemcpy'
	db	21,'@std@_wmemchr$qpxviui'
	db	20,'@std@_wmemchr$qpviui'
	db	10,'__threadid'
	db	14,'@std@ptrdiff_t'
	db	11,'@std@size_t'
	db	11,'@std@wint_t'
	db	13,'@std@wctype_t'
	db	12,'@std@va_list'
	db	9,'_chartype'
	db	6,'_lower'
	db	6,'_upper'
	db	5,'lconv'
	db	5,'_argc'
	db	5,'_argv'
	db	12,'__mb_cur_max'
	db	16,'_cmdline_escapes'
	db	8,'_environ'
	db	9,'_fileinfo'
	db	6,'_fmode'
	db	8,'_osmajor'
	db	8,'_osminor'
	db	7,'_osmode'
	db	10,'_osversion'
	db	12,'_sys_errlist'
	db	9,'_sys_nerr'
	db	9,'_wenviron'
	db	13,'@std@atexit_t'
	db	10,'@std@div_t'
	db	11,'@std@ldiv_t'
$$BNAMES	ends
	?debug	D "D:\_Programs\Work\_Estimate_\project\_Shared\frmAbout\Unit_About.h" 12452 21522
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\DBCommon.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Bde.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\SMIntf.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\dbtables.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Mask.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Buttons.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\RichEdit.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\RichEdit.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ToolWin.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ComCtrls.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Db.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\dbctrls.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\extctrls.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\commdlg.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\CommDlg.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\StdCtrls.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\shellapi.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ShellAPI.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\regstr.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\RegStr.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\wininet.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\WinInet.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\objidl.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\oaidl.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\oleauto.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ActiveX.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\UrlMon.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ShlObj.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\dialogs.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\forms.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\multimon.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\MultiMon.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Contnrs.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Menus.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Imm.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\CommCtrl.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\Commctrl.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ImgList.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\ActnList.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\controls.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\graphics.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\classes.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\SysConst.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysutils.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\messages.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\dde.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\wincrypt.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\wintrust.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\SysInit.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\windows.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\unknwn.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysvari.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysopen.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\search.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\stdlib.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysdyn.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\systvar.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysset.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\syscomp.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\syscurr.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\systdate.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\systobj.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpcnsip.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpcndr.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpcnterr.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpcnsi.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpcdcep.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpcdce.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\rpc.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\wtypes.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\wstring.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysmac.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\dstring.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysclass.H" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\basetyps.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\prsht.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winspool.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\imm.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\mcx.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winsvc.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winnetwk.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winreg.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winver.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\wincon.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winnls.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\tvout.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winuser.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\pshpack1.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\wingdi.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winerror.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winbase.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\pshpack8.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\pshpack2.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\poppack.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\pshpack4.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\_loc.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\locale.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\_str.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\string.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\guiddef.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\basetsd.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\mbctype.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\ctype.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\winnt.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\windef.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\stdarg.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\excpt.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\_null.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\_defs.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\_stddef.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\mem.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\windows.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\sysmac.H" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\system.hpp" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\vcl0.h" 10303 10240
	?debug	D "C:\PROGRAM FILES\BORLAND\CBUILDER5\INCLUDE\VCL\VCL1.H" 10303 10240
	?debug	D "D:\_Programs\Work\_Estimate_\project\_Shared\frmAbout\Unit_About.cpp" 12580 21917
 ?debug  C FB062A633A5C50524F4752417E315C626F726C616E645C434255494C447E315C6C69625C76636C35302E23303199BE250001752931
 ?debug  C FB05062354466F726D
 ?debug  C FB0508232A5450616E656C
 ?debug  C FB0508232A544C6162656C
 ?debug  C FB0509232A54427574746F6E
 ?debug  C FB0508232A54496D616765
 ?debug  C FB0509232A544F626A656374
 ?debug  C FB050C232A54436F6D706F6E656E74
 ?debug  C FB050B23544D7367446C6742746E
 ?debug  C FB050E235F4D454D4F5259535441545553
 ?debug  C FB0507232A54466F726D
 ?debug  C FB050C232A416E7369537472696E67
 ?debug  C FB050B23416E7369537472696E67
 ?debug  C FB050B2354436F6D706F6E656E74
 ?debug  C FB050A232A494F6C65466F726D
 ?debug  C FB050A2326494F6C65466F726D
 ?debug  C FB050B232A2A494F6C65466F726D
 ?debug  C FB050B232A4944657369676E6572
 ?debug  C FB050B23264944657369676E6572
 ?debug  C FB050C232A2A4944657369676E6572
 ?debug  C FB050E232A49446F636B4D616E61676572
 ?debug  C FB050E232649446F636B4D616E61676572
 ?debug  C FB050F232A2A49446F636B4D616E61676572
 ?debug  C FB05072354436F6C6F72
 ?debug  C FB05092354436F6E74726F6C
 ?debug  C FB050C235457696E436F6E74726F6C
 ?debug  C FB050C23544D7367446C6754797065
 ?debug  C FB050C2354437573746F6D466F726D
 ?debug  C FB050F232A5F4D454D4F5259535441545553
 ?debug  C FB050C2326416E7369537472696E67
 ?debug  C FB05072354496D616765
 ?debug  C FB050823544269746D6170
 ?debug  C FB0509232A544269746D6170
 ?debug  C FB0509235450696374757265
 ?debug  C FB050D232A54437573746F6D466F726D
 ?debug  C FB050823544F626A656374
 ?debug  C FB050C232A544D657461436C617373
 ?debug  C FB050D232A5450657273697374656E74
 ?debug  C FB0508232A5446696C6572
 ?debug  C FB050C235450657273697374656E74
 ?debug  C FB050B23544F7065726174696F6E
 ?debug  C FB0509232A54526561646572
 ?debug  C FB0509232A54577269746572
 ?debug  C FB050723265F47554944
 ?debug  C FB05072354506F696E74
 ?debug  C FB0506235452656374
 ?debug  C FB0510232A5444726167496D6167654C697374
 ?debug  C FB050A2354447261674D6F6465
 ?debug  C FB050D232A5457696E436F6E74726F6C
 ?debug  C FB050A2354426944694D6F6465
 ?debug  C FB050A2326544D657373616765
 ?debug  C FB051523545363726F6C6C696E6757696E436F6E74726F6C
 ?debug  C FB050723265452656374
 ?debug  C FB050A232A54436F6E74726F6C
 ?debug  C FB050F232654437265617465506172616D73
 ?debug  C FB050D235457696E646F775374617465
	end
