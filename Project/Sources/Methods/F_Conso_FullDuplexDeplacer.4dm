//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Fonction : F_Conso_FullDuplexDeplacer
//{
//{          Vendrdi 7 novembre 2008 à 17:44
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_DATE:C307($4)

C_BOOLEAN:C305($vb_OK)

If (Length:C16($3)=3)
	va_Trans_CodeSiteB:=$3
Else 
	va_Trans_CodeSiteB:=$3+(" "*(3-Length:C16($3)))
End if 
If ($4>!00-00-00!)
	va_Trans_DateSite:=String:C10(Year of:C25($4); "0000")+String:C10(Month of:C24($4); "00")
Else 
	va_Trans_DateSite:="000000"
End if 

// •On teste l'existence du dossier lu
vt_FullDuplexDossierLu:=$1+<>va_Rép_TransReportLU+Séparateur dossier:K24:12
$vb_OK:=F_Report_FullDuplexDossier(12; vt_FullDuplexDossierLu)
If ($vb_OK)
	//• On teste l'existence dans dossier lu du dossier site
	vt_FullDuplexDossierLu:=vt_FullDuplexDossierLu+va_Trans_CodeSiteB+Séparateur dossier:K24:12
	$vb_OK:=F_Report_FullDuplexDossier(12; vt_FullDuplexDossierLu)
	If ($vb_OK)
		//• On teste l'existence dans dossier lu et dossier site le mois
		vt_FullDuplexDossierLu:=vt_FullDuplexDossierLu+va_Trans_CodeSiteB+va_Trans_DateSite+Séparateur dossier:K24:12
		$vb_OK:=F_Report_FullDuplexDossier(12; vt_FullDuplexDossierLu)
	End if 
End if 
If ($vb_OK)
	vt_TitreDocumentLu:=vt_FullDuplexDossierLu+$2
	
	MOVE DOCUMENT:C540(vt_TitreDocument; vt_TitreDocumentLu)
End if 