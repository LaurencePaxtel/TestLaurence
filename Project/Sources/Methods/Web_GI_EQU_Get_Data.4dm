//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/07/2020, 08:52:04
// ----------------------------------------------------
// Method: Web_GI_EQU_Get_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data)
C_TEXT:C284($JSON; $type)

READ ONLY:C145([Equipement:107])

$O_Data:=Web_AGL_Get_Post_Json_Data

$type:=OB Get:C1224($O_Data; "type"; Est un texte:K8:3)

If ($type#"")
	QUERY:C277([Equipement:107]; [Equipement:107]EQU_Type:5=$type)
Else 
	ALL RECORDS:C47([Equipement:107])
End if 

MultiSoc_Filter(->[Equipement:107])

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

$JSON:=Selection to JSON:C1234([Equipement:107]; SelectionJson_template(->[Equipement:107]))

WEB SEND TEXT:C677($JSON)

