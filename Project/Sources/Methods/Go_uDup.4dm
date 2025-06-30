//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uDup_Nv
//{
//{          Vendredi 23 avril 2004 à 09:38:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($L_W)

C_BOOLEAN:C305(vb_Show)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=False:C215

Case of 
	: (User in group:C338(Current user:C182; <>Groupe_Externe))
		<>vlSTR_Std:=<>vlSTR_HGE
	: (User in group:C338(Current user:C182; <>Groupe_Asile))
		<>vlSTR_Std:=30108
	Else 
		<>vlSTR_Std:=<>vlSTR_HG1
End case 

<>vlSTR_Std_Soc:=(<>vlSTR_Std*1000)+<>ID_Societe_Active

$L_W:=Open form window:C675("Dupliquer_Hebergement"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4; *)
SET WINDOW TITLE:C213("Paramétrage des champs hébergement à dupliquer")

DIALOG:C40("Dupliquer_Hebergement"; New object:C1471)
CLOSE WINDOW:C154($L_W)

<>PR_DupChamp:=0

If (vb_Show)
	Général_Show
End if 