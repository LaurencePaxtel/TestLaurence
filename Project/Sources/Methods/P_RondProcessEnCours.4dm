//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : P_RondProcessEnCours
//{          Mercredi 23 mai 2012 à 14:00:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

Case of 
	: ($1="ReportAuto")
		If (<>vl_TypeApplication=4D mode distant:K5:5)
			If (Process number:C372("ReporAutoServeur"; *)=0)
				OBJECT SET VISIBLE:C603(*; "ReportAuto"; False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*; "ReportAuto"; True:C214)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*; "ReportAuto"; (<>PR_ReportLocal#0))
		End if 
		
	: ($1="TransfertDistant")
		OBJECT SET VISIBLE:C603(*; "TransfertDistantOUI"; <>vb_ConsoTransfert)
		If (<>vl_TypeApplication=4D mode distant:K5:5)
			If (Process number:C372("ConsoTransServeur"; *)=0)
				OBJECT SET VISIBLE:C603(*; "TransfertDistant"; False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*; "TransfertDistant"; True:C214)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*; "TransfertDistant"; (<>PR_ConsoTransfertAuto#0))
		End if 
End case 