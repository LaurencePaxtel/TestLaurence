//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeImprimer
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_POINTER:C301($1)
C_TEXT:C284($2)

FORM SET OUTPUT:C54($1->; $2)
FORM SET INPUT:C55($1->; $2)
PRINT RECORD:C71($1->)
If (OK=1)
	$0:=True:C214
End if 