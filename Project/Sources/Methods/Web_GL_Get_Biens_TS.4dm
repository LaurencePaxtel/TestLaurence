//%attributes = {}
// ======================================================================
// Methode projet : Web_GL_Get_Biens_TS
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 31/03/21 remy@connect-io.fr - Clean code
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
READ ONLY:C145([LesCentres:9])

QUERY:C277([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63#"")

// Modifié par : Scanu Rémy - remy@connect-io.fr (20/07/2021)
// Il faut enlever les biens où LC_Prestation est Vrai
QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215)

// Sélection suivant l'agence connectée
MultiSoc_Filter(->[LesCentres:9])

$table_o:=Create entity selection:C1512([LesCentres:9])

//=====================================//
// Filters
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)

If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
	
	For each ($filtre_t; $verif_o["fcol[@]"].propriete)
		$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
		
		Case of 
			: ($filtre_t="fcol[0]")  // Filtre sur le nom du bien
				$table_o:=$table_o.query("LC_Nom = :1"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
			: ($filtre_t="fcol[1]")  // Filtre sur le nom du propriétaire
				$table_o:=outilsOrdaSearch($table_o; "LC_GL_Proprietaire_ID"; "Proprietaires"; "ID"; "PRO_Nom"; "@"+$verif_o["fcol[@]"].value[$indice_el]+"@")
			: ($filtre_t="fcol[2]")  // Filtre sur le statut du bien
				
				Case of 
					: ($verif_o["fcol[@]"].value[$indice_el]="@Inactif@")
						$table_o:=$table_o.query("LC_Actif = :1"; False:C215)
					: ($verif_o["fcol[@]"].value[$indice_el]="@Actif@")
						$table_o:=$table_o.query("LC_Actif = :1"; True:C214)
				End case 
				
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
			$table_o:=$table_o.orderBy("LC_Nom "+$sensTri_t)
		: ($numColonne_el=1)  // Tri sur colonne 1
			$table_o:=$table_o.orderBy("LC_GL_Proprietaire_nom "+$sensTri_t)
		: ($numColonne_el=2)  // Tri sur colonne 2
			$table_o:=$table_o.orderBy("OneImmeuble.IMM_Nom "+$sensTri_t)
		: ($numColonne_el=3)  // Tri sur colonne 3
			$table_o:=$table_o.orderBy("LC_GL_Type_Gestion "+$sensTri_t)
		: ($numColonne_el=4)  // Tri sur colonne 4
		: ($numColonne_el=5)  // Tri sur colonne 5
		: ($numColonne_el=6)  // Tri sur colonne 5
			$table_o:=$table_o.orderBy("LC_Actif "+$sensTri_t)
	End case 
	
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471

$retour_o.total_rows:=String:C10($table_o.length)
$retour_o.headers:=New collection:C1472("Nom du bien"; "Propriétaire"; "Nom Immeuble"; "Type de gestion"; "Locations en cours"; "Sinistres en cours"; "Bien actif")
$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")

$retour_o.rows:=New collection:C1472

$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	QUERY:C277([Locations:84]; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*); *)
	QUERY:C277([Locations:84];  & ; [Locations:84]LOC_Bien_ID:5=$enregistrement_o.getKey())
	
	MultiSoc_Filter(->[Locations:84])
	
	QUERY:C277([Sinistres:89]; [Sinistres:89]SIN_Travaux_Cloture:11=False:C215; *)
	QUERY:C277([Sinistres:89];  & ; [Sinistres:89]SIN_Origine_ID:12=$enregistrement_o.getKey(); *)
	QUERY:C277([Sinistres:89];  & ; [Sinistres:89]SIN_Origine_Table_No:14=Table:C252(->[LesCentres:9]))
	
	MultiSoc_Filter(->[Sinistres:89])
	
	QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=$enregistrement_o.LC_GL_Proprietaire_ID)
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		$retour_o.headers[0]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LC_Nom)+"</div>"; \
		$retour_o.headers[1]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+[Proprietaires:83]PRO_Nom:2+" "+[Proprietaires:83]PRO_Prenom:3+"</div>"; \
		$retour_o.headers[2]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.OneImmeuble.IMM_Nom)+"</div>"; \
		$retour_o.headers[3]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.LC_GL_Type_Gestion)+"</div>"; \
		$retour_o.headers[4]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+Choose:C955(Records in selection:C76([Locations:84])>0; \
		"<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red'></i>")+"</div>"; \
		$retour_o.headers[5]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+Choose:C955(Records in selection:C76([Sinistres:89])>0; \
		"<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red'></i>")+"</div>"; \
		$retour_o.headers[6]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+Choose:C955($enregistrement_o.LC_Actif=True:C214; \
		"<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red'></i>")+"</div>"))
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))