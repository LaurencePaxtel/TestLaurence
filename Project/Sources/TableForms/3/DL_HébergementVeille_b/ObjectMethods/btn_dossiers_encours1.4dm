Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			Process_Go(-><>PR_Dossiers_Encours; "Go_Dossiers_Encours"; "Dossiers en cours"; 0; [HeBerge:4]HB_ReferenceID:1)
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 