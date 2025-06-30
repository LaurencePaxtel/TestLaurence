//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_CentresOccup
//{
//{          Mardi 30 Novembre 2004 à 17:28:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($TailleTab; $ii; $Position)
C_TEXT:C284($va_DateType)
Case of 
		
	: ($1=0)
		$TailleTab:=0
		ARRAY INTEGER:C220(te_CL_CentreCheck; $TailleTab)
		ARRAY TEXT:C222(ta_CL_CtreNom; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CapacitéCtr; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CtreNb; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CtreNew; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CtrFam; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CtreAdulte; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CtreEnfant; $TailleTab)
		
		ARRAY TEXT:C222(ta_CL_DTi; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_Centre; $TailleTab)
		ARRAY INTEGER:C220(tl_CL_Capacité; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_Capacité115; $TailleTab)
		ARRAY INTEGER:C220(tl_CL_Dispo115; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_VSM; $TailleTab)
		ARRAY LONGINT:C221(tl_CL_CtrDispo; $TailleTab)
		
		vl_Et_HS:=0
		vl_Et_FS:=0
		vl_Et_HC:=0
		vl_Et_FF:=0
		vl_Et_FM:=0
		vl_Et_EF:=0
		
		
		vl_T_Capacité:=0
		vl_T_CapacitéCtr:=0
		vl_T_Capacité115:=0
		vl_T_VSM:=0
		vl_T_CtreNb:=0
		vl_T_CtreNew:=0
		vl_T_CtreFam:=0
		vl_T_CtreAdulte:=0
		vl_T_CtreEnfant:=0
		
	: ($1=1)
		i_Message("recherche en cours  1/3")
		$va_DateType:=Uut_NumeroteLitsType(vd_Date1; "J")
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=$va_DateType)
		MultiSoc_Filter(->[CentresLits:16])
		$TailleTab:=0  //Enregistrements trouves([CentresLits])
		If ($TailleTab>0)
			ORDER BY:C49([CentresLits:16]; [LesCentres:9]LC_Nom:4; >)
			
			//  SELECTION VERS TABLEAU([CentresLits]CL_DateTypeIDLC;ta_CL_DTi;
			//   [CentresLits]CL_LC_ID;tl_CL_Centre;
			// [CentresLits]CL_Capacité;tl_CL_Capacité;
			//  [CentresLits]CL_NA3;tl_CL_Capacité115;
			// [CentresLits]CL_DispoTotal;tl_CL_Dispo115;
			// [CentresLits]CL_NA2;tl_CL_VSM;
			// [CentresLits]CL_Niveau;tl_CL_CtrDispo)
			
			ARRAY INTEGER:C220(te_CL_CentreCheck; $TailleTab)
			ARRAY TEXT:C222(ta_CL_CtreNom; $TailleTab)
			ARRAY LONGINT:C221(tl_CL_CapacitéCtr; $TailleTab)
			ARRAY LONGINT:C221(tl_CL_CtreNb; $TailleTab)
			ARRAY LONGINT:C221(tl_CL_CtreNew; $TailleTab)
			ARRAY LONGINT:C221(tl_CL_CtrFam; $TailleTab)
			ARRAY LONGINT:C221(tl_CL_CtreAdulte; $TailleTab)
			ARRAY LONGINT:C221(tl_CL_CtreEnfant; $TailleTab)
			For ($ii; 1; $TailleTab)
				te_CL_CentreCheck{$ii}:=1
				ta_CL_CtreNom{$ii}:=""
				$Position:=Find in array:C230(tl_LC_Réf; tl_CL_Centre{$ii})
				If ($Position>0)
					ta_CL_CtreNom{$ii}:=ta_LC_Nom{$Position}
				End if 
				tl_CL_CapacitéCtr{$ii}:=tl_CL_Capacité{$ii}-tl_CL_Capacité115{$ii}
				tl_CL_CtreNb{$ii}:=0
				tl_CL_CtreNew{$ii}:=0
				tl_CL_CtrFam{$ii}:=0
				tl_CL_CtreAdulte{$ii}:=0
				tl_CL_CtreEnfant{$ii}:=0
			End for 
			
			vl_Et_HS:=0
			vl_Et_FS:=0
			vl_Et_HC:=0
			vl_Et_FF:=0
			vl_Et_FM:=0
			vl_Et_EF:=0
			
			
			vl_T_Capacité:=0
			vl_T_CapacitéCtr:=0
			vl_T_Capacité115:=0
			vl_T_VSM:=0
			vl_T_CtreNb:=0
			vl_T_CtreNew:=0
			vl_T_CtreFam:=0
			vl_T_CtreAdulte:=0
			vl_T_CtreEnfant:=0
			
		Else 
			P_Calc_CentresOccup(0)
		End if 
		
		
		
	: ($1=2)
		
		
		P_Calc_CentresOccup(1)
		If (vd_Date1<=!00-00-00!)
			CLOSE WINDOW:C154
			ALERT:C41("Veuillez saisir une date !")
		Else 
			If (Size of array:C274(tl_CL_Centre)>0)
				i_MessageSeul("recherche en cours  1/3")
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
				MultiSoc_Filter(->[HeberGement:5])
				$TailleTab:=Records in selection:C76([HeberGement:5])
				If ($TailleTab>0)
					
					SELECTION TO ARRAY:C260([HeberGement:5]HG_LC_ID:61; $tl_IDLC; [HeberGement:5]HG_Signalement:12; $ta_Signalement; [HeberGement:5]HG_EtatCivil:20; $ta_EtCv; [HeberGement:5]HG_Age:23; $tl_Age)
					
					For ($ii; 1; $TailleTab)
						//Par ligne de centre            
						$Position:=Find in array:C230(tl_CL_Centre; $tl_IDLC{$ii})
						If ($Position>0)
							tl_CL_CtreNb{$Position}:=tl_CL_CtreNb{$Position}+1
							If ($ta_Signalement{$ii}="*Usager premier appel")
								tl_CL_CtreNew{$Position}:=tl_CL_CtreNew{$Position}+1
							End if 
							If ($tl_Age{$ii}>=18)
								tl_CL_CtreAdulte{$Position}:=tl_CL_CtreAdulte{$Position}+1
							Else 
								tl_CL_CtreEnfant{$Position}:=tl_CL_CtreEnfant{$Position}+1
							End if 
							If (($ta_EtCv{$ii}="Homme en coup@") | ($ta_EtCv{$ii}="H Famille@") | ($ta_EtCv{$ii}="Homme avec@"))
								tl_CL_CtrFam{$Position}:=tl_CL_CtrFam{$Position}+1
							End if 
						End if 
						If ($tl_Age{$ii}<18)
							vl_Et_EF:=vl_Et_EF+1
						End if 
						//Par civilité regroupées
						Case of 
							: ($ta_EtCv{$ii}="Homme seul@")
								vl_Et_HS:=vl_Et_HS+1
							: ($ta_EtCv{$ii}="Femme seule@")
								vl_Et_FS:=vl_Et_FS+1
							: ($ta_EtCv{$ii}="Homme en coup@")
								vl_Et_HC:=vl_Et_HC+1
							: ($ta_EtCv{$ii}="H Famille@")
								vl_Et_FF:=vl_Et_FF+1
							: ($ta_EtCv{$ii}="Homme avec@")
								vl_Et_FM:=vl_Et_FM+1
						End case 
					End for 
					For ($ii; 1; Size of array:C274(tl_CL_Capacité))
						vl_T_Capacité:=vl_T_Capacité+tl_CL_Capacité{$ii}
						vl_T_CapacitéCtr:=vl_T_CapacitéCtr+tl_CL_CapacitéCtr{$ii}
						vl_T_Capacité115:=vl_T_Capacité115+tl_CL_Capacité115{$ii}
						vl_T_VSM:=vl_T_VSM+tl_CL_VSM{$ii}
						vl_T_CtreNb:=vl_T_CtreNb+tl_CL_CtreNb{$ii}
						vl_T_CtreNew:=vl_T_CtreNew+tl_CL_CtreNew{$ii}
						vl_T_CtreFam:=vl_T_CtreFam+tl_CL_CtrFam{$ii}
						vl_T_CtreAdulte:=vl_T_CtreAdulte+tl_CL_CtreAdulte{$ii}
						vl_T_CtreEnfant:=vl_T_CtreEnfant+tl_CL_CtreEnfant{$ii}
						
					End for 
				End if 
				
			End if 
			CLOSE WINDOW:C154
		End if 
		
End case 