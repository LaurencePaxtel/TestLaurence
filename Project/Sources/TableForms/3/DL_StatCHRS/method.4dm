If (Form event code:C388=Sur chargement:K2:1)
	vt_StTexte:=""
	vd_Date1:=Current date:C33(*)
	vl_NbJ:=1
	
	OBJECT Get pointer:C1124(Objet nommé:K67:5; "avecInconnu")->:=True:C214
	
	OBJECT Get pointer:C1124(Objet nommé:K67:5; "hebergement")->:=True:C214
	OBJECT Get pointer:C1124(Objet nommé:K67:5; "prestation")->:=True:C214
	
	P_StatistiqueNotes(1; <>ve_StatDASS; ->vt_StTexte)
	OBJECT SET VISIBLE:C603(b_CalcDDASS; False:C215)
End if 