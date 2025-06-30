//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_MaraudeEtude
//{
//{          Mardi 10 mai 2005 à 14:13:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TIME:C306($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_LONGINT:C283($ii)

If (<>vb_CestUnMac)
	SEND PACKET:C103($1; $2+Char:C90(13)+Char:C90(13))
Else 
	SEND PACKET:C103($1; _O_Mac to Win:C463($2+Char:C90(13)+Char:C90(13)))
End if 

For ($ii; 1; Size of array:C274($4->))
	If (<>vb_CestUnMac)
		SEND PACKET:C103($1; $3->{$ii}+Char:C90(9)+String:C10($4->{$ii})+Char:C90(9)+String:C10($5->{$ii})+Char:C90(13))
	Else 
		SEND PACKET:C103($1; _O_Mac to Win:C463($3->{$ii}+Char:C90(9)+String:C10($4->{$ii})+Char:C90(9)+String:C10($5->{$ii})+Char:C90(13)))
	End if 
End for 

If (<>vb_CestUnMac)
	SEND PACKET:C103($1; Char:C90(13))
Else 
	SEND PACKET:C103($1; _O_Mac to Win:C463(Char:C90(13)))
End if 