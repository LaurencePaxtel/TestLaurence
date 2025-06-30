//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_CentreChef
//{
//{          Mardi 29 mars 2005 à 16:44:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_IndTps; $vl_IndDr; $L_ref; $ii)
C_BOOLEAN:C305($vb_OK)
C_OBJECT:C1216($O_Progression)

If (vl_NbJ>366) & (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	
	If (ta_Centre<=0)
		ALERT:C41("Vous devez sélectionner un centre d'hébergement !")
	Else 
		$vb_OK:=True:C214
	End if 
	
End if 

If ($vb_OK)
	V_Stat_Centre(1)
	
	$vl_IndTps:=0
	$vl_IndDr:=0
	vl_NbHBd:=0
	vl_NbHB:=0
	rNonVérif:=0
	
	//i_Message ("Chargement en cours …")
	i_Stop
	ON EVENT CALL:C190("i_Stop_ESC")
	
	$L_ref:=4D_Progression_Open("")
	
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Supervision par tranche"; \
		"progress message"; "Statistique du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2); \
		"progress compteur"; -1; \
		"progress max"; -1; \
		"progress stop"; -1\
		)
	
	OB SET:C1220($O_Progression; \
		"progress message"; "Recherche 1/4 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
		)
	4D_Progression_Send(->$O_Progression)
	
	//i_MessageSeul ("recherche en cours  1/4")
	If (<>vb_StopEven=False:C215)
		
		//Recherche sur les dates, nuit/jour, report et ID centre
		If (vd_Date1=vd_Date2)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
		End if 
		
		If (rReport=0)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
		End if 
		
		If (((rJourNuit1=1) & (rJourNuit2=1)) | ((rJourNuit1=0) & (rJourNuit2=0)))
		Else 
			
			If (rJourNuit1=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
			End if 
			
			If (rJourNuit2=1)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
			End if 
			
		End if 
		
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=t_CT_ID{ta_Centre})
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamChef:103=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		
		vl_NbHB:=Records in selection:C76([HeberGement:5])
		
		If (vl_NbHB>0)
			CREATE SET:C116([HeberGement:5]; "E_encours")
		Else 
			CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
		End if 
		
	End if 
	
	If (<>vb_StopEven=False:C215)
		OB SET:C1220($O_Progression; \
			"progress message"; "Tri... 2/4"\
			)
		4D_Progression_Send(->$O_Progression)
		
		//i_MessageSeul ("Tri en cours  2/4")
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
		MultiSoc_Filter(->[HeberGement:5])
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; <>ts_IDID; [HeberGement:5]HG_Date:4; <>ts_Date; [HeberGement:5]HG_Nuit:2; <>ts_Nuit; \
			[HeberGement:5]HG_HB_ID:19; <>ts_IDHB; [HeberGement:5]HG_LC_ID:61; <>ts_IDLC; [HeberGement:5]HG_Cloturée:67; <>ts_Cloturé; \
			[HeberGement:5]HG_FamChef:103; <>ts_FamChef; [HeberGement:5]HG_FamNbPers:106; <>ts_FamPers; [HeberGement:5]HG_FamNbJour:107; <>ts_FamJours; \
			[HeberGement:5]HG_FamNbChambre:108; <>ts_FamChbres; [HeberGement:5]HG_FamPrixJour:109; <>ts_FamCoûtJ; [HeberGement:5]HG_FamTotal:110; <>ts_FamCoût; \
			[HeberGement:5]HG_NuitenCours:92; <>ts_NuitNo; [HeberGement:5]HG_FamVérifiéeLe:137; <>ts_FamDateV; [HeberGement:5]HG_FamNoDeBon:136; <>ts_FamBon)
	End if 
	
	If (<>vb_StopEven=False:C215)
		
		If (Size of array:C274(<>ts_Date)>0)
			OB SET:C1220($O_Progression; \
				"progress message"; "Calcul en cours 3/4 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
				)
			4D_Progression_Send(->$O_Progression)
			
			//i_MessageSeul ("Calcul en cours  3/4")
			For ($ii; 1; Size of array:C274(<>ts_Date))
				$vl_IndTps:=Find in array:C230(<>tsC_IDHB; <>ts_IDHB{$ii})
				
				If ($vl_IndTps>0)
					$vl_IndTps:=0
					$vb_OK:=False:C215
					
					Repeat 
						$vl_IndTps:=$vl_IndTps+1
						
						If (<>tsC_IDHB{$vl_IndTps}=<>ts_IDHB{$ii})
							$vb_OK:=(<>tsC_Bon{$vl_IndTps}=String:C10(<>ts_FamBon{$ii}))  // c'est le même bon
							$vb_OK:=$vb_OK & (<>tsC_CoutJour{$vl_IndTps}=<>ts_FamCoûtJ{$ii})  // c'est  le même prix jour
							$vb_OK:=$vb_OK & (<>tsC_NbPers{$vl_IndTps}=<>ts_FamPers{$ii})  // c'est  le même nb de personnes
						End if 
						
					Until (($vl_IndTps>=Size of array:C274(<>tsC_IDHB)) | $vb_OK)
					
					If ($vb_OK)  //c'est à rajouter à une fiche existante
						$vb_OK:=False:C215
					Else 
						$vb_OK:=True:C214
					End if 
					
				Else 
					$vb_OK:=True:C214
				End if 
				
				If ($vb_OK)
					$vl_IndTps:=Size of array:C274(<>tsC_IDHB)+1
					INSERT IN ARRAY:C227(<>tsC_IDID; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_IDHB; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_IDGP; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_NbPers; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_NbJours; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_NbChbres; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_CoutJour; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_Cout; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_Groupe; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_Clé; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_Date; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_DateVérif; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_Bon; $vl_IndTps; 1)
					INSERT IN ARRAY:C227(<>tsC_DateFin; $vl_IndTps; 1)
					
					<>tsC_IDID{$vl_IndTps}:=<>ts_IDID{$ii}
					<>tsC_IDHB{$vl_IndTps}:=<>ts_IDHB{$ii}
					<>tsC_IDGP{$vl_IndTps}:=0
					<>tsC_NbPers{$vl_IndTps}:=<>ts_FamPers{$ii}
					<>tsC_NbJours{$vl_IndTps}:=1
					<>tsC_NbChbres{$vl_IndTps}:=<>ts_FamChbres{$ii}
					<>tsC_CoutJour{$vl_IndTps}:=<>ts_FamCoûtJ{$ii}
					<>tsC_Cout{$vl_IndTps}:=<>ts_FamCoûtJ{$ii}
					<>tsC_Groupe{$vl_IndTps}:=""
					<>tsC_Clé{$vl_IndTps}:=""
					<>tsC_Date{$vl_IndTps}:=<>ts_Date{$ii}
					<>tsC_DateVérif{$vl_IndTps}:=<>ts_FamDateV{$ii}
					<>tsC_Bon{$vl_IndTps}:=String:C10(<>ts_FamBon{$ii})
					
					<>tsC_DateFin{$vl_IndTps}:=<>ts_Date{$ii}
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>ts_IDHB{$ii})
					MultiSoc_Filter(->[HeBerge:4])
					
					If (Records in selection:C76([HeBerge:4])=1)
						<>tsC_Clé{$vl_IndTps}:=[HeBerge:4]HB_Clé:2
					End if 
					
					QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=<>ts_IDHB{$ii})
					MultiSoc_Filter(->[GroupeHeberges:37])
					
					If (Records in selection:C76([GroupeHeberges:37])>0)
						SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_GP_Référence:2; $tl_réfGP)
						QUERY WITH ARRAY:C644([GrouPe:36]GP_ReferenceID:1; $tl_réfGP)
						
						If (Size of array:C274($tl_réfGP)>0)
							QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=$tl_réfGP{1})
							<>tsC_IDGP{$vl_IndTps}:=[GrouPe:36]GP_ReferenceID:1
							<>tsC_Groupe{$vl_IndTps}:=[GrouPe:36]GP_Intitulé:4
						End if 
						
					End if 
					
				Else 
					<>tsC_NbJours{$vl_IndTps}:=<>tsC_NbJours{$vl_IndTps}+1
					<>tsC_Cout{$vl_IndTps}:=<>tsC_CoutJour{$vl_IndTps}*<>tsC_NbJours{$vl_IndTps}
					<>tsC_DateFin{$vl_IndTps}:=<>ts_Date{$ii}
				End if 
				
			End for 
			
		End if 
		
	End if 
	
	If (<>vb_StopEven=False:C215)
		
		If (Size of array:C274(<>tsC_IDID)>0)
			OB SET:C1220($O_Progression; \
				"progress message"; "Totaux en cours 4/4 du "+String:C10(vd_Date1)+" au "+String:C10(vd_Date2)\
				)
			
			4D_Progression_Send(->$O_Progression)
			
			//i_MessageSeul ("Totaux en cours  4/4")
			<>vl_NbJours:=0
			<>vl_NbChbres:=0
			<>vl_NbPers:=0
			<>vr_CoutJ:=0
			<>vr_Cout:=0
			
			For ($ii; 1; Size of array:C274(<>tsC_Clé))
				<>vl_NbJours:=<>vl_NbJours+<>tsC_NbJours{$ii}
				<>vl_NbChbres:=<>vl_NbChbres+<>tsC_NbChbres{$ii}
				<>vl_NbPers:=<>vl_NbPers+<>tsC_NbPers{$ii}
				<>vr_CoutJ:=<>vr_CoutJ+<>tsC_CoutJour{$ii}
				<>vr_Cout:=<>vr_Cout+<>tsC_Cout{$ii}
			End for 
			
		End if 
		
	End if 
	
	4D_Progression_Close($L_ref)
	
	ON EVENT CALL:C190("")
	CLOSE WINDOW:C154
End if 