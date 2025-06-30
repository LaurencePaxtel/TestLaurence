//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Méthode :  F_Report_ParRattrapage 
//{          Vendredi 9 juillet 2010 à 12:20:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($vb_OK)


If (Form event code:C388=Sur clic:K2:4)
	//•••LES AUTORISATIONS
	$vb_OK:=Accès_Groupe(<>Groupe_DEVELOP)
	If ($vb_OK)
		If (Records in selection:C76([HeberGement:5])>0)
			$vb_OK:=F_Report_Doublons
		Else 
			ALERT:C41("Aucune fiche !")
		End if 
	End if 
End if 