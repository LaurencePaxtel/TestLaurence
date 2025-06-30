//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PR_data
//{
//{          Lundi 4 octobre 2004 à 10:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)

Case of 
	: ($1=0)
		ARRAY LONGINT:C221(tl_PR_HGréf; 0)
		ARRAY LONGINT:C221(tl_PR_PRréf; 0)
		
		ARRAY DATE:C224(td_PR_DateDébut; 0)
		ARRAY DATE:C224(td_PR_DateFin; 0)
		
		ARRAY LONGINT:C221(tl_PR_Jours; 0)
		ARRAY LONGINT:C221(tl_PR_Centre; 0)
		
		ARRAY TEXT:C222(ta_PR_FamCompo; 0)
		ARRAY TEXT:C222(ta_PR_FamCompoV; 0)
		
		ARRAY INTEGER:C220(te_PR_FamNbPers; 0)
		ARRAY INTEGER:C220(te_PR_FamNbJ; 0)
		ARRAY INTEGER:C220(te_PR_FamNbCh; 0)
		
		ARRAY REAL:C219(tr_PR_FamPrixJ; 0)
		ARRAY REAL:C219(tr_PR_FamPrixT; 0)
	: ($1=1)
		td_PR_DateDébut:=$2
		td_PR_DateFin:=$2
		
		tl_PR_HGréf:=$2
		tl_PR_Jours:=$2
		tl_PR_Centre:=$2
		
		ta_PR_FamCompo:=$2
		ta_PR_FamCompoV:=$2
		
		te_PR_FamNbPers:=$2
		te_PR_FamNbJ:=$2
		te_PR_FamNbCh:=$2
		
		tr_PR_FamPrixJ:=$2
		tr_PR_FamPrixT:=$2
	: ($1=2)
		$ii:=Size of array:C274(tl_PR_HGréf)+1
		INSERT IN ARRAY:C227(tl_PR_HGréf; $ii)
		INSERT IN ARRAY:C227(tl_PR_PRréf; $ii)
		
		INSERT IN ARRAY:C227(td_PR_DateDébut; $ii)
		INSERT IN ARRAY:C227(td_PR_DateFin; $ii)
		
		INSERT IN ARRAY:C227(tl_PR_Jours; $ii)
		INSERT IN ARRAY:C227(tl_PR_Centre; $ii)
		
		INSERT IN ARRAY:C227(ta_PR_FamCompo; $ii)
		INSERT IN ARRAY:C227(ta_PR_FamCompoV; $ii)
		
		INSERT IN ARRAY:C227(te_PR_FamNbPers; $ii)
		INSERT IN ARRAY:C227(te_PR_FamNbJ; $ii)
		INSERT IN ARRAY:C227(te_PR_FamNbCh; $ii)
		
		INSERT IN ARRAY:C227(tr_PR_FamPrixJ; $ii)
		INSERT IN ARRAY:C227(tr_PR_FamPrixT; $ii)
	: ($1=3)
		$ii:=Size of array:C274(tl_PR_HGréf)
		tl_PR_HGréf{$ii}:=[HeberGement:5]HG_ReferenceID:1
		tl_PR_PRréf{$ii}:=[Prolongation:38]PR_RéférenceID:1
		
		td_PR_DateDébut{$ii}:=[Prolongation:38]PR_RésaDateDébut:6
		td_PR_DateFin{$ii}:=[Prolongation:38]PR_RésaDateFin:7
		
		tl_PR_Jours{$ii}:=[Prolongation:38]PR_RésaNbJours:8
		tl_PR_Centre{$ii}:=[Prolongation:38]PR_LC_ID:9
		
		ta_PR_FamCompo{$ii}:=[Prolongation:38]PR_FamilleComposition:15
		ta_PR_FamCompo{$ii}:=[Prolongation:38]PR_FamilleCompositionV:16
		
		te_PR_FamNbPers{$ii}:=[Prolongation:38]PR_NbPersonnes:17
		te_PR_FamNbJ{$ii}:=[Prolongation:38]PR_NbJours:18
		te_PR_FamNbCh{$ii}:=[Prolongation:38]PR_NbChambres:19
		
		tr_PR_FamPrixJ{$ii}:=[Prolongation:38]PR_PrixJour:20
		tr_PR_FamPrixT{$ii}:=[Prolongation:38]PR_PrixTotal:21
	: ($1=4)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_PR_HGréf)
End case 