If (<>PR_ConsoRGClientA=0)
	ALERT:C41("La consolidation régionale n'est pas lancée !")
Else 
	If (r1=0)
		ALERT:C41("Le paramètre de consolidation régionale automatique est déjà à non !")
	Else 
		r1:=0
		r2:=1
		<>vb_ConsoRAuto:=(r1=1)
		<>vl_ConsoRAuto:=Num:C11(<>vb_ConsoRAuto=True:C214)
	End if 
End if 