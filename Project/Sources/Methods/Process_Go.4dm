//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Process_Go  
//{
//{          Vendredi 10 Janvier 1997 à 12:26:17
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  // Pointeur du numéro du process créé
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_VARIANT:C1683($5)


// Modifié par : Scanu Rémy - remy@connect-io.fr (10/06/2021)
// Ne sert à rien...
//$L_Pile:=$4*1024  // remplacé par <>L_Pile_defaut_C

If ($1->=0)
	
	// Modifié par : Scanu Rémy (18/05/2022)
	// Ajout d'un 5° paramètre optionnel
	If (Count parameters:C259=5)
		$1->:=New process:C317($2; 0; $3; $5)
	Else 
		$1->:=New process:C317($2; 0; $3)
	End if 
	
Else 
	Process_Show($1->)
End if 