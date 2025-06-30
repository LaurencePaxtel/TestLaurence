//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_AddPersonne
//{
//{          Lundi 3 janvier 2011 à 11:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_SIAO_PopSitFam; 6)
		ARRAY TEXT:C222(ta_SIAO_PopSitFamCode; 6)
		ta_SIAO_PopSitFam{1}:="Ajouter une personne"
		ta_SIAO_PopSitFamCode{1}:="XXX"
		ta_SIAO_PopSitFam{2}:="-"
		ta_SIAO_PopSitFamCode{2}:="XXX"
		
		
		ta_SIAO_PopSitFam{3}:="Ajouter demandeur"
		ta_SIAO_PopSitFamCode{3}:="Demandeur"
		ta_SIAO_PopSitFam{4}:="Ajouter conjoint"
		ta_SIAO_PopSitFamCode{4}:="Conjoint"
		ta_SIAO_PopSitFam{5}:="Ajouter codemandeur"
		ta_SIAO_PopSitFamCode{5}:="Co-demandeur"
		ta_SIAO_PopSitFam{6}:="Ajouter enfant"
		ta_SIAO_PopSitFamCode{6}:="Enfant"
		
End case 
