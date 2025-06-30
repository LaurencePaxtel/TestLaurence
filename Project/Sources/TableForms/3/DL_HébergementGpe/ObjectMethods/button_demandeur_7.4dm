Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			Process_Go2(-><>PR_HBST; "Go_HébergementSPPLUS"; "ST"; 32; [HeBerge:4]HB_ReferenceID:1; "N")
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 