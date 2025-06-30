//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_SIAO_Var_ModPersonne
//{
//{          Lundi 7 février 2011 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_SIAO_PopModFam; 5)
		ARRAY TEXT:C222(ta_SIAO_PopModFamCode; 5)
		ta_SIAO_PopModFam{1}:="Modifications"
		ta_SIAO_PopModFamCode{1}:="XXX"
		ta_SIAO_PopModFam{2}:="-"
		ta_SIAO_PopModFamCode{2}:="XXX"
		
		
		ta_SIAO_PopModFam{3}:="Modifier la cle"
		ta_SIAO_PopModFamCode{3}:="ModCle"
		ta_SIAO_PopModFam{4}:="-"
		ta_SIAO_PopModFamCode{4}:="XXX"
		ta_SIAO_PopModFam{5}:="Supprimer de la liste"
		ta_SIAO_PopModFamCode{5}:="Sup"
		
End case 
