//%attributes = {}
// ----------------------------------------------------
// Développeur (OS) : Kevin HASSAL
// Date et heure : 29/08/18, 19:42:37
// ----------------------------------------------------
// Méthode : MultiSoc_Init_Variables
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($1)

C_TEXT:C284(ref_soc_active; <>ref_soc_active; <>user_nom_entreprise; <>user_uid_entreprise; <>info_structure_user)
C_LONGINT:C283(<>ID_Societe_Active)
C_BOOLEAN:C305($init)

$init:=True:C214

If (Count parameters:C259=1)
	$init:=$1
End if 

If ($init)
	<>ref_soc_active:=""
	<>user_nom_entreprise:=""
	<>user_uid_entreprise:=""
	<>info_structure_user:=""
	<>ID_Societe_Active:=0
	
	ref_soc_active:=""
End if 
