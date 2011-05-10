include global_ns_reg_macro2.asm

global_space_ext2: ; �������, ����������� ������� �������� ���������� �������
	; ����� ������ ��, ��� ��������
	call    register__gs_sell_condition__fl_fl
	pop     ecx
	pop     ecx
	; ��������� ���� ���
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT SetGameTime, "set_game_time"
	; ��� �������
	jmp back_from_global_space_ext2
;

global_space_ext2_additional:
	; ����� ������ ��, ��� ��������
	GLOBAL_NS_SCOPE_ADD
	GLOBAL_NS_SCOPE_ADD
	; ��������� ���� ���
	GLOBAL_NS_SCOPE_ADD
	; ��� �������
	jmp back_from_global_space_ext2_additional



SetGameTime proc
time        = dword ptr 8
time_factor = dword ptr 0Ch
	push    ebp
	mov     ebp, esp
	and     esp, 0FFFFFFF8h
	push    eax
	push    ecx
	
	mov     ecx, ds:g_pGamePersistent
	mov     ecx, [ecx]
	mov     ecx, [ecx+46Ch] ; _DWORD
	
	mov     eax, [ebp+time]
	push    eax
	mov     eax, [ebp+time_factor]
	push    eax
	call    ds:CEnvironment__SetGameTime
	
	pop     ecx
	pop     eax
	mov     esp, ebp
	pop     ebp
	retn
SetGameTime endp
