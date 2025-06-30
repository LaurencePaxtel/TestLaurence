//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_DocumentsDéplacer
//{          Lundi 8 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284($vt_Document)


If (7=7)  //13/4/2011
	vt_TitreDocument:=F_FichierSuffixe($2)
	DELETE DOCUMENT:C159(vt_TitreDocument)
Else 
	
	//• On teste l'existence du dossier  Lu
	
	$vb_OK:=F_Report_FullDuplexDossier(12; $1+$3+Séparateur dossier:K24:12)
	If ($vb_OK)
		vt_TitreDocument:=F_FichierSuffixe($2)
		$vt_Document:=$1+$3+Séparateur dossier:K24:12+vt_TitreDocument
		vt_TitreDocument:=$1+vt_TitreDocument
		COPY DOCUMENT:C541(vt_TitreDocument; $vt_Document)
		DELETE DOCUMENT:C159(vt_TitreDocument)
		
		$0:=True:C214
	End if 
End if 