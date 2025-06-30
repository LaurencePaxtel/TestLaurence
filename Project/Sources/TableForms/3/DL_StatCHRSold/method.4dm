If (Form event code:C388=Sur chargement:K2:1)
	vt_StTexte:=""
	vd_Date1:=Current date:C33(*)
	vl_NbJ:=1
	
	P_StatistiqueNotes(1; <>ve_StatDASS; ->vt_StTexte)
	OBJECT SET VISIBLE:C603(b_CalcDDASS; False:C215)
End if 