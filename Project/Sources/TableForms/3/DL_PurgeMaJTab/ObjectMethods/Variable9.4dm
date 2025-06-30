
va_LibNo:=""
vb_majOK:=False:C215


If (va_NewLibTa>"")
	vl_NewLibTa:=Num:C11(va_NewLibTa)
	If (vl_NewLibTa>0)
		QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=vl_NewLibTa)
	Else 
		QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=va_NewLibTa)
	End if 
	If (Records in selection:C76([TypesTables:11])>1)
		ALERT:C41("Cette table existe déja !")
	Else 
		vb_majOK:=True:C214
	End if 
End if 