//%attributes = {}
// ======================================================================
// Methode projet : Web_GL_Get_Reglements_Spec
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 07/09/21 remy@connect-io.fr - Reprise ancien code
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($sensTri_t; $filtre_t)
	C_LONGINT:C283($debut_el; $nbEnregistrement_el; $page_el; $numColonne_el; $indice_el)
	C_OBJECT:C1216($data_o; $table_o; $verif_o; $enregistrement_o; $retour_o)
End if 

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)

$page_el:=Num:C11($data_o.page)
$nbEnregistrement_el:=Num:C11($data_o.size)

$debut_el:=($page_el*$nbEnregistrement_el)

//=============================================//
// Sélection des données
//=============================================//
READ ONLY:C145([Reglements:93])

QUERY:C277([Reglements:93]; [Reglements:93]REG_Bien_ID:24>0)
MultiSoc_Filter(->[Reglements:93])

$table_o:=Create entity selection:C1512([Reglements:93])

//=====================================//
// Filters
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)

If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
	
	For each ($filtre_t; $verif_o["fcol[@]"].propriete)
		$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
		
		Case of 
			: ($filtre_t="fcol[1]")  // Filtre sur la date du
				$table_o:=$table_o.query("REG_Date_Piece >= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[2]")  // Filtre sur la date au
				$table_o:=$table_o.query("REG_Date_Piece <= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[3]")  // Filtre sur le locataire
				$table_o:=$table_o.query("REG_Locataire_Nom = :1"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
			: ($filtre_t="fcol[4]")  // Filtre sur le montant
				$table_o:=$table_o.query("REG_Montant = :1"; Num:C11($verif_o["fcol[@]"].value[$indice_el]))
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
			$table_o:=$table_o.orderBy("REG_No_Piece "+$sensTri_t)
		: ($numColonne_el=1)  // Tri sur colonne 1
			$table_o:=$table_o.orderBy("REG_Date_Piece "+$sensTri_t)
		: ($numColonne_el=2)  // Tri sur colonne 2
			$table_o:=$table_o.orderBy("REG_Bien_Nom "+$sensTri_t)
		: ($numColonne_el=3)  // Tri sur colonne 3
			$table_o:=$table_o.orderBy("REG_Locataire_Nom "+$sensTri_t)
		: ($numColonne_el=4)  // Tri sur colonne 4
			$table_o:=$table_o.orderBy("REG_Montant "+$sensTri_t)
		: ($numColonne_el=5)  // Tri sur colonne 5
			$table_o:=$table_o.orderBy("REG_Mode_Reglement "+$sensTri_t)
		: ($numColonne_el=6)  // Tri sur colonne 6
			$table_o:=$table_o.orderBy("REG_Date_Echeance "+$sensTri_t)
	End case 
	
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471

$retour_o.total_rows:=String:C10($table_o.length)

$retour_o.headers:=New collection:C1472("N° de pièce"; "Date du règlement"; "Bien"; "Locataire"; "Montant"; "Mode du règlement"; "Échéance")
$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")

$retour_o.rows:=New collection:C1472

$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)
SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		$retour_o.headers[0]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.REG_No_Piece+"</div>"; \
		$retour_o.headers[1]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.REG_Date_Piece; Interne date court:K1:7)+"</div>"; \
		$retour_o.headers[2]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.REG_Bien_Nom+"</div>"; \
		$retour_o.headers[3]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.REG_Locataire_Nom+"</div>"; \
		$retour_o.headers[4]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.REG_Montant; "### ##0.00")+"</div>"; \
		$retour_o.headers[5]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$enregistrement_o.REG_Mode_Reglement+"</div>"; \
		$retour_o.headers[6]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.REG_Date_Echeance; Interne date court:K1:7)+"</div>"))
	
	outilsCleanVariable(->$inputHidden_t; ->$statut_t; ->$type_t; ->$soldeAnterieur_r)
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))