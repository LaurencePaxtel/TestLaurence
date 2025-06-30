//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_appelLive
//{
//{          Lundi 7 mai 2007 à 16:16:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

// `CACHER PROCESS(◊PR_Appel)
//CHANGER BARRE(1)
//C_TEXTE(vt_CurrentURL)
//C_ENTIER LONG(myBrowser;vl_EventFF;vl_Error)

//vt_CurrentURL:=""
//$winid:=Creer fenetre formulaire([DiaLogues];"DL_AppelsLive";Form fenêtre standa
//DIALOGUE([DiaLogues];"DL_AppelsLive")
//FERMER FENETRE($winid)


//Process_Show (◊PR_Appel)
<>PR_AppelLive:=0