//%attributes = {}
// ======================================================================
// Methode projet : Web_GL_Get_Locations_TS
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 29/12/20 remy@connect-io.fr - Création
	// 26/02/21 remy@connect-io.fr - Ajout de 3 colonnes (APL + Charges, Statut et Commentaire) et de la modif en direct de la colonne "Commentaire"
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($sensTri_t; $filtre_t; $filtreBis_t; $inputCheckbox_t; $parametre_t; $valeur_t)
	C_LONGINT:C283($debut_el; $nbEnregistrement_el; $page_el; $numColonne_el; $indice_el; $totalCharges_el; $totalAPL_el; $id_el; $i_el)
	C_OBJECT:C1216($data_o; $table_o; $verif_o; $enregistrement_o; $retour_o; $autreTable_o; $autreTableBis_o)
	C_COLLECTION:C1488($collection_c)
	
	var $locationAPL_e : cs:C1710.LocationsAPLEntity
	var $locationAPL_es : cs:C1710.LocationsAPLSelection
	
	ARRAY TEXT:C222($tableau_at; 0)
End if 

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)

If ($data_o.cell=Null:C1517)  // Affichage des données en mode liste
	$page_el:=Num:C11($data_o.page)
	
	$nbEnregistrement_el:=Num:C11($data_o.size)
	$debut_el:=($page_el*$nbEnregistrement_el)
	
	//=============================================//
	// Sélection des données
	//=============================================//
	READ ONLY:C145([Locations:84])
	READ ONLY:C145([HeBerge:4])
	READ ONLY:C145([LesCentres:9])
	
	ALL RECORDS:C47([Locations:84])
	
	// Sélection suivant l'agence connectée
	MultiSoc_Filter(->[Locations:84])
	
	$table_o:=Create entity selection:C1512([Locations:84])
	
	//=====================================//
	// Filters
	//=====================================//
	$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)
	
	If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
		
		For each ($filtre_t; $verif_o["fcol[@]"].propriete)
			$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
			
			Case of 
				: ($filtre_t="fcol[0]")  // Filtre sur la date du bail
					$table_o:=$table_o.query("LOC_Date = :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
				: ($filtre_t="fcol[1]")  // Filtre sur le bien en location
					$table_o:=$table_o.query("LOC_Bien_Nom = :1"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
				: ($filtre_t="fcol[2]")  // Filtre sur l'usager
					$filtreBis_t:="@"+$verif_o["fcol[@]"].value[$indice_el]+"@"
					
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$filtreBis_t)
					MultiSoc_Filter(->[HeBerge:4])
					
					If (Records in selection:C76([HeBerge:4])=0)
						$filtreBis_t:=Replace string:C233($filtreBis_t; "/19"; "/")
						
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$filtreBis_t)
						MultiSoc_Filter(->[HeBerge:4])
					End if 
					
					$autreTable_o:=Create entity selection:C1512([HeBerge:4])
					$autreTable_o:=outilsOrdaSearch($autreTable_o; "ID"; "Locations"; "LOC_HB_ID")
					
					$table_o:=$table_o.and($autreTable_o)
				: ($filtre_t="fcol[3]")  // Filtre sur les locations
					
					Case of 
						: ($verif_o["fcol[@]"].value[$indice_el]="@Location en cours@")
							$table_o:=$table_o.query("LOC_Date_Sortie >= :1"; Current date:C33)
						: ($verif_o["fcol[@]"].value[$indice_el]="Toutes les locations@")  // Aucun filtre
					End case 
					
				: ($filtre_t="fcol[4]")  // Filtre sur les biens en location
					$filtreBis_t:=$verif_o["fcol[@]"].value[$indice_el]
					UTL_Decoupe_texte(->$filtreBis_t; ->$tableau_at; ",")
					
					For ($i_el; 1; Size of array:C274($tableau_at))
						
						If ($i_el=1)
							$parametre_t:=$parametre_t+"LOC_Bien_Nom = :"+String:C10($i_el)
							$valeur_t:=$valeur_t+Char:C90(Guillemets:K15:41)+"@"+$tableau_at{$i_el}+"@"+Char:C90(Guillemets:K15:41)
						Else 
							$parametre_t:=$parametre_t+" OR LOC_Bien_Nom = :"+String:C10($i_el)
							$valeur_t:=$valeur_t+";"+Char:C90(Guillemets:K15:41)+"@"+$tableau_at{$i_el}+"@"+Char:C90(Guillemets:K15:41)
						End if 
						
					End for 
					
					w_visiteur.requestEntity:=$table_o
					$table_o:=Formula from string:C1601("w_visiteur.requestEntity.query("+Char:C90(Guillemets:K15:41)+$parametre_t+Char:C90(Guillemets:K15:41)+";"+$valeur_t+")").call()
			End case 
			
		End for each 
		
	Else 
		// Modifié par : Scanu Rémy (24/03/2021) et Re-modifié par Scanu Rémy (29/07/2021)
		// Par défaut j'affiche uniquement les locations en cours ET comme le champ date de sortie n'est plus obligatoire il faut qu'on commente cette ligne.
		//$table_o:=$table_o.query("LOC_Date_Sortie >= :1";Date du jour)
	End if 
	
	//=====================================//
	// Sorting
	//=====================================//
	$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("col[@]"))
	
	If (Bool:C1537($verif_o["col[@]"].exist)=True:C214)
		$numColonne_el:=Num:C11($verif_o["col[@]"].propriete)
		$sensTri_t:=Choose:C955($verif_o["col[@]"].value="1"; "asc"; "desc")
		
		Case of 
			: ($numColonne_el=1)  // Tri sur colonne 1
				$table_o:=$table_o.orderBy("LOC_Date "+$sensTri_t)
			: ($numColonne_el=2)  // Tri sur colonne 2
				$table_o:=$table_o.orderBy("LOC_Usager_Prenom_Nom "+$sensTri_t)
			: ($numColonne_el=3)  // Tri sur colonne 3
				$table_o:=$table_o.orderBy("LOC_Bien_Nom "+$sensTri_t)
			: ($numColonne_el=4)  // Tri sur colonne 4
				$table_o:=$table_o.orderBy("LOC_Montant_Initial "+$sensTri_t)
			: ($numColonne_el=5)  // Tri sur colonne 4
				$table_o:=$table_o.orderBy("LOC_Montant_Revise "+$sensTri_t)
			: ($numColonne_el=6)  // Tri sur colonne 6
				$table_o:=$table_o.orderBy("LOC_Date_Entree "+$sensTri_t)
			: ($numColonne_el=7)  // Tri sur colonne 7
				$table_o:=$table_o.orderBy("LOC_Date_Sortie "+$sensTri_t)
			: ($numColonne_el=8)  // Tri sur colonne 8
				$table_o:=$table_o.orderBy("LOC_APL "+$sensTri_t)
			: ($numColonne_el=9)  // Tri sur colonne 9
				$table_o:=$table_o.orderBy("LOC_Charges "+$sensTri_t)
			: ($numColonne_el=10)  // Tri sur colonne 10
				$table_o:=$table_o.orderBy("LOC_Qualification "+$sensTri_t)
			: ($numColonne_el=11)  // Tri sur colonne 11
				$table_o:=$table_o.orderBy("LOC_Commentaire "+$sensTri_t)
		End case 
		
	End if 
	
	//=====================================//
	// Envoi des données
	//=====================================//
	$retour_o:=New object:C1471
	
	$retour_o.total_rows:=String:C10($table_o.length)
	$retour_o.headers:=New collection:C1472(" "; "Date du bail"; "Usager"; "Bien en location"; "Montant du loyer"; "Montant révisé"; "Date d'entrée dans les lieux"; "Date de sortie des lieux"; \
		"APL"; "Charges"; "Statut"; "Commentaire")
	$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")
	
	$retour_o.rows:=New collection:C1472
	
	// Modifié par : Scanu Rémy (25/08/2021)
	// Ajout du filtre pour les biens en location
	$collection_c:=$table_o.toCollection("LOC_Bien_Nom").orderBy("LOC_Bien_Nom asc").extract("LOC_Bien_Nom")
	$collection_c:=$collection_c.distinct()
	
	$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)
	
	SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
	
	For each ($enregistrement_o; $table_o)
		$inputCheckbox_t:="<input type='checkbox' id='chx_"+$enregistrement_o.getKey(dk key as string:K85:16)+"' name='chx_"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='iw_select' value='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' style='text-align:left;margin:0px 5px 0px 0px;'>"
		
		// On cherche les charges qui sont défini dans les paramètres de la location pour le mois en cours
		$autreTable_o:=ds:C1482.Charges.query("CHA_Origine_ID is :1 AND CHA_Annee <= :2 AND CHA_Annee_Fin >= :2 AND CHA_Mois <= :3 AND CHA_Mois_Fin >= :3"; $enregistrement_o.getKey(); Year of:C25(Current date:C33); Month of:C24(Current date:C33))
		
		If ($autreTable_o.length>0)
			$autreTableBis_o:=$autreTable_o.query("CHA_Libelle # :1"; "APL")
			$totalCharges_el:=$totalCharges_el+$autreTableBis_o.sum("CHA_Montant")
		End if 
		
		// Modifié par : Scanu Rémy (12/02/2024)
		// On utilise la table LocationsAPL à la place de la table Charges
		$locationAPL_es:=$enregistrement_o.locationsapls.query("year = :1 AND month = :2"; Year of:C25(Current date:C33); Month of:C24(Current date:C33))
		
		If ($locationAPL_es.length=1)
			$locationAPL_e:=$locationAPL_es[0]
			$totalAPL_el:=$locationAPL_e.receive
		End if 
		
		// On boucle sur le nombre de colonne
		$retour_o.rows.push(New object:C1471(\
			$retour_o.headers[0]; "<div class='iw_text_center' id="+$enregistrement_o.getKey(dk key as string:K85:16)+">"+$inputCheckbox_t+"</div>"; \
			$retour_o.headers[1]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Date; Interne date court:K1:7)+"</div>"; \
			$retour_o.headers[2]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Usager_Prenom_Nom)+"</div>"; \
			$retour_o.headers[3]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Bien_Nom)+"</div>"; \
			$retour_o.headers[4]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Montant_Initial; "### ##0.00")+"</div>"; \
			$retour_o.headers[5]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.lOC_Montant_Revise; "### ##0.00")+"</div>"; \
			$retour_o.headers[6]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Date_Entree; Interne date court:K1:7)+"</div>"; \
			$retour_o.headers[7]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Date_Sortie; Interne date court:K1:7)+"</div>"; \
			$retour_o.headers[8]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($totalAPL_el)+"</div>"; \
			$retour_o.headers[9]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($totalCharges_el)+"</div>"; \
			$retour_o.headers[10]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Qualification)+"</div>"; \
			$retour_o.headers[11]; "<div id='commentaire_"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LOC_Commentaire)+"</div>"))
		
		
		If ($enregistrement_o.LOC_Date_Sortie<Current date:C33)
			outilsTableSorterAddColorRow($retour_o; "fdp-color-red")
		End if 
		
		CLEAR VARIABLE:C89($totalAPL_el)
		CLEAR VARIABLE:C89($totalCharges_el)
	End for each 
	
	// Modifié par : Scanu Rémy (25/08/2021)
	$retour_o.bienNom:=$collection_c
	
Else   // Mise à jour du commentaire d'une ligne
	$id_el:=Num:C11($data_o.id)
	
	$table_o:=ds:C1482.Locations.get($id_el)
	
	If ($table_o#Null:C1517)
		$table_o.LOC_Commentaire:=$data_o.content
		
		$retour_o:=$table_o.save()
	End if 
	
End if 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))