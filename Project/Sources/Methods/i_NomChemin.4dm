//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{
//{          Procédure : i_NomChemin
//{
//{          Vendredi 9 Juillet 1999 à 15:56
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($0)
C_LONGINT:C283($ii; $ij)
$ii:=Length:C16($1)
$ij:=0
Repeat 
	If ($1[[$ii]]=Séparateur dossier:K24:12)
		$ij:=$ii
		$ii:=0
	End if 
	$ii:=$ii-1
Until ($ii<=0)
If ($ij>0)
	$0:=Substring:C12($1; 1; $ij)
Else 
	$0:=$1
End if 
