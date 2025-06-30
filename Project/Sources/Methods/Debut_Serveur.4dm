//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Debut_Serveur
//{
//{          Lundi 19 janvier 2003 à 11:47
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{=================================================
C_LONGINT:C283($refFen_el)

C_OBJECT:C1216(<>webApp_o)

Compiler_Arrays_Inter
Compiler_Variables_Inter

MultiSoc_Check
MultiSoc_Init_On_Server

Init_constantes  // BS 160516
Update

DebutDécProces  // Initialise à 0 plein d'interprocess
i_Environnement  // Init IP

// Modifié par : Scanu Rémy (29/12/2022)
$refFen_el:=Open window:C153(50; 50; 500; 250; 5; "Opération en cours")

DebutDécVar
DebutDécGroupes
DebutDecAge(0)
DebutDecVarParamRepAuto
DébutDécTable  // Initialisation des tableaux super globales

// Modifié par : Scanu Rémy (25/01/2023)
// !Important! C'est ici qu'on va gérer toutes les énumérations du logiciel
Debut_DecVarChampAttribut
DebutDecVarParamRepAuto

// Modified by: Kevin HASSAL (30-12-2018)
// Création de la méthode de lancement des reports auto côté serveur
// Pour la prise en compte de la gestion multi-sociétés

$stateProcess_o:=New process:C317("SER_GO_ReportsAuto"; 0; "SER_GO_ReportsAuto"; *)

DebutDecVarParamConso115
DébutInitConso115(4)

If (<>vb_Conso115Auto)
	<>PR_ConsoServeur:=New process:C317("Go_ConsoParProcess"; 0; "ConsoAutoServeur"; True:C214; <>ref_soc_active; *)
End if 

P_Conso_Transfert("DeclarerParam")

DebutDecVarConsoTransfert
DebutInitConsoTranfert(0)

If (<>vb_ConsoTransfert)
	<>PR_ConsoTransfertAuto:=New process:C317("Go_uConsoTransfertS"; 0; "ConsoTransServeur"; True:C214; <>ref_soc_active; *)
End if 

<>PR_PLA_Recurring_Tasks:=New process:C317("Web_PLA_Recurring_Tasks"; 0; "Planning web : tâches récurrentes")

// Modifié par : Scanu Rémy (29/12/2022)
CLOSE WINDOW:C154($refFen_el)

// *************************************************
// *****  Ajout composant cioWeb & cioMarketingAutomation *****
// *************************************************
<>webApp_o:=cwToolGetClass("webApp").new("WebApp")
cwEMailConfigLoad

cwMarketingAutomationStart(True:C214)
WEB SET ROOT FOLDER:C634(Get 4D folder:C485(Dossier base:K5:14)+"DossierWeb"+Séparateur dossier:K24:12)