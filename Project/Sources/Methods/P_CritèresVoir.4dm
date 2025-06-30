//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_CritèresVoir
//{          Jeudi 24 février 2011 à 17:50:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}



C_POINTER:C301($1)  //Tableau : libellé
C_TEXT:C284($2)  //Titre

C_LONGINT:C283($vl_Fenetre)

ARRAY TEXT:C222(ta_xLibellé; 0)



COPY ARRAY:C226($1->; ta_xLibellé)

$vl_Fenetre:=i_FenêtreNo(357; 399; 5; $2; 4; "")
DIALOG:C40([DiaLogues:3]; "DL_TabCritèreVoir")
CLOSE WINDOW:C154($vl_Fenetre)