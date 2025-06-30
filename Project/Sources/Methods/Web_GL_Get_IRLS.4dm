//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16-12-18, 08:45:26
// ----------------------------------------------------
// Method: Web_GL_Get_IRLS
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data)
C_LONGINT:C283($search_annee; $search_trimestre)
C_REAL:C285($search_irl)
C_TEXT:C284($JSON)

READ ONLY:C145([IRL_CONFIG:85])
ALL RECORDS:C47([IRL_CONFIG:85])
MultiSoc_Filter(->[IRL_CONFIG:85])

ORDER BY:C49([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_Annee:4; <; [IRL_CONFIG:85]IRC_Trimestre:3; <)

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_annee:=Num:C11(OB Get:C1224($O_Data; "search_annee"; Est un texte:K8:3))
$search_trimestre:=Num:C11(OB Get:C1224($O_Data; "search_trimestre"; Est un texte:K8:3))
$search_irl:=Num:C11(OB Get:C1224($O_Data; "search_irl"; Est un texte:K8:3))

If ($search_annee#0)
	QUERY SELECTION:C341([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_Annee:4=$search_annee)
End if 

If ($search_trimestre#0)
	QUERY SELECTION:C341([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_Trimestre:3=$search_trimestre)
End if 

If ($search_irl#0)
	QUERY SELECTION:C341([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_IRL:2=$search_irl)
End if 

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

$JSON:=Selection to JSON:C1234([IRL_CONFIG:85]; SelectionJson_template(->[IRL_CONFIG:85]))

WEB SEND TEXT:C677($JSON)

