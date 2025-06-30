//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/06/22, 14:39:47
// ----------------------------------------------------
// Méthode : outilsHebergeLoadRecord
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $id_el : Integer

ARRAY LONGINT:C221($id_ai; 0)

If (Records in selection:C76([HeBerge:4])>0)
	GET HIGHLIGHTED RECORDS:C902([HeBerge:4]; "$heberge_ebl")
	
	If (Records in set:C195("$heberge_ebl")>0)
		CUT NAMED SELECTION:C334([HeBerge:4]; "avantRecherche")
		
		USE SET:C118("$heberge_ebl")
		LOAD RECORD:C52([HeBerge:4])
		
		$id_el:=[HeBerge:4]ID:65
		USE NAMED SELECTION:C332("avantRecherche")
		
		SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $id_ai)
		
		GOTO SELECTED RECORD:C245([HeBerge:4]; Find in array:C230($id_ai; $id_el))
		HIGHLIGHT RECORDS:C656([HeBerge:4]; "$heberge_ebl")
	End if 
	
End if 