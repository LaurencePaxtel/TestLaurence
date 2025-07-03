Class extends DataClass

Function createEntityAppMobileImportDataHeberge($column_c : Collection; $heberge_e : cs:C1710.HeBergeEntity; $refStructure_t : Text; $dateFiche_d : Date; $importAuto_b : Boolean)->$hebergement_e : cs:C1710.HeberGementEntity
	var $id_el : Integer
	var $hebergement_o : Object
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	$hebergement_e:=ds:C1482.HeberGement.new()
	$id_el:=$hebergement_e.ID
	
	// On prend la dernière fiche existante pour l'hébergé avant la date de la fiche qu'on veut créer
	$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID.query("HG_Nuit = :1 AND HG_Date < :2"; True:C214; $dateFiche_d).orderBy("HG_Date desc")
	
	If ($hebergement_es.length>0)
		$hebergement_o:=$hebergement_es.first().toObject()
		
		$hebergement_e.fromObject($hebergement_o)
		$hebergement_e.ID:=$id_el
	End if 
	
	$hebergement_e.HG_HB_ID:=$heberge_e.HB_ReferenceID
	$hebergement_e.HG_FamClé:=$column_c[3]
	$hebergement_e.HG_FamChef:=($hebergement_e.HG_FamClé#"")
	
	$hebergement_e.HG_Nationalité:=$column_c[9]
	$hebergement_e.HG_CentreNom:="Mise à jour situation"
	
	$hebergement_e.HG_Genre:=$heberge_e.HG_Genre
	$hebergement_e.HG_EtatCivil:=$column_c[29]
	
	$hebergement_e.HG_Date:=Choose:C955($dateFiche_d#!00-00-00!; $dateFiche_d; Current date:C33(*))
	$hebergement_e.HG_RéservationDateFin:=$hebergement_e.HG_Date
	
	$hebergement_e.HG_HeureAppel:=Current time:C178(*)
	$hebergement_e.HG_FicheNuméro:=i_HébérgementNoFiche("N"; $hebergement_e.HG_Date; Uut_Numerote115($hebergement_e.HG_Date))
	
	$hebergement_e.HG_EnAttente:=True:C214
	$hebergement_e.HG_DateDuJour:=Current date:C33()
	$hebergement_e.HG_AttenteHeur:=Current time:C178()
	
	$hebergement_e.HG_ReferenceID:=Uut_Numerote(->[HeberGement:5])
	
	$hebergement_e.HG_Nuit:=True:C214
	
	$hebergement_e.HG_NuitenCours:=1
	$hebergement_e.HG_NuitTOTAL:=1
	
	$hebergement_e.HG_NuitReste:=$hebergement_e.HG_NuitTOTAL-$hebergement_e.HG_NuitenCours
	
	$hebergement_e.HG_Nom:=$heberge_e.HB_Nom
	$hebergement_e.HG_Prénom:=$heberge_e.HB_Prénom
	$hebergement_e.HG_HB_ID:=$heberge_e.HB_ReferenceID
	
	$hebergement_e.HG_EnAttente:=True:C214
	$hebergement_e.HG_Cloturée:=True:C214
	
	$hebergement_e.HG_Ressources1:=$column_c[33]
	$hebergement_e.HG_PiècesIdté1:=$column_c[37]
	$hebergement_e.HG_SituProfess:=$column_c[41]
	
	$hebergement_e.HG_DateCreationFiche:=Current date:C33(*)
	$hebergement_e.HG_ModifDateHeures:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))
	$hebergement_e.HG_Réservation:=True:C214
	$hebergement_e.Ref_Structure:=$refStructure_t
	
	If ($importAuto_b=False:C215)
		
		If (<>vb_T_ModeCHRS)
			$hebergement_e.HG_Plateforme:=<>va_UserPlateforme
		End if 
		
		If (User in group:C338(Current user:C182; "Permanencier")=True:C214)
			$hebergement_e.HG_Permanencier:=Current user:C182
		End if 
		
		$hebergement_e.HG_Coordinateur:=<>va_HG_Coordinateur
		$hebergement_e.HG_Régulateur:=<>va_HG_Régulateur
	End if 
	
	// Indique qu'on provient de l'import des données de l'application mobile
	$hebergement_e.saveEntity(1)
	$statut_o:=$hebergement_e.save()
	
	
	
