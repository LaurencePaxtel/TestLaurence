//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeModifié
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_TEXT:C284($position_t)
C_LONGINT:C283($vl_Fenetre)

READ WRITE:C146($1->)

If (i_NonVerrou($1))
	FORM SET INPUT:C55($1->; $2)
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (21/12/2021)
	Case of 
		: ($4=0)
			$vl_Fenetre:=i_FenêtreNo(632; 436; 4; $3+" : modifier"; 1; "")
		: ($4=1)
			//$vl_Fenetre:=i_FenêtreNo (1940;750;Fenêtre standard;$3+" : modifier";1;"Quit_Simple")  //lpc 31/10/2018 /786;508
			$position_t:="center"
			outilsCreateWindowsForm($2; ->$position_t; Null:C1517; $1; Null:C1517; ->$vl_Fenetre)
	End case 
	
	MODIFY RECORD:C57($1->; *)
	UNLOAD RECORD:C212($1->)
	
	CLOSE WINDOW:C154($vl_Fenetre)
	
	$0:=True:C214
End if 

READ ONLY:C145($1->)