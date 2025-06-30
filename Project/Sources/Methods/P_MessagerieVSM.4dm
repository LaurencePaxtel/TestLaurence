//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_MessagerieVSM
//{
//{          Mardi 30 Novembre 2004 à 14:33
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

ALL RECORDS:C47([MessagerieVSM:39])
MultiSoc_Filter(->[MessagerieVSM:39])
ORDER BY:C49([MessagerieVSM:39]; [MessagerieVSM:39]MV_Date:2; <; *)
ORDER BY:C49([MessagerieVSM:39]; [MessagerieVSM:39]MV_Heure:3; <)