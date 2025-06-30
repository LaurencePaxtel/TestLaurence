//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 05/07/18, 23:07:20
// ----------------------------------------------------
// Méthode : NAV_Paramétrage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($vl_Fenetre)

ALL RECORDS:C47([NAV_Menus:77])
MultiSoc_Filter(->[NAV_Menus:77])

$vl_Fenetre:=Open form window:C675([NAV_Menus:77]; "Saisie_Liste"; Form fenêtre standard:K39:10; À gauche:K39:2; En haut:K39:5)
DIALOG:C40([NAV_Menus:77]; "Saisie_Liste")
CLOSE WINDOW:C154($vl_Fenetre)