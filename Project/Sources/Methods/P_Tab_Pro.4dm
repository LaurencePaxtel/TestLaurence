//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Tab_Pro
//{
//{          Dimanche 19 septembre 2004 à 13:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //le cas
C_LONGINT:C283($2)  //un indice


Case of 
		
	: ($1=-1)  //une initialisation de variables ???
		
	: ($1=0)  //Déclaration de tableaux
		ARRAY LONGINT:C221(<>tl_PR_Réf; 0)
		ARRAY LONGINT:C221(<>tl_PR_GPid; 0)
		ARRAY DATE:C224(<>td_PR_DateDéb; 0)
		ARRAY DATE:C224(<>td_PR_DateFin; 0)
		ARRAY LONGINT:C221(<>te_PR_NbJours; 0)
		ARRAY LONGINT:C221(<>tl_PR_CentreRéf; 0)
		ARRAY TEXT:C222(<>ta_PR_Centre; 0)
		ARRAY BOOLEAN:C223(<>tb_PR_Effectuée; 0)
		ARRAY TEXT:C222(<>ta_PR_Effectuée; 0)
		P_Tab_Pro(1; $2)
		
	: ($1=1)  //Synchro des indices
		<>tl_PR_Réf:=$2
		<>tl_PR_GPid:=$2
		<>td_PR_DateDéb:=$2
		<>td_PR_DateFin:=$2
		<>te_PR_NbJours:=$2
		<>tl_PR_CentreRéf:=$2
		<>ta_PR_Centre:=$2
		<>tb_PR_Effectuée:=$2
		<>ta_PR_Effectuée:=$2
		
	: ($1=2)  //Réduire selection
		REDUCE SELECTION:C351([Prolongation:38]; 0)
		
	: ($1=3)  //Rechercher    
		QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[Prolongation:38])
		vL_Nb_PR:=Records in selection:C76([Prolongation:38])
		ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
		
		
	: ($1=4)  //Recherche et affectation des tableaux
		P_Tab_Pro(0; 0)
		QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[Prolongation:38])
		vL_Nb_PR:=Records in selection:C76([Prolongation:38])
		ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
		SELECTION TO ARRAY:C260([Prolongation:38]PR_RéférenceID:1; <>tl_PR_Réf; [Prolongation:38]PR_GPHB_Référence:5; <>tl_PR_GPid; [Prolongation:38]PR_RésaDateDébut:6; <>td_PR_DateDéb; [Prolongation:38]PR_RésaDateFin:7; <>td_PR_DateFin; [Prolongation:38]PR_RésaNbJours:8; <>te_PR_NbJours; [Prolongation:38]PR_LC_ID:9; <>tl_PR_CentreRéf; [Prolongation:38]PR_CentreNoms:10; <>ta_PR_Centre; [Prolongation:38]PR_ProlongationEffectuée:11; <>tb_PR_Effectuée)
		
		ARRAY TEXT:C222(<>ta_PR_Effectuée; vL_Nb_PR)
		For ($ii; 1; vL_Nb_PR)
			<>ta_PR_Effectuée{$ii}:=("Fait"*Num:C11(<>tb_PR_Effectuée{$ii}=True:C214))+(""*Num:C11(<>tb_PR_Effectuée{$ii}=False:C215))
		End for 
		va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
		vd_FinRésa:=!00-00-00!
		va_FinRésa:=""
		
		P_Tab_Pro(1; 0)
		
		
	: ($1=5)  //Rajout
		
	: ($1=6)  //Suppression
		
	: ($1=8)  //Trier par date de début de réservation
		SORT ARRAY:C229(<>td_PR_DateDéb; <>tl_PR_Réf; <>tl_PR_GPid; <>td_PR_DateFin; <>te_PR_NbJours; <>tl_PR_CentreRéf; <>ta_PR_Centre; <>tb_PR_Effectuée; <>ta_PR_Effectuée; <)
		
		
End case 