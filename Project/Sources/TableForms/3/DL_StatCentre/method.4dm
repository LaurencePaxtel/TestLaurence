If (Form event code:C388=Sur chargement:K2:1)
	wNom1:=1
	wNom2:=0
	sHGliste:=0
	sNbOrHB:=0
	sNbHOrB:=0
	sNbNote:=0
	vl_Break:=0
	sNbParHB:=0
	vd_Date1:=Current date:C33(*)
	vd_Date2:=Current date:C33(*)
	vl_NbJ:=1
	rJourNuit1:=1
	rJourNuit2:=1
	rReport:=1
	vh_Clic1:=?00:00:00?
	vl_Old:=0
	ta_Centre:=0
	vt_StTexte:=""
	P_StatistiqueNotes(1; <>ve_StatCentre; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
	
	rNonVérif:=0
	
End if 