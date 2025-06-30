//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexImport
//{
//{          Vendredi 21 novembre 2008 à 13:50
//{          Modifiée : 14 novembre 2008 à 12:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_BOOLEAN:C305($vb_OK; $vb_OKCréer; $vb_Nuit; $vb_FamChef; $vb_OK_SIAO)
C_LONGINT:C283($ii; $kk; $ii_Plus; $ii_Cas)
C_LONGINT:C283($vl_FichesDe; $vl_FichesA; $vl_OffSet; $vl_Décalage)

ARRAY LONGINT:C221($tl_ref; 0)
ARRAY LONGINT:C221($tl_LC_ID; 0)
ARRAY TEXT:C222($ta_LC_Nom; 0)
C_TEXT:C284($va_Cas)
C_TEXT:C284($va_FamCle)
$vb_FamChef:=False:C215
$va_FamCle:=""



<>vl_Conso_Lignes:=0
For ($ii; 1; Size of array:C274(<>tt_Conso_LeDocument))
	<>vl_Conso_Lignes:=<>vl_Conso_Lignes+Num:C11(<>te_Conso_Ligne{$ii}=1)
End for 
If (7=8)
	$vl_Fenetre:=i_FenêtreNo(652; 645; 16; "Consolidation 115"; 1; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_Fiche_ConsoImport")
	CLOSE WINDOW:C154
End if 


$vl_FichesDe:=1
Repeat 
	//(• Borne  
	$ii:=$vl_FichesDe
	Repeat 
		$ii:=$ii+1
	Until ((<>te_Conso_Ligne{$ii}=1) | ($ii=Size of array:C274(<>te_Conso_Ligne)))
	If (<>te_Conso_Ligne{$ii}=1)
		$vl_FichesA:=$ii-1
	Else 
		$vl_FichesA:=Size of array:C274(<>te_Conso_Ligne)
	End if 
	//(• Borne FIN   
	
	//  DEBUT TRANSACTION
	//TABLE HEBERGÉ : Cherche la clé unique
	$vl_OffSet:=$vl_FichesDe-1
	
	
	
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
	
	$va_FamCle:=""
	
	If (7=8)  //12/01/2012
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>tt_Conso_Valeur{$vl_OffSet+4})
		If (Records in selection:C76([HeBerge:4])=0)
			READ WRITE:C146([HeBerge:4])
			CREATE RECORD:C68([HeBerge:4])
			MultiSoc_Init_Structure(->[HeBerge:4])
			[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
			[HeBerge:4]HB_Clé:2:=<>tt_Conso_Valeur{$vl_OffSet+4}
			[HeBerge:4]HB_Nom:3:=<>tt_Conso_Valeur{$vl_OffSet+5}
			[HeBerge:4]HB_Prénom:4:=<>tt_Conso_Valeur{$vl_OffSet+6}
			[HeBerge:4]HB_DateNéLe:5:=Date:C102(<>tt_Conso_Valeur{$vl_OffSet+7})
			[HeBerge:4]HG_Genre:39:=F_EtatCivilGenre(<>tt_Conso_Valeur{$vl_OffSet})
			[HeBerge:4]HB_FicheCrééele:46:=vd_DateRéelle
			
			[HeBerge:4]HB_Trans_RéférenceID:55:=Num:C11(<>tt_Conso_Valeur{$vl_OffSet+13})
			[HeBerge:4]HB_Trans_CléFam:56:=<>tt_Conso_Valeur{$vl_OffSet+32}
			vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
			SAVE RECORD:C53([HeBerge:4])
			UNLOAD RECORD:C212([HeBerge:4])
			READ ONLY:C145([HeBerge:4])
		Else 
			vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		End if 
	Else 
		READ WRITE:C146([HeBerge:4])
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>tt_Conso_Valeur{$vl_OffSet+4})
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
			$kk:=$vl_OffSet+50
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
			$kk:=$vl_OffSet+50
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
	End if 
	
	
	// 4/12/2008 Les dispos pour les centres CHRS au 115 ne sont pas crées
	// ici rechercher la fiche au cas où elle a déjà été importée
	$vb_OKCréer:=False:C215
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
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=Date:C102(<>tt_Conso_Valeur{$vl_OffSet+2}); *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)  //06/06/2012
	End if 
	MultiSoc_Filter(->[HeberGement:5])
	
	If (Records in selection:C76([HeberGement:5])=0)
		$vb_OKCréer:=True:C214
	Else 
		
		If (7=8)  //10/01/2011
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_ref; [HeberGement:5]HG_LC_ID:61; $tl_LC_ID; [HeberGement:5]HG_CentreNom:62; $ta_LC_Nom)
			For ($ii_Cas; 1; Size of array:C274($tl_ref))
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$tl_LC_ID{$ii_Cas})
				If (Records in selection:C76([LesCentres:9])=1)
					$ta_LC_Nom{$ii_Cas}:=[LesCentres:9]LC_Répertoire:54
				Else 
					$ta_LC_Nom{$ii_Cas}:=""
				End if 
			End for 
			$ii_Cas:=Find in array:C230($ta_LC_Nom; va_Centre_Rep)
			If ($ii_Cas>0)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$tl_ref{$ii_Cas})
				Repeat 
					IDLE:C311
					LOAD RECORD:C52([HeberGement:5])
				Until (Not:C34(Locked:C147([HeberGement:5])))
				$vb_OK:=True:C214
			Else 
				$vb_OKCréer:=True:C214
			End if 
		Else 
			//10/01/2011
			Repeat 
				IDLE:C311
				LOAD RECORD:C52([HeberGement:5])
			Until (Not:C34(Locked:C147([HeberGement:5])))
			$vb_OK:=True:C214
			
		End if 
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
		
		If ($vl_FichesA>=($vl_OffSet+$vl_Décalage))
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
		End if 
		
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
		
		
		If (7=8)
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
		
		//13/12/2011 Création du dossier SIAO
		//12/01/2012 Modification
		$vb_OK_SIAO:=(<>vb_T_DosSIAO)
		If ($vb_OK_SIAO)
			If (<>vb_T_ModeCHRS)
				$vb_OK_SIAO:=False:C215
			Else 
				//  $vb_OK_SIAO:=([HeberGement]HG_NuitenCours=1)
				$vb_OK_SIAO:=$vb_OK_SIAO & ([HeberGement:5]HG_DossierSIAO:164>"")
				If ($vb_OK_SIAO)
					$va_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
					$vb_OK_SIAO:=(($va_Cas="1") | ($va_Cas="2") | ($va_Cas="3"))
				End if 
			End if 
		End if 
		If ($vb_OK_SIAO)
			If (F_SIAO_DansHebergement("Conso"; ->[HeberGement:5]HG_HB_ID:19; ->[HeberGement:5]HG_DossierSIAO:164; ->[HeberGement:5]HG_FamClé:104))
			End if 
		End if 
		//FIN 13/12/2011 Création du dossier SIAO
		
	End if 
	
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	// VALIDER TRANSACTION
	//(• Borne
	If ($vl_FichesA<Size of array:C274(<>te_Conso_Ligne))
		$vl_FichesDe:=$vl_FichesA+1
	End if 
	//(• Borne DEBUT     
	$vb_OK:=($vl_FichesA=Size of array:C274(<>te_Conso_Ligne))
Until ($vb_OK)




