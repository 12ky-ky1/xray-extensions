CInventory__CInventory_fix proc
	xor     eax, eax
	mov     [esi+60h], eax ; �������� m_pOwner
	
	; ������ ��, ��� ��������
	mov     eax, esi
	pop     ebx
	add     esp, 110h
	retn
CInventory__CInventory_fix endp

CInventory__Take_fix proc
	; ������ ��, ��� ��������
	mov     ecx, [ebx+60h]
	cmp     ecx, ecx
	jz      skip
	mov     eax, [ecx]
	mov     edx, [eax+0B4h]
	push    ebp
	call    edx
skip:
	; ��� �������
	jmp back_from_CInventory__Take_fix
CInventory__Take_fix endp

CInventory__Ruck_fix proc
	; ������ ��, ��� ��������
	mov     ecx, [esi+60h]
	cmp     ecx, ecx ; 
	jz      skip
	mov     eax, [ebp+98h]
	mov     edx, [ecx]
	mov     edx, [edx+0BCh]
	push    eax
	push    ebp
	call    edx
skip:
	; ��� �������
	jmp back_from_CInventory__Ruck_fix
CInventory__Ruck_fix endp

CInventory__DropItem_fix proc
	; ������ ��, ��� ��������
	mov     ecx, [esi+60h]
	cmp     ecx, ecx ; 
	jz      skip
	mov     edx, [ecx]
	push    eax
	mov     eax, [edx+0C4h]
	call    eax
skip:
	; ��� �������
	jmp back_from_CInventory__DropItem_fix
CInventory__DropItem_fix endp
