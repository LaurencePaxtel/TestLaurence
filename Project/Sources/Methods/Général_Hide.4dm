//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Général_Hide  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (Value type:C1509(<>PR_Genéral)#Est une variable indéfinie:K8:13) && (<>PR_Genéral#0)
	HIDE PROCESS:C324(<>PR_Genéral)
End if 