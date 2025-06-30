//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 22/02/21, 11:55:30
// ----------------------------------------------------
// Méthode : outilsGestionDossierBiblioNum
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($position_el)
C_OBJECT:C1216($info_o)

outilsWProChargerDocument("rechercheDossierBibliothequeNumerique"; False:C215; ->$info_o; $1->)

$position_el:=70
outilsCreateWindowsForm("searchDocument"; ->$position_el; $info_o; ->[DOCWPRO:121])

If (Bool:C1537($info_o.selectionDocument)=True:C214)
	ACCEPT:C269
End if 