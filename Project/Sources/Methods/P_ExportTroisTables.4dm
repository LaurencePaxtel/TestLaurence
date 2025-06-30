//%attributes = {}
C_TIME:C306($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)

C_LONGINT:C283($ii)

SEND PACKET:C103($1; $2+<>va_CR+<>va_CR)

For ($ii; 1; Size of array:C274($4->))
	
	// Modifié par : Scanu Rémy (10/10/2023)
	If ($4->{$ii}>0) & ($5->{$ii}>0)
		SEND PACKET:C103($1; $3->{$ii}+<>va_TAB+String:C10($4->{$ii})+<>va_TAB+String:C10($5->{$ii})+<>va_CR)
	End if 
	
End for 

SEND PACKET:C103($1; <>va_CR)