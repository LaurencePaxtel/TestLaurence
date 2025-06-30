Case of 
	: (Form event code:C388=Sur clic:K2:4)
		<>vt_Trans:=""
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			<>vt_Trans:=[HeBerge:4]HB_Clé:2
			P_MemoFusion(0; <>ve_MemoFusion; -><>vt_Trans)
			
			<>vt_Trans:=""
		Else 
			StrAlerte(24; "")
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 