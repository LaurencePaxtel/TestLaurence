var $hebergeID_el : Integer

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		// Modifié par : Scanu Rémy (03/08/2022)
		// Au lieu d'utiliser [HeBerge]HB_ReferenceID, on utilise [HeBerge]ID, plus fiable
		If ([HeBerge:4]ID:65>0)
			
			// Modifié par : Scanu Rémy (23/01/2023)
			// Pour éviter problème de fiche vérouillé on libère l'enregistrement ici
			$hebergeID_el:=[HeBerge:4]ID:65
			UNLOAD RECORD:C212([HeBerge:4])
			
			Process_Go2(-><>PR_HBNotes; "Go_HébergementNotesNew"; "Notes"; 0; $hebergeID_el; "N")
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 