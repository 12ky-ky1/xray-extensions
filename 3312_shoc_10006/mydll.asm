.686
.XMM

.model flat,  C

include addr.inc

_code segment public 'CODE' use32
	assume cs:_code
	assume ds:_code
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

; ������� �� ������� ����
include xrgame_stubs.asm

ALIGN_8 MACRO
	;ALIGN 8
ENDM



; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include actor_input_fix.asm
include global_ns_fix.asm
include game_object_fix.asm

_code ENDS

end LibMain

