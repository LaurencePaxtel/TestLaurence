If (<>PR_ConsoClientA=0)
	ALERT:C41("La consolidation n'est pas lancée !")
Else 
	If (r1=1)
		ALERT:C41("Le paramètre de consolidation automatique est déjà à non !")
	Else 
		r1:=0
		r2:=1
		<>vb_Conso115Clt:=(r1=1)
		<>vl_Conso115Clt:=Num:C11(<>vb_Conso115Clt=True:C214)
	End if 
End if 