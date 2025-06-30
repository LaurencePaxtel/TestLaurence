//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Regional_DossierLu
//{          lundi 31 janvier 2011 à 11:00
//{         
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215


C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($vt_LeDocu; $vt_LeDocuLu; $vt_LeRepLu)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Temp)
$va_Temp:=""

$vt_LeDocu:=$1+$2
$vt_LeDocu:=F_FichierSuffixe($vt_LeDocu)

If (7=7)  //13/4/2011
	DELETE DOCUMENT:C159($vt_LeDocu)
Else 
	
	$vt_LeDocuLu:=$2
	
	//• On teste l'existence du dossier   Lu
	$vt_LeRepLu:=$1+"LU"+Séparateur dossier:K24:12
	$vb_OK:=F_Report_FullDuplexDossier(12; $vt_LeRepLu)
	
	//• On teste l'existence dans dossier lu et dossier site le mois (AAAAMM
	If ($vb_OK)
		$vt_LeRepLu:=$vt_LeRepLu+"20"+Substring:C12($2; 4; 2)
		$vt_LeRepLu:=$vt_LeRepLu+Substring:C12($2; 6; 2)
		$vt_LeRepLu:=$vt_LeRepLu+Séparateur dossier:K24:12
		$vb_OK:=F_Report_FullDuplexDossier(12; $vt_LeRepLu)
	End if 
	
	//• On deplace
	If ($vb_OK)
		If (Substring:C12($vt_LeDocuLu; Length:C16($vt_LeDocuLu)-3; 4)=".TXT")
			$vt_LeDocuLu:=Substring:C12($vt_LeDocuLu; 1; Length:C16($vt_LeDocuLu)-4)
		End if 
		$vt_LeRepLu:=$vt_LeRepLu+$vt_LeDocuLu+"LU"
		$vt_LeDocuLu:=F_FichierSuffixe($vt_LeRepLu)
		
		COPY DOCUMENT:C541($vt_LeDocu; $vt_LeDocuLu)
		DELETE DOCUMENT:C159($vt_LeDocu)
		
		
		// DEPLACER DOCUMENT($vt_LeDocu;$vt_LeDocuLu)
		
	End if 
End if 

