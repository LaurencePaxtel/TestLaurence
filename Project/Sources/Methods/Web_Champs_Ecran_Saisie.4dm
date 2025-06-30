//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 18/11/18, 15:32:13
// ----------------------------------------------------
// Méthode : Web_Champs_Ecran_Saisie
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($param)
C_TEXT:C284($name)

$param:=$1
$name:=$2

WEB_CHAMP_Titre:=""
WEB_CHAMP_Saisissable:=""
WEB_CHAMP_Visible:=""

WEB_CHAMP_Modifiable:=False:C215
WEB_CHAMP_Invisible_Boolean:=False:C215
WEB_CHAMP_Obligatoire:=False:C215

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$param; *)
QUERY:C277([LesRubriques:21];  & ; [LesRubriques:21]RubNom:2=$name)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])=1)
	WEB_CHAMP_Titre:=[LesRubriques:21]RubNomNew:13
	
	If (Not:C34([LesRubriques:21]RubSaississable:5))
		WEB_CHAMP_Saisissable:=" iw_read_only"
	End if 
	
	WEB_CHAMP_Modifiable:=[LesRubriques:21]RubModifiable:10
	
	If (Not:C34([LesRubriques:21]RubVisible:8))
		WEB_CHAMP_Visible:=" iw_display_none"
		WEB_CHAMP_Invisible_Boolean:=True:C214
	End if 
	
	WEB_CHAMP_Obligatoire:=[LesRubriques:21]RubObligatoire:6
	
	If (WEB_CHAMP_Saisissable#"") & (WEB_CHAMP_Modifiable=False:C215)  // Si on ne peut pas ni saisir ni modifié le champ
		WEB_CHAMP_Saisissable:=WEB_CHAMP_Saisissable+" disabled"
	End if 
	
End if 