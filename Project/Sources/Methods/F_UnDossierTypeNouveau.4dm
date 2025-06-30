//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeNouveau
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

READ WRITE:C146($1->)
FORM SET INPUT:C55($1->; $2)

// Modifié par : Scanu Rémy - remy@connect-io.fr (11/10/2021)
Case of 
	: ($4=0)
		$vl_Fenetre:=i_FenêtreNo(632; 436; 4; $3+" : nouveau"; 1; "")
	: ($4=1)
		$vl_Fenetre:=i_FenêtreNo(1940; 750; Fenêtre standard:K34:13; $3+" : nouveau"; 1; "Quit_Simple")  //lpc 31/10/2018 /786;508
End case 

ADD RECORD:C56($1->)  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)

READ ONLY:C145($1->)