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
	ARRAY DATE:C224(<>td_PopCT_Date; 1)
	<>td_PopCT_Date{1}:=vd_Date1
	vl_NbJ:=1
	rJourNuit1:=1
	rJourNuit2:=1
	rReport:=1
	rSomme:=1
	vt_StTexte:=""
	e1:=0
	e2:=0
	e3:=0
	e4:=0
	e5:=1
	u1:=1
	u2:=0
	P_StatistiqueNotes(1; <>ve_StatDirectionC; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
End if 