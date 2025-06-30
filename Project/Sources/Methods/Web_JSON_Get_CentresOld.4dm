//%attributes = {}
// ======================================================================
// Methode projet : Web_JSON_Get_Centres
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 04/08/22 remy@connect-io.fr - Clean code
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($nomChefFam_t)
	C_LONGINT:C283($nbJour_el)
	C_BOOLEAN:C305($continue_b)
	C_DATE:C307($dateDebut_d; $date_d)
	C_OBJECT:C1216($data_o; $table_o; $autreTable_o; $enregistrement_o; $retour_o)
	C_COLLECTION:C1488($dateUnique_c)
	
	var $heberge_e; $autreHeberge_e : cs:C1710.HeBergeEntity
	var $autreHeberge_es : cs:C1710.HeBergeSelection
	
	var $hebergement_es; $autreHebergement_es; $autreHebergementB_es : cs:C1710.HeberGementSelection
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
$hebergement_es:=ds:C1482.HeberGement.query("Ref_Structure = :1"; Session:C1714.storage.intervenant.Ref_Structure)

//=====================================//
// Filters
//=====================================//

If (String:C10($data_o.data.nom)#"")
	$table_o:=$table_o.query("LC_Nom = :1"; "@"+$data_o.data.nom+"@")
End if 

If (String:C10($data_o.data.datedu)#"")
	$autreTable_o:=$table_o.LC_RéférenceID_8_CL_LC_ID.query("CL_Date >= :1"; Date:C102($data_o.data.datedu)).CL_LC_ID_8_LC_RéférenceID
	$table_o:=$table_o.and($autreTable_o)
	
	If (String:C10($data_o.data.dateau)#"")
		$hebergement_es:=$hebergement_es.query("HG_Date >= :1"; Date:C102($data_o.data.datedu))
	Else 
		$hebergement_es:=$hebergement_es.query("HG_Date = :1"; Date:C102($data_o.data.datedu))
	End if 
	
	$nbJour_el:=1
	$dateDebut_d:=Date:C102($data_o.data.datedu)
End if 

If (String:C10($data_o.data.dateau)#"")
	$autreTable_o:=$table_o.LC_RéférenceID_8_CL_LC_ID.query("CL_Date <= :1"; Date:C102($data_o.data.dateau)).CL_LC_ID_8_LC_RéférenceID
	$table_o:=$table_o.and($autreTable_o)
	
	If ($nbJour_el=0)
		$nbJour_el:=1
		$dateDebut_d:=Date:C102($data_o.data.dateau)
		$hebergement_es:=$hebergement_es.query("HG_Date = :1"; Date:C102($data_o.data.dateau))
	Else 
		$nbJour_el:=outilsGetNbJour(Date:C102($data_o.data.dateau); Date:C102($data_o.data.datedu))
		$hebergement_es:=$hebergement_es.query("HG_Date <= :1"; Date:C102($data_o.data.dateau))
	End if 
	
End if 

If (String:C10($data_o.data.typegestion)#"Choix du type de gestion")
	$table_o:=$table_o.query("LC_GL_Type_Gestion = :1"; String:C10($data_o.data.typegestion))
End if 

//=====================================//
// Envoi des données
//=====================================//
$retour_o:=New object:C1471
$retour_o.rows:=New collection:C1472

$table_o:=$table_o.orderBy("LC_Nom asc")
SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For each ($enregistrement_o; $table_o)
	$autreTable_o:=$enregistrement_o.LC_RéférenceID_8_CL_LC_ID
	
	If ($autreTable_o.length>0)  // Il y a des enregistrements [CentresLits]
		// Il faut rechercher dans la période de date, les hébergements dans le centre X
		$autreHebergement_es:=$hebergement_es.query("HG_CentreNom = :1"; $enregistrement_o.LC_Nom).orderBy("HG_Date asc")
		
		For each ($heberge_e; $autreHebergement_es.HG_HB_ID_1_HB_ReferenceID)  // Il y a donc des hébergements pour le centre X dans la période de date recherchée
			$autreHebergementB_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID.and($autreHebergement_es)  // On cherche les fiches hébergements de l'hébergé pendant la période recherchée dans le centre X
			$autreHeberge_es:=ds:C1482.HeBerge.query("HB_CléFam = :1"; $autreHebergementB_es[$autreHebergementB_es.length-1].HG_FamClé)  // On cherche la fiche hébergée chef de famille
			
			If ($autreHeberge_es.length=1)  // On a bien trouvé la fiche de l'hébergé qui est indiqué en tant que chef chef de famille
				$autreHeberge_e:=$autreHeberge_es.first()
				$nomChefFam_t:=$autreHeberge_e.HB_Nom+" "+$autreHeberge_e.HB_Prénom
			End if 
			
			$dateUnique_c:=$autreHebergementB_es.distinct("HG_Date")
			
			For each ($date_d; $dateUnique_c)
				$centreLits_es:=$autreTable_o.query("CL_Date = :1"; $date_d)
				
				If ($centreLits_es.length>0)
					$continue_b:=True:C214
					
					If (String:C10($data_o.data.complet)#"Choix du statut")
						
						If ($data_o.data.complet="Oui")  // Si l'utilisateur souhaite avoir les centres complet
							$continue_b:=($centreLits_es.sum("CL_Restant")<=0)
						Else 
							$continue_b:=($centreLits_es.sum("CL_Restant")>0)
						End if 
						
					End if 
					
					If ($continue_b=True:C214)
						$retour_o.rows.push(New object:C1471(\
							FieldName_to_property(->[LesCentres:9]LC_RéférenceID:1); String:C10($enregistrement_o.LC_RéférenceID); \
							FieldName_to_property(->[LesCentres:9]LC_Nom:4); $enregistrement_o.LC_Nom; \
							FieldName_to_property(->[CentresLits:16]CL_Date:3); String:C10($centreLits_es[0].CL_Date); \
							"datePourTri"; $centreLits_es[0].CL_Date; \
							FieldName_to_property(->[CentresLits:16]CL_Capacité:4); String:C10($centreLits_es.sum("CL_Capacité")); \
							FieldName_to_property(->[CentresLits:16]CL_Distribué:6); String:C10($centreLits_es.sum("CL_Distribué")); \
							FieldName_to_property(->[CentresLits:16]CL_Restant:7); String:C10($centreLits_es.sum("CL_Restant")); \
							"nomUsager"; $nomChefFam_t; \
							"dateDebut"; String:C10(($autreHebergementB_es.orderBy("HG_Date asc").first().HG_Date-($autreHebergementB_es.orderBy("HG_Date asc").first().HG_NuitenCours))); \
							"dateFin"; String:C10(($autreHebergementB_es.orderBy("HG_Date asc").first().HG_Date+($autreHebergementB_es.orderBy("HG_Date asc").first().HG_NuitReste))); \
							"complet"; Choose:C955($autreTable_o.sum("CL_Restant")<=0; "<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red'></i>"); \
							"reservationProvisoire"; Choose:C955(($autreHebergementB_es.orderBy("HG_Date asc").first().HG_ReservationProvisoire)=True:C214; "<i class='fa fa-check-square-o fdp-icon-green'></i>"; "<i class='fa fa-times fdp-icon-red'></i>")))
					End if 
					
				End if 
				
			End for each 
			
			CLEAR VARIABLE:C89($nomChefFam_t)
		End for each 
		
	End if 
	
End for each 

If ($retour_o.rows.length>0)
	$retour_o.rows:=$retour_o.rows.orderBy("datePourTri asc, lc_nom asc, nomUsager asc")
End if 

WEB_UTL_send_json(JSON Stringify:C1217($retour_o))