Function getTsModif($id_el : Integer)->$ts_el : Integer
	var $date_t; $heure_t : Text
	var $hebergement_e : cs:C1710.HeberGementEntity
	
	$hebergement_e:=ds:C1482.HeberGement.get($id_el)
	
	If ($hebergement_e#Null:C1517)
		$date_t:=Substring:C12($hebergement_e.HG_ModifDateHeures; 1; 8)
		$heure_t:=Substring:C12($hebergement_e.HG_ModifDateHeures; 9)+":00"  // On rajoute les secondes car non stocké
		
		$date_t:=Substring:C12($date_t; 7; 2)+"/"+Substring:C12($date_t; 5; 2)+"/"+Substring:C12($date_t; 1; 4)
		$ts_el:=outilsTimeStamp(Date:C102($date_t); Time:C179($heure_t))
	End if 
	
	
	
Function getDatePremierContact($referenceID_el : Integer; $ficheNuit_b : Boolean; $dateFiche_d : Date)->$date_d : Date
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	$date_d:=$dateFiche_d
	
	If ($referenceID_el>0)
		$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Nuit = :2"; $referenceID_el; $ficheNuit_b).orderBy("HG_Date asc")
		
		If ($hebergement_es.length>0)
			$date_d:=$hebergement_es[0].HG_Date
		End if 
	End if 
	
	
	
Function reportManuel($id_el : Integer; $dateFin_d : Date)
	var $dateType_t : Text
	var $nbJour_el; $nuitEnCours_el; $idCentre_el; $i_el; $idFicheReport_el : Integer
	var $date_d : Date
	var $societe_es : cs:C1710.SOcieteSelection
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	If ($id_el>0)
		QUERY:C277([HeberGement:5]; [HeberGement:5]ID:168=$id_el)
		
		If (Records in selection:C76([HeberGement:5])=1)
			[HeberGement:5]HG_Reporté:94:="R"
			SAVE RECORD:C53([HeberGement:5])
			
			// Utile pour la méthode MultiSoc_Filter
			ref_soc_active:=[HeberGement:5]Ref_Structure:169
			
			$date_d:=[HeberGement:5]HG_Date:4
			$societe_es:=ds:C1482.SOciete.query("Ref_Structure = :1"; [HeberGement:5]Ref_Structure:169)
			
			$nbJour_el:=outilsGetNbJour($dateFin_d; [HeberGement:5]HG_Date:4)
			$nuitEnCours_el:=[HeberGement:5]HG_NuitenCours:92+1
			
			QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[HeberGement:5]HG_LC_ID:61)
			$idCentre_el:=[LesCentres:9]ID:60
			
			For ($i_el; 1; $nbJour_el)
				$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date = :2 AND HG_Nuit = :3"; [HeberGement:5]HG_HB_ID:19; Add to date:C393($date_d; 0; 0; $i_el); False:C215)  // Modifié par : Scanu Rémy (20/10/2022), recherche s'il y a des fiches jours ce jour là
				
				If ($hebergement_es.length=0)  // Si pas de fiche au jour sur lequel on est en train de boucler pour une fiche Hébergement OU report manuel pour une fiche Prestation pour la personne
					DUPLICATE RECORD:C225([HeberGement:5])
					[HeberGement:5]HG_Date:4:=Add to date:C393($date_d; 0; 0; $i_el)
					
					// Modifié par : Scanu Rémy (24/08/2022)
					// Ajout champs uniques et champs pour le compteur des nuits et champ pour voir que la fiche est reporté
					[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
					[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4); ref_soc_active)
					
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
					
					$idFicheReport_el:=[HeberGement:5]ID:168
				End if 
				
				$dateType_t:=Uut_NumeroteLitsType(Add to date:C393($date_d; 0; 0; $i_el); "J")
				QUERY:C277([LesCentres:9]; [LesCentres:9]Ref_Structure:61=[HeberGement:5]Ref_Structure:169)
				
				While (Not:C34(End selection:C36([LesCentres:9])))
					QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=$dateType_t; *)
					QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1; *)
					QUERY:C277([CentresLits:16];  & ; [CentresLits:16]Ref_Structure:31=[HeberGement:5]Ref_Structure:169)
					
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
			
		End if 
		
	End if 
	
	
	
