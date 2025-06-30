//%attributes = {}
// ======================================================================
// Methode projet : Web_GL_Get_Interventions_TS
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 07/06/23 <remy@connect-io.fr> - Création
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($sensTri_t; $filtre_t; $filtreBis_t; $inputCheckbox_t; $intervenant_t)
	C_LONGINT:C283($debut_el; $nbEnregistrement_el; $page_el; $numColonne_el; $indice_el)
	C_OBJECT:C1216($data_o; $table_o; $verif_o; $enregistrement_o; $retour_o; $autreTable_o)
End if 

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)

$page_el:=Num:C11($data_o.page)

$nbEnregistrement_el:=Num:C11($data_o.size)
$debut_el:=($page_el*$nbEnregistrement_el)

//=============================================//
// Sélection des données
//=============================================//
READ ONLY:C145([Intervention:108])

ALL RECORDS:C47([Intervention:108])

// Sélection suivant l'agence connectée
MultiSoc_Filter(->[Intervention:108])

$table_o:=Create entity selection:C1512([Intervention:108])

//=====================================//
// Filters
//=====================================//
$verif_o:=outilsVerifPropExisteDansObjet($data_o; New collection:C1472("fcol[@]"); -1)

If (Bool:C1537($verif_o["fcol[@]"].exist)=True:C214)
	
	For each ($filtre_t; $verif_o["fcol[@]"].propriete)
		$indice_el:=$verif_o["fcol[@]"].propriete.indexOf($filtre_t)
		
		Case of 
			: ($filtre_t="fcol[0]")  // Filtre sur le nom de l'immeuble
				$table_o:=$table_o.query("INT_Immeuble_Nom = :1"; String:C10($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[1]")  // Filtre sur le nom du logement
				$table_o:=$table_o.query("INT_LC_Nom = :1"; String:C10($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[2]")  // Filtre sur le type d'intervention
				$table_o:=$table_o.query("INT_Type = :1"; String:C10($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[3]")  // Filtre sur le nom de l'intervenant
				$filtreBis_t:="@"+$verif_o["fcol[@]"].value[$indice_el]+"@"
				
				outilsOrdaSearchSimple(->[GI_Intervenants:110]; ->[GI_Intervenants:110]GII_NomPrenom:6; $filtreBis_t; ->$autreTable_o)
				outilsOrdaSearchByRefStctre(->$autreTable_o)
				
				$autreTable_o:=$autreTable_o.AllGILKIntervenants.OneIntervention
				$table_o:=$table_o.and($autreTable_o)
			: ($filtre_t="fcol[4]")  // Filtre sur la date de début
				$table_o:=$table_o.query("INT_Date_debut >= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
			: ($filtre_t="fcol[5]")  // Filtre sur la date de fin
				$table_o:=$table_o.query("INT_Date_Fin <= :1"; Date:C102($verif_o["fcol[@]"].value[$indice_el]))
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
		: ($numColonne_el=1)  // Tri sur colonne 1
			$table_o:=$table_o.orderBy("INT_Immeuble_Nom "+$sensTri_t)
		: ($numColonne_el=2)  // Tri sur colonne 2
			$table_o:=$table_o.orderBy("INT_LC_Nom "+$sensTri_t)
		: ($numColonne_el=3)  // Tri sur colonne 3
			$table_o:=$table_o.orderBy("INT_Type "+$sensTri_t)
		: ($numColonne_el=4)  // Tri sur colonne 4
		: ($numColonne_el=5)  // Tri sur colonne 5
			$table_o:=$table_o.orderBy("INT_Date_debut "+$sensTri_t)
		: ($numColonne_el=6)  // Tri sur colonne 6
			$table_o:=$table_o.orderBy("INT_Date_Fin "+$sensTri_t)
		: ($numColonne_el=7)  // Tri sur colonne 7
			$table_o:=$table_o.orderBy("INT_EQU_Total_TTC "+$sensTri_t)
		: ($numColonne_el=8)  // Tri sur colonne 8
			$table_o:=$table_o.orderBy("INT_Prestation_Total_TTC "+$sensTri_t)
		: ($numColonne_el=9)  // Tri sur colonne 9
			$table_o:=$table_o.orderBy("INT_Total_TTC "+$sensTri_t)
		: ($numColonne_el=10)  // Tri sur colonne 10
			$table_o:=$table_o.orderBy("INT_Etape "+$sensTri_t)
	End case 
	
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471

$retour_o.total_rows:=String:C10($table_o.length)
$retour_o.headers:=New collection:C1472(" "; "Nom immeuble"; "Nom logement"; "Type intervention"; "Nom intervenant"; "Date début"; "Date fin"; \
"Coût matériel TTC"; "Coût prestation TTC"; "Coût total TTC"; "Etape")
$retour_o.headers:=$retour_o.headers.map("outilsListeFormatHeaders")

$retour_o.rows:=New collection:C1472

$table_o:=$table_o.slice($debut_el; $debut_el+$nbEnregistrement_el)

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	$inputCheckbox_t:="<input type='checkbox' id='chx_"+$enregistrement_o.getKey(dk key as string:K85:16)+"' name='chx_"+$enregistrement_o.getKey(dk key as string:K85:16)+"' class='iw_select' value='"+$enregistrement_o.getKey(dk key as string:K85:16)+"' style='text-align:left;margin:0px 5px 0px 0px;'>"
	
	If ($enregistrement_o.AllGILKIntervenants.OneGIIntervenants.length>0)
		$intervenant_t:=$enregistrement_o.AllGILKIntervenants.OneGIIntervenants.orderBy("ID asc").first().GII_NomPrenom
	End if 
	
	// On boucle sur le nombre de colonne
	$retour_o.rows.push(New object:C1471(\
		$retour_o.headers[0]; "<div class='iw_text_center' id="+$enregistrement_o.getKey(dk key as string:K85:16)+">"+$inputCheckbox_t+"</div>"; \
		$retour_o.headers[1]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Immeuble_Nom)+"</div>"; \
		$retour_o.headers[2]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_LC_Nom)+"</div>"; \
		$retour_o.headers[3]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Type)+"</div>"; \
		$retour_o.headers[4]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+$intervenant_t+"</div>"; \
		$retour_o.headers[5]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Date_debut; Interne date court:K1:7)+"</div>"; \
		$retour_o.headers[6]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Date_Fin; Interne date court:K1:7)+"</div>"; \
		$retour_o.headers[7]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_EQU_Total_TTC; "### ##0.00")+"</div>"; \
		$retour_o.headers[8]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Prestation_Total_TTC; "### ##0.00")+"</div>"; \
		$retour_o.headers[9]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Total_TTC; "### ##0.00")+"</div>"; \
		$retour_o.headers[10]; "<div id='"+$enregistrement_o.getKey(dk key as string:K85:16)+"'>"+String:C10($enregistrement_o.INT_Etape)+"</div>"))
	
	Case of 
		: ($enregistrement_o.INT_Etape="En attente")
			outilsTableSorterAddColorRow($retour_o; "iw_highlight_red")
		: ($enregistrement_o.INT_Etape="En cours")
			outilsTableSorterAddColorRow($retour_o; "iw_highlight_orange")
		: ($enregistrement_o.INT_Etape="Terminé")
			outilsTableSorterAddColorRow($retour_o; "iw_highlight_normal")
	End case 
	
	CLEAR VARIABLE:C89($intervenant_t)
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))