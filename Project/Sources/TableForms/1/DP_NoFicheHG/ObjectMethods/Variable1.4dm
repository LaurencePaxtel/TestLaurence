
If (vd_Date>!00-00-00!)
	If (vd_Date#vd_DateTemp)
		vd_DateTemp:=vd_Date
		va_NoFiche:=""
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3; <)
			FIRST RECORD:C50([HeberGement:5])
			va_NoFiche:=[HeberGement:5]HG_FicheNuméro:3
		End if 
	End if 
	
Else 
	va_NoFiche:=""
End if 