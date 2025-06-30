//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Tab_PR
//{
//{          Lundi 13 septembre 2004 à 10:53:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //le cas
C_LONGINT:C283($2)  //un indice

C_LONGINT:C283($ii; $ij)

Case of 
	: ($1=-1)  //une initialisation de variables ???
		va_GPmembres:=F_HébergementGroupeProlong("")
		va_GPLib:=""
		va_GPLibel:=""
		va_GPLibel:="Groupe "+("Nuit"*Num:C11(va_JourNuit="N"))+("Jour"*Num:C11(va_JourNuit="J"))
	: ($1=0)  //Déclaration de tableaux
		ARRAY TEXT:C222(<>ta_GpP_Clé; $2)
		ARRAY TEXT:C222(<>ta_GpP_EtCv; $2)
		ARRAY TEXT:C222(<>ta_GpP_Etat; $2)
		
		ARRAY INTEGER:C220(<>te_GpP_Ordre; $2)
		ARRAY INTEGER:C220(<>te_GpP_Check; $2)
		ARRAY INTEGER:C220(<>te_GpP_Etat; $2)
		
		ARRAY LONGINT:C221(<>tl_GpP_Réfi; $2)
		ARRAY LONGINT:C221(<>tl_GpP_GPID; $2)
		ARRAY LONGINT:C221(<>tl_GpP_HBID; $2)
		
		P_Tab_GP(1; $2)
		
		If ($2>0)
			va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
		Else 
			va_GPmembres:=F_HébergementGroupeProlong("")
		End if 
		
		va_NNN:=""
		va_FrappeClavier:=""
		va_IDT_Nom:=""
		va_IDT_Pré:=""
		va_IDT_Clé:=""
		
		vL_Nb_HG_F:=0
		ve_IDT_Age:=0
		ve_IDT_PCAge:=0
		
		vd_IDT_NéLe:=!00-00-00!
		
		REDUCE SELECTION:C351([HeberGement:5]; 0)
	: ($1=1)  //Synchro des indices
		<>te_GpP_Ordre:=$2
		<>te_GpP_Check:=$2
		<>tl_GpP_Réfi:=$2
		<>tl_GpP_GPID:=$2
		<>tl_GpP_HBID:=$2
		<>ta_GpP_Clé:=$2
		<>ta_GpP_EtCv:=$2
		<>ta_GpP_Etat:=$2
		<>te_GpP_Etat:=$2
		
	: ($1=2)  //Réduire selection
		REDUCE SELECTION:C351([GroupeHeberges:37]; 0)
		va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
	: ($1=3)  //Rechercher
		QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[GroupeHeberges:37])
		
		va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
	: ($1=4)  //Recherche et affectation des tableaux
		P_Tab_PR(0; 0)
		
		QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_GP_Référence:2=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[GroupeHeberges:37])
		
		SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_ReferenceID:1; <>tl_GpP_Réfi; [GroupeHeberges:37]GH_GP_Référence:2; <>tl_GpP_GPID; [GroupeHeberges:37]GH_HB_Référence:3; <>tl_GpP_HBID; [GroupeHeberges:37]GH_HB_Clé:4; <>ta_GpP_Clé; [GroupeHeberges:37]GH_EtatCivil:5; <>ta_GpP_EtCv; [GroupeHeberges:37]GH_Ordre:6; <>te_GpP_Ordre)
		$ii:=Size of array:C274(<>tl_GpP_Réfi)
		
		ARRAY TEXT:C222(<>ta_GpP_Etat; $ii)
		
		ARRAY INTEGER:C220(<>te_GpP_Check; $ii)
		ARRAY INTEGER:C220(<>te_GpP_Etat; $ii)
		
		vL_Nb_GH:=$ii
		
		For ($ii; 1; vL_Nb_GH)
			<>te_GpP_Check{$ii}:=1
		End for 
		
		va_GPmembres:=F_HébergementGroupeProlong([GrouPe:36]GP_Intitulé:4)
		vd_FinRésa:=!00-00-00!
		va_FinRésa:=""
		
		P_Tab_PR(8; 0)
		P_Tab_PR(1; 0)
		P_Tab_PR(10; 0)
		
		If (vL_Nb_GH>0)
			P_Tab_PR(1; 1)
			
			vL_Nb_HG_F:=0
			va_NNN:=""
			
			REDUCE SELECTION:C351([HeberGement:5]; 0)
			
			If (<>ta_GpP_Clé>0)
				va_FrappeClavier:=""
				va_IDT_Nom:=""
				va_IDT_Pré:=""
				va_IDT_Clé:=<>ta_GpP_Clé{<>ta_GpP_Clé}
				
				ve_IDT_Age:=0
				ve_IDT_PCAge:=0
				
				vd_IDT_NéLe:=!00-00-00!
				
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>ta_GpP_Clé{<>ta_GpP_Clé})
				
				If (Records in selection:C76([HeBerge:4])=1)
					vL_Nb_HG_F:=0
					va_NNN:=F_AfficheCléHébergé
					
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
					MultiSoc_Filter(->[HeberGement:5])
					
					vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
					
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
					
					FIRST RECORD:C50([HeberGement:5])
					PREVIOUS RECORD:C110([HeberGement:5])
				End if 
				
			End if 
			
		End if 
	: ($1=5)  //Rajout d'un membre
	: ($1=6)  //Suppression d'un membre
	: ($1=8)  //Tri par n°d'ordre
		SORT ARRAY:C229(<>te_GpP_Ordre; <>te_GpP_Check; <>tl_GpP_GPID; <>tl_GpP_HBID; <>tl_GpP_Réfi; <>ta_GpP_Clé; <>ta_GpP_EtCv; <>ta_GpP_Etat; <>te_GpP_Etat; >)
		
		If (Size of array:C274(<>te_GpP_Check)>0)
			$ii:=1
			
			Repeat 
				
				If (<>te_GpP_Check{$ii}=1)
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>tl_GpP_HBID{$ii})
					MultiSoc_Filter(->[HeberGement:5])
					
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
					
					vd_FinRésa:=[HeberGement:5]HG_RéservationDateFin:134
					va_FinRésa:=("Fin de réservation : "+String:C10(vd_FinRésa; Système date court:K1:1))
					
					$ii:=Size of array:C274(<>te_GpP_Check)+100
				Else 
					$ii:=$ii+1
				End if 
				
			Until ($ii>Size of array:C274(<>te_GpP_Check))
			
		End if 
		
	: ($1=9)  //Le responsable mis en N°1 et les autres par ordre alpha
	: ($1=10)  //Recherche et affectation du statut des membres du groupe
		$ij:=Size of array:C274(<>te_GpP_Check)
		
		If ($ij>0)
			i_Message("Situation des membres…")
			
			For ($ii; 1; $ij)
				i_MessageSeul("Situation des membres recherche en cours : "+String:C10(Size of array:C274(<>ta_GpP_Clé))+"/"+String:C10($ii))
				F_HébergementGroupeProlong(va_JourNuit; $ii)
			End for 
			
			CLOSE WINDOW:C154
		End if 
		
	: ($1=12)
		
		If (Size of array:C274(<>ta_GpP_Clé)>0)
			vL_Nb_HG_F:=0
			va_NNN:=""
			
			REDUCE SELECTION:C351([HeberGement:5]; 0)
			
			If ($2>0)
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>ta_GpP_Clé{$2})
				MultiSoc_Filter(->[HeBerge:4])
				
				If (Records in selection:C76([HeBerge:4])=1)
					vL_Nb_HG_F:=0
					va_NNN:=F_AfficheCléHébergé
					
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
					MultiSoc_Filter(->[HeberGement:5])
					
					vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
					
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
					
					FIRST RECORD:C50([HeberGement:5])
					PREVIOUS RECORD:C110([HeberGement:5])
				End if 
				
			End if 
			
		End if 
		
End case 