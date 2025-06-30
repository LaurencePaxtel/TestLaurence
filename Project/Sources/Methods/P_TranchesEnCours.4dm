//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_TranchesEnCours
//{          Mercredi 3 février 2010 à 12:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================} 
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_TEXT:C284($va_EtCivil; $va_EtCv)
C_LONGINT:C283($ii; $jj; $k; $vl_NbTranches; $vl_TrancheEnCours; $vl_TrancheLigne; $vl_pos; $vl_TrancheFichesOK; $vl_bcle; $vl_Position1; $vl_RéfHB; $vl_Jours)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_TrancheColTotal; vl_TrancheColEtatCivil; vl_TrancheLigneEtatCivil; vl_TrancheDiffTotal)
		vl_TrancheLigneEtatCivil:=4
		C_LONGINT:C283(ve_TrancheCasNew)
		ve_TrancheCasNew:=0
		
		
		ARRAY TEXT:C222(ta_MoisColEtatCivil; vl_MoisLigneEtatCivil)
		ta_MoisColEtatCivil{1}:="Homme seul"  //(HS)
		ta_MoisColEtatCivil{2}:="Femme seule"  //(FS)
		ta_MoisColEtatCivil{3}:="Couples"  //(HC-FC)
		ta_MoisColEtatCivil{4}:="Familles"  //(HF-HE-FF-FE FP-HP)
		
		
		
		ARRAY TEXT:C222(ta_TrancheColEtatCivil; vl_TrancheLigneEtatCivil)
		
		//  COPIER TABLEAU(◊ta_TBEtCiv;ta_TrancheColEtatCivil)
		//  vl_TrancheLigneEtatCivil:=Taille tableau(ta_TrancheColEtatCivil)
		
		
		ta_TrancheColEtatCivil{1}:="Homme seul"  //(HS)
		ta_TrancheColEtatCivil{2}:="Femme seule"  //(FS)
		ta_TrancheColEtatCivil{3}:="Couples"  //(HC-FC)
		ta_TrancheColEtatCivil{4}:="Familles"  //(HF-HE-FF-FE FP-HP)
		
		
		
		ARRAY TEXT:C222(ta_TrancheDemande; 3)
		ta_TrancheDemande{1}:="Toutes les demandes"
		ta_TrancheDemande{2}:="Les demandes satisfaites"
		ta_TrancheDemande{3}:="Les demandes non satisfaites"
		ta_TrancheDemande:=2
		ta_TrancheDemande{0}:=ta_TrancheDemande{ta_TrancheDemande}
		
		C_DATE:C307(vd_DateAfficheDebut; vd_DateAfficheFin)
		C_LONGINT:C283(ve_TrancheAffichéDébut; ve_TrancheAffichéFin)
		C_TEXT:C284(va_TrancheAffiche1; va_TrancheAffiche2; va_TrancheAffiche3; va_TrancheAffiche4; va_TrancheAffiche5; va_TrancheAffiche6)
		C_TEXT:C284(va_TrancheAffiche7; va_TrancheAffiche8; va_TrancheAffiche9; va_TrancheAffiche10; va_TrancheAffiche11; va_TrancheAffiche12)
		ve_TrancheAffichéDébut:=0
		ve_TrancheAffichéFin:=0
		
		ARRAY LONGINT:C221(tl_TranchePersOld; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol1; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol2; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol3; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol4; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol5; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol6; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol7; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol8; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol9; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol10; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol11; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol12; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_TrancheCol12; vl_TrancheLigneEtatCivil)
		
		C_LONGINT:C283(vl_TrancheCol1)
		C_LONGINT:C283(vl_TrancheCol2)
		C_LONGINT:C283(vl_TrancheCol3)
		C_LONGINT:C283(vl_TrancheCol4)
		C_LONGINT:C283(vl_TrancheCol5)
		C_LONGINT:C283(vl_TrancheCol6)
		C_LONGINT:C283(vl_TrancheCol7)
		C_LONGINT:C283(vl_TrancheCol8)
		C_LONGINT:C283(vl_TrancheCol9)
		C_LONGINT:C283(vl_TrancheCol10)
		C_LONGINT:C283(vl_TrancheCol11)
		C_LONGINT:C283(vl_TrancheCol12)
		C_LONGINT:C283(vl_TrancheColTOTAL)
		
		
		C_LONGINT:C283(vl_TrancheColPers1)
		C_LONGINT:C283(vl_TrancheColPers2)
		C_LONGINT:C283(vl_TrancheColPers3)
		C_LONGINT:C283(vl_TrancheColPers4)
		C_LONGINT:C283(vl_TrancheColPers5)
		C_LONGINT:C283(vl_TrancheColPers6)
		C_LONGINT:C283(vl_TrancheColPers7)
		C_LONGINT:C283(vl_TrancheColPers8)
		C_LONGINT:C283(vl_TrancheColPers9)
		C_LONGINT:C283(vl_TrancheColPers10)
		C_LONGINT:C283(vl_TrancheColPers11)
		C_LONGINT:C283(vl_TrancheColPers12)
		C_LONGINT:C283(vl_TrancheColPersTotal)
		
		ARRAY LONGINT:C221(tl_TrancheColPers1; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers2; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers3; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers4; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers5; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers6; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers7; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers8; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers9; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers10; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers11; 0)
		ARRAY LONGINT:C221(tl_TrancheColPers12; 0)
		
		
		ARRAY INTEGER:C220(te_TrancheAffiche; 0)
		ARRAY INTEGER:C220(te_TrancheAfficheDebut; 0)
		ARRAY INTEGER:C220(te_TrancheAfficheFin; 0)
		
		ARRAY LONGINT:C221(tl_TrancheHGTemp; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol1_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol1_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol1_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol1_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol2_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol2_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol2_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol2_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol3_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol3_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol3_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol3_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol4_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol4_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol4_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol4_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol5_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol5_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol5_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol5_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol6_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol6_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol6_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol6_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol7_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol7_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol7_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol7_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol8_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol8_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol8_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol8_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol9_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol9_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol9_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol9_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol10_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol10_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol10_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol10_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol11_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol11_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol11_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol11_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol12_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol12_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol12_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol12_4; 0)
		
		
		ARRAY LONGINT:C221(tl_HGRupture; 0)
		
		
		
	: ($1=2)
		For ($ii; 1; 12)
			// remplacement get pointer 17/2/17
			//vp_LePointeur:=Get pointer("va_TrancheAffiche"+String($ii))
			Case of 
				: ($ii=1)
					vp_LePointeur:=->va_TrancheAffiche1
				: ($ii=2)
					vp_LePointeur:=->va_TrancheAffiche2
				: ($ii=3)
					vp_LePointeur:=->va_TrancheAffiche3
				: ($ii=4)
					vp_LePointeur:=->va_TrancheAffiche4
				: ($ii=5)
					vp_LePointeur:=->va_TrancheAffiche5
				: ($ii=6)
					vp_LePointeur:=->va_TrancheAffiche6
				: ($ii=7)
					vp_LePointeur:=->va_TrancheAffiche7
				: ($ii=8)
					vp_LePointeur:=->va_TrancheAffiche8
				: ($ii=9)
					vp_LePointeur:=->va_TrancheAffiche9
				: ($ii=10)
					vp_LePointeur:=->va_TrancheAffiche10
				: ($ii=11)
					vp_LePointeur:=->va_TrancheAffiche11
				: ($ii=12)
					vp_LePointeur:=->va_TrancheAffiche12
				Else 
					TRACE:C157
			End case 
			vp_LePointeur->:="…"
		End for 
		
		$vl_NbTranches:=Size of array:C274(<>ta_LesTranches)
		If ($vl_NbTranches>0)
			
			ARRAY INTEGER:C220(te_TrancheAffiche; $vl_NbTranches)
			ARRAY INTEGER:C220(te_TrancheAfficheDebut; $vl_NbTranches)
			ARRAY INTEGER:C220(te_TrancheAfficheFin; $vl_NbTranches)
			For ($ii; 1; $vl_NbTranches)
				
				te_TrancheAffiche{$ii}:=$ii
				If ($ii=1)
					te_TrancheAfficheDebut{$ii}:=0
				Else 
					te_TrancheAfficheDebut{$ii}:=<>te_LesTranches{$ii-1}+1
				End if 
				te_TrancheAfficheFin{$ii}:=<>te_LesTranches{$ii}
				
				// remplacement get pointer 17/2/17
				// vp_LePointeur:=Get pointer("va_TrancheAffiche"+String($ii))
				Case of 
					: ($ii=1)
						vp_LePointeur:=->va_TrancheAffiche1
					: ($ii=2)
						vp_LePointeur:=->va_TrancheAffiche2
					: ($ii=3)
						vp_LePointeur:=->va_TrancheAffiche3
					: ($ii=4)
						vp_LePointeur:=->va_TrancheAffiche4
					: ($ii=5)
						vp_LePointeur:=->va_TrancheAffiche5
					: ($ii=6)
						vp_LePointeur:=->va_TrancheAffiche6
					: ($ii=7)
						vp_LePointeur:=->va_TrancheAffiche7
					: ($ii=8)
						vp_LePointeur:=->va_TrancheAffiche8
					: ($ii=9)
						vp_LePointeur:=->va_TrancheAffiche9
					: ($ii=10)
						vp_LePointeur:=->va_TrancheAffiche10
					: ($ii=11)
						vp_LePointeur:=->va_TrancheAffiche11
					: ($ii=12)
						vp_LePointeur:=->va_TrancheAffiche12
					Else 
						TRACE:C157
				End case 
				
				If ($ii<$vl_NbTranches)
					vp_LePointeur->:=String:C10(te_TrancheAfficheDebut{$ii})+"-"+String:C10(te_TrancheAfficheFin{$ii})
				Else 
					vp_LePointeur->:=" > "+String:C10(te_TrancheAfficheDebut{$ii})
				End if 
			End for 
			
		End if 
		
		
		For ($ii; 1; vl_TrancheLigneEtatCivil)
			tl_TrancheCol1{$ii}:=0
			tl_TrancheCol2{$ii}:=0
			tl_TrancheCol3{$ii}:=0
			tl_TrancheCol4{$ii}:=0
			tl_TrancheCol5{$ii}:=0
			tl_TrancheCol6{$ii}:=0
			tl_TrancheCol7{$ii}:=0
			tl_TrancheCol8{$ii}:=0
			tl_TrancheCol9{$ii}:=0
			tl_TrancheCol10{$ii}:=0
			tl_TrancheCol11{$ii}:=0
			tl_TrancheCol12{$ii}:=0
		End for 
		
		vl_TrancheCol1:=0
		vl_TrancheCol2:=0
		vl_TrancheCol3:=0
		vl_TrancheCol4:=0
		vl_TrancheCol5:=0
		vl_TrancheCol6:=0
		vl_TrancheCol7:=0
		vl_TrancheCol8:=0
		vl_TrancheCol9:=0
		vl_TrancheCol10:=0
		vl_TrancheCol11:=0
		vl_TrancheCol12:=0
		vl_TrancheColTOTAL:=0
		
		vt_ColRéf_Libellé:=""
		vt_ColRéf_LibelléRupture:=""
		ARRAY LONGINT:C221(tl_TranchePersOld; 0)
		ARRAY LONGINT:C221(tl_TrancheOK; 0)
		
		ARRAY LONGINT:C221(tl_TrancheHGTemp; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol1_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol1_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol1_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol1_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol2_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol2_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol2_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol2_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol3_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol3_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol3_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol3_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol4_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol4_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol4_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol4_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol5_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol5_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol5_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol5_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol6_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol6_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol6_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol6_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol7_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol7_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol7_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol7_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol8_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol8_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol8_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol8_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol9_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol9_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol9_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol9_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol10_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol10_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol10_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol10_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol11_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol11_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol11_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol11_4; 0)
		
		ARRAY LONGINT:C221(tl_TrancheCol12_1; 0)
		ARRAY LONGINT:C221(tl_TrancheCol12_2; 0)
		ARRAY LONGINT:C221(tl_TrancheCol12_3; 0)
		ARRAY LONGINT:C221(tl_TrancheCol12_4; 0)
		
		ARRAY LONGINT:C221(tl_HGRupture; 0)
		
	: ($1=5)
		//i_Message ("RAZ…")
		
		C_BOOLEAN:C305($B_Dummy)
		$B_Dummy:=P_TranchesEnCours(2)
		
		
		//i_MessageSeul ("Recherche…")
		
		C_TEXT:C284($T_File)
		$T_File:="debug_"+Current method name:C684+"_.txt"
		C_BOOLEAN:C305($B_Log)
		$B_Log:=False:C215
		Log_mensuel($B_Log; "----------------- Demarrage de "+Current method name:C684; $T_File)
		
		
		C_LONGINT:C283($L_Tick)
		$L_Tick:=Milliseconds:C459
		
		
		
		If (Application type:C494#4D Server:K5:6)  // modifié pour optimisation serveur 
			D_Date:=[DiaLogues:3]DL_Date:2
			D_Date2:=[DiaLogues:3]DL_Date2:8
		End if 
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=D_Date; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=D_Date2; *)
		
		Case of 
			: (ta_TrancheDemande=1)
				
			: (ta_TrancheDemande=2)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
			: (ta_TrancheDemande=3)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215; *)
		End case 
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		//Centre
		C_LONGINT:C283($vl_Fiches)
		$vl_Fiches:=Records in selection:C76([HeberGement:5])
		
		Log_mensuel($B_Log; "Recherche 1 "+String:C10($vl_Fiches)+" records: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
		
		If ($vl_Fiches>0)
			P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_xCentre; ->te_xCentre)
		End if 
		$vl_Fiches:=Records in selection:C76([HeberGement:5])
		vl_TrancheColTotal:=$vl_Fiches
		
		
		Log_mensuel($B_Log; "Recherche dans la sélection "+String:C10($vl_Fiches)+" records: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
		
		
		
		//i_MessageSeul ("Tri…")
		If ($vl_Fiches>0)
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
			//FIRST RECORD([HeberGement])
			
			Log_mensuel($B_Log; "Tri: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
			
			
			$vl_RéfHB:=[HeberGement:5]HG_HB_ID:19
			$va_EtCivil:=[HeberGement:5]HG_EtatCivil:20
			$vl_Jours:=0
			$vl_TrancheFichesOK:=0
			ARRAY LONGINT:C221(tl_TrancheHGTemp; 0)
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			
			C_LONGINT:C283($L_ref)
			If (Not:C34(4DENV_isOnServer))
				$L_ref:=4D_Progression_Open("")  // ("Stop")
				C_OBJECT:C1216($O_Progression)
				C_BOOLEAN:C305($B_Stop)
				$B_Stop:=False:C215
			End if 
			
			$k:=0
			$L_Max:=$vl_Fiches
			Repeat 
				
				$k:=$k+1
				If (Application type:C494#4D Server:K5:6)
					If ((($k%30)=0))
						OB SET:C1220($O_Progression; \
							"progress ref"; $L_ref; \
							"progress titel"; "Supervision par tranche"; \
							"progress message"; "Statistique du "+String:C10(D_Date)+" au "+String:C10(D_Date2); \
							"progress compteur"; $k; \
							"progress max"; $L_Max; \
							"progress stop"; -1\
							)
						4D_Progression_Send(->$O_Progression)
					End if 
				End if 
				
				// i_MessageSeul ("Calcul : "+String($vl_Fiches)+"/"+String($kk))
				
				If ($vl_RéfHB=[HeberGement:5]HG_HB_ID:19)
					$vl_Jours:=$vl_Jours+1
				Else 
					$vl_Jours:=1
					$vl_RéfHB:=[HeberGement:5]HG_HB_ID:19
					$va_EtCivil:=[HeberGement:5]HG_EtatCivil:20
					ARRAY LONGINT:C221(tl_TrancheHGTemp; 0)
				End if 
				
				
				//$va_EtCv:=Substring($va_EtCivil;Length($va_EtCivil)-2;2)  //Ancien
				$va_EtCv:=""
				$vl_Position1:=Position:C15("("; $va_EtCivil)
				If ($vl_Position1>0)
					$vl_Position1:=$vl_Position1+1
					$va_EtCv:=Substring:C12($va_EtCivil; $vl_Position1; 2)
					//  $va_EtCv:=$va_EtCv+")"
				End if 
				
				
				$vl_TrancheLigne:=0
				Case of 
					: ($va_EtCv="HS")  //HOMME SEUL
						$vl_TrancheLigne:=1
						
					: ($va_EtCv="FS")  //FEMME SEULE
						$vl_TrancheLigne:=2
						
					: ($va_EtCv="HC") | ($va_EtCv="FC")  //COUPLES
						$vl_TrancheLigne:=3
						
					: ($va_EtCv="HF") | ($va_EtCv="HE") | ($va_EtCv="FF") | ($va_EtCv="FE") | ($va_EtCv="FP") | ($va_EtCv="HP")  //FAMILLES
						$vl_TrancheLigne:=4
				End case 
				
				If ($vl_TrancheLigne>0)
					
					INSERT IN ARRAY:C227(tl_TrancheOK; Size of array:C274(tl_TrancheOK)+1)
					tl_TrancheOK{Size of array:C274(tl_TrancheOK)}:=[HeberGement:5]HG_ReferenceID:1
					
					$vl_pos:=Find in array:C230(tl_TranchePersOld; [HeberGement:5]HG_HB_ID:19)
					If ($vl_pos<=0)
						INSERT IN ARRAY:C227(tl_TranchePersOld; Size of array:C274(tl_TranchePersOld)+1)
						tl_TranchePersOld{Size of array:C274(tl_TranchePersOld)}:=[HeberGement:5]HG_HB_ID:19
					End if 
					INSERT IN ARRAY:C227(tl_TrancheHGTemp; Size of array:C274(tl_TrancheHGTemp)+1)
					tl_TrancheHGTemp{Size of array:C274(tl_TrancheHGTemp)}:=[HeberGement:5]HG_ReferenceID:1
					
					$vl_TrancheLigne:=0
				End if 
				
				NEXT RECORD:C51([HeberGement:5])
				
				
				If ($vl_RéfHB#[HeberGement:5]HG_HB_ID:19)
					
					$vl_TrancheEnCours:=0
					Repeat 
						$vl_TrancheEnCours:=$vl_TrancheEnCours+1
					Until ((($vl_Jours>=te_TrancheAfficheDebut{$vl_TrancheEnCours}) & ($vl_Jours<=te_TrancheAfficheFin{$vl_TrancheEnCours})) | ($vl_TrancheEnCours>=Size of array:C274(te_TrancheAfficheDebut)))
					
					$vl_TrancheLigne:=0
					Case of 
						: ($va_EtCv="HS")  //HOMME SEUL
							$vl_TrancheLigne:=1
						: ($va_EtCv="FS")  //FEMME SEULE
							$vl_TrancheLigne:=2
						: ($va_EtCv="HC") | ($va_EtCv="FC")  //COUPLES
							$vl_TrancheLigne:=3
						: ($va_EtCv="HF") | ($va_EtCv="HE") | ($va_EtCv="FF") | ($va_EtCv="FE") | ($va_EtCv="FP") | ($va_EtCv="HP")  //FAMILLES
							$vl_TrancheLigne:=4
					End case 
					
					$vb_OK:=(($vl_TrancheEnCours>0) & ($vl_TrancheEnCours<=Size of array:C274(te_TrancheAfficheDebut)))
					$vb_OK:=$vb_OK & ($vl_TrancheLigne>0)
					
					If ($vb_OK)
						// remplacement get pointer 17/2/17
						//vp_LePointeur:=Get pointer("tl_TrancheCol"+String($vl_TrancheEnCours))
						Case of 
							: ($vl_TrancheEnCours=1)
								vp_LePointeur:=->tl_TrancheCol1
							: ($vl_TrancheEnCours=2)
								vp_LePointeur:=->tl_TrancheCol2
							: ($vl_TrancheEnCours=3)
								vp_LePointeur:=->tl_TrancheCol3
							: ($vl_TrancheEnCours=4)
								vp_LePointeur:=->tl_TrancheCol4
							: ($vl_TrancheEnCours=5)
								vp_LePointeur:=->tl_TrancheCol5
							: ($vl_TrancheEnCours=6)
								vp_LePointeur:=->tl_TrancheCol6
							: ($vl_TrancheEnCours=7)
								vp_LePointeur:=->tl_TrancheCol7
							: ($vl_TrancheEnCours=8)
								vp_LePointeur:=->tl_TrancheCol8
							: ($vl_TrancheEnCours=9)
								vp_LePointeur:=->tl_TrancheCol9
							: ($vl_TrancheEnCours=10)
								vp_LePointeur:=->tl_TrancheCol10
							: ($vl_TrancheEnCours=11)
								vp_LePointeur:=->tl_TrancheCol11
							: ($vl_TrancheEnCours=12)
								vp_LePointeur:=->tl_TrancheCol12
							Else 
								TRACE:C157
						End case 
						vp_LePointeur->{$vl_TrancheLigne}:=vp_LePointeur->{$vl_TrancheLigne}+1
						
						If (Size of array:C274(tl_TrancheHGTemp)>0)
							// remplacement get pointer 17/2/17
							// vp_LePointeur:=Get pointer("tl_TrancheCol"+String($vl_TrancheEnCours)+"_"+String($vl_TrancheLigne))
							Case of 
								: ($vl_TrancheEnCours=1)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol1_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol1_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol1_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol1_4
										Else 
											TRACE:C157
									End case 
								: ($vl_TrancheEnCours=2)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol2_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol2_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol2_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol2_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=3)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol3_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol3_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol3_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol3_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=4)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol4_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol4_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol4_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol4_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=5)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol5_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol5_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol5_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol5_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=6)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol6_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol6_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol6_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol6_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=7)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol7_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol7_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol7_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol7_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=8)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol8_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol8_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol8_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol8_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=9)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol9_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol9_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol9_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol9_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=10)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol10_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol10_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol10_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol10_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=11)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol11_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol11_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol11_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol11_4
										Else 
											TRACE:C157
									End case 
									
								: ($vl_TrancheEnCours=12)
									
									Case of 
										: ($vl_TrancheLigne=1)
											vp_LePointeur:=->tl_TrancheCol12_1
										: ($vl_TrancheLigne=2)
											vp_LePointeur:=->tl_TrancheCol12_2
										: ($vl_TrancheLigne=3)
											vp_LePointeur:=->tl_TrancheCol12_3
										: ($vl_TrancheLigne=4)
											vp_LePointeur:=->tl_TrancheCol12_4
										Else 
											TRACE:C157
									End case 
									
								Else 
									TRACE:C157
							End case 
							
							For ($vl_bcle; 1; Size of array:C274(tl_TrancheHGTemp))
								INSERT IN ARRAY:C227(vp_LePointeur->; Size of array:C274(vp_LePointeur->)+1)
								vp_LePointeur->{Size of array:C274(vp_LePointeur->)}:=tl_TrancheHGTemp{$vl_bcle}
							End for 
						End if 
					End if 
					
				End if 
				
				
			Until (End selection:C36([HeberGement:5]))
			
			4D_Progression_Close($L_Ref)
			
			Log_mensuel($B_Log; "Boucle: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
			
			
			
			For ($jj; 1; vl_TrancheLigneEtatCivil)
				vl_TrancheCol1:=vl_TrancheCol1+tl_TrancheCol1{$jj}
				vl_TrancheCol2:=vl_TrancheCol2+tl_TrancheCol2{$jj}
				vl_TrancheCol3:=vl_TrancheCol3+tl_TrancheCol3{$jj}
				vl_TrancheCol4:=vl_TrancheCol4+tl_TrancheCol4{$jj}
				vl_TrancheCol5:=vl_TrancheCol5+tl_TrancheCol5{$jj}
				vl_TrancheCol6:=vl_TrancheCol6+tl_TrancheCol6{$jj}
				vl_TrancheCol7:=vl_TrancheCol7+tl_TrancheCol7{$jj}
				vl_TrancheCol8:=vl_TrancheCol8+tl_TrancheCol8{$jj}
				vl_TrancheCol9:=vl_TrancheCol9+tl_TrancheCol9{$jj}
				vl_TrancheCol10:=vl_TrancheCol10+tl_TrancheCol10{$jj}
				vl_TrancheCol11:=vl_TrancheCol11+tl_TrancheCol11{$jj}
				vl_TrancheCol12:=vl_TrancheCol12+tl_TrancheCol12{$jj}
			End for 
			
			C_LONGINT:C283($L_Tick)
			$L_Tick:=Milliseconds:C459
			P_StatTranche("TRT"; 0; 0)
			Log_mensuel($B_Log; "P_StatTranche: "+String:C10(exec_time($L_Tick))+" secondes"; $T_File)
			
		Else 
			REDUCE SELECTION:C351([HeberGement:5]; 0)
		End if 
		
		CLOSE WINDOW:C154
End case 