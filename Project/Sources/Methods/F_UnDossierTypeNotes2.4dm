//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeNotes2
//{
//{          Mardi 30 août 2005 à 10:51:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215


C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

ARRAY TEXT:C222(ta_PageNote; 2)
ta_PageNote{1}:="Note 1"
ta_PageNote{2}:="Note 2"


READ WRITE:C146($1->)
If (i_NonVerrou($1))
	FORM SET INPUT:C55($1->; $2)
	//$vl_Fenetre:=i_FenêtreNo (492;492;4;$3;3;$4)
	$vl_Fenetre:=i_FenêtreNo(492; 542; 4; $3; 3; $4)
	MODIFY RECORD:C57($1->; *)
	UNLOAD RECORD:C212($1->)
	CLOSE WINDOW:C154($vl_Fenetre)
End if 
READ ONLY:C145($1->)