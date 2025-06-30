var $index_el; $indexB_el; $i_el; $j_el; $lengthMax_el; $moduloProgress_el : Integer
var $passage_o; $passageB_o : Object
var $service_c; $motifSortie_c; $etatCivil_c; $centreHebergement_c; $elementASupprimer_c; $chefFamille_c : Collection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		Form:C1466.serviceDistinct_c:=Form:C1466.collectionInit_c.distinct("service")
		Form:C1466.motifSortieDistinct_c:=Form:C1466.collectionInit_c.distinct("motifSortie")
		Form:C1466.etatCivilDistinct_c:=Form:C1466.collectionInit_c.distinct("etatCivil")
		Form:C1466.centreHebergementDistinct_c:=Form:C1466.collectionInit_c.distinct("centre")
		
		dateDu_d:=outilsManageDate(1)
		dateAu_d:=Current date:C33
		
		// Permet de ne pas déclencher la commande Sur appel extérieur pour les deux inputs de Date
		Form:C1466.appelExterieur:=True:C214
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur appel extérieur:K2:11)
		Form:C1466.passageGlobal_c:=Form:C1466.collectionInit_c.copy()
		
		For each ($passage_o; Form:C1466.passageGlobal_c)
			$passage_o.nbNuitReference:=0
		End for each 
		
		If (dateDu_d#!00-00-00!)
			//Form.passageGlobal_c:=Form.passageGlobal_c.query("dateDebut >= :1"; dateDu_d) - Modif LPC 28/04/2022
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("dateFin >= :1"; dateDu_d)
		End if 
		
		If (dateAu_d#!00-00-00!)
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("dateFin <= :1"; dateAu_d)
		End if 
		
		If (dateReferenceDu_d#!00-00-00!) & (dateReferenceAu_d#!00-00-00!)
			$elementASupprimer_c:=New collection:C1472
			outilsCleanVariable(->$index_el; ->$i_el)
			
			For each ($passage_o; Form:C1466.passageGlobal_c)
				
				Case of 
					: ($passage_o.dateDebut>=dateReferenceDu_d) & ($passage_o.dateFin<=dateReferenceAu_d)  // Le passage est entre l'intervalle de date de référence
						$passage_o.nbNuitReference:=outilsGetNbJour($passage_o.dateFin; $passage_o.dateDebut)+1
					: ($passage_o.dateDebut>=dateReferenceDu_d) & ($passage_o.dateDebut<=dateReferenceAu_d) & ($passage_o.dateFin>dateReferenceAu_d)  // La date de début est dans l'intervalle de date de référence MAIS la date de fin "Non" et est supérieure à la date de fin de l'intervalle de date de référence
						$passage_o.nbNuitReference:=outilsGetNbJour(dateReferenceAu_d; $passage_o.dateDebut)+1
					: ($passage_o.dateDebut<dateReferenceDu_d) & ($passage_o.dateFin>=dateReferenceDu_d) & ($passage_o.dateFin<=dateReferenceAu_d)  // La date de début n'est pas dans l'intervalle de date de référence MAIS la date de fin "Oui"
						$passage_o.nbNuitReference:=outilsGetNbJour($passage_o.dateFin; $passage_o.dateDebut)+1
					: ($passage_o.dateDebut<dateReferenceDu_d) & ($passage_o.dateFin>dateReferenceAu_d)  // La date de début ET la date de fin ne sont pas dans l'intervalle de date de référence MAIS la date de fin est supérieure à la date de fin de l'intervalle de date de référence
						$passage_o.nbNuitReference:=outilsGetNbJour(dateReferenceAu_d; $passage_o.dateDebut)
					Else 
						$elementASupprimer_c.push(Form:C1466.passageGlobal_c.indexOf($passage_o))
				End case 
				
			End for each 
			
			$lengthMax_el:=$elementASupprimer_c.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsCleanVariable(->$index_el; ->$i_el)
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($index_el; $elementASupprimer_c)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lengthMax_el; "Remplissage du tableau avec les données de « Nb nuit référence » en cours..."; False:C215)
				End if 
				
				Form:C1466.passageGlobal_c.remove($index_el)
				
				For each ($indexB_el; $elementASupprimer_c)
					
					If ($elementASupprimer_c[$j_el]#Null:C1517)
						$elementASupprimer_c[$j_el]:=$indexB_el-1
					End if 
					
					$j_el:=$j_el+1
				End for each 
				
				$i_el:=$i_el+1
				CLEAR VARIABLE:C89($j_el)
			End for each 
			
			outilsProgressBar(1; "arrêt")
		End if 
		
		If (String:C10(Form:C1466.service)#"")
			$service_c:=Split string:C1554(Form:C1466.service; ";")
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("service in :1"; $service_c)
		End if 
		
		If (String:C10(Form:C1466.motifSortie)#"")
			$motifSortie_c:=Split string:C1554(Form:C1466.motifSortie; ";")
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("motifSortie in :1"; $motifSortie_c)
		End if 
		
		If (String:C10(Form:C1466.etatCivil)#"")
			$etatCivil_c:=Split string:C1554(Form:C1466.etatCivil; ";")
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("etatCivil in :1"; $etatCivil_c)
		End if 
		
		If (String:C10(Form:C1466.centreHebergement)#"")
			$centreHebergement_c:=Split string:C1554(Form:C1466.centreHebergement; ";")
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("centre in :1"; $centreHebergement_c)
		End if 
		
		If (Num:C11(Form:C1466.nbNuitDe)>0)
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("nbNuit >= :1"; Num:C11(Form:C1466.nbNuitDe))
		End if 
		
		If (Num:C11(Form:C1466.nbNuitA)>0)
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("nbNuit <= :1"; Num:C11(Form:C1466.nbNuitA))
		End if 
		
		If (Bool:C1537(Form:C1466.ficheInconnu)=False:C215)
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("cle # :1"; "Z0@")
		End if 
		
		If (Bool:C1537(Form:C1466.cumul)=True:C214)
			$elementASupprimer_c:=New collection:C1472
			outilsCleanVariable(->$index_el; ->$i_el)
			
			For each ($passage_o; Form:C1466.passageGlobal_c)
				$i_el:=$i_el+1
				
				If ($i_el+1<=Form:C1466.passageGlobal_c.length)
					$passageB_o:=Form:C1466.passageGlobal_c[$i_el]
					
					If ($passageB_o.cle=$passage_o.cle)  // Le passage suivant concerne la même personne que celui sur lequel on est en train de boucler
						Form:C1466.passageGlobal_c[$index_el].dateFin:=$passageB_o.dateFin
						
						Form:C1466.passageGlobal_c[$index_el].nbNuit:=Form:C1466.passageGlobal_c[$index_el].nbNuit+$passageB_o.nbNuit
						Form:C1466.passageGlobal_c[$index_el].nbNuitReference:=Form:C1466.passageGlobal_c[$index_el].nbNuitReference+$passageB_o.nbNuitReference
						
						$elementASupprimer_c.push($i_el)
					Else 
						$index_el:=$i_el
					End if 
					
				End if 
				
			End for each 
			
			$lengthMax_el:=$elementASupprimer_c.length
			$moduloProgress_el:=outilsProgressBarGetModulo($lengthMax_el)
			
			outilsCleanVariable(->$index_el; ->$i_el)
			outilsProgressBar(0; "Initialisation"; True:C214)
			
			For each ($index_el; $elementASupprimer_c)
				
				If ($i_el%$moduloProgress_el=0)
					outilsProgressBar($i_el/$lengthMax_el; "Fusion des lignes à cause du filtre « Cumul » en cours..."; False:C215)
				End if 
				
				Form:C1466.passageGlobal_c.remove($index_el)
				
				For each ($indexB_el; $elementASupprimer_c)
					
					If ($elementASupprimer_c[$j_el]#Null:C1517)
						$elementASupprimer_c[$j_el]:=$indexB_el-1
					End if 
					
					$j_el:=$j_el+1
				End for each 
				
				$i_el:=$i_el+1
				CLEAR VARIABLE:C89($j_el)
			End for each 
			
			outilsProgressBar(1; "arrêt")
		End if 
		
		// Modifié par : Scanu Rémy (02/10/2023)
		If (Bool:C1537(Form:C1466.sejourEnCours)=True:C214)
			Form:C1466.passageGlobal_c:=Form:C1466.passageGlobal_c.query("dateFin >= :1"; Current date:C33)
		End if 
		
		outilsCleanVariable(->$i_el)
		
		$chefFamille_c:=Form:C1466.passageGlobal_c.query("chefFamille = :1"; True:C214)
		Form:C1466.nbChefFamille:=$chefFamille_c.distinct("cle").length
		
		Form:C1466.nbHebergeDistinct:=Form:C1466.passageGlobal_c.distinct("cle").length
		Form:C1466.nbNuitTotale:=Form:C1466.passageGlobal_c.sum("nbNuit")
		Form:C1466.nbNuitReference:=Form:C1466.passageGlobal_c.sum("nbNuitReference")
End case 