//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutInitTabConso  
//{           
//{          Lundi 22 décembre 2008 à 17:12:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($2)

Case of 
	: ($1=0)
		ARRAY INTEGER:C220(<>te_Conso_Ligne; 0)
		ARRAY TEXT:C222(<>tt_Conso_LeDocument; 0)
		ARRAY TEXT:C222(<>ta_Conso_Titre; 0)
		ARRAY TEXT:C222(<>tt_Conso_Valeur; 0)
		ARRAY INTEGER:C220(<>te_Conso_Table; 0)
		ARRAY INTEGER:C220(<>te_Conso_Champ; 0)
		ARRAY INTEGER:C220(<>te_Conso_ChampType; 0)
		ARRAY TEXT:C222(<>ta_Conso_ChampType; 0)
		
		
	: ($1=1)
		ARRAY INTEGER:C220(<>te_ConsoT_Ligne; 0)
		ARRAY TEXT:C222(<>tt_ConsoT_LeDocument; 0)
		ARRAY TEXT:C222(<>ta_ConsoT_Titre; 0)
		ARRAY TEXT:C222(<>tt_ConsoT_Valeur; 0)
		ARRAY INTEGER:C220(<>te_ConsoT_Table; 0)
		ARRAY INTEGER:C220(<>te_ConsoT_Champ; 0)
		ARRAY INTEGER:C220(<>te_ConsoT_ChampType; 0)
		ARRAY TEXT:C222(<>ta_ConsoT_ChampType; 0)
		
		
End case 