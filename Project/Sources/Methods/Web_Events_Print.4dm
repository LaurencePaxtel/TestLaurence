//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 08:33:19
// ----------------------------------------------------
// Method: Web_Events_Print
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($filtre_heberge; $filtre_type; $filtre_presence; $filtre_titre)

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "pla"; Est un objet:K8:27)

$filtre_heberge:=OB Get:C1224($O_Data; "filtre_nom_heberge"; Est un texte:K8:3)
$filtre_type:=OB Get:C1224($O_Data; "filtre_type"; Est un texte:K8:3)
$filtre_presence:=OB Get:C1224($O_Data; "eve_presence"; Est un texte:K8:3)
$filtre_titre:=OB Get:C1224($O_Data; "filtre_titre"; Est un texte:K8:3)

$filtre_date_du:=Date:C102(OB Get:C1224($O_Data; "filtre_date_du"; Est un texte:K8:3))
$filtre_date_au:=Date:C102(OB Get:C1224($O_Data; "filtre_date_au"; Est un texte:K8:3))
$filtre_proprietaire:=Num:C11(OB Get:C1224($O_Data; "filtre_proprietaire"; Est un texte:K8:3))
//=============================================//
// Sélection des données
//=============================================//
ALL RECORDS:C47([Events:103])
MultiSoc_Filter(->[Events:103])

ARRAY TEXT:C222($tb_name_hb; 0)
UTL_Cut_Text(->$filtre_heberge; ->$tb_name_hb; " ")

If ($filtre_heberge#"")
	If (Size of array:C274($tb_name_hb)>0)
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Nom:3="@"+$tb_name_hb{1}+"@")
	End if 
	If (Size of array:C274($tb_name_hb)>1)
		QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Prénom:4="@"+$tb_name_hb{2}+"@")
	End if 
	
	If (Records in selection:C76([HeBerge:4])=1)
		QUERY SELECTION:C341([Events:103]; [Events:103]EVE_HB_ID:14=[HeBerge:4]HB_ReferenceID:1)
	Else 
		ARRAY LONGINT:C221($tb_ids_tmp; 0)
		SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $tb_ids_tmp)
		QUERY SELECTION WITH ARRAY:C1050([Events:103]EVE_HB_ID:14; $tb_ids_tmp)
	End if 
End if 

If ($filtre_type#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Type:10=$filtre_type)
End if 

If ($filtre_presence#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Presence:11=$filtre_presence)
End if 

If ($filtre_titre#"")
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Titre:3="@"+$filtre_titre+"@")
End if 

If ($filtre_date_du#!00-00-00!)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Date_Du:5>=$filtre_date_du)
End if 

If ($filtre_date_au#!00-00-00!)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_Date_Au:6<=$filtre_date_au)
End if 

If ($filtre_proprietaire>0)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_User_ID:9=$filtre_proprietaire)
End if 
If ($filtre_proprietaire=0)
	QUERY SELECTION:C341([Events:103]; [Events:103]EVE_User_ID:9=w_userUID)
End if 

ORDER BY:C49([Events:103]; [Events:103]EVE_Date_Du:5; <)

SOC_Get_Config
Print_Init_Variables_Events

ORDER BY:C49([Events:103]; [Events:103]EVE_Date_Du:5; <)

AGL_Fiche_Print(->[Events:103]; "print_liste"; ->[Events:103]; True:C214; True:C214)

