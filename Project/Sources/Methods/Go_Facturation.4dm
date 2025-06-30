//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/02/20, 08:34:37
// ----------------------------------------------------
// Method: Go_Facturation
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($1)
C_DATE:C307($2)

C_TEXT:C284($form; fac_mode_hg_p)
C_DATE:C307(txt_filtre_date1; txt_filtre_date2)

ARRAY TEXT:C222(tb_fac_mode_hg_p; 0)

APPEND TO ARRAY:C911(tb_fac_mode_hg_p; "Fiches d'hébergements")
APPEND TO ARRAY:C911(tb_fac_mode_hg_p; "Participations")

txt_filtre_date1:=$1
txt_filtre_date2:=$2

SOC_Get_Config
UTL_Form_Popup("Choix du mode de facturation"; ->tb_fac_mode_hg_p; ->fac_mode_hg_p)

If (fac_mode_hg_p="Fiches d'hébergements")
	$form:="Liste_HB"
Else 
	$form:="Liste_P"
End if 

$vl_Fenetre:=Open form window:C675([Factures:86]; $form; Form fenêtre standard:K39:10; À gauche:K39:2; En haut:K39:5)
DIALOG:C40([Factures:86]; $form)

CLOSE WINDOW:C154($vl_Fenetre)

<>PR_Facturation:=0