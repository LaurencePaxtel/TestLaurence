//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 18:26:35
// ----------------------------------------------------
// Method: UTL_Get_Adresse
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)

C_TEXT:C284($txt_adresse)
C_POINTER:C301($id_origine; $id_table_origine)

$id_origine:=$1
$id_table_origine:=$2

READ ONLY:C145([Adresses:53])

QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=$id_origine->; *)
QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252($id_table_origine))

If (Records in selection:C76([Adresses:53])=1)
	$txt_adresse:=[Adresses:53]AD_Adresse1:16
	
	If ([Adresses:53]AD_Adresse2:17#"")
		$txt_adresse:=$txt_adresse+Char:C90(Retour chariot:K15:38)+[Adresses:53]AD_Adresse2:17
	End if 
	
	If ([Adresses:53]AD_Adresse3:18#"")
		$txt_adresse:=$txt_adresse+Char:C90(Retour chariot:K15:38)+[Adresses:53]AD_Adresse3:18
	End if 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (21/04/2021)
	$txt_adresse:=$txt_adresse+Char:C90(Retour chariot:K15:38)
	
	$txt_adresse:=$txt_adresse+[Adresses:53]AD_Code_postal:19+" "+[Adresses:53]AD_Ville:20
End if 

$0:=$txt_adresse