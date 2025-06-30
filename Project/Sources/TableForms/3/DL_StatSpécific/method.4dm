If (Form event code:C388=Sur chargement:K2:1)
	vt_StTexte:=""
	va_Dept:=""
	
	vl_NbJ:=1
	
	rJourNuit1:=1
	rJourNuit2:=1
	
	w1:=1
	w2:=0
	
	u1:=0
	u2:=1
	
	rReport:=1
	
	sansChangementSituation_b:=False:C215
	
	vd_Date1:=Current date:C33(*)
	vd_Date2:=Current date:C33(*)
	
	OBJECT SET VISIBLE:C603(*; "CritDept_@"; (<>ve_ConsoRegion_Mode=2))  //6/12/2011 : IMPORT pour le régional
	
	P_StatistiqueNotes(1; <>ve_StatSpécific; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
End if 