Function reportMotifSortie($id_el : Integer; $autreSol_t : Text; $dateSortie_d : Date)->$modif_b : Boolean
	var $stop_b : Boolean
	var $datePrecedente_d : Date
	var $statut_o : Object
	var $hebergement_e; $hebergementB_e : cs:C1710.HeberGementEntity
	var $hebergement_es : cs:C1710.HeberGementSelection
	
	If ($id_el>0)
		$hebergement_e:=ds:C1482.HeberGement.get($id_el)
		
		If ($hebergement_e#Null:C1517)
			$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date = :2"; $hebergement_e.HG_HB_ID; Add to date:C393($hebergement_e.HG_Date; 0; 0; -1))
			
			If ($hebergement_es.length=1)
				$hebergementB_e:=$hebergement_es.first()
				
				$hebergementB_e.HG_AutreSolutio:=$autreSol_t
				$statut_o:=$hebergementB_e.save()
				
				$modif_b:=$statut_o.success
			End if 
			
			// Modifié par : Scanu Rémy (16/05/2023)
			// On recherche la dernière fiche cloturée qui précède la fiche chez qui on fait la sortie
			$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date < :2 AND HG_Cloturée = :3"; $hebergement_e.HG_HB_ID; $hebergement_e.HG_Date; True:C214).orderBy("HG_Date desc")
			
			If ($hebergement_es.length>0)
				$hebergementB_e:=$hebergement_es.first()
				
				$hebergementB_e.HG_DateSortie:=$dateSortie_d
				$statut_o:=$hebergementB_e.save()
				
				// Puis on cherche toutes les fiches cloturés qui précède cette même fiche avec le même service
				$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Date < :2 AND HG_Cloturée = :3 AND HG_FamGroupe = :4"; $hebergement_e.HG_HB_ID; $hebergementB_e.HG_Date; True:C214; $hebergementB_e.HG_FamGroupe).orderBy("HG_Date desc")
				$datePrecedente_d:=$hebergementB_e.HG_Date
				
				For each ($hebergementB_e; $hebergement_es) Until ($stop_b=True:C214)
					$stop_b:=($hebergementB_e.HG_Date#Add to date:C393($datePrecedente_d; 0; 0; -1))
					
					If ($stop_b=False:C215)
						$hebergementB_e.HG_DateSortie:=$dateSortie_d
						$statut_o:=$hebergementB_e.save()
						
						$datePrecedente_d:=$hebergementB_e.HG_Date
					End if 
					
				End for each 
				
			End if 
			
		End if 
		
	End if 
	
Function listeUsager($statParam_o : Object) : Object
/*
var $statParam_o : Object
var $return_o : Object
$statParam_o:={}
	
$statParam_o.affichageNom:="état civil"  // Nom personnalisé statistique
$statParam_o.filtreRecherche:={}
$statParam_o.filtreRecherche.HG_DateMin:=!01/06/2024!
$statParam_o.filtreRecherche.HG_DateMax:=!26/11/2024!
$statParam_o.filtreRecherche.HG_Cloturée:=Vrai
$statParam_o.filtreRecherche.HG_Nuit:=Vrai
$statParam_o.filtreRecherche.HG_CentreNom:=["13LGV-HUDA-Accompagnement extérieur"; "13LGV-HUDA-Concertation Partenaire"]
$statParam_o.filtreRecherche.HG_EtatCivil:=["Femme seule (FS)"; "Femme avec 1 enfant (FE)"]  // Item de l'énumération en propriété
$return_o:=ds.HeberGement.statistiqueGenerer($statParam_o)
	
*/
	
	$statParam_o.dataRetour:=["HG_HB_ID"; "HG_Prénom"; "HG_Nom"; "HG_DateNéLe"; "HG_Age"; "HG_FamChef"]
	
	var $querySettings_o : Object
	var $query : Text
	var $HeberGement_es : cs:C1710.HeberGementSelection
	var $HeberGement_e : cs:C1710.HeberGementEntity
	var $Heberge_e : cs:C1710.HeBergeEntity
	var $Adresses_es : cs:C1710.AdressesSelection
	var $Adresses_e : cs:C1710.AdressesEntity
	
	var $HeberGementEnumeration_es : cs:C1710.HeberGementSelection
	var $statExport_c : Collection
	var $quantite_i : Integer
	
	var $Ref_Structure_t : Text
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End if 
	
	$field_c:=OB Entries:C1720(ds:C1482.HeberGement)
	$field_c:=$field_c.extract("key"; "champsNom")
	
	// On vérifie que les champs en filtre existe bien dans la table.
	For each ($filtreNom_t; $statParam_o.filtreRecherche)
		If (($filtreNom_t="@Min") | ($filtreNom_t="@Max"))
			$filtreNom_t:=Substring:C12($filtreNom_t; 1; Length:C16($filtreNom_t)-3)
		End if 
		
		
		If ($field_c.query("champsNom = :1"; $filtreNom_t).length=0)
			return {cstatus: False:C215; MESSAGE: "Le champs filtre "+$filtreNom_t+" n'existe pas dans la table HeberGement."; colonne: New collection:C1472()}
		End if 
	End for each 
	
	// On vérifie que les champs en retour existent bien dans la table.
	For each ($filtreNom_t; $statParam_o.dataRetour)
		If ($field_c.query("champsNom = :1"; $filtreNom_t).length=0)
			
			// Si ce n'est pas dans la table Hebergement, on regarde la table Heberge
			return {cstatus: False:C215; MESSAGE: "Le champs retour "+$filtreNom_t+" n'existe pas dans la table HeberGement."; colonne: New collection:C1472()}
			
		End if 
	End for each 
	
	$querySettings_o:=New object:C1471("parameters"; New object:C1471(); "context"; "liste")
	//$query:="Ref_Structure = :RefStructure AND HG_Plateforme = :HG_Plateforme AND "
	$query:="Ref_Structure = :RefStructure AND HG_Plateforme = '@' AND "
	$querySettings_o.parameters["RefStructure"]:=$Ref_Structure_t
	$querySettings_o.parameters["HG_Plateforme"]:=Session:C1714.storage.intervenant.Plateforme
	
	For each ($filtreNom_t; $statParam_o.filtreRecherche)
		$champsNom_t:=$filtreNom_t
		
		$querySettings_o.parameters[$filtreNom_t]:=$statParam_o.filtreRecherche[$filtreNom_t]
		
		Case of 
			: ($filtreNom_t="@Min")
				$champsNom_t:=Substring:C12($filtreNom_t; 1; Length:C16($filtreNom_t)-3)
				$query+=$champsNom_t+" >= :"+$filtreNom_t+" AND "
				
			: ($filtreNom_t="@Max")
				$champsNom_t:=Substring:C12($filtreNom_t; 1; Length:C16($filtreNom_t)-3)
				$query+=$champsNom_t+" <= :"+$filtreNom_t+" AND "
				
			: (Value type:C1509($statParam_o.filtreRecherche[$filtreNom_t])=Est une collection:K8:32)
				$query+=$champsNom_t+" IN :"+$filtreNom_t+" AND "
			Else 
				$query+=$champsNom_t+" = :"+$filtreNom_t+" AND "
		End case 
		
	End for each 
	
	$query:=Substring:C12($query; 1; Length:C16($query)-5)
	
	//Mark: Génération des colonnes.
	
	$HeberGement_es:=ds:C1482.HeberGement.query($query; $querySettings_o)
	
	// On force l'ajout des champs HG_FamChef et HG_HB_ID dans les data de retour (utile pour des calculs)
	If ($statParam_o.dataRetour.indexOf("HG_FamChef")=-1)
		$statParam_o.dataRetour.unshift("HG_FamChef")
	End if 
	
	If ($statParam_o.dataRetour.indexOf("HG_HB_ID")=-1)
		$statParam_o.dataRetour.unshift("HG_HB_ID")
	End if 
	
	If ($statParam_o.dataRetour.indexOf("ID")=-1)
		$statParam_o.dataRetour.unshift("ID")
	End if 
	
	
	// En cas de personne, On conserve uniquement la plus recente.
	$HeberGement_es:=$HeberGement_es.orderBy("HG_HB_ID, HG_Date desc")
	
	$HeberGementPrecedentID:=0
	For each ($HeberGement_e; $HeberGement_es)
		If ($HeberGement_e.HG_HB_ID=$HeberGementPrecedentID)
			$HeberGement_es:=$HeberGement_es.minus($HeberGement_e)
			continue
		End if 
		$HeberGementPrecedentID:=$HeberGement_e.HG_HB_ID
	End for each 
	
	
	$colonne_c:=$HeberGement_es.toCollection($statParam_o.dataRetour)
	
	
	For each ($colonne_o; $colonne_c)
		$Heberge_e:=ds:C1482.HeBerge.query("HB_ReferenceID = :1"; $colonne_o.HG_HB_ID).first()
		
		$colonne_o.genre:=($HeberGement_e.HG_Genre) ? "Féminin" : "Masculin"
		$colonne_o.email:=$Heberge_e.HB_Email
		$colonne_o.modeFacturation:=$Heberge_e.HB_FAC_Mode_Facturation
		
		$Adresses_es:=ds:C1482.Adresses.query("AD_ID_Origine = :1"; $Heberge_e.ID)
		If ($Adresses_es.length#0)
			$Adresses_e:=$Adresses_es.first()
			$colonne_o.adresse1:=$Adresses_e.AD_Adresse1
			$colonne_o.adresse2:=$Adresses_e.AD_Adresse2
			$colonne_o.adresse3:=$Adresses_e.AD_Adresse3
			$colonne_o.codePostal:=$Adresses_e.AD_Code_postal
			$colonne_o.ville:=$Adresses_e.AD_Ville
		Else 
			$colonne_o.adresse1:=""
			$colonne_o.adresse2:=""
			$colonne_o.adresse3:=""
			$colonne_o.codePostal:=""
			$colonne_o.ville:=""
			
		End if 
		
		
		var $Adresses_e : cs:C1710.AdressesEntity
	End for each 
	
	
	return {status: True:C214; message: "ok"; typeGraph: $statParam_o.typeGraph; colonne: $colonne_c}
	
	
	
Function statistiqueGenerer($statParam_o : Object) : Object
/*
var $statParam_o : Object
var $return_o : Object
$statParam_o:={}
	
$statParam_o.affichageNom:="état civil"  // Nom personnalisé statistique
$statParam_o.filtreRecherche:={}
$statParam_o.filtreRecherche.HG_DateMin:=!01/06/2024!
$statParam_o.filtreRecherche.HG_DateMax:=!26/11/2024!
$statParam_o.filtreRecherche.HG_Cloturée:=Vrai
$statParam_o.filtreRecherche.HG_Nuit:=Vrai
$statParam_o.filtreRecherche.HG_CentreNom:=["13LGV-HUDA-Accompagnement extérieur"; "13LGV-HUDA-Concertation Partenaire"]
$statParam_o.filtreRecherche.HG_EtatCivil:=["Femme seule (FS)"; "Femme avec 1 enfant (FE)"]  // Item de l'énumération en propriété
$statParam_o.dataRetour:=["HG_Date"; "HG_Nom"; "HG_Prénom"; "HG_DateNéLe"; "HG_FamClé"; "HG_EtatCivil"; "HG_FamGroupe";"HG_HB_ID_1_HB_ReferenceID.HG_Genre"]  // (nom du champ 4D)
$statParam_o.typeGraph:="Bar" // "Bar" ou "Pie"
$statParam_o.statistiqueComptage:="personne"  // Obligatoire : fiche ou personne
$statParam_o.statistiqueType:="HG_FamGroupe"  // Obligatoire (nom du champ 4D)
$statParam_o.statistiqueFicheUnique:=Vrai
$return_o:=ds.HeberGement.statistiqueGenerer($statParam_o)
	
*/
	
	var $querySettings_o : Object
	var $query : Text
	var $HeberGement_es : cs:C1710.HeberGementSelection
	var $HeberGementEnumeration_es : cs:C1710.HeberGementSelection
	var $statExport_c : Collection
	var $quantite_i : Integer
	
	var $Ref_Structure_t : Text
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$Ref_Structure_t:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$Ref_Structure_t:=Storage:C1525.societeDetail.Ref_Structure
	End if 
	
	$field_c:=OB Entries:C1720(ds:C1482.HeberGement)
	$field_c:=$field_c.extract("key"; "champsNom")
	
	$fieldHeberge_c:=OB Entries:C1720(ds:C1482.HeBerge)
	$fieldHeberge_c:=$fieldHeberge_c.extract("key"; "champsNom")
	
	If ($statParam_o.statistiqueComptage#"fiche") & ($statParam_o.statistiqueComptage#"personne")
		return {cstatus: False:C215; MESSAGE: "Le comptage des statistiques n'est pas renseigné. (fiche ou personne)"; colonne: New collection:C1472()}
	End if 
	
	// On vérifie que les champs en filtre existe bien dans la table.
	For each ($filtreNom_t; $statParam_o.filtreRecherche)
		If (($filtreNom_t="@Min") | ($filtreNom_t="@Max"))
			$filtreNom_t:=Substring:C12($filtreNom_t; 1; Length:C16($filtreNom_t)-3)
		End if 
		
		
		If ($field_c.query("champsNom = :1"; $filtreNom_t).length=0)
			return {cstatus: False:C215; MESSAGE: "Le champs filtre "+$filtreNom_t+" n'existe pas dans la table HeberGement."; colonne: New collection:C1472()}
		End if 
	End for each 
	
	// On vérifie que les champs en retour existent bien dans la table.
	For each ($filtreNom_t; $statParam_o.dataRetour)
		If ($field_c.query("champsNom = :1"; $filtreNom_t).length=0)
			
			// Si ce n'est pas dans la table Hebergement, on regarde la table Heberge
			If ($fieldHeberge_c.query("champsNom = :1"; Replace string:C233($filtreNom_t; "HG_HB_ID_1_HB_ReferenceID."; "")).length=0)
				return {cstatus: False:C215; MESSAGE: "Le champs retour "+$filtreNom_t+" n'existe pas dans la table HeberGement."; colonne: New collection:C1472()}
			End if 
			
		End if 
	End for each 
	
	$querySettings_o:=New object:C1471("parameters"; New object:C1471(); "context"; "liste")
	$query:="Ref_Structure = :RefStructure AND HG_Plateforme = :HG_Plateforme AND "
	$querySettings_o.parameters["RefStructure"]:=$Ref_Structure_t
	$querySettings_o.parameters["HG_Plateforme"]:=Session:C1714.storage.intervenant.Plateforme
	
	For each ($filtreNom_t; $statParam_o.filtreRecherche)
		$champsNom_t:=$filtreNom_t
		
		$querySettings_o.parameters[$filtreNom_t]:=$statParam_o.filtreRecherche[$filtreNom_t]
		
		Case of 
			: ($filtreNom_t="@Min")
				$champsNom_t:=Substring:C12($filtreNom_t; 1; Length:C16($filtreNom_t)-3)
				$query+=$champsNom_t+" >= :"+$filtreNom_t+" AND "
				
			: ($filtreNom_t="@Max")
				$champsNom_t:=Substring:C12($filtreNom_t; 1; Length:C16($filtreNom_t)-3)
				$query+=$champsNom_t+" <= :"+$filtreNom_t+" AND "
				
			: (Value type:C1509($statParam_o.filtreRecherche[$filtreNom_t])=Est une collection:K8:32)
				$query+=$champsNom_t+" IN :"+$filtreNom_t+" AND "
			Else 
				$query+=$champsNom_t+" = :"+$filtreNom_t+" AND "
		End case 
		
	End for each 
	
	$query:=Substring:C12($query; 1; Length:C16($query)-5)
	
	//Mark: Génération des colonnes.
	
	$HeberGement_es:=ds:C1482.HeberGement.query($query; $querySettings_o)
	
	// On force l'ajout des champs HG_FamChef et HG_HB_ID dans les data de retour (utile pour des calculs)
	If ($statParam_o.dataRetour.indexOf("HG_FamChef")=-1)
		$statParam_o.dataRetour.unshift("HG_FamChef")
	End if 
	
	If ($statParam_o.dataRetour.indexOf("HG_HB_ID")=-1)
		$statParam_o.dataRetour.unshift("HG_HB_ID")
	End if 
	
	If ($statParam_o.dataRetour.indexOf("ID")=-1)
		$statParam_o.dataRetour.unshift("ID")
	End if 
	
	
	
	If (Bool:C1537($statParam_o.statistiqueFicheUnique))
		// En cas de personne, On conserve uniquement la plus recente.
		$HeberGement_es:=$HeberGement_es.orderBy("HG_HB_ID, HG_Date desc")
		
		$HeberGementPrecedentID:=0
		For each ($HeberGement_e; $HeberGement_es)
			If ($HeberGement_e.HG_HB_ID=$HeberGementPrecedentID)
				$HeberGement_es:=$HeberGement_es.minus($HeberGement_e)
				continue
			End if 
			$HeberGementPrecedentID:=$HeberGement_e.HG_HB_ID
		End for each 
	End if 
	
	$colonne_c:=$HeberGement_es.toCollection($statParam_o.dataRetour)
	// Petit patch pour transformer HG_MaraudeX_2 en date
	If (JSON Stringify:C1217($statParam_o.dataRetour)="@HG_Maraude1_2@")
		For each ($colonne_o; $colonne_c)
			$colonne_o.HG_Maraude1_2:=Date:C102($colonne_o.HG_Maraude1_2)
		End for each 
	End if 
	
	If (JSON Stringify:C1217($statParam_o.dataRetour)="@HG_Maraude2_2@")
		For each ($colonne_o; $colonne_c)
			$colonne_o.HG_Maraude2_2:=Date:C102($colonne_o.HG_Maraude2_2)
		End for each 
	End if 
	
	//Mark: Génération des statistiques
	$statExport_c:=New collection:C1472()
	Case of 
		: ($statParam_o.statistiqueType="états civils fusionnés")
			// On recherche tous les états civiles
			$tableFusion_es:=ds:C1482.TableFusions.query("TF_RéférenceTable = :1 AND TF_Diviseur > :2"; "EtaCv"; 0)
			// Filtre par structure
			outilsOrdaSearchByRefStctre(->$tableFusion_es)
			
			$tableFusion_c:=$tableFusion_es.toCollection()  // Collection de tous les états civiles
			$tableFusionUnique_c:=$tableFusion_c.distinct("TF_Libellé")  // Collection de tous les états civiles fusionnés
			
			
			
			For each ($tableFusionUnique_t; $tableFusionUnique_c)
				
				$tableFusion_es:=ds:C1482.TableFusions.query("TF_RéférenceTable = :1 AND TF_Diviseur > :2 AND TF_Libellé = :3"; "EtaCv"; 0; $tableFusionUnique_t)
				outilsOrdaSearchByRefStctre(->$tableFusion_es)
				
				$etatCivil_c:=$tableFusion_es.toCollection("TF_LibelléOrigine").extract("TF_LibelléOrigine")
				$HeberGementEnumeration_es:=$HeberGement_es.query("HG_EtatCivil in :1"; $etatCivil_c)
				
				$quantite_i:=($statParam_o.statistiqueComptage="fiche") ? $HeberGementEnumeration_es.length : $HeberGementEnumeration_es.distinct("HG_HB_ID").length
				
				$statExport_c.push({enumeration: $tableFusionUnique_t; quantite: $quantite_i})
			End for each 
			
		: ($statParam_o.statistiqueType="tranches d’âges")
			var $trancheAge_c : Collection
			var $trancheAge_o : Object
			
			$trancheAge_c:=ds:C1482.TrancheAge.info($Ref_Structure_t)
			
			For each ($trancheAge_o; $trancheAge_c)
				$HeberGementEnumeration_es:=$HeberGement_es.query("HG_Age> :1 AND HG_Age < :2"; $trancheAge_o.ageMin; $trancheAge_o.ageMax)
				
				$quantite_i:=($statParam_o.statistiqueComptage="fiche") ? $HeberGementEnumeration_es.length : $HeberGementEnumeration_es.distinct("HG_HB_ID").length
				$statExport_c.push({enumeration: $trancheAge_o.lib; quantite: $quantite_i})
			End for each 
			
		: ($statParam_o.statistiqueType="mois")
			var $mois_c : Collection
			var $mois_t : Text
			$mois_c:=$HeberGement_es.distinct("HG_Mois")
			
			For each ($mois_t; $mois_c)
				$HeberGementEnumeration_es:=$HeberGement_es.query("HG_Mois> :1"; $mois_t)
				
				$quantite_i:=($statParam_o.statistiqueComptage="fiche") ? $HeberGementEnumeration_es.length : $HeberGementEnumeration_es.distinct("HG_HB_ID").length
				$statExport_c.push({enumeration: $mois_t; quantite: $quantite_i})
			End for each 
			
		Else 
			$infoEnumeration_o:=Session:C1714.storage.enumeration.query("champNom = :1"; $statParam_o.statistiqueType)[0]
			
			If (Bool:C1537($statParam_o.statistiqueFicheUnique)) && ($statParam_o.statistiqueComptage="personne")
				// En cas de personne, On conserve uniquement la plus recente.
				$HeberGement_es:=$HeberGement_es.orderBy("HG_HB_ID, HG_Date desc")
				
				$HeberGementPrecedentID:=0
				For each ($HeberGement_e; $HeberGement_es)
					If ($HeberGement_e.HG_HB_ID=$HeberGementPrecedentID)
						$HeberGement_es:=$HeberGement_es.minus($HeberGement_e)
						continue
					End if 
					$HeberGementPrecedentID:=$HeberGement_e.HG_HB_ID
				End for each 
			End if 
			
			For each ($item_t; $infoEnumeration_o.item)
				$HeberGementEnumeration_es:=$HeberGement_es.query(":1 = :2"; $statParam_o.statistiqueType; $item_t)
				$quantite_i:=($statParam_o.statistiqueComptage="fiche") ? $HeberGementEnumeration_es.length : $HeberGementEnumeration_es.distinct("HG_HB_ID").length
				$statExport_c.push({enumeration: $item_t; quantite: $quantite_i})
			End for each 
			
			
			// On retire les items qui n'ont pas de résultat.
			$statExport_c:=$statExport_c.query("quantite # 0")
			
	End case 
	
	return {status: True:C214; message: "ok"; typeGraph: $statParam_o.typeGraph; colonne: $colonne_c; statistique: $statExport_c}
	
	