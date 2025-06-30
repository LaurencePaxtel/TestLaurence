Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		// Modifié par : Scanu Rémy (03/08/2022)
		// Au lieu d'utiliser [HeBerge]HB_ReferenceID, on utilise [HeBerge]ID, plus fiable
		If ([HeBerge:4]ID:65>0)
			Process_Go2(-><>PR_HBNotes; "Go_HébergementNotes"; "Notes"; 32; [HeBerge:4]ID:65; "N")
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 