//%attributes = {}
// ======================================================================
// Methode projet : Web_GL_Get_Factures_TS
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 26/07/21 remy@connect-io.fr - Reprise ancien code
End if 

If (True:C214)  // Déclarations
	var $sensTri_t; $filtre_t; $inputHidden_t; $statut_t; $type_t; $export_t : Text
	var $debut_el; $nbEnregistrement_el; $page_el; $numColonne_el; $indice_el : Integer
	var $soldeAnterieur_r; $loyer_r : Real
	var $data_o; $table_o; $verif_o; $enregistrement_o; $retour_o; $facture_o : Object
	var $facture_c : Collection
	
	var $factureLigne_es : cs:C1710.Factures_LignesSelection
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

// Modifié par : Scanu Rémy (24/03/2021)
// Ajout du même critère que dans la liste des situations usagers méthode : Web_JSON_Get_Liste_Sit_Usagers
QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Type_Piece:40="mixte"; *)
QUERY SELECTION:C341([Factures:86];  | ; [Factures:86]FAC_Type:21="Avoir"; *)
QUERY SELECTION:C341([Factures:86];  | ; [Factures:86]FAC_Type_Piece:40="charge"; *)
QUERY SELECTION:C341([Factures:86];  | ; [Factures:86]FAC_Type_Piece:40="location"; *)
QUERY SELECTION:C341([Factures:86];  | ; [Factures:86]FAC_Type_Piece:40="autre")

// Modifié par : Scanu Rémy (14/04/2021) et Re-modifié par Scanu Rémy (27/07/2021) et Re-modifié par Scanu Rémy (05/04/2023)
// On affiche pas les factures dont le montant TTC est strictement supérieur à 0€ ET on cherche aussi les avoirs
// Finalement on ne met pas ce filtre
/*
CHERCHER DANS SÉLECTION([Factures]; [Factures]FAC_Montant_TTC>0; *)
CHERCHER DANS SÉLECTION([Factures];  | ; [Factures]FAC_Type="Avoir")
*/

// Sélection suivant l'agence connectée
MultiSoc_Filter(->[Factures:86])

ORDER BY:C49([Factures:86]; [Factures:86]FAC_Date_Piece:3; <)
$table_o:=Create entity selection:C1512([Factures:86])

//=====================================//
// Filters
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)

