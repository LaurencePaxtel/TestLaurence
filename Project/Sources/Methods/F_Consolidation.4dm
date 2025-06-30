//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_Consolidation
//{          Mardi 10 avril 2012 à 12:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($vb_OK; $vb_OKCréer; $vb_OKNewCleFam)
C_LONGINT:C283($kk; $vl_FichesA; $vl_OffSet; $vl_Décalage)
C_TEXT:C284($va_FamCle)



C_TEXT:C284($vt_Temp)
Case of 
	: ($1="DocuValide")
		$vt_Temp:=$2
		//AH 09022508h15J01810 FS49.TXT            
		//•(x1) Longueur 25 caractères
		If (Substring:C12($vt_Temp; Length:C16($vt_Temp)-3; 4)=".TXT")
			$vb_OK:=(Length:C16($vt_Temp)=29)
		Else 
			$vb_OK:=(Length:C16($vt_Temp)=25)
		End if 
		//•(x2) Année               
		If ($vb_OK)
			$vb_OK:=(Num:C11($vt_Temp[[4]])>=0) & (Num:C11($vt_Temp[[4]])<=9)
			$vb_OK:=$vb_OK & ((Num:C11(Substring:C12($vt_Temp; 4; 2))>0) & (Num:C11(Substring:C12($vt_Temp; 4; 2))<=99))
		End if 
		//•(x3) Mois               
		If ($vb_OK)
			$vb_OK:=((Num:C11(Substring:C12($vt_Temp; 6; 2))>0) & (Num:C11(Substring:C12($vt_Temp; 6; 2))<=12))
		End if 
		//•(x4) Jour              
		If ($vb_OK)
			$vb_OK:=((Num:C11(Substring:C12($vt_Temp; 8; 2))>0) & (Num:C11(Substring:C12($vt_Temp; 8; 2))<=31))
		End if 
		//•(x5) h          
		If ($vb_OK)
			$vb_OK:=($vt_Temp[[12]]="h")
		End if 
		//•(x6) Jour   ou Nuit                 
		If ($vb_OK)
			$vb_OK:=(($vt_Temp[[15]]="J") | ($vt_Temp[[15]]="N"))
		End if 
		//•(x7) Homme   ou Femme             
		If ($vb_OK)
			$vb_OK:=(($vt_Temp[[22]]="H") | ($vt_Temp[[22]]="F"))
		End if 
		
		$0:=$vb_OK
		
		
	: ($1="Importer")
		$vl_OffSet:=0
		$vb_FamChef:=False:C215
		$va_FamCle:=""
		$vl_FichesA:=Size of array:C274(<>te_Conso_Ligne)
		
		//TABLE CENTRE : Cherche la clé unique
		READ WRITE:C146([LesCentres:9])
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+14}))
		MultiSoc_Filter(->[LesCentres:9])
		If (Records in selection:C76([LesCentres:9])=0)
			CREATE RECORD:C68([LesCentres:9])
			MultiSoc_Init_Structure(->[LesCentres:9])
			[LesCentres:9]LC_RéférenceID:1:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+14})
			[LesCentres:9]LC_Trans_RéférenceID:57:=[LesCentres:9]LC_RéférenceID:1
			[LesCentres:9]LC_Prestation:55:=(vl_LC_Prestation=1)
			vl_RéfU_LC:=[LesCentres:9]LC_RéférenceID:1
		Else 
			Repeat 
				IDLE:C311
				LOAD RECORD:C52([LesCentres:9])
			Until (Not:C34(Locked:C147([LesCentres:9])))
			vl_RéfU_LC:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+14})
		End if 
		
		[LesCentres:9]LC_Nom:4:=<>tt_Conso_Valeur{$vl_OffSet+15}
		[LesCentres:9]LC_Adr1:24:=<>tt_Conso_Valeur{$vl_OffSet+16}
		[LesCentres:9]LC_Adr2:25:=<>tt_Conso_Valeur{$vl_OffSet+17}
		[LesCentres:9]LC_CP:27:=<>tt_Conso_Valeur{$vl_OffSet+18}
		[LesCentres:9]LC_Ville:28:=<>tt_Conso_Valeur{$vl_OffSet+19}
		[LesCentres:9]LC_Téléphone:29:=<>tt_Conso_Valeur{$vl_OffSet+20}
		[LesCentres:9]LC_Télécopie2:31:=<>tt_Conso_Valeur{$vl_OffSet+21}
		[LesCentres:9]LC_Responsable:32:=<>tt_Conso_Valeur{$vl_OffSet+22}
		[LesCentres:9]LC_Plateforme:56:=<>tt_Conso_Valeur{$vl_OffSet+23}
		[LesCentres:9]LC_Niveau:52:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+24})
		[LesCentres:9]LC_DispoJour:48:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+25})
		[LesCentres:9]LC_Répertoire:54:=<>tt_Conso_Valeur{$vl_OffSet+26}
		va_Centre_Rep:=[LesCentres:9]LC_Répertoire:54
		SAVE RECORD:C53([LesCentres:9])
		UNLOAD RECORD:C212([LesCentres:9])
		READ ONLY:C145([LesCentres:9])
		
		READ WRITE:C146([HeBerge:4])
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>tt_Conso_Valeur{$vl_OffSet+4})
		MultiSoc_Filter(->[HeBerge:4])
		If (Records in selection:C76([HeBerge:4])=0)
			CREATE RECORD:C68([HeBerge:4])
			MultiSoc_Init_Structure(->[HeBerge:4])
			[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
			[HeBerge:4]HB_Clé:2:=<>tt_Conso_Valeur{$vl_OffSet+4}
			[HeBerge:4]HB_Nom:3:=<>tt_Conso_Valeur{$vl_OffSet+5}
			[HeBerge:4]HB_Prénom:4:=<>tt_Conso_Valeur{$vl_OffSet+6}
			[HeBerge:4]HB_DateNéLe:5:=Date:C102(<>tt_Conso_Valeur{$vl_OffSet+7})
			[HeBerge:4]HG_Genre:39:=F_EtatCivilGenre(<>tt_Conso_Valeur{$vl_OffSet})
			[HeBerge:4]HB_FicheCrééele:46:=vd_DateRéelle
			vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
			
			[HeBerge:4]HB_Trans_RéférenceID:55:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+13})
			
			//94 Chef de famille       	N	5	103
			//95 Clé de lien familial	    	5	104  
			$kk:=50
			Repeat 
				$kk:=$kk+1
			Until ((<>te_Conso_Table{$kk}=5) & (<>te_Conso_Champ{$kk}=103))
			If (<>tt_Conso_Valeur{$kk}="O")
				[HeBerge:4]HB_CléFam:47:=<>tt_Conso_Valeur{$kk+1}
				$va_FamCle:=[HeBerge:4]HB_CléFam:47
			End if 
			[HeBerge:4]HB_Trans_CléFam:56:=<>tt_Conso_Valeur{$vl_OffSet+32}
			SAVE RECORD:C53([HeBerge:4])
		Else 
			Repeat 
				IDLE:C311
				LOAD RECORD:C52([HeBerge:4])
			Until (Not:C34(Locked:C147([HeBerge:4])))
			
			//Pour les clés de lien famille  
			$kk:=50
			Repeat 
				$kk:=$kk+1
			Until ((<>te_Conso_Table{$kk}=5) & (<>te_Conso_Champ{$kk}=103))
			
			If (<>tt_Conso_Valeur{$kk}="O")
				If ([HeBerge:4]HB_CléFam:47>"")
					If ([HeBerge:4]HB_CléFam:47=<>tt_Conso_Valeur{$kk+1})
					Else 
						[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
						[HeBerge:4]HB_CléFam:47:=<>tt_Conso_Valeur{$kk+1}
						SAVE RECORD:C53([HeBerge:4])
					End if 
				Else 
					[HeBerge:4]HB_CléFam:47:=<>tt_Conso_Valeur{$kk+1}
					SAVE RECORD:C53([HeBerge:4])
				End if 
				$va_FamCle:=[HeBerge:4]HB_CléFam:47
				
			End if 
			
		End if 
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
		
		// 4/12/2008 Les dispos pour les centres CHRS au 115 ne sont pas crées
		// ici rechercher la fiche au cas où elle a déjà été importée
		$vb_OKCréer:=False:C215
		$vb_OKNewCleFam:=False:C215
		$vb_OK:=False:C215
		READ WRITE:C146([HeberGement:5])
		$vb_Nuit:=(<>tt_Conso_Valeur{$vl_OffSet+3}[[1]]="N")  //Fiche de jour(faux); fiche de nuit (vrai)
		If ($vb_Nuit)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_RéfU_HBB; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Trans_FicheNuméro:143=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+3}); *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Trans_RéférenceID:142=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+12}); *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=$vb_Nuit)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_RéfU_HBB; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=Date:C102(<>tt_Conso_Valeur{$vl_OffSet+2}))
		End if 
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])=0)
			$vb_OKCréer:=True:C214
		Else 
			Repeat   //10/01/2011
				IDLE:C311
				LOAD RECORD:C52([HeberGement:5])
			Until (Not:C34(Locked:C147([HeberGement:5])))
			$vb_OK:=True:C214
		End if 
		
		If ($vb_OKCréer)
			CREATE RECORD:C68([HeberGement:5])
			MultiSoc_Init_Structure(->[HeberGement:5])
			[HeberGement:5]HG_DateCreationFiche:149:=vd_DateRéelle
			[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
			[HeberGement:5]HG_Nuit:2:=(<>tt_Conso_Valeur{$vl_OffSet+3}[[1]]="N")
			[HeberGement:5]HG_Date:4:=Date:C102(<>tt_Conso_Valeur{$vl_OffSet+2})
			[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche(<>tt_Conso_Valeur{$vl_OffSet+3}[[1]]; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
			[HeberGement:5]HG_HB_ID:19:=vl_RéfU_HBB
			$vb_OK:=True:C214
		End if 
		
		If ($vb_OK)
			[HeberGement:5]HG_EtatCivil:20:=<>tt_Conso_Valeur{$vl_OffSet}
			[HeberGement:5]HG_Nom:21:=<>tt_Conso_Valeur{$vl_OffSet+5}
			[HeberGement:5]HG_Prénom:22:=<>tt_Conso_Valeur{$vl_OffSet+6}
			[HeberGement:5]HG_DateNéLe:24:=Date:C102(<>tt_Conso_Valeur{$vl_OffSet+7})
			[HeberGement:5]HG_Age:23:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+8})
			[HeberGement:5]HG_Genre:96:=F_EtatCivilGenre(<>tt_Conso_Valeur{$vl_OffSet})
			
			[HeberGement:5]HG_NuitenCours:92:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+9})
			[HeberGement:5]HG_NuitTOTAL:93:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+10})
			
			[HeberGement:5]HG_Réservation:91:=([HeberGement:5]HG_NuitTOTAL:93>1)
			
			[HeberGement:5]HG_Reporté:94:=""
			[HeberGement:5]HG_NuitReste:95:=0
			
			[HeberGement:5]HG_LC_ID:61:=vl_RéfU_LC
			[HeberGement:5]HG_CentreNom:62:=<>tt_Conso_Valeur{$vl_OffSet+15}
			[HeberGement:5]HG_CentreARR:63:=""
			[HeberGement:5]HG_Priorité:57:=0
			[HeberGement:5]HG_DispoSpé:90:=False:C215
			
			
			
			[HeberGement:5]HG_EnAttente:64:=False:C215
			[HeberGement:5]HG_AttenteHeur:83:=?00:00:00?
			[HeberGement:5]HG_Transmis:65:=False:C215
			[HeberGement:5]HG_TransmisHeur:84:=?00:00:00?
			[HeberGement:5]HG_PriseCharge:66:=False:C215
			[HeberGement:5]HG_PrChargeHeur:85:=?00:00:00?
			[HeberGement:5]HG_Cloturée:67:=False:C215
			[HeberGement:5]HG_CloturéeHeur:86:=?00:00:00?
			
			
			If (<>vb_FullDuplexDataB)
				$vl_Décalage:=43
			Else 
				$vl_Décalage:=34
			End if 
			
			For ($ii_Plus; $vl_OffSet+$vl_Décalage; $vl_FichesA)
				Case of 
					: (<>te_Conso_ChampType{$ii_Plus}=Est un champ alpha:K8:1)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=<>tt_Conso_Valeur{$ii_Plus}
					: (<>te_Conso_ChampType{$ii_Plus}=Est un texte:K8:3)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=<>tt_Conso_Valeur{$ii_Plus}
					: (<>te_Conso_ChampType{$ii_Plus}=Est un numérique:K8:4)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=Num:C11(<>tt_Conso_Valeur{$ii_Plus})
					: (<>te_Conso_ChampType{$ii_Plus}=Est un entier:K8:5)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=Num:C11(<>tt_Conso_Valeur{$ii_Plus})
					: (<>te_Conso_ChampType{$ii_Plus}=Est un entier long:K8:6)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=Num:C11(<>tt_Conso_Valeur{$ii_Plus})
					: (<>te_Conso_ChampType{$ii_Plus}=Est une date:K8:7)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=Date:C102(<>tt_Conso_Valeur{$ii_Plus})
					: (<>te_Conso_ChampType{$ii_Plus}=Est une heure:K8:8)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=Time:C179(<>tt_Conso_Valeur{$ii_Plus})
					: (<>te_Conso_ChampType{$ii_Plus}=Est un booléen:K8:9)
						Field:C253(<>te_Conso_Table{$ii_Plus}; <>te_Conso_Champ{$ii_Plus})->:=(<>tt_Conso_Valeur{$ii_Plus}="O")
					: (<>te_Conso_ChampType{$ii_Plus}=Est une image:K8:10)
					: (<>te_Conso_ChampType{$ii_Plus}=Est une sous table:K8:11)
					: (<>te_Conso_ChampType{$ii_Plus}=Est un BLOB:K8:12)
				End case 
			End for 
			
			
			
			[HeberGement:5]HG_Plateforme:139:=<>tt_Conso_Valeur{$vl_OffSet+23}
			[HeberGement:5]HG_PlateformeCentre:140:=""
			[HeberGement:5]HG_Trans_DDASS:141:=True:C214
			[HeberGement:5]HG_Trans_RéférenceID:142:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+12})
			[HeberGement:5]HG_Trans_FicheNuméro:143:=<>tt_Conso_Valeur{$vl_OffSet+3}
			[HeberGement:5]HG_Trans_HB_ID:144:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+13})
			[HeberGement:5]HG_Trans_LC_ID:145:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+14})
			[HeberGement:5]HG_Trans_CentreNom:146:=<>tt_Conso_Valeur{$vl_OffSet+15}
			[HeberGement:5]HG_Trans_FamClé:147:=<>tt_Conso_Valeur{$vl_OffSet+32}
			[HeberGement:5]HG_Trans_Plateforme:148:=<>tt_Conso_Valeur{$vl_OffSet+23}
			
			
			
			
			If ([HeberGement:5]HG_FamClé:104>"")
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_CléFam:47=[HeberGement:5]HG_FamClé:104)
				If (Records in selection:C76([HeBerge:4])=1)
					
				Else 
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Trans_CléFam:56=[HeberGement:5]HG_FamClé:104)
					If (Records in selection:C76([HeBerge:4])=1)
						[HeberGement:5]HG_Trans_FamClé:147:=[HeberGement:5]HG_FamClé:104
						[HeberGement:5]HG_FamClé:104:=[HeBerge:4]HB_CléFam:47
					End if 
				End if 
			End if 
			
			
			If (<>vb_FullDuplexDataB)
				[HeberGement:5]HG_Signalement:12:=<>tt_Conso_Valeur{$vl_OffSet+34}
				[HeberGement:5]HG_Orientation1:58:=<>tt_Conso_Valeur{$vl_OffSet+35}
				// [HéberGement]HG_Orientation2:=◊tt_Conso_Valeur{$vl_OffSet+36}
				//[HéberGement]HG_AutreSolutio:=◊tt_Conso_Valeur{$vl_OffSet+37}
				//[HéberGement]HG_Plateforme:=◊tt_Conso_Valeur{$vl_OffSet+38}
				[HeberGement:5]HG_FamGroupe:102:=<>tt_Conso_Valeur{$vl_OffSet+39}
				//[HéberGement]HG_FamChef:=(◊tt_Conso_Valeur{$vl_OffSet+40}="O")
				//[HéberGement]HG_FamClé:=◊tt_Conso_Valeur{$vl_OffSet+41}
				[HeberGement:5]HG_FamCompoVar:117:=<>tt_Conso_Valeur{$vl_OffSet+42}
			End if 
			
			[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
			
			SAVE RECORD:C53([HeberGement:5])
			$0:=True:C214
		End if 
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
		
End case 