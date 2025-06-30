//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_EtatCivilEnfant
//{
//{          Lundi 28 décembre 2008 à 16:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
If ($1>"")
	$0:=(Substring:C12($1; Length:C16($1)-1; 1)="P")
	//$0:=(Sous chaine($1;Longueur($1)-1;1)="M")
End if 