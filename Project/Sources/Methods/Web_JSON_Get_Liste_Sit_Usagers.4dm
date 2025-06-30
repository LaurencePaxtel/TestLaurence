//%attributes = {}
// ======================================================================
// Methode projet : Web_JSON_Get_Liste_Sit_Usagers
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 23/12/20 remy@connect-io.fr - Création
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($sensTri_t; $filtre_t)
	C_LONGINT:C283($debut_el; $nbEnregistrement_el; $page_el; $numColonne_el; $indice_el)
	C_OBJECT:C1216($data_o; $table_o; $verif_o; $enregistrement_o; $retour_o; $autreTable_o; $heberge_o; $facture_o; $autreEnregistrement_o)
	C_COLLECTION:C1488($pk_c)
End if 

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)

$page_el:=Num:C11($data_o.page)
$nbEnregistrement_el:=Num:C11($data_o.size)

$debut_el:=($page_el*$nbEnregistrement_el)

//=============================================//
// Sélection des données
//=============================================//
READ ONLY:C145([Factures:86])
ALL RECORDS:C47([Factures:86])

// Sélection suivant l'agence connectée
MultiSoc_Filter(->[Factures:86])

$table_o:=Create entity selection:C1512([Factures:86])

//=====================================//
// Filters
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)

If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
	
	For each ($filtre_t; $verif_o["fcol[@]"].propriete)
		$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
		
		Case of 
			: ($filtre_t="fcol[0]")  // Filtre sur la date de début facture
				$table_o:=$table_o.query("FAC_Date_Piece >= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[1]")  // Filtre sur la date de fin facture
				$table_o:=$table_o.query("FAC_Date_Piece <= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[2]")  // Filtre sur le nom de la personne
				// Modifié par : Scanu Rémy - remy@connect-io.fr (26/07/2021)
				//$table_o:=$table_o.query("FAC_Destinataire_Nom = :1";"@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
				$table_o:=outilsOrdaSearch($table_o; "FAC_Locataire_ID"; "HeBerge"; "ID"; "HB_Nom"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
			: ($filtre_t="fcol[3]")  // Filtre sur la location/hébergement/participation
				
				Case of 
					: ($verif_o["fcol[@]"].value[$indice_el]="Location")
						$table_o:=$table_o.query("FAC_Type_Piece = :1 OR FAC_Type_Piece = :2 OR FAC_Type_Piece = :3"; "mixte"; "charge"; "location")
					: ($verif_o["fcol[@]"].value[$indice_el]="Hébergement")
						$table_o:=$table_o.query("FAC_Type_Piece = :1"; "HG")
					: ($verif_o["fcol[@]"].value[$indice_el]="Participation")
						$table_o:=$table_o.query("FAC_Type_Piece = :1"; "P")
				End case 
				
			: ($filtre_t="fcol[4]")  // Filtre sur le n° de facture
				$table_o:=$table_o.query("FAC_No_Piece = :1"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
			: ($filtre_t="fcol[5]")  // Filtre sur le Net à payer
				$verif_o["fcol[@]"].value[$indice_el]:=Replace string:C233($verif_o["fcol[@]"].value[$indice_el]; "."; ",")
				
				$table_o:=$table_o.query("FAC_Net_A_Payer_cal = :1"; Num:C11($verif_o["fcol[@]"].value[$indice_el]))
		End case 
		
	End for each 
	
End if 

$pk_c:=$table_o.toCollection("ID").extract("ID")
//=====================================//
// Sorting
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("col[@]"))

If (Bool:C1537($verif_o["col[@]"].exist)=True:C214)
	$numColonne_el:=Num:C11($verif_o["col[@]"].propriete)
	$sensTri_t:=Choose:C955($verif_o["col[@]"].value="1"; "asc"; "desc")
	
	Case of 
		: ($numColonne_el=0)  // Tri sur colonne 0
			$table_o:=$table_o.orderBy("FAC_Destinataire_Nom "+$sensTri_t)
		: ($numColonne_el=1)  // Tri sur colonne 1
			// On recherche tous les Heberges
			$autreTable_o:=outilsOrdaSearch($table_o; "FAC_Locataire_ID"; "HeBerge"; "ID")
			
			$autreTable_o:=$autreTable_o.orderBy("HB_Prénom "+$sensTri_t)
			
			If ($autreTable_o.length>0)
				$table_o:=ds:C1482.Factures.newSelection(dk keep ordered:K85:11)
			End if 
			
			For each ($enregistrement_o; $autreTable_o)
				$facture_o:=ds:C1482.Factures.query("FAC_Locataire_ID is :1"; $enregistrement_o.ID)
				
				Case of 
					: ($facture_o.length>1)
						
						For each ($autreEnregistrement_o; $facture_o)
							
							If ($pk_c.indexOf($autreEnregistrement_o.getKey())>=0)
								$table_o.add($autreEnregistrement_o)
							End if 
							
						End for each 
						
					: ($facture_o.length=1)
						
						If ($pk_c.indexOf($facture_o.first().getKey())>=0)
							$table_o.add($facture_o.first())
						End if 
						
				End case 
				
			End for each 
			
		: ($numColonne_el=2)  // Tri sur colonne 2
			// On recherche tous les Heberges
			$autreTable_o:=outilsOrdaSearch($table_o; "FAC_Locataire_ID"; "HeBerge"; "ID")
			
			$autreTable_o:=$autreTable_o.orderBy("HB_DateNéLe "+$sensTri_t)
			
			If ($autreTable_o.length>0)
				$table_o:=ds:C1482.Factures.newSelection(dk keep ordered:K85:11)
			End if 
			
			For each ($enregistrement_o; $autreTable_o)
				$facture_o:=ds:C1482.Factures.query("FAC_Locataire_ID is :1"; $enregistrement_o.ID)
				
				Case of 
					: ($facture_o.length>1)
						
						For each ($autreEnregistrement_o; $facture_o)
							
							If ($pk_c.indexOf($autreEnregistrement_o.getKey())>=0)
								$table_o.add($autreEnregistrement_o)
							End if 
							
						End for each 
						
					: ($facture_o.length=1)
						
						If ($pk_c.indexOf($facture_o.first().getKey())>=0)
							$table_o.add($facture_o.first())
						End if 
						
				End case 
				
			End for each 
			
		: ($numColonne_el=3)  // Tri sur colonne 3
			$table_o:=$table_o.orderBy("FAC_Date_Piece "+$sensTri_t)
		: ($numColonne_el=4)  // Tri sur colonne 4
			$table_o:=$table_o.orderBy("FAC_No_Piece "+$sensTri_t)
		: ($numColonne_el=5)  // Tri sur colonne 5
			$table_o:=$table_o.orderBy("FAC_Solde_Regle "+$sensTri_t)
		: ($numColonne_el=6)  // Tri sur colonne 6
			$table_o:=$table_o.orderBy("FAC_Net_A_Payer_cal "+$sensTri_t)
	End case 
	
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471

$retour_o.total_rows:=String:C10($table_o.length)
$retour_o.headers:=New collection:C1472("Nom hébergé"; "Prénom hébergé"; "Date de naissance hébergé"; "Date facture"; "N° facture"; "Règlement reçus"; "Net à payer"; "Solde restant")
$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")

$retour_o.rows:=New collection:C1472

$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	
	Case of 
		: ($enregistrement_o.FAC_Locataire_ID#0)
			$heberge_o:=ds:C1482.HeBerge.query("ID is :1"; $enregistrement_o.FAC_Locataire_ID).first()
		: ($enregistrement_o.FAC_Destinataire_ID#0)
			$autreTable_o:=ds:C1482.HeberGement.query("HG_HB_ID is :1"; $enregistrement_o.FAC_Destinataire_ID)
			
			If (Num:C11($autreTable_o.length)>0)
				$heberge_o:=$autreTable_o.HG_HB_ID_1_HB_ReferenceID.first()
			End if 
			
	End case 
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		$retour_o.headers[0]; String:C10($heberge_o.HB_Nom); \
		$retour_o.headers[1]; String:C10($heberge_o.HB_Prénom); \
		$retour_o.headers[2]; String:C10($heberge_o.HB_DateNéLe; Interne date court:K1:7); \
		$retour_o.headers[3]; String:C10($enregistrement_o.FAC_Date_Piece; Interne date court:K1:7); \
		$retour_o.headers[4]; String:C10($enregistrement_o.FAC_No_Piece); \
		$retour_o.headers[5]; String:C10($enregistrement_o.FAC_Solde_Regle; "### ##0.00"); \
		$retour_o.headers[6]; String:C10($enregistrement_o.FAC_Net_A_Payer_cal; "### ##0.00"); \
		$retour_o.headers[7]; String:C10($enregistrement_o.FAC_Solde_Du_cal; "### ##0.00")))
	
	CLEAR VARIABLE:C89($heberge_o)
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))