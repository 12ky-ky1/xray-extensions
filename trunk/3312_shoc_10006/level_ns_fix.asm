;===============| ���������� ����������� ������������ ��� level |=============
level_ns_extension_1:
	call    get_snd_volume_register ; ������ ��, ��� ��������
;------------< ������������ ������� ��������� �������, �� ������� ������� >------
	push    eax
	call    get_target_obj_register
	pop     ecx
;------------< ������������ ������� ��������� ���������� �� �������, �� ������� ������� >------
	pop     ecx
	pop     ecx
	mov     eax, esp
	push    offset GetTargetDistance
	push    offset aGet_target_dist ; "get_target_dist"
	push    eax
	call    get_snd_volume_register ; ������������ ������� � ���������� ��� �   get_snd_volume
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
	; ��� get_target_obj �� ��������� ?
;	mov     ecx, eax
;	call    esi
	; ��� get_target_dist
	mov     ecx, eax
	call    esi
; ��� �������
	jmp back_to_level_ns_ext_2

CCustomHUD__GetRQ proc
	mov     eax, [ecx+34h]
	add     eax, 0Ch
	retn
CCustomHUD__GetRQ endp	

GetTargetDistance proc
	mov     eax, [g_hud] ; CCustomHUD * g_hud
	mov     ecx, [eax]
	call    CCustomHUD__GetRQ ; eax = RQ
	fld     dword ptr [eax+4] ; return EQ.range
	retn
GetTargetDistance endp

smart_cast_CGameObject proc
arg_0           = dword ptr  4
	mov     eax, [esp+arg_0]
	retn
smart_cast_CGameObject endp

GetTargetObject proc
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
return_value:
	push    edi
	mov     edi, eax
	call    CGameObject__lua_game_object
	pop     edi
	retn
GetTargetObject endp

get_target_obj_register proc
var_8           = dword ptr -8
var_4           = byte ptr -4
arg_0           = dword ptr  8
	push    ebp
	mov     ebp, esp
	push    ecx
	push    ecx
	mov     ecx, ds:?Memory@@3VxrMemory@@A ; xrMemory Memory
	push    esi
	push    14h
	call    ds:?mem_alloc@xrMemory@@QAEPAXI@Z ; xrMemory::mem_alloc(uint)
	mov     esi, eax
	test    esi, esi
	jz      loc_101AF65F
	mov     ecx, esi
	call    ds:??0registration@detail@luabind@@QAE@XZ ; luabind::detail::registration::registration(void)
	mov     dword ptr [esi], offset off_10481E80
	mov     dword ptr [esi+8], offset aGet_target_obj ; "get_target_obj"
	mov     dword ptr [esi+0Ch], offset GetTargetObject
	jmp     loc_101AF661
get_target_obj_register endp
