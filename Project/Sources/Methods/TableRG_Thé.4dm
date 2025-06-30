//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableRG_Thé
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
Case of 
	: ($1=1)
		<>ta_AdUtil:=$2
		GIP_PopUpRG(<>Va_AdUtil; <>ta_AdUtil; -><>ta_AdUtil; -><>ta_AdUtilCd)
		<>va_PrestBis:=<>va_PrestNom
	: ($1=2)
		Process_Go(-><>PR_AS; "Go_AssocRG"; "Assocs"; 64)
	: ($1=3)
		<>ta_DemP:=$2
		GIP_PopUpRG(<>Va_DemP; <>ta_DemP; -><>ta_DemP; -><>ta_DemPCd)
		<>va_PrestBis:=<>va_PrestNom
	: ($1=4)
		<>ta_SitPar:=$2
		GIP_PopUpRG(<>Va_SitPar; <>ta_SitPar; -><>ta_SitPar; -><>ta_SitParCd)
		<>va_PrestBis:=<>va_PrestNom
End case 