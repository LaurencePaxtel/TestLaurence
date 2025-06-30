//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut  
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK; $B_Dummy)

MESSAGES OFF:C175

READ ONLY:C145(*)
READ WRITE:C146([StockBis:122])

HIDE TOOL BAR:C434

Update
appelerapropos("A propos de Paxtel..."; "PAXTEL"; <>T_VersionDB__C)

Init_constantes
DebutDécProces  // Initialisation des variable process

i_Environnement

DebutDécVar  // Initialisation des variable super globales
DebutDécGroupes
DebutDécUser
DebutDecDépart(0)
DebutDecDépart(-21)
DebutDecAge(0)

DebutDecVarParamRepAuto
DebutDecVarParamRepAuto2

//Fenêtre de menus
$B_Dummy:=i_Paramnum(-3)
$B_Dummy:=i_Paramnum(0)

<>vl_FenPP:=Frontmost window:C447

i_PPrincipalHide
i_Version

DébutDécTable  // Initialisation des tableaux super globales
DébutDécTableCritèreVeille(0)

// Modifié par : Scanu Rémy (20/12/2021)
outilsManageStorage("structure")
outilsManageStorage("image")

// Déclations Pour la mire
Go_MireDébut  // Mire de départ

For ($ii; 1; 10)
	Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Ouverture …"+String:C10($ii))
End for 

Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Accès aux tables...")

DébutAccèsTable
DébutAccèsTableSuite

Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Accès aux champs...")


If (Is compiled mode:C492)
	i_PPrincipalHide
End if 

<>vb_UtDirect:=True:C214

For ($ii; 1; 10)
	Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Lancement ..."+String:C10(10-$ii))
End for 

Process_Ordre(<>PR_Mire; -><>vt_AProposMes; "Quitter"; -><>vt_APropos; "")
$vb_OK:=Debut_Connexion

Debut_DecVarChampAttribut
DébutInitTable