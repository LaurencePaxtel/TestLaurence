//%attributes = {}
//{==================================================}
//{ LOGICIEL : Route Postale
//{ © DBsolutions
//{
//{          Procédure : Go_MireDébutV  
//{
//{          Vendredi 10 Janvier 1997 à 12:27:59
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($L_W)

SET MENU BAR:C67(1)  // #IMG2017-1

// Modifié par : Scanu Rémy (20/10/2022)
<>vt_AProposMes:=""
<>vt_AProposMesMes:=""

<>vt_APropos:=""

//<>PR_Mire:=0

$L_W:=Open form window:C675([DiaLogues:3]; "DL_Mire"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; Centrée verticalement:K39:4)
DIALOG:C40([DiaLogues:3]; "DL_Mire")

CLOSE WINDOW:C154($L_W)