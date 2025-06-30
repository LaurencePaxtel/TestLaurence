If (Form event code:C388=Sur chargement:K2:1)
	vd_Date1:=Current date:C33(*)
	vd_Date2:=Current date:C33(*)
	
	vl_NbJ:=1
	rJourNuit1:=1
	rJourNuit2:=1
	
	w1:=1
	w2:=0
	w3:=0
	
	u1:=0
	u2:=1
	
	rReport:=1
	sDif:=1
	
	sCP:=1
	sGare:=1
	sVille:=1
	sRupt:=1
	
	sSexe:=1
	sEtCv:=1
	sAge:=1
	sHeure:=1
	sSignal:=1
	sNation:=1
	sMéd:=1
	sErrance:=1
	sRess:=1
	sSuivi:=1
	sCouv:=1
	sOR1:=1
	sOR2:=1
	sAutre:=1
	sSitFam:=1
	sDerJob:=1
	sSitPro:=1
	sDerHg:=1
	sLien:=1
	sPIdté:=1
	sNivEtude:=1
	sCasSpec:=1
	
	// Modifié par : Scanu Rémy (10/10/2023)
	sChefFam:=1
	
	vt_StTexte:=""
	
	ve_AgeInf:=0
	ve_AgeSup:=0
	
	// Modifié par : Scanu Rémy (16/02/2024)
	sansChangementSituation_b:=False:C215
	
	P_StatistiqueNotes(1; <>ve_StatEtude; ->vt_StTexte)
	P_JourNuitPrestation("rJourNuit2")
End if 