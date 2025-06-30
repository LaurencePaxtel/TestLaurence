//%attributes = {}
// ======================================================================
// Methode projet : Web_GL_Get_Sinistres_TS
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 11/04/2024 <remy@connect-io.fr> - Reprise ancien code
End if 

If (True:C214)  // Déclarations
	var $sensTri_t; $filtre_t; $inputCheckbox_t : Text
	var $debut_el; $nbEnregistrement_el; $page_el; $numColonne_el; $indice_el : Integer
	var $data_o; $table_o; $verif_o; $enregistrement_o; $retour_o : Object
End if 

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)

$page_el:=Num:C11($data_o.page)
$nbEnregistrement_el:=Num:C11($data_o.size)

$debut_el:=($page_el*$nbEnregistrement_el)

//=============================================//
// Sélection des données
//=============================================//
READ ONLY:C145([Sinistres:89])
READ ONLY:C145([Immeuble:105])
READ ONLY:C145([LesCentres:9])

ALL RECORDS:C47([Sinistres:89])

// Sélection suivant l'agence connectée
MultiSoc_Filter(->[Sinistres:89])

$table_o:=Create entity selection:C1512([Sinistres:89])

//=====================================//
// Filters
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)

/*
Si ($search_filtre_0#"")

CHERCHER([Immeuble]; [Immeuble]IMM_Nom="@"+$search_filtre_0+"@")
MultiSoc_Filter(->[Immeuble])

TABLEAU ENTIER LONG($tb_imm_ids; 0)
SÉLECTION VERS TABLEAU([Immeuble]ID; $tb_imm_ids)

CHERCHER PAR TABLEAU([LesCentres]LC_Immeuble_ID; $tb_imm_ids)
MultiSoc_Filter(->[LesCentres])

TABLEAU ENTIER LONG($tb_lc_ids; 0)
SÉLECTION VERS TABLEAU([LesCentres]ID; $tb_lc_ids)

CHERCHER PAR TABLEAU DANS SÉLECTION([Sinistres]SIN_Origine_ID; $tb_lc_ids)

Fin de si 

Si ($search_filtre_1#"")

CHERCHER([LesCentres]; [LesCentres]LC_GL_Nom_Suite="@"+$search_filtre_1+"@")
MultiSoc_Filter(->[LesCentres])

TABLEAU ENTIER LONG($tb_lc_ids; 0)
SÉLECTION VERS TABLEAU([LesCentres]ID; $tb_lc_ids)

CHERCHER PAR TABLEAU DANS SÉLECTION([Sinistres]SIN_Origine_ID; $tb_lc_ids)
Fin de si 
*/

If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
	
	For each ($filtre_t; $verif_o["fcol[@]"].propriete)
		$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
		
		Case of 
			: ($filtre_t="fcol[1]")  // Filtre sur immeuble
				
			: ($filtre_t="fcol[2]")  // Filtre sur logement
				
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
		: ($numColonne_el=2)  // Tri sur colonne 2
		: ($numColonne_el=3)  // Tri sur colonne 3
		: ($numColonne_el=4)  // Tri sur colonne 4
		: ($numColonne_el=5)  // Tri sur colonne 5
		: ($numColonne_el=6)  // Tri sur colonne 6
		: ($numColonne_el=7)  // Tri sur colonne 7
		: ($numColonne_el=8)  // Tri sur colonne 8
		: ($numColonne_el=9)  // Tri sur colonne 9
	End case 
	
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471
$retour_o.total_rows:=String:C10($table_o.length)

$retour_o.headers:=New collection:C1472(" "; "Date"; "Libellé"; "Immeuble"; "Logement"; "Coût"; "Prise en charge d'assurance"; "N° du sinistre"; \
"Mt de remboursement"; "Travaux clôturées")
$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")

$retour_o.rows:=New collection:C1472

$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)
$table_o.refresh()

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	$inputCheckbox_t:="<input type='checkbox' id='chx_"+$enregistrement_o.getKey(dk key as string:K85:16)+"' name='chx_"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='iw_select' value='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' style='text-align:left;margin:0px 5px 0px 0px;'>"
	
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=$enregistrement_o.SIN_Origine_ID)
	MultiSoc_Filter(->[LesCentres:9])
	
	If (Records in selection:C76([LesCentres:9])=1)
		QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
		MultiSoc_Filter(->[Immeuble:105])
	End if 
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		$retour_o.headers[0]; "<div class='iw_text_center' id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$inputCheckbox_t+"</div>"; \
		$retour_o.headers[1]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Date)+"</div>"; \
		$retour_o.headers[2]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Libelle)+"</div>"; \
		$retour_o.headers[3]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+[Immeuble:105]IMM_Nom:3+"</div>"; \
		$retour_o.headers[4]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+[LesCentres:9]LC_GL_Nom_Suite:63+"</div>"; \
		$retour_o.headers[5]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Cout; "### ##0.00")+"</div>"; \
		$retour_o.headers[6]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Assurance_PE)+"</div>"; \
		$retour_o.headers[7]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Assurance_Contrat_No)+"</div>"; \
		$retour_o.headers[8]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Assurance_Montant; "### ##0.00")+"</div>"; \
		$retour_o.headers[9]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.SIN_Travaux_Cloture)+"</div>"))
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))