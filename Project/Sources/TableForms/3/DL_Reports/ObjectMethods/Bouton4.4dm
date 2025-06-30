//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Script b_RpReRat 
//{
//{          Vendredi 1 août 2008 à 10:19:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)

If (Form event code:C388=Sur clic:K2:4)
	$vb_OK:=Accès_Groupe(<>Groupe_DEVELOP; "Rattrapage")
	
	If ($vb_OK)
		
		If (vb_ReportAuto)
			$vb_OK:=i_Confirmer("Report automatique programmé !"+Char:C90(Retour chariot:K15:38)+"Voulez-vous continuer ?")
		Else 
			$vb_OK:=True:C214
		End if 
		
	End if 
	
	If ($vb_OK)
		$vb_OK:=F_Report_ParRattrapage2
	End if 
	
End if 