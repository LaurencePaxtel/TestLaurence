If (Form event code:C388=Sur chargement:K2:1)
	qNoLien:=0
	qChef:=0
	qNonChef:=0
	qOrientation:=0
	qDossier:=0
	qBasculeCf:=0
	qBasculeNonCf:=0
	va_UnLibRecDosSiao:="Sur "+String:C10(Records in selection:C76([HeberGement:5]); "### ### ##0")+" fiche(s)"
	vh_LDF_DebutRenum:=?00:00:00?
	vh_LDF_FinRenum:=vh_LDF_DebutRenum
	vh_LDF_DebutChef:=vh_LDF_DebutRenum
	vh_LDF_FinChef:=vh_LDF_DebutRenum
	vh_LDF_DebutNonChef:=vh_LDF_DebutRenum
	vh_LDF_FinNonChef:=vh_LDF_DebutRenum
	vh_LDF_DebutCas:=vh_LDF_DebutRenum
	vh_LDF_FinCas:=vh_LDF_DebutRenum
	vh_LDF_DebutDos:=vh_LDF_DebutRenum
	vh_LDF_FinDos:=vh_LDF_DebutRenum
	
	vh_LDF_DureRenum:=vh_LDF_DebutRenum
	vh_LDF_DureChef:=vh_LDF_DebutRenum
	vh_LDF_DureNonChef:=vh_LDF_DebutRenum
	vh_LDF_DureCas:=vh_LDF_DebutRenum
	vh_LDF_DureDos:=vh_LDF_DebutRenum
	
End if 