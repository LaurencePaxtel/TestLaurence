If (Form event code:C388=Sur clic:K2:4)
	
	If (Records in selection:C76([HeberGement:5])>0)
		F_Report_FullDuplexTableau
		FIRST RECORD:C50([HeberGement:5])
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
		If (Size of array:C274(tl_Trans_Réf_HG)>0)
			
			$vb_T_ModeCHRS:=<>vb_T_ModeCHRS
			$vb_T_FullDuplex:=<>vb_T_FullDuplex
			
			<>vb_T_ModeCHRS:=True:C214
			<>vb_T_FullDuplex:=True:C214
			
			$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Reprise du tranfert du report du "+String:C10(vd_Date1; Interne date court:K1:7))
			
			F_Report_FullDuplexTableau
			<>vb_T_ModeCHRS:=$vb_T_ModeCHRS
			<>vb_T_FullDuplex:=$vb_T_FullDuplex
			
			
		End if 
	End if 
End if 


