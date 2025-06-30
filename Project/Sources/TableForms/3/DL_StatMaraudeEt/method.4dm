If (Form event code:C388=Sur chargement:K2:1)
	vd_Date1:=Current date:C33(*)
	vd_Date2:=Current date:C33(*)
	vl_NbJ:=1
	rJourNuit1:=1
	rJourNuit2:=1
	u1:=1
	u2:=0
	
	V_Stat_MaraudeEt(-10; 1)
	
	vt_StTexte:=""
	ve_AgeInf:=0
	ve_AgeSup:=0
	P_StatistiqueNotes(1; <>ve_StatMaraudeEt; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
End if 