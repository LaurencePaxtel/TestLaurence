
va_LibNo:=""
vb_majWrong:=False:C215

If (va_LibTab>"")
	vl_NumTab:=Num:C11(va_LibTab)
	If (Num:C11(va_LibTab)>0)
		QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=vl_NumTab)
	Else 
		QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=va_LibTab)
	End if 
	If (Records in selection:C76([TypesTables:11])=1)
		va_CléWrong:=[TypesTables:11]TT_Libellé:4
		vl_NbWrong:=[TypesTables:11]TT_NbNiveaux:2
		vl_RéfWrong:=[TypesTables:11]TT_RéférenceID:1
		vb_majWrong:=True:C214
	Else 
		va_CléWrong:=String:C10(Records in selection:C76([TypesTables:11]))+" table(s)"
		vl_NbWrong:=0
		vl_RéfWrong:=0
	End if 
Else 
	va_CléWrong:=""
	vl_NbWrong:=0
	vl_RéfWrong:=0
End if 