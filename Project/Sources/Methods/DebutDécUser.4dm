//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/07/23, 16:10:23
// ----------------------------------------------------
// Méthode : DebutDécUser
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283(<>vl_UserRéfU)
C_TEXT:C284(<>va_User)
C_TEXT:C284(<>va_UserCourant)
C_LONGINT:C283(<>vl_UserLogRéfU)

C_TEXT:C284(<>va_ProfUser)
C_BOOLEAN:C305(<>vb_UserLOFT)
C_BOOLEAN:C305(<>vb_UserPointage)
C_TEXT:C284(<>va_UserMessagerie)
C_BOOLEAN:C305(<>vb_UserMessagerie)
C_BOOLEAN:C305(<>vb_UserLOFT)
C_TEXT:C284(<>va_UserPlateforme)
ARRAY TEXT:C222(<>ta_UserPlateforme; 0)
<>vb_UserLOFT:=False:C215

ARRAY TEXT:C222(<>ta_Types; 0)
LIST TO ARRAY:C288("eTypes"; <>ta_Types)