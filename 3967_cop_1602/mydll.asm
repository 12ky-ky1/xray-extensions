.686
.XMM

.model flat,  C

include addr.inc

_code segment byte public 'CODE' use32
	assume cs:_code
	assume ds:_data
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

; ������� �� ������� ����
include xrgame_stubs.asm

; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

;===============| ���������� ����������� ����������� ������������ ��� |=======
global_space_ext: ; �������, ����������� ������� �������� ���������� �������
	; ����� ������ ��, ��� ��������
	call    error_log_register
	; ��������� ���� ���
	; ����������� ������� ������ � ���, ������ ��������� "log"
    push    offset my_log_fun
    push    offset alog1 ; "log1"
    push    esi
    call    error_log_register
	add     esp, 0Ch
	; ����������� ������� "flush1", ������ ��������� "flush"
     lea     eax, [ebp-1]
     push    eax
     push    offset my_flush
     push    offset aFlush1   ; "flush1"
     push    esi
     call    flush_register
	; ����������� ������� "flush1", ������ ��������� "flush"
     lea     eax, [ebp-1]
     push    eax
     push    offset my_log2
     push    offset alog2   ; "log2"
     push    esi
     call    flush_register
	; ��� �������
	jmp back_to_global_space_ext

alog1   db "log1", 0
alog2   db "log2", 0
aFlush1 db "flush1", 0

my_flush proc near
	push    edi
	mov     eax, offset FlushLog
	mov     edi, [eax]
	call    edi
	pop     edi
	retn
my_flush endp

my_log2 proc near
	push    edi

	sub   esp, 8
	fld     [value1]
	fstp   QWORD  ptr [esp]
	push    offset format_str
	mov eax, offset Msg
	mov edi, [eax]
	call    edi ; Msg(char const *,...)
	add     esp, 0Ch

	pop     edi
	retn
my_log2 endp

; 1.912553e-315
; 1.755758e-314
format_str db "qwerty %e", 0
value1 REAL4  1.23456e12
value2   dd 12345678h

my_log_fun      proc near
	push    ebp
	mov     ebp, esp
	push    edi
	mov     eax, [ebp+8]
	push    eax
	push    offset aS_4     ; "%s"
	mov eax, offset Msg
	mov edi, [eax]
	call    edi ; Msg(char const *,...)
	add     esp, 8
	pop     edi
	pop     ebp
	retn
my_log_fun      endp

;===============| ���������� ����������� ������������ ��� level |=============
level_ns_extension_1:
	call    get_snd_volume_register ; ������ ��, ��� ��������
;------------< ������������ ������� ��������� ���������� �� �������, �� ������� ������� >------
	pop     ecx
	pop     ecx
	mov     eax, esp
	push    offset GetTargetDistance
	push    offset aGet_target_dist ; "get_target_dist"
	push    eax
	call    get_snd_volume_register ; ������������ ������� � ���������� ��� �   get_snd_volume
;--------------------------------------
	pop     ecx
	pop     ecx
	mov     eax, esp
	push    offset GetTargetObject
	push    offset aGet_target_obj ; "get_target_obj"
	push    eax
	call    object_by_id_register ; ������������ ������� � ���������� ��� �   object_by_id
;--------------------------------------
	jmp back_to_level_ns_ext_1
	
aGet_target_dist db "get_target_dist", 0
aGet_target_obj  db "get_target_obj", 0

level_ns_extension_2: ; ����� ���� ��������� ������� ���   "mov ecx, eax" + "call esi", ������� ��������� �������
; ������ ��, ��� ��������
	mov     ecx, eax
	call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
	mov     ecx, eax
	call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
; ��������� ���
	; ��� get_target_dist
	mov     ecx, eax
	call    esi 
	; ��� get_target_obj
	mov     ecx, eax
	call    esi 
; ��� �������
	jmp back_to_level_ns_ext_2


GetTargetDistance:
	mov     eax, [g_hud] ; CCustomHUD * g_hud
	mov     ecx, [eax]
	call    CCustomHUD__GetRQ ; eax = RQ
	fld     dword ptr [eax+4] ; return EQ.range
	retn
	
GetTargetObject:
	mov     eax, [g_hud] ; CCustomHUD * g_hud
	mov     ecx, [eax]
	call    CCustomHUD__GetRQ ; eax = RQ
	push    dword ptr [eax] ; RQ.O
	call    smart_cast_CGameObject ; eax = smart_cast<CGameObject*>
	pop     ecx
	test    eax, eax ; ���� ������ �� �����
	jnz     return_value
	xor     eax, eax ; �� ���������� nil
	retn
return_value: ; ����� - ������������ � game_object
	mov     ecx, eax ; this = <��������� CGameObject>
	jmp     CGameObject__lua_game_object

; ���������� ����������� CUIStatic
CUIStatic_extention_1:
	xor     eax, eax
	push    eax
	mov     eax, offset CUIStatic__SetTextureRect
	push    eax
	push    offset aSettexturerect ; "SetTextureRect"
; ��������� ��� ���� �����
	xor     eax, eax
	push    eax
	mov     eax, offset CUIStatic__SetHeading
	push    eax
	push    offset aSetHeading ; "SetHeading"

; ---------------------------
	jmp     back_to_CUIStatic_ext_1;


CUIStatic_extention_2:
; ��� �����������
	mov     ecx, eax
	call    SetTextureRect_register    ; SetTextureRect_register
; ��� ������������
	mov     ecx, eax
	call    SetTextureRect_register    ; SetTextureRect
; ---------------------------
	jmp     back_to_CUIStatic_ext_2;

CUIStatic__SetHeading:	
arg_0           = dword ptr  4
	mov     eax, dword ptr [esp+arg_0]
	mov     eax, dword ptr [eax]
	mov     byte ptr [ecx+0C8h], 1
	mov     byte ptr [ecx+0C9h], 1
	mov     dword ptr [ecx+0CCh], eax
	retn    4
	
	
aF_4 db "%f", 0
aS_4 db "%s", 0
aSettexturerect db "SetTextureRect", 0
aSetHeading db "SetHeading", 0

include actor_hit_callback.asm
include console_fix.asm
include pda_fix.asm
include car_fix.asm


;=================================================

log_str:
	;push edi
	push    eax
	push    offset aS_4     ; "%s"
	mov eax, offset Msg
	mov edi, [eax]
	call    edi ; Msg(char const *,...)
	add     esp, 8
	;pop edi
	retn
	
_code ENDS

end LibMain

