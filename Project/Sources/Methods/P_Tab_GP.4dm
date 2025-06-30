//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Tab_GP
//{
//{          Mardi 9 mars 2004 à 12:30:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //le cas
C_LONGINT:C283($2)  //un indice

C_TEXT:C284($jourNuit_t)
C_LONGINT:C283($ii; $ij)  // #Fix20170424-4

If (Count parameters:C259=3)
	C_POINTER:C301($3)  //un pointeur
End if 

If (Value type:C1509(va_JourNuit)#Est une variable indéfinie:K8:13) & (va_JourNuit#"")
	$jourNuit_t:=va_JourNuit
	
	If (va_JourNuit="JN")
		$jourNuit_t:=Choose:C955([GrouPe:36]GP_Nuit:5=True:C214; "N"; "J")
	End if 
	
End if 

Case of 
	: ($1=-1)  //une initialisation de variables ???
		va_GPmembres:=F_HébergementGroupeTitre("")
		va_GPLib:=""
		va_GPLibel:=""
		va_GPLibel:="Groupe "+("Nuit"*Num:C11($jourNuit_t="N"))+("Jour"*Num:C11($jourNuit_t="J"))
	: ($1=0)  //Déclaration de tableaux
		ARRAY INTEGER:C220(<>te_GpOrdre; $2)
		ARRAY INTEGER:C220(<>te_GpCheck; $2)
		
		ARRAY LONGINT:C221(<>tl_GpRéfi; $2)
		ARRAY LONGINT:C221(<>tl_GpGPID; $2)
		ARRAY LONGINT:C221(<>tl_GpHBID; $2)
		
		ARRAY TEXT:C222(<>ta_GpClé; $2)
		ARRAY TEXT:C222(<>ta_GpEtCv; $2)
		ARRAY TEXT:C222(<>ta_GpEtat; $2)
		ARRAY INTEGER:C220(<>te_GpEtat; $2)
		
		P_Tab_GP(1; $2)
		
		If ($2>0)
			va_GPmembres:=F_HébergementGroupeTitre([GrouPe:36]GP_Intitulé:4)
		Else 
			va_GPmembres:=F_HébergementGroupeTitre("")
		End if 
		
	: ($1=1)  //Synchro des indices
		<>te_GpOrdre:=$2
		<>te_GpCheck:=$2
		<>tl_GpRéfi:=$2
		<>tl_GpGPID:=$2
		<>tl_GpHBID:=$2
		<>ta_GpClé:=$2
		<>ta_GpEtCv:=$2
		<>ta_GpEtat:=$2
		<>te_GpEtat:=$2
	: ($1=2)
		REDUCE SELECTION:C351([GroupeHeberges:37]; 0)
		va_GPmembres:=F_HébergementGroupeTitre([GrouPe:36]GP_Intitulé:4)
		
	: ($1=3)
		QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[GroupeHeberges:37])
		va_GPmembres:=F_HébergementGroupeTitre([GrouPe:36]GP_Intitulé:4)
		
	: ($1=4)  //Recherche et affectation des tableaux
		P_Tab_GP(0; 0)
		
		QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
		
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_ReferenceID:1; <>tl_GpRéfi; *)  // #Fix20170424-4
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_GP_Référence:2; <>tl_GpGPID; *)
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_HB_Référence:3; <>tl_GpHBID; *)
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_HB_Clé:4; <>ta_GpClé; *)
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_EtatCivil:5; <>ta_GpEtCv; *)
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_Ordre:6; <>te_GpOrdre)
		
		$ii:=Size of array:C274(<>tl_GpRéfi)
		ARRAY INTEGER:C220(<>te_GpCheck; $ii)
		ARRAY TEXT:C222(<>ta_GpEtat; $ii)
		ARRAY INTEGER:C220(<>te_GpEtat; $ii)
		
		vL_Nb_GH:=$ii
		
		For ($ii; 1; vL_Nb_GH)
			<>te_GpCheck{$ii}:=1
		End for 
		
		va_GPmembres:=F_HébergementGroupeTitre([GrouPe:36]GP_Intitulé:4)
		
		P_Tab_GP(8; 0)
		P_Tab_GP(1; 0)
		P_Tab_GP(10; 0)
	: ($1=5)  //Rajout d'un membre
		$ii:=Size of array:C274(<>te_GpCheck)+1
		
		INSERT IN ARRAY:C227(<>te_GpOrdre; $ii)
		INSERT IN ARRAY:C227(<>te_GpCheck; $ii)
		INSERT IN ARRAY:C227(<>tl_GpGPID; $ii)
		INSERT IN ARRAY:C227(<>tl_GpHBID; $ii)
		INSERT IN ARRAY:C227(<>tl_GpRéfi; $ii)
		INSERT IN ARRAY:C227(<>ta_GpClé; $ii)
		INSERT IN ARRAY:C227(<>ta_GpEtCv; $ii)
		INSERT IN ARRAY:C227(<>ta_GpEtat; $ii)
		INSERT IN ARRAY:C227(<>te_GpEtat; $ii)
		
		<>te_GpCheck{$ii}:=1
		<>tl_GpGPID{$ii}:=[GroupeHeberges:37]GH_GP_Référence:2
		<>tl_GpHBID{$ii}:=[GroupeHeberges:37]GH_HB_Référence:3
		<>tl_GpRéfi{$ii}:=[GroupeHeberges:37]GH_ReferenceID:1
		<>ta_GpClé{$ii}:=[GroupeHeberges:37]GH_HB_Clé:4
		<>ta_GpEtCv{$ii}:=[GroupeHeberges:37]GH_EtatCivil:5
		<>te_GpOrdre{$ii}:=[GroupeHeberges:37]GH_Ordre:6
		<>ta_GpEtat{$ii}:=""
		<>te_GpEtat{$ii}:=0
		
		P_Tab_GP(1; $ii)
		P_Tab_GP(3; $ii)
	: ($1=6)  //Suppression d'un membre
		$ii:=$2
		
		DELETE FROM ARRAY:C228(<>te_GpOrdre; $ii; 1)
		DELETE FROM ARRAY:C228(<>te_GpCheck; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_GpGPID; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_GpHBID; $ii; 1)
		DELETE FROM ARRAY:C228(<>tl_GpRéfi; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_GpClé; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_GpEtCv; $ii; 1)
		DELETE FROM ARRAY:C228(<>ta_GpEtat; $ii; 1)
		DELETE FROM ARRAY:C228(<>te_GpEtat; $ii; 1)
		
		If ($ii>Size of array:C274(<>te_GpCheck))
			$ii:=$ii-1
		End if 
		
		P_Tab_GP(1; $ii)
		P_Tab_GP(3; $ii)
	: ($1=8)  //Tri par n°d'ordre
		SORT ARRAY:C229(<>te_GpOrdre; <>te_GpCheck; <>tl_GpGPID; <>tl_GpHBID; <>tl_GpRéfi; <>ta_GpClé; <>ta_GpEtCv; <>ta_GpEtat; <>te_GpEtat; >)
	: ($1=9)  //Le responsable mis en N°1 et les autres par ordre alpha
		SORT ARRAY:C229(<>ta_GpClé; <>te_GpOrdre; <>te_GpCheck; <>tl_GpGPID; <>tl_GpHBID; <>tl_GpRéfi; <>ta_GpEtCv; <>ta_GpEtat; <>te_GpEtat; >)
		
		For ($ii; 1; Size of array:C274(<>ta_GpClé))
			<>te_GpOrdre{$ii}:=$ii
		End for 
		
		$ii:=Find in array:C230(<>tl_GpRéfi; $2)
		
		If ($ii<0)
		Else 
			<>te_GpOrdre{$ii}:=-1
		End if 
		
		P_Tab_GP(8; 0)  //Tri par n° d'ordre
		
		For ($ii; 1; Size of array:C274(<>ta_GpClé))
			<>te_GpOrdre{$ii}:=$ii
		End for 
		
		P_Tab_GP(1; 1)
		
		READ WRITE:C146([GroupeHeberges:37])
		
		For ($ii; 1; Size of array:C274(<>ta_GpClé))
			QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_ReferenceID:1=<>tl_GpRéfi{$ii})
			MultiSoc_Filter(->[GroupeHeberges:37])
			
			If (Records in selection:C76([GroupeHeberges:37])=1)
				
				If (Not:C34(Locked:C147([GroupeHeberges:37])))
					[GroupeHeberges:37]GH_Ordre:6:=<>te_GpOrdre{$ii}
					SAVE RECORD:C53([GroupeHeberges:37])
				End if 
				
			End if 
			
		End for 
		
		UNLOAD RECORD:C212([GroupeHeberges:37])
		READ ONLY:C145([GroupeHeberges:37])
	: ($1=10)  //Recherche et affectation du statut des membres du groupe
		$ij:=Size of array:C274(<>te_GpCheck)
		
		If ($ij>0)
			
			For ($ii; 1; $ij)
				P_HébergementCtrlCréationGpe($jourNuit_t; $ii)  // #BS Migration : manque un $0
			End for 
			
		End if 
		
	: ($1=11)
		
		If (Size of array:C274(<>te_GpCheck)>0)
			
			If ($2>0)
				va_FrappeClavier:=""
				va_IDT_Nom:=""
				va_IDT_Pré:=""
				vd_IDT_NéLe:=!00-00-00!
				ve_IDT_Age:=0
				ve_IDT_PCAge:=0
				va_IDT_Clé:=<>ta_GpClé{$2}
				va_IDT_Nom:=Substring:C12(va_IDT_Clé; 1; 30)
				
				va_IDT_Nom:=Substring:C12(va_IDT_Clé; 1; 29)
				va_FrappeClavier:=va_IDT_Nom
				If (va_FrappeClavier="")
					REDUCE SELECTION:C351([HeBerge:4]; 0)
				Else 
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_FrappeClavier+"@"))
					MultiSoc_Filter(->[HeBerge:4])
				End if 
				vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
				ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
				//DÉBUT SELECTION([HeBerge])// #Fix20170424-4
				REDUCE SELECTION:C351([HeberGement:5]; 0)
				vL_Nb_HG_F:=0
				va_NNN:=""
				P_HébergementNotesBt(0)
				
				Rec_Hébergements1(->vL_Nb_HG_F)
				va_NNN:=F_AfficheCléHébergé
				
				P_HébergementNotesBt(1)
				If (wresMulti=0)
					OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
				End if 
				POST CLICK:C466(290; 62)
			End if 
		End if 
		
	: ($1=12)
		$ii:=Find in array:C230(<>tl_GpHBID; $2)
		
		If ($ii<0)
		Else 
			P_Tab_GP(11; $ii)
			P_Tab_GP(1; $ii)
			
		End if 
		
	: ($1=13)
		$3->:=<>ta_GpClé{$2}
End case 