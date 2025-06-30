//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_HébergementCritères80
//{          Lundi 26 mars 2012 à 11:44:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1)  //Tableau : libellé
C_POINTER:C301($2)  //Tableau : Cas
C_TEXT:C284($3)  //Titre

C_LONGINT:C283($vl_Fenetre)

ARRAY TEXT:C222(<>ta_xLibellé80; 0)
ARRAY INTEGER:C220(<>te_xCheck80; 0)



COPY ARRAY:C226($1->; <>ta_xLibellé80)
COPY ARRAY:C226($2->; <>te_xCheck80)

$vl_Fenetre:=i_FenêtreNo(357; 399; 5; $3; 4; "")
DIALOG:C40([DiaLogues:3]; "DL_TabCritère80")
CLOSE WINDOW:C154($vl_Fenetre)

COPY ARRAY:C226(<>ta_xLibellé80; $1->)
COPY ARRAY:C226(<>te_xCheck80; $2->)