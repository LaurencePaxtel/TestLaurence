Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			//Process_Go20(-><>PR_HBAction; "Go_HébergementAction"; "Actions"; 0; )
			LOAD RECORD:C52([HeberGement:5])
			Go_HébergementAction([HeBerge:4]HB_ReferenceID:1; "N"; "")
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 