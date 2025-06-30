//%attributes = {"preemptive":"capable"}
// ======================================================================
// Methode projet : Web_JSON_Get_Centres
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 04/08/22 remy@connect-io.fr - Clean code
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($nomChefFam_t)
	C_LONGINT:C283($index_el)
	C_BOOLEAN:C305($continue_b; $stop_b)
	C_OBJECT:C1216($data_o; $table_o; $retour_o; $passage_o)
	C_COLLECTION:C1488($hebergement_c; $passageDebut_c; $passageFin_c; $passage_c)
	
	var $heberge_e : cs:C1710.HeBergeEntity
	var $heberge_es : cs:C1710.HeBergeSelection
	
	var $hebergement_e : cs:C1710.HeberGementEntity
	var $hebergement_es; $autreHebergement_es : cs:C1710.HeberGementSelection
	
	var $centre_e : cs:C1710.LesCentresEntity
	var $centre_es; $centreB_es : cs:C1710.LesCentresSelection
	
	var $centreLits_es : cs:C1710.CentresLitsSelection
End if 

$data_o:=Web_AGL_Get_Post_Json_Data(True:C214)
$data_o:=JSON Parse:C1218($data_o.json)

//=============================================//
// Sélection des données
//=============================================//
READ ONLY:C145([LesCentres:9])

// Modifié par : Scanu Rémy - remy@connect-io.fr (20/07/2021)
// Il faut enlever les biens où LC_Prestation est Vrai
QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215)
MultiSoc_Filter(->[LesCentres:9])

$table_o:=Create entity selection:C1512([LesCentres:9])
$table_o:=$table_o.query("LC_Nom # :1"; "")

$hebergement_es:=ds:C1482.HeberGement.query("Ref_Structure = :1"; Session:C1714.storage.intervenant.Ref_Structure)

