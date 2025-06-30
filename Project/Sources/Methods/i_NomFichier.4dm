//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{
//{          Procédure : i_NomFichier
//{
//{          Vendredi 9  Juilletars 1999 à 15:56
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($0)
C_LONGINT:C283($ii; $ij)

$ii:=Length:C16($1)
$ij:=$ii

Repeat 
	
	If ($1[[$ii]]=Séparateur dossier:K24:12)
		$ij:=$ii+1
		$ii:=0
	End if 
	
	$ii:=$ii-1
Until ($ii<=0)

If ($ij<Length:C16($1))
	$0:=Substring:C12($1; $ij)
Else 
	$0:=$1
End if 