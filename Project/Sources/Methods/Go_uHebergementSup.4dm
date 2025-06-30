//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uHebergementSup
//{
//{          Vendredi 25 juillet 2003 à 16:20:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284(va_MPmot1)
C_TEXT:C284(va_LaCleDelafiche)
va_LaCleDelafiche:=""
va_Titre:="Suppression d'une fiche d'hébergement"
$vl_Fenetre:=i_FenêtreNo(466; 212; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_HébergementSup")
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])