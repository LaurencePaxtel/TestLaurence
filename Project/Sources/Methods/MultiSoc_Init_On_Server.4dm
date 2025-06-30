//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 06/12/18, 17:28:04
// ----------------------------------------------------
// Méthode : MultiSoc_Init_On_Server
// Description
// Cette méthode permet d'initialiser la valeur de
// la variable <>ref_soc_active pour les méthodes 
// qui s'exécutent côté serveur
// Paramètres
// ---------------------------------------------------- 
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($nb_params)
C_TEXT:C284($ref_soc_active)

MultiSoc_Init_Variables(False:C215)

If (Count parameters:C259=2)
	$nb_params:=$1
	$ref_soc_active:=$2
	
	If ($nb_params=2)
		<>ref_soc_active:=$ref_soc_active
		ref_soc_active:=$ref_soc_active
	End if 
	
Else 
	READ ONLY:C145([Structures:79])
	ALL RECORDS:C47([Structures:79])
	
	REDUCE SELECTION:C351([Structures:79]; 1)
	
	<>ref_soc_active:=[Structures:79]Ref_Structure:3
	ref_soc_active:=[Structures:79]Ref_Structure:3
	
	<>user_nom_entreprise:=[Structures:79]STRC_Nom:4
	<>ID_Societe_Active:=[Structures:79]STRC_Societe_ID:6
End if 