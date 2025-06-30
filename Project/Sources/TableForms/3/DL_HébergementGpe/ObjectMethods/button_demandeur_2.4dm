ARRAY LONGINT:C221($tl_ref; 0)  // #Fix20170424-5

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeBerge:4]HB_ReferenceID:1)
			va_GPLib:=""
			
			If (Records in selection:C76([GroupeHeberges:37])>0)
				SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_GP_Référence:2; $tl_ref)
				QUERY WITH ARRAY:C644([GrouPe:36]GP_ReferenceID:1; $tl_ref)
			Else 
				REDUCE SELECTION:C351([GrouPe:36]; 0)
			End if 
			
			vL_Nb_GP:=Records in selection:C76([GrouPe:36])
			ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
			
			POST CLICK:C466(20; 390)
			
			If ([GrouPe:36]GP_ReferenceID:1>0)
				P_Tab_GP(4; 0)
			Else 
				P_Tab_GP(0; 0)
			End if 
			
		Else 
			StrAlerte(3; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 