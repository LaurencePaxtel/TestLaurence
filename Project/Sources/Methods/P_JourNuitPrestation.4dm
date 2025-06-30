//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_JourNuitPrestation
//{          Vendrdi 26 novembre 2004 à 15:13:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)

Case of 
	: ($1="rJourNuit2")
		
		If (<>vb_T_ModeCHRS=True:C214)
			OBJECT SET TITLE:C194(rJourNuit2; "Prestation")
		Else 
			OBJECT SET TITLE:C194(rJourNuit2; "Nuit")
		End if 
		
End case 