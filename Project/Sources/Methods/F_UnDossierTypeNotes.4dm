//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeNotes
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

READ WRITE:C146($1->)

If (i_NonVerrou($1))
	FORM SET INPUT:C55($1->; $2)
	
	$vl_Fenetre:=i_FenêtreNo(420; 398; 4; $3; 3; $4)
	$vl_Fenetre:=i_FenêtreNo(475; 518; 4; $3; 3; $4)
	
	MODIFY RECORD:C57($1->; *)
	UNLOAD RECORD:C212($1->)
	
	CLOSE WINDOW:C154($vl_Fenetre)
End if 

READ ONLY:C145($1->)