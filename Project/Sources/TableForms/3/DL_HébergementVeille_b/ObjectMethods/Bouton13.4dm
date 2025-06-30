//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_Retour 
//{
//{          Lundi 28 Juillet 1997 à 17:02:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
FORM GOTO PAGE:C247(2)

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)