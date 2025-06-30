C_LONGINT:C283($ii)

If (<>ta_vDSLibel>0)
	
	If (<>ta_vDSLibel{<>ta_vDSLibel}#<>ta_vDSLibel{0})
		$ii:=Find in array:C230(<>ta_vDSLibel; <>ta_vDSLibel{0})
		TableChamps(5; $ii)
		
		// #BS Migration v15 30/05/16
		// Remplacement de la commande obsolète
		
		// Modifié par : Scanu Rémy (25/01/2023)
		//xliff_ARRAY_TO_XLIFF_(-><>ta_RubNomNew; (<>vlSTR+$ii))
		outilsCreateXliffFile((<>vlSTR+$ii); -><>ta_RubNomNew)
		
		//====================================================//
		// Modified by: Kevin HASSAL (12/10/2020)
		//  Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
		//====================================================//
		
		// Modifié par : Scanu Rémy (25/01/2023)
		//xliff_ARRAY_TO_XLIFF_(-><>ta_RubNomNew; ((<>vlSTR+$ii)*1000)+<>ID_Societe_Active)
		outilsCreateXliffFile(((<>vlSTR+$ii)*1000)+<>ID_Societe_Active; -><>ta_RubNomNew)
		
		<>ta_vDSLibel{0}:=<>ta_vDSLibel{<>ta_vDSLibel}
		TableChamps(2; <>ta_vDSLibel)
	End if 
	
Else 
	<>ta_vDSLibel:=Find in array:C230(<>ta_vDSLibel; <>ta_vDSLibel{0})
End if 