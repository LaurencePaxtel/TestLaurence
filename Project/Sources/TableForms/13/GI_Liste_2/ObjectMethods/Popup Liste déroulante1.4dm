

If (Size of array:C274(<>ta_SsTh)>0)
	Case of 
		: (<>ta_SsTh<=0)
			
		: (<>ta_SsTh=1)
			va_LibSsTh:="Tous"
			USE SET:C118("E_EnCours")
		: (<>ta_SsTh>1)
			va_LibSsTh:=<>ta_SsTh{<>ta_SsTh}
			USE SET:C118("E_EnCours")
			QUERY SELECTION:C341([GIP:13]; [GIP:13]GI_SousTheme:4=va_LibSsTh)
	End case 
	
	ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
	FIRST RECORD:C50([GIP:13])
	SET WINDOW TITLE:C213(<>Va_Rubrique+" : "+<>Va_Thème+" : "+String:C10(Records in selection:C76([GIP:13])))
Else 
	va_LibSsTh:=""
End if 