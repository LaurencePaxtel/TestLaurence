//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_EtatCivil_Enfant
//{          Vendredi 6 janvier 2012 à 16:30
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
If ($1>"")
	$0:=(Substring:C12($1; Length:C16($1)-1; 1)="P")
End if 