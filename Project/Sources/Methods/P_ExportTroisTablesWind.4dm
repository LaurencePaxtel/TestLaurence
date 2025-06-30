//%attributes = {}
C_TIME:C306($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)


For ($ii; 1; Size of array:C274($4->))
	If (<>vb_CestUnMac)
		SEND PACKET:C103($1; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+$2+Char:C90(34)+va_Virgule+Char:C90(34)+$3->{$ii}+Char:C90(34)+va_Virgule+String:C10($4->{$ii})+va_Virgule+String:C10($5->{$ii})+<>va_CR)
	Else 
		SEND PACKET:C103($1; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($3->{$ii})+Char:C90(34)+va_Virgule+_O_Mac to Win:C463(String:C10($4->{$ii}))+va_Virgule+_O_Mac to Win:C463(String:C10($5->{$ii})+<>va_CR))
	End if 
End for 