//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 08/12/18, 01:29:37
// ----------------------------------------------------
// Méthode : Web_GL_Get_Proprietaires
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($O_Data)
C_TEXT:C284($search_nom; $search_prenom; $search_telephone; $search_email)
C_TEXT:C284($JSON)

READ ONLY:C145([Proprietaires:83])
ALL RECORDS:C47([Proprietaires:83])
MultiSoc_Filter(->[Proprietaires:83])

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_nom:=OB Get:C1224($O_Data; "search_nom"; Est un texte:K8:3)
$search_prenom:=OB Get:C1224($O_Data; "search_prenom"; Est un texte:K8:3)
$search_telephone:=OB Get:C1224($O_Data; "search_telephone"; Est un texte:K8:3)
$search_email:=OB Get:C1224($O_Data; "search_email"; Est un texte:K8:3)

If ($search_nom#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Nom:2=$search_nom)
End if 

If ($search_prenom#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Prenom:3=$search_prenom)
End if 

If ($search_telephone#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Telephone:4=$search_telephone)
End if 

If ($search_email#"")
	QUERY SELECTION:C341([Proprietaires:83]; [Proprietaires:83]PRO_Email:5=$search_email)
End if 

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

$JSON:=Selection to JSON:C1234([Proprietaires:83]; SelectionJson_template(->[Proprietaires:83]))

WEB SEND TEXT:C677($JSON)


