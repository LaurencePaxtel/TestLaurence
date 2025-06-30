//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VarParamConsoVoir
//{          
//{          Mardi 18 novembre 2008 à 11:12
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		C_LONGINT:C283(<>vl_ConsoB_DocumentLignes)
		ARRAY TEXT:C222(<>ta_ConsoB_Document; 0)
		
		ARRAY INTEGER:C220(<>te_ConsoB_Ligne; 0)
		ARRAY TEXT:C222(<>tt_ConsoB_LeDocument; 0)
		ARRAY TEXT:C222(<>ta_ConsoB_Titre; 0)
		ARRAY TEXT:C222(<>tt_ConsoB_Valeur; 0)
		ARRAY INTEGER:C220(<>te_ConsoB_Table; 0)
		ARRAY INTEGER:C220(<>te_ConsoB_Champ; 0)
		ARRAY INTEGER:C220(<>te_ConsoB_ChampType; 0)
		ARRAY TEXT:C222(<>ta_ConsoB_ChampType; 0)
		
		C_TEXT:C284(<>vt_ConsoB_Buffer)
		
		C_TEXT:C284(<>vt_ConsoB_Chemin)
		C_TEXT:C284(<>vt_ConsoB_CheminDossier)
		C_TEXT:C284(<>vt_ConsoB_Dossier)
		C_TEXT:C284(<>vt_ConsoB_Document)
		C_TEXT:C284(<>vt_ConsoB_Titre)
		
		
		
		C_TEXT:C284(<>va_ConsoB_FicheSiteCode)
		C_TEXT:C284(<>va_ConsoB_FicheSite)
		C_DATE:C307(<>vd_ConsoB_FicheDate)
		C_TEXT:C284(<>va_ConsoB_FicheJour)
		C_TEXT:C284(<>va_ConsoB_FicheNo)
		C_TEXT:C284(<>va_ConsoB_FicheET)
		C_TEXT:C284(<>va_ConsoB_FicheGenre)
		C_TEXT:C284(<>va_ConsoB_FicheAge)
		C_BOOLEAN:C305(<>va_ConsoB_115)
		
	: ($1=1)
		<>vl_ConsoB_DocumentLignes:=0
		ARRAY TEXT:C222(<>ta_ConsoB_Document; 0)
		<>vt_ConsoB_Chemin:=""
		<>vt_ConsoB_CheminDossier:=""
		<>vt_ConsoB_Dossier:=""
		
		
	: ($1=2)
		
		ARRAY INTEGER:C220(<>te_ConsoB_Ligne; 0)
		ARRAY TEXT:C222(<>tt_ConsoB_LeDocument; 0)
		ARRAY TEXT:C222(<>ta_ConsoB_Titre; 0)
		ARRAY TEXT:C222(<>tt_ConsoB_Valeur; 0)
		ARRAY INTEGER:C220(<>te_ConsoB_Table; 0)
		ARRAY INTEGER:C220(<>te_ConsoB_Champ; 0)
		ARRAY INTEGER:C220(<>te_ConsoB_ChampType; 0)
		ARRAY TEXT:C222(<>ta_ConsoB_ChampType; 0)
		
		<>vt_ConsoB_Buffer:=""
		
		
		<>vt_ConsoB_Document:=""
		<>vt_ConsoB_Titre:=""
		
		<>va_ConsoB_FicheSiteCode:=""
		<>va_ConsoB_FicheSite:=""
		<>vd_ConsoB_FicheDate:=!00-00-00!
		
		<>va_ConsoB_FicheJour:=""
		<>va_ConsoB_FicheNo:=""
		<>va_ConsoB_FicheET:=""
		<>va_ConsoB_FicheGenre:=""
		<>va_ConsoB_FicheAge:=""
		
	: ($1=3)
		<>vt_ConsoB_Chemin:=""
		<>vt_ConsoB_CheminDossier:=""
		<>vt_ConsoB_Dossier:=""
		
	: ($1=4)
		<>t_ConsoB_Document:=""
		<>vt_ConsoB_Titre:=""
		
		<>va_ConsoB_FicheSiteCode:=""
		<>va_ConsoB_FicheSite:=""
		vd_ConsoB_FicheDate:=!00-00-00!
		<>va_ConsoB_FicheJour:=""
		<>va_ConsoB_FicheNo:=""
		<>va_ConsoB_FicheET:=""
		<>va_ConsoB_FicheGenre:=""
		<>va_ConsoB_FicheAge:=""
		
		
	: ($1=10)
		$ii:=1
		Repeat 
			If ((Length:C16(<>ta_ConsoB_Document{$ii})>=25) & (Length:C16(<>ta_ConsoB_Document{$ii})<=32))
				$ii:=$ii+1
			Else 
				DELETE FROM ARRAY:C228(<>ta_ConsoB_Document; $ii; 1)
			End if 
		Until ($ii>Size of array:C274(<>ta_ConsoB_Document))
End case 

