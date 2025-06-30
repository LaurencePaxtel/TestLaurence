//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : Prolongation_FicheIncluse 
//{
//{          Lundi 26 septefévriermbre 20074 à 12:06:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($0)
$0:=""

C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($vt_Texte)
$vt_Texte:=$1


If (7=8)
	If (<>vb_CestUnMac)
		$vt_Texte:=Replace string:C233($vt_Texte; "/"; Séparateur dossier:K24:12)
	Else 
		$vt_Texte:=Replace string:C233($vt_Texte; ":"; Séparateur dossier:K24:12)
	End if 
End if 


$vb_OK:=(Test path name:C476($vt_Texte)=Est un dossier:K24:2)
If ($vb_OK)
	$0:=$vt_Texte
Else 
	If ($2=1)
		CREATE FOLDER:C475($vt_Texte)
		$0:=$vt_Texte
	End if 
End if 