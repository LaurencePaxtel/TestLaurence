//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_Page
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
		ARRAY TEXT:C222(ta_SIAO_Page; 12)
		ARRAY TEXT:C222(ta_SIAO_PageTitre; 12)
		ARRAY INTEGER:C220(te_SIAO_PageNo; 12)
		
		C_TEXT:C284(va_SIAO_PageTitre)
		
		
		C_LONGINT:C283(vl_SIAO_PageNo)
		
		va_SIAO_PageTitre:=""
		ta_SIAO_Page{1}:="Eléments de la demande"
		ta_SIAO_PageTitre{1}:="ELEMENTS DE LA DEMANDE"
		te_SIAO_PageNo{1}:=1
		
		ta_SIAO_Page{2}:="Adresses"
		ta_SIAO_PageTitre{2}:="ADRESSES"
		te_SIAO_PageNo{2}:=2
		
		ta_SIAO_Page{3}:="Renseignements administratifs"
		ta_SIAO_PageTitre{3}:="RENSEIGNEMENTS ADMINISTRATIFS"
		te_SIAO_PageNo{3}:=3
		
		ta_SIAO_Page{4}:="Situation professionnelle"
		ta_SIAO_PageTitre{4}:="SITUATION PROFESSIONNELLE"
		te_SIAO_PageNo{4}:=4
		
		ta_SIAO_Page{5}:="Ressources"
		ta_SIAO_PageTitre{5}:="RESSOURCES"
		te_SIAO_PageNo{5}:=5
		
		ta_SIAO_Page{6}:="Endettement"
		ta_SIAO_PageTitre{6}:="ENDETTEMENT"
		te_SIAO_PageNo{6}:=6
		
		ta_SIAO_Page{7}:="Situation en regard du logement"
		ta_SIAO_PageTitre{7}:="SITUATION EN REGARD DU LOGEMENT"
		te_SIAO_PageNo{7}:=7
		
		ta_SIAO_Page{8}:="Situation en regard de la demande de logement"
		ta_SIAO_PageTitre{8}:="SITUATION EN REGARD DE LA DEMANDE DE LOGEMENT"
		te_SIAO_PageNo{8}:=8
		
		ta_SIAO_Page{9}:="Evaluation réalisée par le professionnel"
		ta_SIAO_PageTitre{9}:="EVALUATION REALISEE PAR LE PROFESSIONNEL"
		te_SIAO_PageNo{9}:=9
		
		ta_SIAO_Page{10}:="Préconisation du professionnel"
		ta_SIAO_PageTitre{10}:="PRECONISATION DU PROFESSIONNEL"
		te_SIAO_PageNo{10}:=10
		
		ta_SIAO_Page{11}:="Préconisation du professionnel suite"
		ta_SIAO_PageTitre{11}:="PRECONISATION DU PROFESSIONNEL SUITE"
		te_SIAO_PageNo{11}:=11
		
		ta_SIAO_Page{12}:="Propositions"
		ta_SIAO_PageTitre{12}:="PROPOSITIONS"
		te_SIAO_PageNo{12}:=12
		
		vl_SIAO_PageNo:=1
		ta_SIAO_Page:=vl_SIAO_PageNo
		ta_SIAO_PageTitre:=vl_SIAO_PageNo
		te_SIAO_PageNo:=vl_SIAO_PageNo
		
End case 
