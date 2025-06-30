If (Form event code:C388=Sur chargement:K2:1)
	vd_Date1:=Current date:C33(*)
	vd_Date2:=Current date:C33(*)
	vl_NbJ:=1
	rJourNuit1:=1
	rJourNuit2:=1
	vl_Break:=1
	vl_Break2:=1
	vt_StTexte:=""
	P_StatistiqueNotes(1; <>ve_StatEMA; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
End if 
