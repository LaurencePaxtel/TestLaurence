C_BOOLEAN:C305($vb_OK)

$vb_OK:=([HeberGement:5]HG_NuitenCours:92>1)
$vb_OK:=$vb_OK & ([HeberGement:5]HG_Reporté:94="")
$vb_OK:=$vb_OK & ([HeberGement:5]HG_Date:4>=Current date:C33(*))

If ($vb_OK)
	
	If (i_Confirmer("Confirmez-vous le renouvellement d'hébergement de la personne ?"))
		[HeberGement:5]HG_Réservation:91:=True:C214
		[HeberGement:5]HG_NuitenCours:92:=2
		[HeberGement:5]HG_NuitTOTAL:93:=2
		[HeberGement:5]HG_NuitReste:95:=0
		
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
		[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
		
		GOTO OBJECT:C206([HeberGement:5]HG_NuitTOTAL:93)
	End if 
	
Else 
	ALERT:C41("Vous ne pouvez pas renouveller à partir de cette fiche d'hébergement !"+<>va_CR+<>va_CR+"Ce doit être la fiche du jour en cours issue du report.")
End if 