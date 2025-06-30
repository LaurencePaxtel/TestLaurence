//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Script b_RpRep  
//{
//{          Vendredi 28 Février 1997 à 12:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur clic:K2:4)
	If (vb_ReportAuto)
		ALERT:C41("Report automatique programmé !")
	Else 
		If (<>vb_AvecProlongation)
			P_Report_ManuelPR
		Else 
			P_Report_Manuel
		End if 
	End if 
End if 