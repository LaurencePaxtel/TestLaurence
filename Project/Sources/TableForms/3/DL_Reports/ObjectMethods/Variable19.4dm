//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Script b_RpRepA
//{
//{          Vendredi 28 Février 1997 à 12:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur clic:K2:4)
	
	If (vb_ReportAuto)
		ALERT:C41("Report automatique programmé !")
	Else 
		
		If (i_Confirmer("Pendant le report veuillez auparavant vous assurer que personne n'est connecté !"))
			
			If (<>vb_AvecProlongation)
				P_Report_AutoPR
			Else 
				P_Report_Auto
			End if 
			
		End if 
		
	End if 
	
End if 