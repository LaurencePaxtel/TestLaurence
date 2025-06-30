If (Form event code:C388=Sur chargement:K2:1)
	r1:=Num:C11(<>vb_Conso115Auto=True:C214)
	r2:=Num:C11(<>vb_Conso115Auto=False:C215)
	//s1:=Num(◊vb_Conso115ServeurAuto=Vrai)
	//s2:=Num(◊vb_Conso115ServeurAuto=Faux)
	
	<>vh_Conso115Ticks:=<>vl_Conso115Ticks/60
	
	
End if 