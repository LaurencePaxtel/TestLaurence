//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : i_NonVerrou
//{
//{          Samedi 4 Novembre 1995 17:11
//{          Modifiée :
//{          Développement : Philippe GUEDJ
//{==================================================}

//Test une fiche verrouillée avec confirmation de l'utilisateur
//Le paramètre envoyé est un pointeur sur le fichier
//Le paramètre renvoyé est un booléen à vrai si la fiche n'est pas verrouillée

// C_TIME($h)
C_POINTER:C301($1)
C_BOOLEAN:C305($0)

$0:=False:C215
Ok:=0

C_LONGINT:C283($vl_Process)
C_TEXT:C284($va_User; $va_Mac; $va_Process)
Repeat 
	LOAD RECORD:C52($1->)
	LOCKED BY:C353($1->; $vl_Process; $va_User; $va_Mac; $va_Process)
	If (Locked:C147($1->))
		CONFIRM:C162("Fiche occupée par "+$va_User+" patienter ?")
		If (Ok=1)
			LOAD RECORD:C52($1->)
		End if 
	End if 
Until ((Not:C34(Locked:C147($1->))) | (Ok=0))

If (Not:C34(Locked:C147($1->)))
	$0:=True:C214
End if 