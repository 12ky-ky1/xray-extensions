;===============| ���������� ����������� ������������ ��� level |=============
level_ns_extension_1 proc
	call    get_snd_volume_register ; ������ ��, ��� ��������
	add     esp, 08h
	;jmp back_to_level_ns_ext_1
;------------< ������������ ������� ��������� ���������� �� �������, �� ������� ������� >------
	;pop     ecx
	;pop     ecx
	mov     eax, esp
	push    offset GetTargetDistance
	push    offset aGet_target_dist ; "get_target_dist"
	push    eax
	call    get_snd_volume_register ; ������������ ������� � ���������� ��� �   get_snd_volume
	add     esp, 08h
;--------------------------------------
	;jmp skip
;------------< ������������ ������� ��������� ������� ���������� ������ >------
	mov     eax, esp
	push    ecx
	push    offset set_ph_time_factor
	push    offset aSet_ph_time_factor ; "set_ph_time_factor"
	push    eax
	call    register_set_snd_volume
	add     esp, 0Ch
;------------< ������������ ������� ��������� ������� ���������� ������ >------
	mov     eax, esp
	push    offset get_ph_time_factor
	push    offset aGet_ph_time_factor ; "get_ph_time_factor"
	push    eax
	call    get_snd_volume_register ; ������������ ������� � ���������� ��� �   get_snd_volume
	add     esp, 08h
;------------< ������������ ������� ��������� FOV >------
	mov     eax, esp
	push    ecx
	push    offset SetFOV
	push    offset aSet_fov ; "set_fov"
	push    eax
	call    register_set_snd_volume
	add     esp, 0Ch
;------------< ������������ ������� ��������� FOV >------
	mov     eax, esp
	push    offset GetFOV
	push    offset aGet_fov ; "get_fov"
	push    eax
	call    get_snd_volume_register ; ������������ ������� � ���������� ��� �   get_snd_volume
	add     esp, 08h
	
skip:
	
level_ns_extension_1 endp

;-------------------------------------------------
	;pop     ecx
	;pop     ecx
	;mov     eax, esp
	;push    offset GetTargetObject
	;push    offset aGet_target_obj ; "get_target_obj"
	;push    eax
	;call    object_by_id_register ; ������������ ������� � ���������� ��� �   object_by_id
;--------------------------------------
	jmp back_to_level_ns_ext_1
	
aGet_target_dist db "get_target_dist", 0
;aGet_target_obj  db "get_target_obj", 0
aSet_ph_time_factor db "set_ph_time_factor", 0
aGet_ph_time_factor db "get_ph_time_factor", 0
aGet_fov db "get_fov", 0
aSet_fov db "set_fov", 0

level_ns_extension_2 proc
 ; ����� ���� ��������� ������� ���   "mov ecx, eax" + "call esi", ������� ��������� �������
; ������ ��, ��� ��������
	mov     ecx, eax
	call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
	mov     ecx, eax
	call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
; ��������� ���
	; ��� get_target_dist
	mov     ecx, eax
	call    esi 
	;jmp skip
	; ��� set_ph_time_factor
	mov     ecx, eax
	call    esi 
	; ��� get_ph_time_factor
	mov     ecx, eax
	call    esi 
	; ��� set_fov
	mov     ecx, eax
	call    esi 
	; ��� get_fov
	mov     ecx, eax
	call    esi 
skip:
	; ��� get_target_obj
	;mov     ecx, eax
	;call    esi 
; ��� �������
	jmp back_to_level_ns_ext_2
level_ns_extension_2 endp

GetTargetDistance proc
	mov     eax, [g_hud] ; CCustomHUD * g_hud
	mov     ecx, [eax]
	call    CCustomHUD__GetRQ ; eax = RQ
	fld     dword ptr [eax+4] ; return EQ.range
	retn
GetTargetDistance endp
	
GetTargetObject_old proc
	mov     eax, [g_hud] ; CCustomHUD * g_hud
	mov     ecx, [eax]
	call    CCustomHUD__GetRQ ; eax = RQ
	;--
	mov     eax, [eax] ; RQ.O
	;--
	;push    dword ptr [eax] ; RQ.O
	;call    smart_cast_CGameObject ; eax = smart_cast<CGameObject*>
	;pop     ecx
	test    eax, eax ; ���� ������ �� �����
	jnz     return_value
	xor     eax, eax ; �� ���������� nil
	retn
return_value: ; ����� - ������������ � game_object
	mov     ecx, eax ; this = <��������� CGameObject>
	jmp     CGameObject__lua_game_object
GetTargetObject_old endp

GetHUD proc
	mov     eax, [g_pGameLevel] ; eax = level object
	mov     eax, [eax+40104h] ; eax = phud
	retn
GetHUD endp

CCustomHUD__GetRQ proc
	mov     eax, [ecx+74h]
	add     eax, 8
	retn
CCustomHUD__GetRQ endp	
	
set_ph_time_factor proc
arg_0           = dword ptr  4
	mov     eax, [esp+arg_0]
	mov     [phTimefactor], eax
	retn
set_ph_time_factor endp

get_ph_time_factor proc
	mov     eax, ds:phTimefactor
	fld     dword ptr [eax]
	retn
get_ph_time_factor endp

GetFOV proc
	fld     dword ptr [g_fov]
	retn
GetFOV endp

SetFOV proc
arg_0           = dword ptr  4
	mov     eax, [esp+arg_0]
	mov     [g_fov], eax
	retn
SetFOV endp
