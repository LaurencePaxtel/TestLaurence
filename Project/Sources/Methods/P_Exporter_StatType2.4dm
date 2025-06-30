//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_StatType2
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TIME:C306($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)
C_TEXT:C284($8)
i_MessageSeul("Export en cours  :  "+$8)
$3->:=Size of array:C274($2->)
If (($3->)>0)
	If (<>vb_CestUnMac)
		SEND PACKET:C103($1; $8+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR)
	Else 
		SEND PACKET:C103($1; _O_Mac to Win:C463($8+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR))
	End if 
	C_LONGINT:C283($ii)
	For ($ii; 1; ($3->))
		If (<>vb_CestUnMac)
			SEND PACKET:C103($1; $2->{$ii}+<>va_TAB+String:C10($6->{$ii})+<>va_TAB+String:C10($7->{$ii})+<>va_CR)
		Else 
			SEND PACKET:C103($1; _O_Mac to Win:C463($2->{$ii}+<>va_TAB+String:C10($6->{$ii})+<>va_TAB+String:C10($7->{$ii})+<>va_CR))
		End if 
	End for 
	If (<>vb_CestUnMac)
		SEND PACKET:C103($1; "TOTAL "+$8+<>va_TAB+String:C10($4->)+<>va_TAB+String:C10($5->)+<>va_CR)
	Else 
		SEND PACKET:C103($1; _O_Mac to Win:C463(<>va_CR))
	End if 
End if 
If (<>vb_CestUnMac)
	SEND PACKET:C103($1; <>va_CR)
Else 
	SEND PACKET:C103($1; _O_Mac to Win:C463(<>va_CR))
End if 