If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
	
	For each ($filtre_t; $verif_o["fcol[@]"].propriete)
		$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
		
		Case of 
			: ($filtre_t="fcol[1]")  // Filtre sur la date du
				$table_o:=$table_o.query("FAC_Date_Piece >= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[2]")  // Filtre sur la date au
				$table_o:=$table_o.query("FAC_Date_Piece <= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[3]")  // Filtre sur la période
				$table_o:=$table_o.query("FAC_Periode = :1"; $verif_o["fcol[@]"].value[$indice_el])
			: ($filtre_t="fcol[4]")  // Filtre sur le locataire
				$table_o:=$table_o.query("FAC_Locataire_Nom = :1"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
			: ($filtre_t="fcol[5]")  // Filtre sur le type de facture
				
				Case of 
					: ($verif_o["fcol[@]"].value[$indice_el]="Facture")
						$table_o:=$table_o.query("FAC_Type # :1"; "Avoir")
					: ($verif_o["fcol[@]"].value[$indice_el]="Avoir")
						$table_o:=$table_o.query("FAC_Type = :1"; "Avoir")
				End case 
				
			: ($filtre_t="fcol[6]")  // Filtre sur l'export facture
				
				If ($verif_o["fcol[@]"].value[$indice_el]="Oui")
					$table_o:=$table_o.query("FAC_Export = :1"; True:C214)
				Else 
					$table_o:=$table_o.query("FAC_Export = :1"; False:C215)
				End if 
				
			: ($filtre_t="fcol[7]")  // Filtre sur l'export facture
				$table_o:=$table_o.query("FAC_Categorie = :1"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
		End case 
		
	End for each 
	
End if 

//=====================================//
// Sorting
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("col[@]"))

If (Bool:C1537($verif_o["col[@]"].exist)=True:C214)
	$numColonne_el:=Num:C11($verif_o["col[@]"].propriete)
	$sensTri_t:=Choose:C955($verif_o["col[@]"].value="1"; "asc"; "desc")
	
	Case of 
		: ($numColonne_el=0)  // Tri sur colonne 0
		: ($numColonne_el=1)  // Tri sur colonne 1
			$table_o:=$table_o.orderBy("FAC_No_Piece "+$sensTri_t)
		: ($numColonne_el=2)  // Tri sur colonne 2
			$table_o:=$table_o.orderBy("FAC_Date_Piece "+$sensTri_t)
		: ($numColonne_el=3)  // Tri sur colonne 3
			$table_o:=$table_o.orderBy("FAC_Bien_Nom "+$sensTri_t)
		: ($numColonne_el=4)  // Tri sur colonne 4
			$table_o:=$table_o.orderBy("FAC_Locataire_Nom "+$sensTri_t)
		: ($numColonne_el=5)  // Tri sur colonne 5
			$table_o:=$table_o.orderBy("FAC_Montant_TTC "+$sensTri_t)
		: ($numColonne_el=6)  // Tri sur colonne 6
			$table_o:=$table_o.orderBy("FAC_Solde_Anterieur_cal "+$sensTri_t)
		: ($numColonne_el=7)  // Tri sur colonne 7
			$table_o:=$table_o.orderBy("FAC_Net_A_Payer_cal "+$sensTri_t)
		: ($numColonne_el=8)  // Tri sur colonne 8
			$table_o:=$table_o.orderBy("FAC_Solde_Regle "+$sensTri_t)
		: ($numColonne_el=9)  // Tri sur colonne 9
			$table_o:=$table_o.orderBy("FAC_Solde_Du_cal "+$sensTri_t)
		: ($numColonne_el=10)  // Tri sur colonne 10
			$table_o:=$table_o.orderBy("FAC_Date_Echeance "+$sensTri_t)
		: ($numColonne_el=11)  // Tri sur colonne 11
			$facture_c:=$table_o.toCollection()
			
			// Modifié par : Scanu Rémy (04/07/2022)
			For each ($facture_o; $facture_c)
				$facture_o.FAC_Periode:=Date:C102("01/"+Substring:C12($facture_o.FAC_Periode; 0; 2)+"/"+Substring:C12($facture_o.FAC_Periode; 4))
			End for each 
			
			$facture_c:=$facture_c.orderBy("FAC_Periode "+$sensTri_t)
			$table_o:=ds:C1482.Factures.newSelection(dk keep ordered:K85:11)
			
			For each ($facture_o; $facture_c)
				$enregistrement_o:=ds:C1482.Factures.get($facture_o.ID)
				$table_o.add($enregistrement_o)
			End for each 
			
			//$table_o:=$table_o.orderBy("FAC_Periode "+$sensTri_t)
		: ($numColonne_el=12)  // Tri sur colonne 12
			$table_o:=$table_o.orderBy("FAC_Total_Charges "+$sensTri_t)
		: ($numColonne_el=13)  // Tri sur colonne 13
			$table_o:=$table_o.orderBy("FAC_Total_APL "+$sensTri_t)
		: ($numColonne_el=14)  // Tri sur colonne 14
			$table_o:=$table_o.orderBy("FAC_Loyer_Residuel "+$sensTri_t)
		: ($numColonne_el=15)  // Tri sur colonne 15
			$table_o:=$table_o.orderBy("FAC_Caution "+$sensTri_t)
		: ($numColonne_el=16)  // Tri sur colonne 16
			$table_o:=$table_o.orderBy("FAC_LOC_Date_Entree "+$sensTri_t)
		: ($numColonne_el=17)  // Tri sur colonne 17
		: ($numColonne_el=18)  // Tri sur colonne 18
			$table_o:=$table_o.orderBy("FAC_Statut "+$sensTri_t)
		: ($numColonne_el=19)  // Tri sur colonne 19
			$table_o:=$table_o.orderBy("FAC_Export "+$sensTri_t)
	End case 
	
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471

$retour_o.total_rows:=String:C10($table_o.length)

$retour_o.headers:=New collection:C1472(" "; "N° de pièce"; "Date"; "Bien"; "Locataire"; "Montant TTC"; "Solde<br>antérieur"; "Net à<br>payer"; ""; "Solde<br>dû"; \
"Échéance"; "Période"; "Charges"; "APL"; "Loyer<br>résiduel"; "Dépôt de<br>garantie"; "Date d’entrée"; "Type"; "Réglée"; "Exportée")
$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")

$retour_o.rows:=New collection:C1472
$retour_o.factureID:=$table_o.toCollection("ID").extract("ID")

$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)
$table_o.refresh()

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	$inputHidden_t:="<input type='checkbox' id='chx_"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' name='chx_"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' class='iw_select' style='text-align:left;margin:0px 5px 0px 0px;'>"
	
	$inputHidden_t:=$inputHidden_t+"<input type='hidden' id='id_selection_"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' name='id_selection_"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' value='"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"'>"
	$inputHidden_t:=$inputHidden_t+"<input type='hidden' id='id"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' name='id"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' value='"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"'>"
	$inputHidden_t:=$inputHidden_t+"<input type='hidden' id='chk_bien_id"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' name='chk_bien_id"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' value='"+String:C10($enregistrement_o.FAC_Bien_ID)+"'>"
	$inputHidden_t:=$inputHidden_t+"<input type='hidden' id='chk_locataire_id"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' name='chk_locataire_id"+String:C10($enregistrement_o.getKey(dk key as string:K85:16))+"' value='"+String:C10($enregistrement_o.FAC_Locataire_ID)+"'>"
	
	If ($enregistrement_o.FAC_Type#"Avoir") & ($enregistrement_o.FAC_Avoir_ID=0)
		
		If ($enregistrement_o.FAC_Solde_Du_cal<=0)  //  réglé
			$statut_t:="<i class='fa fa-check-square-o fdp-icon-green'></i>"
		Else 
			$statut_t:="<i class='fa fa-times fdp-icon-red'></i>"
		End if 
		
	End if 
	
	Case of 
		: ($enregistrement_o.FAC_Type="Avoir")
			$type_t:="AD"
		: ($enregistrement_o.FAC_Type="Définitive")
			$type_t:="FD"
		Else 
			$type_t:="FP"
	End case 
	
	If ($enregistrement_o.FAC_Export)
		$export_t:="<i class='fa fa-check-square-o fdp-icon-green'></i>"
	Else 
		$export_t:="<i class='fa fa-times fdp-icon-red'></i>"
	End if 
	
	// Modifié par : Scanu Rémy (14/02/2024)
	// On va chercher finalement la ligne loyer dans le détail de la facture au lieu du champ [Factures]FAC_Loyer_Residuel
	$factureLigne_es:=$enregistrement_o.AllFacturesLigne
	$loyer_r:=Round:C94($factureLigne_es.query("FACL_Libelle = :1"; "Loyer").toCollection("FACL_Montant_TTC").sum("FACL_Montant_TTC"); 2)
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		$retour_o.headers[0]; "<div class='iw_text_center' id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$inputHidden_t+"</div>"; \
		$retour_o.headers[1]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.FAC_No_Piece+"</div>"; \
		$retour_o.headers[2]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.FAC_Date_Piece; Interne date court:K1:7)+"</div>"; \
		$retour_o.headers[3]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.FAC_Bien_Nom+"</div>"; \
		$retour_o.headers[4]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.FAC_Locataire_Nom+"</div>"; \
		$retour_o.headers[5]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Montant_TTC; "### ##0.00")+"</div>"; \
		$retour_o.headers[6]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Solde_Anterieur_cal; "### ##0.00")+"</div>"; \
		$retour_o.headers[7]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Net_A_Payer_cal; "### ##0.00")+"</div>"; \
		$retour_o.headers[8]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+""+"</div>"; \
		$retour_o.headers[9]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Solde_Du_cal; "### ##0.00")+"</div>"; \
		$retour_o.headers[10]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.FAC_Date_Echeance; Interne date court:K1:7)+"</div>"; \
		$retour_o.headers[11]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.FAC_Periode+"</div>"; \
		$retour_o.headers[12]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Total_Charges; "### ##0.00")+"</div>"; \
		$retour_o.headers[13]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Total_APL; "### ##0.00")+"</div>"; \
		$retour_o.headers[14]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($loyer_r; "### ##0.00")+"</div>"; \
		$retour_o.headers[15]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_Caution; "### ##0.00")+"</div>"; \
		$retour_o.headers[16]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='text-right'>"+String:C10($enregistrement_o.FAC_LOC_Date_Entree)+"</div>"; \
		$retour_o.headers[17]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$type_t+"</div>"; \
		$retour_o.headers[18]; "<div class='iw_text_center' id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$statut_t+"</div>"; \
		$retour_o.headers[19]; "<div class='iw_text_center' id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$export_t+"</div>"))
	//FAC_Solde_Regle
	outilsCleanVariable(->$inputHidden_t; ->$statut_t; ->$type_t; ->$soldeAnterieur_r)
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))