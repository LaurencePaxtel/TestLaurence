If (Form event code:C388=Sur chargement:K2:1)
	vd_Date1:=Current date:C33(*)
	vd_Date2:=Current date:C33(*)
	vl_NbJ:=1
	rJourNuit1:=1
	rJourNuit2:=1
	w1:=0
	w2:=1
	u1:=1
	u2:=0
	vt_StTexte:=""
	P_StatistiqueNotes(1; <>ve_StatMaraude; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
End if 