//=====================================//
// Filters
//=====================================//
If (String:C10($data_o.data.nom)#"")
	$table_o:=$table_o.query("LC_Nom = :1"; "@"+$data_o.data.nom+"@")
	$hebergement_es:=$hebergement_es.query("HG_CentreNom = :1"; "@"+$data_o.data.nom+"@")
End if 

If (String:C10($data_o.data.datedu)#"")
	
	If (String:C10($data_o.data.dateau)#"")
		$hebergement_es:=$hebergement_es.query("HG_Date >= :1"; Date:C102($data_o.data.datedu))
	Else 
		$hebergement_es:=$hebergement_es.query("HG_Date = :1"; Date:C102($data_o.data.datedu))
	End if 
	
End if 

If (String:C10($data_o.data.dateau)#"")
	
	If (String:C10($data_o.data.datedu)#"")
		$hebergement_es:=$hebergement_es.query("HG_Date <= :1"; Date:C102($data_o.data.dateau))
	Else 
		$hebergement_es:=$hebergement_es.query("HG_Date = :1"; Date:C102($data_o.data.dateau))
	End if 
	
End if 

If (String:C10($data_o.data.typegestion)#"Choix du type de gestion")
	$autreHebergement_es:=$hebergement_es.HG_LC_ID_4_LC_RéférenceID.query("LC_GL_Type_Gestion = :1"; String:C10($data_o.data.typegestion))
	$hebergement_es:=$hebergement_es.and($autreHebergement_es)
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471
$retour_o.rows:=New collection:C1472

$check_c:=New collection:C1472
$hebergement_c:=New collection:C1472

$centre_es:=ds:C1482.LesCentres.newSelection()

$hebergement_es:=$hebergement_es.orderBy("HG_Date asc, HG_CentreNom asc, HG_CentreNom asc")
SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($hebergement_e; $hebergement_es)
	
	If ($hebergement_e.HG_FamChef=True:C214)
		$centreLits_es:=$hebergement_e.HG_LC_ID_4_LC_RéférenceID.LC_RéférenceID_8_CL_LC_ID.query("CL_Date = :1"; $hebergement_e.HG_Date)  // Tous les enregistrements [CentresLits] pour le centre de l'hébergement à la date de l'hébergement
		$heberge_es:=ds:C1482.HeBerge.query("HB_CléFam = :1"; $hebergement_e.HG_FamClé)  // On cherche la fiche hébergée chef de famille
		
		If ($heberge_es.length=1)  // On a bien trouvé la fiche de l'hébergé qui est indiqué en tant que chef chef de famille
			$heberge_e:=$heberge_es.first()
			$nomChefFam_t:=$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom
		End if 
		
		$continue_b:=True:C214
		
		If (String:C10($data_o.data.complet)#"Choix du statut")
			
			If ($data_o.data.complet="Oui")  // Si l'utilisateur souhaite avoir les centres complet
				$continue_b:=($centreLits_es.sum("CL_Restant")<=0)
			Else 
				$continue_b:=($centreLits_es.sum("CL_Restant")>0)
			End if 
			
		End if 
		
		If ($continue_b=True:C214)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$hebergement_e.HG_HB_ID)
			//todo:GF - C'est possible que ce n'est pas utilisé dans le web.
			//F_Passages(1; 0; Vrai)
			
			$passage_c:=New collection:C1472
			$passageDebut_c:=New collection:C1472
			$passageFin_c:=New collection:C1472
			
			ARRAY TO COLLECTION:C1563($passageDebut_c; td_PasS_Date1; "passageDebut")
			ARRAY TO COLLECTION:C1563($passageFin_c; td_PasS_Date2; "passageFin")
			
			For each ($passage_o; $passageFin_c)
				$passage_c.push(New object:C1471("passageDebut"; $passageDebut_c[$passageFin_c.indexOf($passage_o)].passageDebut; "passageFin"; $passage_o.passageFin))
			End for each 
			
			$passage_c:=$passage_c.query("passageDebut <= :1"; $hebergement_e.HG_Date).orderBy("passageDebut asc")
			
			For each ($passage_o; $passage_c) Until ($stop_b=True:C214)
				$index_el:=$passage_c.indexOf($passage_o)
				$stop_b:=(Date:C102($passage_o.passageFin)>=$hebergement_e.HG_Date)
			End for each 
			
			$retour_o.rows.push(New object:C1471(\
				FieldName_to_property(->[HeberGement:5]ID:168); String:C10($hebergement_e.ID); \
				FieldName_to_property(->[LesCentres:9]LC_Nom:4); $hebergement_e.HG_CentreNom; \
				FieldName_to_property(->[HeberGement:5]HG_Date:4); String:C10($hebergement_e.HG_Date); \
				FieldName_to_property(->[CentresLits:16]CL_Capacité:4); String:C10($centreLits_es.sum("CL_Capacité")); \
				FieldName_to_property(->[CentresLits:16]CL_Distribué:6); String:C10($centreLits_es.sum("CL_Distribué")); \
				FieldName_to_property(->[CentresLits:16]CL_Restant:7); String:C10($centreLits_es.sum("CL_Restant")); \
				"nomUsager"; $nomChefFam_t; \
				"dateDebut"; String:C10(Date:C102($passage_c[$index_el].passageDebut)); \
				"dateFin"; String:C10(Date:C102($passage_c[$index_el].passageFin)); \
				"complet"; Choose:C955($centreLits_es.sum("CL_Restant")<=0; "<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red changeStatutComplet'></i>"); \
				"reservationProvisoire"; Choose:C955($hebergement_e.HG_ReservationProvisoire=True:C214; "<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red'></i>")))
			
			$centreB_es:=ds:C1482.LesCentres.query("LC_Nom = :1"; $hebergement_e.HG_CentreNom)
			outilsOrdaSearchByRefStctre(->$centreB_es)
			
			If ($centreB_es.length=1)
				$centre_e:=$centreB_es.first()
				
				If ($centre_e.indexOf($centre_es)=-1)
					$centre_es.add($centreB_es.first())
				End if 
				
			End if 
			
		End if 
		
	End if 
	
	outilsCleanVariable(->$nomChefFam_t; ->$passageDebut_c; ->$passageFin_c; ->$stop_b)
End for each 

$table_o:=$table_o.minus($centre_es)
$retour_o.rowsEmpty:=$table_o.length

For each ($enregistrement_o; $table_o)
	$centreLits_es:=$enregistrement_o.LC_RéférenceID_8_CL_LC_ID  // Tous les enregistrements [CentresLits] pour le centre de l'hébergement à la date de l'hébergement
	
	If (String:C10($data_o.data.datedu)#"")
		
		If (String:C10($data_o.data.dateau)#"")
			$centreLits_es:=$centreLits_es.query("CL_Date >= :1"; Date:C102($data_o.data.datedu))
		Else 
			$centreLits_es:=$centreLits_es.query("CL_Date = :1"; Date:C102($data_o.data.datedu))
		End if 
		
	End if 
	
	If (String:C10($data_o.data.dateau)#"")
		
		If (String:C10($data_o.data.datedu)#"")
			$centreLits_es:=$centreLits_es.query("CL_Date <= :1"; Date:C102($data_o.data.dateau))
		Else 
			$centreLits_es:=$centreLits_es.query("CL_Date = :1"; Date:C102($data_o.data.dateau))
		End if 
		
	End if 
	
	$retour_o.rows.push(New object:C1471(\
		FieldName_to_property(->[HeberGement:5]ID:168); ""; \
		FieldName_to_property(->[LesCentres:9]LC_Nom:4); $enregistrement_o.LC_Nom; \
		FieldName_to_property(->[HeberGement:5]HG_Date:4); ""; \
		FieldName_to_property(->[CentresLits:16]CL_Capacité:4); String:C10($centreLits_es.sum("CL_Capacité")); \
		FieldName_to_property(->[CentresLits:16]CL_Distribué:6); String:C10($centreLits_es.sum("CL_Distribué")); \
		FieldName_to_property(->[CentresLits:16]CL_Restant:7); String:C10($centreLits_es.sum("CL_Restant")); \
		"nomUsager"; ""; \
		"dateDebut"; ""; \
		"dateFin"; ""; \
		"complet"; "<i class='fa fa-times fdp-icon-red changeStatutComplet'></i>"; \
		"reservationProvisoire"; "<i class='fa fa-times fdp-icon-red'></i>"))
	
End for each 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))