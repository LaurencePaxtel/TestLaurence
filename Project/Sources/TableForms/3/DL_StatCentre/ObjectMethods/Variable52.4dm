If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(<>tsC_IDID)>0)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; <>tsC_IDID)
		If (Records in selection:C76([HeberGement:5])>0)
			_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtCentreRés")
			PRINT SETTINGS:C106
			If (OK=1)
				
				vl_Indice:=0
				vl_IndiceJour:=0
				vl_IndicePers:=0
				vl_IndiceCh:=0
				vr_IndicePxJour:=0
				vr_IndiceTotal:=0
				
				<>va_T_03:=ta_Centre{ta_Centre}
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
				FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtCentreRés")
				PRINT SELECTION:C60([HeberGement:5]; *)
			End if 
		End if 
	End if 
End if 