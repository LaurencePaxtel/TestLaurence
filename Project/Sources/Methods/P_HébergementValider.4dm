//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementValider
//{
//{          Mercredi 23 Mars 2001 à 13:58:38
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  // J ou N

C_TEXT:C284($variable_t)
C_LONGINT:C283($i_el; $nbJour_el; $id_el; $idCentre_el; $nuitEnCours_el; $lengthMax_el; $moduloProgress_el)
C_BOOLEAN:C305($stop_b)
C_DATE:C307($date_d)
C_OBJECT:C1216($table_o; $enregistrement_o)

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es : cs:C1710.HeberGementSelection

var $societe_es : cs:C1710.SOcieteSelection

If (F_ChampObligatoire(<>vlSTR_Std-<>vlSTR))
	[HeberGement:5]HG_CléFax:69:=Uut_FaxClé(->[HeberGement:5]HG_Date:4; ->[HeberGement:5]HG_Nuit:2; ->[HeberGement:5]HG_Cloturée:67)
	
	If ([HeberGement:5]HG_ER_Excuse:124)
		[HeberGement:5]HG_CléFax:69:=[HeberGement:5]HG_CléFax:69+"E"
	End if 
	
	va_LC_Stop:=""
	
	If (<>ve_Si_ModeCHRS#1)  // C'est un hébergement
		
		If (Is new record:C668([HeberGement:5]))  // Nouvelle fiche
			MultiSoc_Init_Structure(->[HeberGement:5])
			
			If ([HeberGement:5]HG_Réservation:91) | ([HeberGement:5]HG_NuitTOTAL:93>[HeberGement:5]HG_NuitenCours:92)  //(([HéberGement]HG_NuitTOTAL>1) & ([HéberGement]HG_NuitTOTAL>[HéberGement]HG_Nuit
				
				If ([HeberGement:5]HG_Cloturée:67=False:C215)
					va_LC_Stop:="Vous avez fait une réservation active : vous devez approuver avant de valider."+Char:C90(13)+"Si vous ne voulez pas clôturer : mettez la réservation à non."
				End if 
				
			End if 
			
			If (va_LC_Stop="")
				
				If ([HeberGement:5]HG_Cloturée:67) & ([HeberGement:5]HG_LC_ID:61>0)  //Si Cloturé et Lit lié
					va_LC_Stop:=F_CL_LitsDispoAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; $1; 1; (1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
				End if 
				
			End if 
			
		Else   //Modification de fiche
			
			Case of 
				: ([HeberGement:5]HG_Cloturée:67=True:C214)
					
					If (Old:C35([HeberGement:5]HG_Cloturée:67)=True:C214)
						
						If (Old:C35([HeberGement:5]HG_LC_ID:61)#[HeberGement:5]HG_LC_ID:61)
							va_LC_Stop:=F_CL_LitsDispoAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; $1; 1; (1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
							
							If (va_LC_Stop="")
								P_CL_LitsAffecter([HeberGement:5]HG_Date:4; Old:C35([HeberGement:5]HG_LC_ID:61); -1; $1; (-1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
							End if 
							
						End if 
						
					Else 
						va_LC_Stop:=F_CL_LitsDispoAffecter([HeberGement:5]HG_Date:4; [HeberGement:5]HG_LC_ID:61; 1; $1; 1; (1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
					End if 
					
				: ([HeberGement:5]HG_Cloturée:67=False:C215)
					
					If ([HeberGement:5]HG_ER_Excuse:124=False:C215)
						
						If ([HeberGement:5]HG_Réservation:91) | ([HeberGement:5]HG_NuitTOTAL:93>[HeberGement:5]HG_NuitenCours:92)  // (([HéberGement]HG_NuitTOTAL>1) & ([HéberGement]HG_NuitTOTAL=[HéberGement]HG_Nui
							va_LC_Stop:="Il y a une réservation active : "+"vous devez confirmer la place occupée avant de valider."+Char:C90(13)+"Si vous ne voulez pas confirmer la place : mettez la réservation à non."
						Else 
							
							If (Old:C35([HeberGement:5]HG_Cloturée:67)=True:C214)
								P_CL_LitsAffecter([HeberGement:5]HG_Date:4; Old:C35([HeberGement:5]HG_LC_ID:61); -1; $1; (-1*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=True:C214)))
							End if 
							
						End if 
						
					End if 
					
			End case 
			
		End if 
		
	End if 
	
	If (va_LC_Stop>"")
		ALERT:C41(va_LC_Stop)
	Else 
		
		If ([HeberGement:5]HG_FamChef:103)
			
			If ([HeberGement:5]HG_FamClé:104>"")
				INSERT IN ARRAY:C227(<>tl_HBCheffamille; Size of array:C274(<>tl_HBCheffamille)+1)
				<>tl_HBCheffamille{Size of array:C274(<>tl_HBCheffamille)}:=[HeberGement:5]HG_HB_ID:19
			End if 
			
		End if 
		
		READ WRITE:C146([HeBerge:4])
		LOAD RECORD:C52([HeBerge:4])
		
		If (Not:C34(Locked:C147([HeBerge:4])))
			[HeBerge:4]HG_Genre:39:=[HeberGement:5]HG_Genre:96
			SAVE RECORD:C53([HeBerge:4])
		End if 
		
		UNLOAD RECORD:C212([HeBerge:4])
		
		//******************************
		If ([HeberGement:5]HG_NuitenCours:92=1)
			
			Case of 
				: ([HeberGement:5]HG_LC_ID:61#Old:C35([HeberGement:5]HG_LC_ID:61))
					[HeberGement:5]HG_1_TransHeure:70:=<>vh_HeureVide
				: ([HeberGement:5]HG_Cloturée:67#Old:C35([HeberGement:5]HG_Cloturée:67))
					[HeberGement:5]HG_1_TransHeure:70:=<>vh_HeureVide
			End case 
			
		End if 
		//******************************
		
		[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  // 19/07/2010
		
		// Modifié par : Scanu Rémy (03/05/2023)
		// Mise en place d'un timeStamp plus facilement manipulable
		[HeberGement:5]HG_TimeStamp:180:=outilsTimeStamp(Current date:C33(*); Current time:C178(*))
		
		// Modifié par : Scanu Rémy (09/11/2023)
		// Mise en place d'un booléen pour savoir si la sauvegarde provient de l'application mobile ou pas
		[HeberGement:5]importApplicationMobile:184:=False:C215
		
		// Modifié par : Scanu Rémy (24/06/2021)
		If (variableModif_c.length>0)
			variableModif_c:=variableModif_c.distinct()
			
			For each ($variable_t; variableModif_c)
				
				Case of 
					: ($variable_t="101_Chp")  // Date PEC Sortie
						// On cherche toutes les fiches d'hébergements de l'hébergé qui ont une date PEC début inférieure à la date de sortie indiquée
						$table_o:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date < :2 AND ID # :3"; [HeberGement:5]HG_HB_ID:19; [HeberGement:5]HG_Date:4; [HeberGement:5]ID:168).orderBy("HG_Date desc")
						$date_d:=[HeberGement:5]HG_Date:4
						
						For each ($enregistrement_o; $table_o) Until ($stop_b=True:C214)
							$date_d:=Add to date:C393($date_d; 0; 0; -1)
							
							If ($enregistrement_o.HG_Date=$date_d)
								$enregistrement_o.HG_DateSortie:=[HeberGement:5]HG_DateSortie:185
								$enregistrement_o.save()
							Else 
								$stop_b:=False:C215
							End if 
							
						End for each 
						
				End case 
				
			End for each 
			
		End if 
		
		// Modifié par : Scanu Rémy (09/05/2022) et Re-modifié par : Scanu Rémy (24/08/2022)
		If (Is new record:C668([HeberGement:5])=True:C214)
			$hebergement_es:=ds:C1482.HeberGement.query("HG_FicheNuméro = :1"; [HeberGement:5]HG_FicheNuméro:3)
			
			If ($hebergement_es.length=1)
				[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche($1; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
			End if 
			
			// Modifié par : Scanu Rémy (23/02/2023)
			If (User in group:C338(Current user:C182; "SaisieMenage")=True:C214)
				LOAD RECORD:C52([HeBerge:4])
				$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1"; [HeBerge:4]HB_ReferenceID:1)
				
				If ($hebergement_es.length=0)  // C'est la première fiche hébergement de l'hébergé
					CONFIRM:C162("Voulez vous enregistrer et rattacher une nouvelle personne à ce demandeur ?"; "Oui"; "Non")
					Form:C1466.dupliquerFiche:=(OK=1)
				End if 
				
			End if 
			
		End if 
		
		SAVE RECORD:C53([HeberGement:5])
		
		// Modifié par : Scanu Rémy (11/08/2022)
		// Ajout de la réservation provisoire
		If (Bool:C1537(Form:C1466.reservationProvisoire)=True:C214) | (Form:C1466.reservationProvisoire#Null:C1517)
			$nbJour_el:=outilsGetNbJour([HeberGement:5]HG_RéservationDateFin:134; [HeberGement:5]HG_Date:4)
			
			// Modifié par : Scanu Rémy (24/08/2022)
			// Ajout du thermomètre de progession
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For ($i_el; 0; $nbJour_el)
				outilsProgressBar($i_el/$nbJour_el; Choose:C955(Bool:C1537(Form:C1466.reservationProvisoire)=True:C214; "Bascule des fiches en \"Réservation provisoire\""; "Suppression du statut \"Réservation provisoire\" pour les fiches")+" en cours..."; True:C214)
				
				$hebergement_es:=ds:C1482.HeberGement.query("HG_FamClé = :1 AND HG_Date = :2 AND ID # :3"; [HeberGement:5]HG_FamClé:104; Add to date:C393([HeberGement:5]HG_Date:4; 0; 0; $i_el); [HeberGement:5]ID:168).orderBy("HG_Date asc")
				
				For each ($hebergement_e; $hebergement_es)
					$hebergement_e.HG_ReservationProvisoire:=[HeberGement:5]HG_ReservationProvisoire:177
					$hebergement_e.save()
				End for each 
				
			End for 
			
			outilsProgressBar(1; "arrêt")
		End if 
		
		// Modifié par : Scanu Rémy (11/08/2022)
		// Ajout du report manuel
		If (Bool:C1537(Form:C1466.reportManuel)=True:C214)
			[HeberGement:5]HG_Reporté:94:="R"
			SAVE RECORD:C53([HeberGement:5])
			
			$id_el:=[HeberGement:5]ID:168
			$date_d:=[HeberGement:5]HG_Date:4
			
			// Modifié par : Scanu Rémy (17/10/2022)
			$societe_es:=ds:C1482.SOciete.query("Ref_Structure = :1"; <>ref_soc_active)
			
			// Modifié par : Scanu Rémy (11/07/2023)
			$nbJour_el:=outilsGetNbJour(Form:C1466.reportManuelDate; [HeberGement:5]HG_Date:4)
			$nuitEnCours_el:=[HeberGement:5]HG_NuitenCours:92+1
			
			QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[HeberGement:5]HG_LC_ID:61)
			$idCentre_el:=[LesCentres:9]ID:60
			
			$lengthMax_el:=$nbJour_el
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			// Modifié par : Scanu Rémy (24/08/2022)
			// Ajout du thermomètre de progession
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For ($i_el; 1; $nbJour_el)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$nbJour_el; "Création du report des fiches en cours..."; True:C214)
				End if 
				
				$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date = :2 AND HG_Nuit = :3"; [HeberGement:5]HG_HB_ID:19; Add to date:C393($date_d; 0; 0; $i_el); False:C215)  // Modifié par : Scanu Rémy (20/10/2022), recherche s'il y a des fiches jours ce jour là
				
				If ($hebergement_es.length=0)  // Si pas de fiche au jour sur lequel on est en train de boucler pour une fiche Hébergement OU report manuel pour une fiche Prestation pour la personne
					DUPLICATE RECORD:C225([HeberGement:5])
					
					[HeberGement:5]HG_Date:4:=Add to date:C393($date_d; 0; 0; $i_el)
					
					// Modifié par : Scanu Rémy (24/08/2022)
					// Ajout champs uniques et champs pour le compteur des nuits et champ pour voir que la fiche est reporté
					[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
					[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche($1; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
					
					[HeberGement:5]HG_NuitenCours:92:=$nuitEnCours_el
					[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
					
					If ($i_el<$nbJour_el)
						[HeberGement:5]HG_Reporté:94:="R"
					Else 
						[HeberGement:5]HG_Reporté:94:=""
					End if 
					
					[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
					[HeberGement:5]HG_Cloturée:67:=True:C214
					SAVE RECORD:C53([HeberGement:5])
				End if 
				
				$dateType_t:=Uut_NumeroteLitsType(Add to date:C393($date_d; 0; 0; $i_el); $1)
				
				ALL RECORDS:C47([LesCentres:9])
				MultiSoc_Filter(->[LesCentres:9])
				
				While (Not:C34(End selection:C36([LesCentres:9])))
					QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=$dateType_t; *)
					QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
					
					MultiSoc_Filter(->[CentresLits:16])
					
					Case of 
						: (Records in selection:C76([CentresLits:16])=0)
							
							If ([LesCentres:9]LC_Fermé:53=False:C215) & ([LesCentres:9]LC_Prestation:55=False:C215)
								P_DisponibilitéCréer(0; "J"; Add to date:C393($date_d; 0; 0; $i_el); 0; 0; 0; 0; 0; Choose:C955([LesCentres:9]ID:60=$idCentre_el; 1; 0))
								QUERY:C277([HeberGement:5]; [HeberGement:5]ID:168=$id_el)
								
								If ([LesCentres:9]ID:60#$idCentre_el)
									QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=$dateType_t; *)
									QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
									
									If (Records in selection:C76([CentresLits:16])>0)
										[CentresLits:16]CL_Restant:7:=[LesCentres:9]LC_DispoJour:48
										SAVE RECORD:C53([CentresLits:16])
									End if 
									
								End if 
								
							End if 
							
						: ([LesCentres:9]LC_Fermé:53=False:C215) & ([LesCentres:9]ID:60=$idCentre_el)
							[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6+1
							[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7-[CentresLits:16]CL_Distribué:6
							SAVE RECORD:C53([CentresLits:16])
					End case 
					
					NEXT RECORD:C51([LesCentres:9])
				End while 
				
				// Modifié par : Scanu Rémy (27/10/2022)
				$nuitEnCours_el:=$nuitEnCours_el+1
			End for 
			
			outilsProgressBar(1; "arrêt")
		End if 
		
		// Modifié par : Scanu Rémy (23/02/2023)
		// Duplication fiche pour un ménage
		OB REMOVE:C1226(Form:C1466; "dupliquerFicheHBID")
		OB REMOVE:C1226(Form:C1466; "dupliquerFicheHGID")
		OB REMOVE:C1226(Form:C1466; "dupliquerFicheType")
		
		If (Bool:C1537(Form:C1466.dupliquerFiche)=True:C214)
			Form:C1466.dupliquerFicheHBID:=[HeBerge:4]ID:65
			Form:C1466.dupliquerFicheHGID:=[HeberGement:5]ID:168
			
			Form:C1466.dupliquerFicheType:=$1
		End if 
		
		ACCEPT:C269
	End if 
	
End if 