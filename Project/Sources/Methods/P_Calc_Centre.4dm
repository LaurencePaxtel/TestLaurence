//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_Centre
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_IndTps; $viiRéf; $ii)
C_BOOLEAN:C305($vb_OK)

If (vl_NbJ>366) & (vl_NbJ<1)
	ALERT:C41("Vous ne pouvez pas excéder une année !")
Else 
	
	If (ta_Centre<=0)
		ALERT:C41("Vous devez sélectionner un centre d'hébergement !")
	Else 
		rNonVérif:=0
		
		i_Message("Chargement en cours …")
		i_Stop
		V_Stat_Centre(1)
		
		vl_NbHBd:=0
		vl_NbHB:=0
		ON EVENT CALL:C190("i_Stop_ESC")
		
		i_MessageSeul("recherche en cours  1/4")
		
		If (<>vb_StopEven=False:C215)
			
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
			
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=t_CT_ID{ta_Centre})
			MultiSoc_Filter(->[HeberGement:5])
			
			vl_NbHB:=Records in selection:C76([HeberGement:5])
			
			If (vl_NbHB>0)
				CREATE SET:C116([HeberGement:5]; "E_encours")
			Else 
				CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
			End if 
			
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; <>ts_IDID; [HeberGement:5]HG_Date:4; <>ts_Date; [HeberGement:5]HG_Nuit:2; <>ts_Nuit; \
				[HeberGement:5]HG_HB_ID:19; <>ts_IDHB; [HeberGement:5]HG_LC_ID:61; <>ts_IDLC; [HeberGement:5]HG_Cloturée:67; <>ts_Cloturé; \
				[HeberGement:5]HG_FamChef:103; <>ts_FamChef; [HeberGement:5]HG_FamNbPers:106; <>ts_FamPers; [HeberGement:5]HG_FamNbJour:107; <>ts_FamJours; \
				[HeberGement:5]HG_FamNbChambre:108; <>ts_FamChbres; [HeberGement:5]HG_FamPrixJour:109; <>ts_FamCoûtJ; [HeberGement:5]HG_FamTotal:110; <>ts_FamCoût; \
				[HeberGement:5]HG_NuitenCours:92; <>ts_NuitNo; [HeberGement:5]HG_FamVérifiéeLe:137; <>ts_FamDateV; [HeberGement:5]HG_FamNoDeBon:136; <>ts_FamBon)
			
			vl_DrTDem:=Records in selection:C76([HeberGement:5])
			
			RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
			MultiSoc_Filter(->[HeBerge:4])
			
			vl_DrTPers2:=Records in selection:C76([HeBerge:4])
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >)
			
			vl_DrTPers:=0
			
			Repeat 
				
				If ([HeberGement:5]HG_HB_ID:19#$viiRéf)
					vl_DrTPers:=vl_DrTPers+1
					$viiRéf:=[HeberGement:5]HG_HB_ID:19
				End if 
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
			USE SET:C118("E_encours")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
			
			vl_DrTHg:=Records in selection:C76([HeberGement:5])
			
			RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
			MultiSoc_Filter(->[HeBerge:4])
			
			vl_DrTHgé2:=Records in selection:C76([HeBerge:4])
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >)
			
			CLEAR VARIABLE:C89($viiRéf)
			vl_DrTHgé:=0
			
			Repeat 
				
				If ([HeberGement:5]HG_HB_ID:19#$viiRéf)
					vl_DrTHgé:=vl_DrTHgé+1
					$viiRéf:=[HeberGement:5]HG_HB_ID:19
				End if 
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
		End if 
		
		i_MessageSeul("Calcul en cours  2/4")
		
		If (Size of array:C274(<>ts_Date)>0)
			
			If (<>vb_StopEven=False:C215)
				SORT ARRAY:C229(<>ts_Date; <>ts_IDID; <>ts_Nuit; <>ts_IDHB; <>ts_IDLC; <>ts_Cloturé; <>ts_FamChef; <>ts_FamPers; <>ts_FamJours; \
					<>ts_FamChbres; <>ts_FamCoûtJ; <>ts_FamCoût; <>ts_NuitNo; <>ts_FamDateV; <>ts_FamBon; >)
				
				For ($ii; 1; Size of array:C274(<>ts_Date))
					<>tsp_IDHB:=Find in array:C230(<>tsp_IDHB; <>ts_IDHB{$ii})
					
					If (<>tsp_IDHB>0)
					Else 
						$vl_IndTps:=Size of array:C274(<>tsp_IDHB)+1
						
						INSERT IN ARRAY:C227(<>tsp_IDHB; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(<>tsp_NbJ; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(<>tsp_NbN; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(<>tsp_NbJc; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(<>tsp_NbNc; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(<>tsp_NbTout; $vl_IndTps; 1)
						INSERT IN ARRAY:C227(<>tsp_NbToutc; $vl_IndTps; 1)
						
						<>tsp_IDHB:=$vl_IndTps
						<>tsp_IDHB{<>tsp_IDHB}:=<>ts_IDHB{$ii}
					End if 
					
					If (<>ts_Cloturé{$ii})
						
						If (<>ts_Nuit{$ii}=True:C214)
							<>tsp_NbNc{<>tsp_IDHB}:=<>tsp_NbNc{<>tsp_IDHB}+1
						Else 
							<>tsp_NbJc{<>tsp_IDHB}:=<>tsp_NbJc{<>tsp_IDHB}+1
						End if 
						
					Else 
						
						If (<>ts_Nuit{$ii}=True:C214)
							<>tsp_NbN{<>tsp_IDHB}:=<>tsp_NbN{<>tsp_IDHB}+1
						Else 
							<>tsp_NbJ{<>tsp_IDHB}:=<>tsp_NbJ{<>tsp_IDHB}+1
						End if 
						
					End if 
					
				End for 
				
			End if 
			
		End if 
		
		i_MessageSeul("Calcul en cours  3/4")
		
		If (Size of array:C274(<>ts_Date)>0)
			
			If (<>vb_StopEven=False:C215)
				
				For ($ii; 1; Size of array:C274(<>tsp_IDHB))
					<>tsp_NbTout{$ii}:=<>tsp_NbJ{$ii}+<>tsp_NbN{$ii}
					<>tsp_NbToutc{$ii}:=<>tsp_NbJc{$ii}+<>tsp_NbNc{$ii}
				End for 
				
				SORT ARRAY:C229(<>tsp_NbToutc; <>tsp_NbJc; <>tsp_NbNc; <>tsp_NbTout; <>tsp_NbJ; <>tsp_NbN; <>tsp_IDHB; >)
				For ($ii; 1; Size of array:C274(<>tsp_IDHB))
					
					If (<>tsp_NbToutc{$ii}>0)
						td_ORnb:=Find in array:C230(td_ORnb; <>tsp_NbToutc{$ii})
						
						If (td_ORnb>0)
							td_ORT{td_ORnb}:=td_ORT{td_ORnb}+1
						Else 
							$vl_IndTps:=Size of array:C274(td_ORnb)+1
							
							INSERT IN ARRAY:C227(td_ORnb; $vl_IndTps; 1)
							INSERT IN ARRAY:C227(td_ORJ; $vl_IndTps; 1)
							INSERT IN ARRAY:C227(td_ORN; $vl_IndTps; 1)
							INSERT IN ARRAY:C227(td_ORT; $vl_IndTps; 1)
							
							td_ORnb:=$vl_IndTps
							td_ORnb{td_ORnb}:=<>tsp_NbToutc{$ii}
							td_ORT{td_ORnb}:=td_ORT{td_ORnb}+1
						End if 
						
					End if 
					
				End for 
				
				vl_ORJ:=0
				vl_ORT:=0
				
				For ($ii; 1; Size of array:C274(td_ORT))
					vl_ORT:=vl_ORT+td_ORT{$ii}
					vl_ORJ:=vl_ORJ+(td_ORnb{$ii}*td_ORT{$ii})
				End for 
				
				vl_ORJb:=vl_ORJ
				vl_ORTb:=vl_ORT
				SORT ARRAY:C229(td_ORnb; td_ORT; >)
			End if 
			
		End if 
		
		i_MessageSeul("Calcul en cours  4/4")
		
		If (Size of array:C274(<>ts_Date)>0)
			
			If (<>vb_StopEven=False:C215)
				
				For ($ii; 1; Size of array:C274(<>ts_Date))
					// Si cloturé et chef de famile
					// Nuit ou/et jour
					$vb_OK:=((<>ts_Cloturé{$ii}) & (<>ts_FamChef{$ii}) & (<>ts_NuitNo{$ii}=1))
					
					If ($vb_OK)
						$vl_IndTps:=Find in array:C230(<>tsC_IDHB; <>ts_IDHB{$ii})
						
						If ($vl_IndTps>0)  // L'hébergé existe déja mais est-ce la même réservation
							
							If (<>tsC_Date{$vl_IndTps}=<>ts_Date{$ii})
								$vb_OK:=False:C215
							End if 
							
						End if 
						
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
						
						<>tsC_IDID{$vl_IndTps}:=<>ts_IDID{$ii}
						<>tsC_IDHB{$vl_IndTps}:=<>ts_IDHB{$ii}
						<>tsC_IDGP{$vl_IndTps}:=0
						<>tsC_NbPers{$vl_IndTps}:=<>ts_FamPers{$ii}
						<>tsC_NbJours{$vl_IndTps}:=<>ts_FamJours{$ii}
						<>tsC_NbChbres{$vl_IndTps}:=<>ts_FamChbres{$ii}
						<>tsC_CoutJour{$vl_IndTps}:=<>ts_FamCoûtJ{$ii}
						<>tsC_Cout{$vl_IndTps}:=<>ts_FamCoût{$ii}
						<>tsC_Groupe{$vl_IndTps}:=""
						<>tsC_Clé{$vl_IndTps}:=""
						<>tsC_Date{$vl_IndTps}:=<>ts_Date{$ii}
						<>tsC_DateVérif{$vl_IndTps}:=<>ts_FamDateV{$ii}
						<>tsC_Bon{$vl_IndTps}:=String:C10(<>ts_FamBon{$ii})
						
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
						
					End if 
					
				End for 
				
				SORT ARRAY:C229(<>tsC_Clé; <>tsC_IDID; <>tsC_IDHB; <>tsC_IDGP; <>tsC_NbPers; <>tsC_NbJours; \
					<>tsC_NbChbres; <>tsC_CoutJour; <>tsC_Cout; <>tsC_Groupe; <>tsC_Date; <>tsC_DateVérif; <>tsC_Bon; >)
				
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
		
		ON EVENT CALL:C190("")
		CLOSE WINDOW:C154
	End if 
	
End if 