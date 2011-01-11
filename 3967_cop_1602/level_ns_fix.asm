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
