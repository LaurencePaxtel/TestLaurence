//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_Debut_Suite
//{
//{          Vendrdi 9 janvier 2009 à 15:44:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
Process_Go(-><>PR_Genéral; "Go_Général"; "LaPaletteGénérale"; 0)

// Modifié par : Scanu Rémy (20/10/2022)
If (User in group:C338(Current user:C182; <>Groupe_Appel)) & (Process number:C372("Appel")=0)
	Process_Go(-><>PR_Appel; "Go_Appel"; "Appel"; 0)
Else 
	Process_Show(<>PR_Appel)
End if 

If (<>vl_TypeApplication=4D mode distant:K5:5)
	
	If (<>vb_UserMessagerie) & (Process number:C372("Sortants")=0)
		Process_Go(-><>PR_Sortants; "Go_HébergementSortants"; "Sortants"; 0)
	Else 
		Process_Show(<>PR_Sortants)
	End if 
	
	// Added by: Kevin HASSAL (09/03/2020)
	If (Process number:C372("Dossiers en cours")=0)
		Process_Go(-><>PR_Dossiers_Encours_Liste; "Go_Dossiers_Encours_Not"; "Dossiers en cours"; 0)
	Else 
		Process_Show(<>PR_Dossiers_Encours_Liste)
	End if 
	
Else 
	DébutInitReportAuto(4; Storage:C1525.societeDetail.Ref_Structure)
	
	If (vb_ReportAuto)
		
		If (<>PR_ReportLocal=0) & (Process number:C372("ReporAutoLocal")=0)
			<>PR_ReportLocal:=New process:C317("Go_ReportParProcess"; 0; "ReporAutoLocal"; False:C215; <>ref_soc_active)  // #20170623-1
		Else 
			Process_Show(<>PR_ReportLocal)
		End if 
		
	End if 
	
End if 