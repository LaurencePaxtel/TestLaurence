//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 12/04/23, 17:57:39
// ----------------------------------------------------
// Méthode : F_PassagesGlobal
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Integer
var $3 : Object

var $position_t; $servicePrevious_t : Text
var $i_el; $numSejour_el; $lengthMax_el; $moduloProgress_el; $ts_el; $passage_el : Integer
var $init_b; $update_b : Boolean
var $passage_c : Collection

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es; $hebergementB_es; $hebergementAll_es : cs:C1710.HeberGementSelection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es : cs:C1710.HeBergeSelection

var $statistique_e : cs:C1710.StatistiqueEntity
var $statistique_es : cs:C1710.StatistiqueSelection

Case of 
	: ($1=0)  // Initialisation des variables
		var position_el; nbNuit_el : Integer
		var date_d : Date
		var passageGlobal_c : Collection
	: ($1=1)  // Recherche des données pour les traiter et les afficher dans le formulaire [DiaLogues]DL_PassagesGlobal
		F_PassagesGlobal(0; 0)
		F_PassagesGlobal(2; 0)
		
		$position_t:="center"
		outilsCreateWindowsForm("DL_PassagesGlobal"; ->$position_t; New object:C1471("collectionInit_c"; passageGlobal_c); ->[DiaLogues:3])
	: ($1=2)  // Remplissage des tableaux utilisés dans le formulaire [DiaLogues]DL_PassagesGlobal
		nbNuit_el:=0
		position_el:=1
		
		passageGlobal_c:=New collection:C1472
		$statistique_es:=ds:C1482.Statistique.checkIfExist(<>user_uid_entreprise; Table:C252(->[HeberGement:5]); "statistique séjour")
		
		If ($statistique_es.length>0)
			$statistique_e:=$statistique_es.first()
		Else 
			$statistique_e:=ds:C1482.Statistique.new()
			$statistique_e.init(<>user_uid_entreprise; Table:C252(->[HeberGement:5]); "statistique séjour")
		End if 
		
		// Modifié par : Scanu Rémy (02/05/2023)
		// Passage de la recherche en ORDA
		$hebergementAll_es:=ds:C1482.HeberGement.query("HG_Nuit = :1 AND HG_Cloturée = :2"; False:C215; True:C214)
		outilsOrdaSearchByRefStctre(->$hebergementAll_es)
		
		passageGlobal_c:=$statistique_e.getData(1)
		$ts_el:=$hebergementAll_es.orderBy("HG_TimeStamp desc").first().HG_TimeStamp
		
		Case of 
			: (passageGlobal_c.length=0)  // Première initialisation
				$init_b:=True:C214
				$hebergement_es:=$hebergementAll_es.copy()
			: ($ts_el>$statistique_e.ts)  // S'il y a eu une ou des modification(s) de fiches hébergements depuis la dernière fois où on a généré les statistiques séjour
				$update_b:=True:C214
				
				// On prend uniquement les hébergements mises à jour depuis la dernière fois
				$hebergement_es:=$hebergementAll_es.query("HG_TimeStamp > :1"; $statistique_e.ts)
		End case 
		
		If ($init_b=True:C214) | ($update_b=True:C214)
			$hebergement_es:=$hebergement_es.orderBy("HG_Date asc, HG_HeureAppel asc")
			$heberge_es:=$hebergement_es.HG_HB_ID_1_HB_ReferenceID
			
			If ($update_b=True:C214)  // On purge les élements déjà traités auparavant
				
				For each ($heberge_e; $heberge_es)
					$passage_c:=passageGlobal_c.indices("cle = :1"; $heberge_e.HB_Clé)
					
					If ($passage_c.length>0)
						
						For each ($passage_el; $passage_c)
							passageGlobal_c.remove($passage_el)
						End for each 
						
					End if 
					
				End for each 
				
				position_el:=passageGlobal_c.length
			End if 
			
			$lengthMax_el:=$heberge_es.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($heberge_e; $heberge_es)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lengthMax_el; Choose:C955($init_b=True:C214; "Extraction"; "Mise à jour")+" des données en cours..."; False:C215)
				End if 
				
				$hebergementB_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
				$hebergementB_es:=$hebergementAll_es.and($hebergementB_es)
				
				$hebergementB_es:=$hebergementB_es.orderBy("HG_Date asc, HG_HeureAppel asc")
				date_d:=$hebergementB_es.first().HG_Date
				
				Case of 
					: ($init_b=True:C214)  // A chaque passage à un nouvel hébergé, on insère une nouvelle ligne
						
						If ($heberge_e.indexOf($heberge_es)>0)
							position_el:=position_el+1
						End if 
						
					: ($update_b=True:C214)  // Si c'est une mise à jour des données, on insère une nouvelle ligne
						position_el:=position_el+1
				End case 
				
				F_PassagesGlobal(4; $hebergementB_es.length; $hebergementB_es)
				
				For each ($hebergement_e; $hebergementB_es)
					
					// Modifié par : Scanu Rémy (02/05/2023)
					// Contrôle du service
					If ($hebergement_e.indexOf($hebergementB_es)=0)
						$servicePrevious_t:=$hebergement_e.HG_FamGroupe
					End if 
					
					If (date_d=$hebergement_e.HG_Date) & ($servicePrevious_t=$hebergement_e.HG_FamGroupe)  // Mise à jour d'une ligne du tableau si le séjour suit le séjour précédent et qu'il est dans le même service
						passageGlobal_c[position_el-1].nbNuit:=passageGlobal_c[position_el-1].nbNuit+1
						nbNuit_el:=nbNuit_el+1
					Else   // Ajout d'une nouvelle ligne au tableau
						date_d:=$hebergement_e.HG_Date
						
						position_el:=position_el+1
						F_PassagesGlobal(3; position_el)
						
						$numSejour_el:=$numSejour_el+1
						
						passageGlobal_c[position_el-1].numSejour:=$numSejour_el
						passageGlobal_c[position_el-1].dateDebut:=$hebergement_e.HG_Date
						passageGlobal_c[position_el-1].nbNuit:=1
						
						nbNuit_el:=nbNuit_el+1
					End if 
					
					passageGlobal_c[position_el-1].dateFin:=$hebergement_e.HG_Date
					
					passageGlobal_c[position_el-1].cle:=$heberge_e.HB_Clé
					passageGlobal_c[position_el-1].service:=$hebergement_e.HG_FamGroupe
					passageGlobal_c[position_el-1].motifSortie:=$hebergement_e.HG_AutreSolutio
					passageGlobal_c[position_el-1].dateSortie:=$hebergement_e.HG_DateSortie
					
					// Modifié par : Scanu Rémy (25/04/2023)
					// Ajout état civil
					passageGlobal_c[position_el-1].etatCivil:=$hebergement_e.HG_EtatCivil
					
					// Modifié par : Scanu Rémy (02/05/2023)
					// Contrôle du service
					$servicePrevious_t:=$hebergement_e.HG_FamGroupe
					
					// Modifié par : Scanu Rémy (04/09/2023)
					// Ajout centre hébergement
					passageGlobal_c[position_el-1].centre:=$hebergement_e.HG_CentreNom
					
					// Modifié par : Scanu Rémy (02/10/2023)
					// Ajout chef de famille
					passageGlobal_c[position_el-1].chefFamille:=$hebergement_e.HG_FamChef
					
					date_d:=Add to date:C393(date_d; 0; 0; 1)
				End for each 
				
				$i_el:=$i_el+1
				outilsCleanVariable(->$numSejour_el)
			End for each 
			
			outilsProgressBar(1; "arrêt")
			$statistique_e.saveData(1; passageGlobal_c)
		End if 
		
	: ($1=3)  // Insertion d'une nouvelle ligne
		passageGlobal_c.insert($2-1; New object:C1471(\
			"cle"; ""; \
			"chefFamille"; False:C215; \
			"motifSortie"; ""; \
			"dateSortie"; !00-00-00!; \
			"service"; ""; \
			"numSejour"; 0; \
			"dateDebut"; !00-00-00!; \
			"dateFin"; !00-00-00!; \
			"nbNuit"; 0; \
			"nbNuitReference"; 0; \
			"centre"; ""; \
			"etatCivil"; ""))
	: ($1=4)  // Insertion et initialisation de la nouvelle ligne
		
		If ($2>0)
			date_d:=$3.first().HG_Date
		Else 
			date_d:=!00-00-00!
		End if 
		
		F_PassagesGlobal(3; position_el)
		
		passageGlobal_c[position_el-1].numSejour:=1
		
		passageGlobal_c[position_el-1].dateDebut:=date_d
		passageGlobal_c[position_el-1].dateFin:=date_d
		
		passageGlobal_c[position_el-1].nbNuit:=0
End case 