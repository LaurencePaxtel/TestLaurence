If (Form event code:C388=Sur clic:K2:4)
	<>vb_RAP_CréerDispo:=(E1=1)
	
	If (<>vb_RAP_CréerDispo=False:C215)  //Vérification des disponibilitées aux deux bornes de date 
		va_DateType:=Uut_NumeroteLitsType(<>vd_RAP_Départ; "J")
		
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		MultiSoc_Filter(->[CentresLits:16])
		
		vl_CHJx:=Records in selection:C76([CentresLits:16])
		va_DateType:=Uut_NumeroteLitsType(<>vd_RAP_Départ; "N")
		
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
		MultiSoc_Filter(->[CentresLits:16])
		
		vl_CHNx:=Records in selection:C76([CentresLits:16])
		
		If (vl_CHNx<=0) | (vl_CHNx<=0)
			ALERT:C41("Il n'y a pas de disponibilités le "+String:C10(<>vd_RAP_Départ)+" .")
			REJECT:C38
		Else 
			va_DateType:=Uut_NumeroteLitsType(<>vd_RAP_Jusque; "J")
			
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
			MultiSoc_Filter(->[CentresLits:16])
			
			vl_CHJx:=Records in selection:C76([CentresLits:16])
			va_DateType:=Uut_NumeroteLitsType(<>vd_RAP_Jusque; "N")
			
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
			MultiSoc_Filter(->[CentresLits:16])
			
			vl_CHNx:=Records in selection:C76([CentresLits:16])
			
			If (vl_CHNx<=0) | (vl_CHNx<=0)
				ALERT:C41("Il n'y a pas de disponibilités le "+String:C10(<>vd_RAP_Jusque)+" .")
				REJECT:C38
			End if 
			
		End if 
		
	End if 
	
End if 