If (Form event code:C388=Sur après frappe clavier:K2:26)
	va_GPLib:=Get edited text:C655
	
	If (va_GPLib>"")
		QUERY:C277([GrouPe:36]; [GrouPe:36]GP_Intitulé:4=(va_GPLib+"@"))
		MultiSoc_Filter(->[GrouPe:36])
	Else 
		REDUCE SELECTION:C351([GrouPe:36]; 0)
	End if 
	
	vL_Nb_GP:=Records in selection:C76([GrouPe:36])
	ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
	
	If ([GrouPe:36]GP_ReferenceID:1>0)
		P_Tab_GP(4; 0)
	Else 
		P_Tab_GP(0; 0)
	End if 
	
End if 
