//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 10-01-19, 18:54:59
// ----------------------------------------------------
// Method: Web_GL_Get_Biens
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($O_Data)
C_LONGINT:C283($i)
C_TEXT:C284($JSON; $search_nom)
C_LONGINT:C283($search_proprietaire; $search_bien_id)

ARRAY LONGINT:C221($tb_id; 0)

READ ONLY:C145([LesCentres:9])

QUERY:C277([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63#"")
MultiSoc_Filter(->[LesCentres:9])

ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63; <)

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_nom:=OB Get:C1224($O_Data; "search_nom"; Est un texte:K8:3)

$search_proprietaire:=Num:C11(OB Get:C1224($O_Data; "search_proprietaire"; Est un texte:K8:3))

$search_bien_id:=Num:C11(OB Get:C1224($O_Data; "search_bien_id"; Est un texte:K8:3))


If ($search_nom#"")
	QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_GL_Nom_Suite:63="@"+$search_nom+"@")
End if 

If ($search_bien_id#0)
	QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]ID:60=$search_bien_id)
End if 

If ($search_proprietaire#0)
	QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_GL_Proprietaire_ID:66=$search_proprietaire)
End if 

SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_id)
ARRAY OBJECT:C1221($tb_result; Size of array:C274($tb_id))

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

READ ONLY:C145([Locations:84])
C_BOOLEAN:C305($location_encours; $sinistre_encours)

For ($i; 1; Size of array:C274($tb_id))
	
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=$tb_id{$i})
	QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)
	
	//Location en cours
	QUERY:C277([Locations:84]; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*); *)
	QUERY:C277([Locations:84];  & ; [Locations:84]LOC_Bien_ID:5=[LesCentres:9]ID:60)
	MultiSoc_Filter(->[Locations:84])
	$location_encours:=False:C215
	If (Records in selection:C76([Locations:84])>0)
		$location_encours:=True:C214
	End if 
	
	//Sinistre en cours
	QUERY:C277([Sinistres:89]; [Sinistres:89]SIN_Travaux_Cloture:11=False:C215; *)
	QUERY:C277([Sinistres:89];  & ; [Sinistres:89]SIN_Origine_ID:12=[LesCentres:9]ID:60; *)
	QUERY:C277([Sinistres:89];  & ; [Sinistres:89]SIN_Origine_Table_No:14=Table:C252(->[LesCentres:9]))
	MultiSoc_Filter(->[Sinistres:89])
	$sinistre_encours:=False:C215
	If (Records in selection:C76([Sinistres:89])>0)
		$sinistre_encours:=True:C214
	End if 
	
	OB SET:C1220($tb_result{$i}; "id"; String:C10([LesCentres:9]ID:60); "lc_gl_nom_suite"; [LesCentres:9]LC_GL_Nom_Suite:63; "lc_gl_proprietaire_nom"; [Proprietaires:83]PRO_Nom:2+" "+[Proprietaires:83]PRO_Prenom:3; "lc_gl_type_gestion"; [LesCentres:9]LC_GL_Type_Gestion:62; "lc_gl_nombre_places"; String:C10([LesCentres:9]LC_GL_Nombre_Places:65); "location_encours"; $location_encours; "sinistre_encours"; $sinistre_encours)
	
End for 

$JSON:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($JSON)

