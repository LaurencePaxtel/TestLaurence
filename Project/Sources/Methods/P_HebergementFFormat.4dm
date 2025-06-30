//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_HébergementFFormat
//{                             Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :    Mardi 13 mars 2012
//{          Développement : GABBAY Jean-Guy
//{          Méthode formulaire du format de saisie des hébergements
//{==================================================}
C_LONGINT:C283($vl_Event; $ii; $i_el)  // #20170816-1 
C_BOOLEAN:C305($vb_OK; $initialisation_b)
C_TIME:C306($vh_Heure)
C_OBJECT:C1216($enregistrement_o; $table_o; $produit_o; $refProduit_o)

var $hebergement_e : cs:C1710.HeberGementEntity

$vl_Event:=Form event code:C388

Case of 
	: ($vl_Event=Sur chargement:K2:1)
		// Modifié par : Scanu Rémy (18/01/2022)
		C_OBJECT:C1216(Form_o)
		
		// Modifié par : Scanu Rémy (24/06/2021)
		C_COLLECTION:C1488(variableModif_c)
		
		If (Read only state:C362([HeberGement:5])=True:C214)
			READ WRITE:C146([HeberGement:5])
		End if 
		
		variableModif_c:=New collection:C1472
		
		va_Transfert_HBAlors:=""  //26/7/2011
		va_Transfert_Centre:=""
		
		vl_AccesDossierSIAO_HG:=0
		vt_AccesDossierSIAO_HG:=""
		
		<>vt_HG_SiaoNo:=""
		
		va_LC_Stop:=""  //Alpha contient le libellé des erreurs à la validation
		
		// Modifié par : Scanu Rémy (20/10/2022)
		va_CtrLib:=""  //un libellé de 80 Car multiples usages
		
		If (outilsCheckCharacterIsNumber(Substring:C12(Current user:C182; 1; 1))=True:C214) & (outilsCheckCharacterIsNumber(Substring:C12(Current user:C182; 2; 1))=True:C214)
			va_CtrLib:=Substring:C12(Current user:C182; 1; 2)
		End if 
		
		SOC_Get_Config
		
		If (Not:C34(SO_DOS_Encours_Activer))
			OBJECT SET VISIBLE:C603(*; "@dossiers_encours@"; False:C215)
		End if 
		
		ve_TheAge:=0  //Age en entier de l'hébergé au moment de l'hébergement
		va_TheAge:=""  //Idem mais en alpha
		
		OBJECT SET VISIBLE:C603(b_Prests; Not:C34(<>vb_T_PrestaMasquer))  //28/3/2011Bouton Prestations caché par le bouton SIAO
		
		// #BS Fix O par 0 - 150616
		P_HébergementGpeAsile(0; (User in group:C338(Current user:C182; <>Groupe_Asile)))  //Init : Activer montrer ou inactiver cacher le panneau Asile 
		//◊vlSTR_Std : N° de la ressource STR  : pour les libellés : P_Profil
		
		P_ChampAttribut(<>vlSTR_Std-<>vlSTR)  // Statut des champs en fonction du profil
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_AttenteHeur:83; (User in group:C338(Current user:C182; <>Groupe_SaisieHoraires)))
		
		If (Is new record:C668([HeberGement:5]))
			MultiSoc_Init_Structure(->[HeberGement:5])
			
			P_HébergementNo(va_JourNuit)  //Numérotation et affectation de la fiche d'hébergement
			P_HébergementNoRéf
			
			If (F_VariablesTransite(4; 1; False:C215))  //Affectation des champs (dans le cas d'un nouvel hébegement avec historique)
				F_VariablesTransite(6; 0; False:C215)
			End if 
			
			P_HébergementGpeAsile(1; (User in group:C338(Current user:C182; <>Groupe_Asile)))  //Le panneau Asile 
			
			If (<>vb_T_ModeCHRS)  //• Base CHRS
				[HeberGement:5]HG_Plateforme:139:=<>va_UserPlateforme
				
				If (Length:C16(<>va_UserPlateforme)>3)
					va_CtrLib:=Substring:C12(<>va_UserPlateforme; 1; 4)
				Else 
					va_CtrLib:=<>va_UserPlateforme
				End if 
				
				F_Report_FullPlateforme(->[HeberGement:5]HG_Trans_DDASS:141; [HeberGement:5]HG_Plateforme:139)
			End if 
			
			[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
			[HeberGement:5]HG_Participation:138:=True:C214  //21/09/2009
			
			// Modifié par : Scanu Rémy (25/08/2022)
			If (Records in selection:C76([HeBerge:4])=1)
				
				If ([HeBerge:4]HB_CléFam:47#"")
					[HeberGement:5]HG_FamChef:103:=True:C214
					P_HG_FamilleChef(1)
					
					OBJECT SET ENTERABLE:C238(*; "091_Chp1"; True:C214)
				End if 
				
			End if 
			
			// Modifié par : Scanu Rémy (08/12/2022)
			[HeberGement:5]HG_Maraude1_2:97:=String:C10([HeberGement:5]HG_Date:4)
			OBJECT SET ENTERABLE:C238(*; "097_Chp"; (User in group:C338(Current user:C182; "ModifMaraude1-2")))
		Else 
			P_HébergementGpeAsile(2; (User in group:C338(Current user:C182; <>Groupe_Asile)))  //Le panneau Asile
			P_LesLogs(<>va_Log_Hebergement; [HeberGement:5]HG_FicheNuméro:3)  //Suivi des logs
			P_Transfert_HBAlors("Libelle")  //26/7/2011
			P_Transfert_HBAlors("Centre")  //26/7/2011
		End if 
		
		// Modified by: Kevin HASSAL (18-03-2019)
		// Correction du bug du choix du chef de famille : Oui/Non
		If ([HeberGement:5]HG_FamChef:103=True:C214)
			x1:=1
			x2:=0
		Else 
			x1:=0
			x2:=1
		End if 
		
		<>vl_NoHHisto:=[HeberGement:5]HG_HB_ID:19
		
		ve_TheAge:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_Date:4)
		va_TheAge:=String:C10(ve_TheAge)
		
		If (<>vb_T_RéfHébergé)
			va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" ("+String:C10(ve_TheAge)+" an"+("s"*Num:C11(ve_TheAge>=2))+")"+"  <"+String:C10([HeberGement:5]HG_HB_ID:19)+">"
		Else 
			va_Identité:=[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" ("+String:C10(ve_TheAge)+" an"+("s"*Num:C11(ve_TheAge>=2))+")"
		End if 
		
		P_HébergementGpeExterne(0; (User in group:C338(Current user:C182; <>Groupe_Externe)))  //Activer montrer ou inactiver cacher les boutons et champs du groupe externe     
		
		If (<>vb_UserLOFT)  //Utilisateurs de type LOFT
			OBJECT SET VISIBLE:C603(*; "102@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Asile_Cache"; False:C215)
			
			//Centre par défaut
			If (Is new record:C668([HeberGement:5])) & (<>vl_LOFTCtrRéf>0)
				MultiSoc_Init_Structure(->[HeberGement:5])
				
				[HeberGement:5]HG_LC_ID:61:=<>vl_LOFTCtrRéf
				[HeberGement:5]HG_CentreNom:62:=<>va_LOFTCtrNom
				[HeberGement:5]HG_CentreARR:63:=<>va_LOFTCtrCP
				[HeberGement:5]HG_Médicalisé:56:=<>vb_LOFTCtrMéd
			End if 
			
		End if 
		
		P_HébergementFrom("")  //D'où vient l'appel (Jour/Nuit ou depuis la liste veille)
		P_HébergementExcuser(<>vb_CentreEXCExc; 0)  //Activer montrer ou inactiver cacher Si c'est un hébergement en excuse
		
		If (<>vb_CentreEXC) & ([HeberGement:5]HG_Nuit:2=False:C215) & (Is new record:C668([HeberGement:5]))
			MultiSoc_Init_Structure(->[HeberGement:5])
			
			$vh_Heure:=Current time:C178
			
			If ($vh_Heure>=<>vh_CentreEXChD) & ($vh_Heure<=<>vh_CentreEXChF)
				[HeberGement:5]HG_GestionCentreNuit:133:="J"
			Else 
				[HeberGement:5]HG_GestionCentreNuit:133:="N"
			End if 
			
		End if 
		
		P_HébergementClignote(0)  //Faire clignoter le bouton SP  et SIAO
		
		If (<>vb_RéservationActive=False:C215)  //Partie concernat la saisie différée
			
			If (<>ve_Si_ModeCHRS=0)  //• Si fiche d'hébergement profil Prestation
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Réservation:91; <>vb_RéservationActive)  /// utilisateur lambda + saisie différeé : champ saisissable
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitenCours:92; <>vb_RéservationActive)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; <>vb_RéservationActive)
				OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Reporté:94; <>vb_RéservationActive)
			End if 
			
			OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
		End if 
		
		If (va_FormatFrom="P")  //Activer montrer ou inactiver cacher Si  l'appel est "P"
			P_HébergementFrom("P")
		End if 
		
		P_HébergementFrom("PR")  //Participation
		
		
		COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpCHRS)
		$ii:=Size of array:C274(<>ta_FMGrpCHRS)
		
		Repeat 
			
			If (<>ta_FMGrpCHRS{$ii}#(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
				DELETE FROM ARRAY:C228(<>ta_FMGrpCHRS; $ii; 1)
			End if 
			
			$ii:=$ii-1
		Until ($ii<1)
		
		
		If (<>ve_Si_ModeCHRS=1)  //• Si fiche d'hébergement profil Prestation
			va_TitreCentrePrest:=xliff_Txt_Get_Indexed_String_(31011; 5)  //"Prestation" 
			
			OBJECT SET VISIBLE:C603(*; "Exc_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Remp_@"; False:C215)
		Else   //• Si fiche d'hébergement profil Centre
			va_TitreCentrePrest:=xliff_Txt_Get_Indexed_String_(<>vlSTR_Std_Soc; 51)  //"Centres
			
			P_MasqueEtatCivil([HeberGement:5]HG_EtatCivil:20)  //22/4/2008
		End if 
		
		OBJECT SET VISIBLE:C603(*; "141_@"; [HeberGement:5]HG_Trans_DDASS:141)
		OBJECT SET VISIBLE:C603(b_ChgtPtfme; (User in group:C338(Current user:C182; <>Groupe_ChgtPlateforme) & ([HeberGement:5]HG_Nuit:2=False:C215)))  //Bouton Changement de plateforme 21/09/2009
		
		If (Is new record:C668([HeberGement:5])=False:C215)
			P_FicheHorsCentres((<>vlSTR_Std-<>vlSTR); [HeberGement:5]HG_LC_ID:61)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "057_@"; False:C215)  //15/2/2010
		OBJECT SET VISIBLE:C603(*; "063_@"; False:C215)  //15/2/2010
		OBJECT SET VISIBLE:C603(*; "090_@"; False:C215)  //15/2/2010
		
		OBJECT SET VISIBLE:C603(b_Renouvellement; (User in group:C338(Current user:C182; <>Groupe_Renouvellement) & ([HeberGement:5]HG_Nuit:2=False:C215)))  //Bouton REVOUVELLEMENT : 2/11/2010
		
		P_Formatage("FamDistribution"; <>vb_T_DitribSansDecimale)  //10/01/2011
		OBJECT SET VISIBLE:C603(*; "Fiche_115"; F_Fiche115)  //28/3/2011
		
		// Modifié par : Scanu Rémy (01/06/2022)
		// Ajout d'un groupe Modif Nuits en cours
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitenCours:92; User in group:C338(Current user:C182; "Modif Nuits en cours"))
		
		$vb_OK:=F_SIAO_Dossier("SIAODossierSurChargement")
		$vb_OK:=F_SIAO_DansHebergement("Charger"; ->[HeberGement:5]HG_HB_ID:19)
		
		If (<>ve_Si_ModeCHRS=1)  //• Si fiche d'hébergement profil Prestation
			
			If (<>tb_RdsVis{<>vlSTR_Std-<>vlSTR}{46}=True:C214)  //Afficher à l'écran
				
				If (<>tb_RdsSais{<>vlSTR_Std-<>vlSTR}{46}=True:C214)
					OBJECT SET ENTERABLE:C238(Field:C253(<>te_RdsFic{<>vlSTR_Std-<>vlSTR}{46}; <>te_RdsRub{<>vlSTR_Std-<>vlSTR}{46})->; True:C214)
				End if 
				
			End if 
			
		End if 
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (30/03/2021)
		OBJECT SET ENTERABLE:C238([HeberGement:5]HG_Réservation:91; True:C214)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (25/08/2022)
		OBJECT SET VISIBLE:C603(*; "Rectangle rond7"; [HeberGement:5]HG_ReservationProvisoire:177)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (11/10/2021)
		If (va_JourNuit="J")
			TableChamps(2; 8)
		Else 
			TableChamps(2; 12)
		End if 
		
		For ($ii; 1; Size of array:C274(<>te_RubTri))
			QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=<>vlSTR+1)
			MultiSoc_Filter(->[LesRubriques:21])
			
			QUERY SELECTION:C341([LesRubriques:21]; [LesRubriques:21]NuméroTri:1=<>te_RubTri{$ii})
			
			If (Records in selection:C76([LesRubriques:21])=1)
				LOAD RECORD:C52([LesRubriques:21])
				
				Case of 
					: ([LesRubriques:21]RubNom:2="Coordinateur")
						OBJECT SET VISIBLE:C603(*; "007_Bt"; [LesRubriques:21]RubModifiable:10)
					: ([LesRubriques:21]RubNom:2="Régulateur")
						OBJECT SET VISIBLE:C603(*; "008_Bt"; [LesRubriques:21]RubModifiable:10)
					: ([LesRubriques:21]RubNom:2="Permanencier")
						OBJECT SET VISIBLE:C603(*; "009_Bt"; [LesRubriques:21]RubModifiable:10)
						OBJECT SET VISIBLE:C603(*; "009_ico1"; [LesRubriques:21]RubModifiable:10)
					: ([LesRubriques:21]RubNom:2="Assistante sociale")
						OBJECT SET VISIBLE:C603(*; "087_Bt"; [LesRubriques:21]RubModifiable:10)
					: ([LesRubriques:21]RubNom:2="Signalement")
					: ([LesRubriques:21]RubNom:2="Signalement Centre")
					: ([LesRubriques:21]RubNom:2="Code postal")
						OBJECT SET VISIBLE:C603(*; "018_Bt"; [LesRubriques:21]RubModifiable:10)
					: ([LesRubriques:21]RubNom:2="Gare")
						OBJECT SET VISIBLE:C603(*; "015_Bt"; [LesRubriques:21]RubModifiable:10)
				End case 
				
			End if 
			
		End for 
		
		// Modifié par : Scanu Rémy (18/01/2022)
		Form_o:=New object:C1471("reinitialisation"; True:C214; "entitySelectionInit"; ds:C1482.StockBis.newSelection(); "stockHeberge"; New collection:C1472; "refProduit1"; ""; "refProduit2"; ""; "refProduit3"; "")
		outilsOrdaSearchSimple("SOciete"; "Ref_Structure"; <>ref_soc_active; ->$enregistrement_o; "first")
		
		If ($enregistrement_o#Null:C1517)
			
			If ($enregistrement_o.SO_StockHeberge#Null:C1517)
				Form_o.stockHeberge:=$enregistrement_o.SO_StockHeberge.param.query("check = :1"; True:C214)
				
				If (Form_o.stockHeberge.length>0)
					$table_o:=ds:C1482.StockBis.all()
					outilsOrdaSearchByRefStctre(->$table_o; <>ref_soc_active)
					
					Form_o.entitySelectionInit:=$table_o.query("produit in :1 AND date >= :2 AND date <= :3"; Form_o.stockHeberge.extract("produit"); [HeberGement:5]HG_Date:4; [HeberGement:5]HG_RéservationDateFin:134).orderBy("date asc, produit asc")
				End if 
				
			End if 
			
		End if 
		
		// Modifié par : Scanu Rémy (28/02/2023)
		If (Is new record:C668([HeberGement:5])=True:C214)
			
			If (Bool:C1537(Form:C1466.dupliquerFiche)=True:C214)
				$hebergement_e:=ds:C1482.HeberGement.get(Form:C1466.dupliquerFicheHGID)
				
				If ($hebergement_e#Null:C1517)
					[HeberGement:5]HG_Date:4:=$hebergement_e.HG_Date
					[HeberGement:5]HG_Signalement:12:=$hebergement_e.HG_Signalement
					[HeberGement:5]HG_FamGroupe:102:=$hebergement_e.HG_FamGroupe
					[HeberGement:5]HG_Plateforme:139:=$hebergement_e.HG_Plateforme
					[HeberGement:5]HG_FamClé:104:=$hebergement_e.HG_FamClé
				End if 
				
			End if 
			
		End if 
		
		// Modifié par : Scanu Rémy (01/06/2022)
		// Ajout d'un groupe modif_date_fiche
		OBJECT SET VISIBLE:C603(*; "dateOrigine@"; User in group:C338(Current user:C182; "modif_date_fiche"))
		OBJECT SET VISIBLE:C603(*; "editDate"; User in group:C338(Current user:C182; "modif_date_fiche"))
		
		// Modifié par : Scanu Rémy (12/04/2024)
		// Affichage du bouton "Sortie" uniquement si fiche Jour
		OBJECT SET VISIBLE:C603(*; "sortieButton@"; Not:C34([HeberGement:5]HG_Nuit:2))
		
		POST OUTSIDE CALL:C329(Current process:C322)
	: ($vl_Event=Sur minuteur:K2:25)
		P_HébergementClignote(1)  //Faire clignoter le bouton SP  
		P_HébergementClignote(2)  //Faire clignoter le bouton SIAO  
	: ($vl_Event=Sur données modifiées:K2:15)
		
		Case of 
			: (Modified:C32([HeberGement:5]HG_NuitTOTAL:93))
				
				If (<>ve_Si_ModeCHRS=1)  //• Si fiche d'hébergement profil Prestation
					
					If ([HeberGement:5]HG_NuitTOTAL:93<=1)
						[HeberGement:5]HG_NuitTOTAL:93:=1
						[HeberGement:5]HG_Réservation:91:=False:C215
					Else 
						[HeberGement:5]HG_Réservation:91:=True:C214
					End if 
					
					[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
					[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
				Else 
					
					If ([HeberGement:5]HG_NuitTOTAL:93<[HeberGement:5]HG_NuitenCours:92)
						[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
					End if 
					
					[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
					
					//06/09/2004
					[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
					
					//29/03/2005
					If ([HeberGement:5]HG_FamChef:103)
						[HeberGement:5]HG_FamNbJour:107:=[HeberGement:5]HG_NuitTOTAL:93
						P_HG_FamilleTotal
					End if 
					
				End if 
				
			: (Modified:C32([HeberGement:5]HG_RéservationDateFin:134))
				
				If (<>ve_Si_ModeCHRS=1)  //• Si fiche d'hébergement profil Prestation
					
					If ([HeberGement:5]HG_RéservationDateFin:134<=[HeberGement:5]HG_Date:4)
						[HeberGement:5]HG_RéservationDateFin:134:=[HeberGement:5]HG_Date:4
						[HeberGement:5]HG_Réservation:91:=False:C215
						[HeberGement:5]HG_NuitTOTAL:93:=1
						[HeberGement:5]HG_NuitReste:95:=0
					Else 
						[HeberGement:5]HG_Réservation:91:=True:C214
						[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_RéservationDateFin:134-[HeberGement:5]HG_Date:4+1
						[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
					End if 
					
				End if 
				
			: (Modified:C32([HeberGement:5]HG_CentreNom:62))
				
				If ([HeberGement:5]HG_CentreNom:62<="")
					[HeberGement:5]HG_CentreNom:62:=""
					[HeberGement:5]HG_CentreARR:63:=""
					[HeberGement:5]HG_LC_ID:61:=0
				End if 
				
			: (Modified:C32([HeberGement:5]HG_Cloturée:67))
				
				If ([HeberGement:5]HG_Cloturée:67)
					[HeberGement:5]HG_EnAttente:64:=False:C215
				End if 
				
		End case 
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		
		If (Value type:C1509(Form_o)#Est une variable indéfinie:K8:13) && (Form_o#Null:C1517)
			$initialisation_b:=(Bool:C1537(Form_o.reinitialisation)=True:C214)
			
			If (Bool:C1537(Form_o.reinitialisation)=True:C214)
				Form_o.reference:=New collection:C1472
				
				Form_o.refProduit1:=""
				Form_o.refProduit2:=""
				Form_o.refProduit3:=""
				
				If (Form_o.entitySelectionInit.length>0)
					$table_o:=Form_o.entitySelectionInit.query("date = :1"; [HeberGement:5]HG_Date:4).orderBy("date asc, produit asc")
					
					outilsProgressBar(0; "Initialisation"; True:C214)
					
					For each ($produit_o; $table_o)
						outilsProgressBar($i_el/$table_o.configuration.length; "Extraction des références produit en cours..."; True:C214)
						
						For each ($refProduit_o; $produit_o.configuration.detail)
							
							If ($refProduit_o.hebergeID#Null:C1517)
								
								If ($refProduit_o.hebergeID=[HeberGement:5]HG_HB_ID:19)
									Form_o.reference.push(New object:C1471("reference"; $refProduit_o.reference))
									
									Case of 
										: (Form_o.refProduit1="")
											Form_o.refProduit1:=$refProduit_o.reference
										: (Form_o.refProduit2="")
											Form_o.refProduit2:=$refProduit_o.reference
										: (Form_o.refProduit3="")
											Form_o.refProduit3:=$refProduit_o.reference
									End case 
									
								End if 
								
							End if 
							
						End for each 
						
						$i_el:=$i_el+1
					End for each 
					
					outilsProgressBar(1; "arrêt")
				End if 
				
				OB REMOVE:C1226(Form_o; "reinitialisation")
			End if 
			
		End if 
		
		If ($initialisation_b=False:C215)
			
			Case of 
				: (<>va_MessageAE_HG="")
					[HeberGement:5]HG_FamClé:104:=<>va_LeNoFAM
					
					F_SIAO_Dossier("SIAODossierCleLien")
				: (<>va_MessageAE_HG=<>va_MessageAE_HGRemp)
					<>va_MessageAE_HG:=""
					
					P_HébergementListeValider(0; 0)
				: (<>va_MessageAE_HG=<>va_MessageAE_HGTranfert)
					<>va_MessageAE_HG:=""
					
					P_BAL_C(41)
			End case 
			
		End if 
		
	: ($vl_Event=Sur menu sélectionné:K2:14)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
		// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
		i_MenuChoisi
End case 