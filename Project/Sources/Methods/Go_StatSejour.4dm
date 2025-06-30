//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/04/23, 17:54:12
// ----------------------------------------------------
// Méthode : Go_StatSejour
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305(vb_Show)

SET MENU BAR:C67(1)

vb_Show:=False:C215

F_PassagesGlobal(1; 0)
<>PR_StatSejour:=0

If (vb_Show)
	Général_Show
End if 