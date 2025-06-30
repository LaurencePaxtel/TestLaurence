//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-12-18, 03:44:04
// ----------------------------------------------------
// Method: Web_GL_Get_Locations
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($JSON; $type_display; $loc_status)
C_LONGINT:C283($size; $i; $search_usager; $search_bien_location)
C_DATE:C307($search_date)
C_OBJECT:C1216($O_Data)

READ ONLY:C145([Locations:84])
READ ONLY:C145([HeBerge:4])
READ ONLY:C145([LesCentres:9])

ALL RECORDS:C47([Locations:84])
MultiSoc_Filter(->[Locations:84])

ORDER BY:C49([Locations:84]LOC_Date:2; [Locations:84]LOC_HB_ID:3; <; [Locations:84]LOC_Bien_ID:5; <)

$O_Data:=Web_AGL_Get_Post_Json_Data
$type_display:=OB Get:C1224($O_Data; "type_display"; Est un texte:K8:3)

Case of 
	: ($type_display="encours")
		$id:=Num:C11(OB Get:C1224($O_Data; "search_bien_location"; Est un texte:K8:3))
		
		QUERY:C277([Locations:84]; [Locations:84]LOC_Bien_ID:5=$id; *)
		QUERY:C277([Locations:84];  & ; [Locations:84]LOC_Date_Sortie:10>Current date:C33(*))
	: ($type_display="locataire")
		$search_usager:=Num:C11(OB Get:C1224($O_Data; "search_usager"; Est un texte:K8:3))
		
		READ ONLY:C145([HeBerge:4])
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$search_usager)
		
		If ($search_usager#0)
			QUERY SELECTION:C341([Locations:84]; [Locations:84]LOC_HB_ID:3=[HeBerge:4]ID:65)
		End if 
		
	Else 
		$search_usager:=Num:C11(OB Get:C1224($O_Data; "search_usager"; Est un texte:K8:3))
		$search_bien_location:=Num:C11(OB Get:C1224($O_Data; "search_bien_location"; Est un texte:K8:3))
		$search_date:=Date:C102(OB Get:C1224($O_Data; "search_date"; Est un texte:K8:3))
		
		If ($search_usager#0)
			QUERY SELECTION:C341([Locations:84]; [Locations:84]LOC_HB_ID:3=$search_usager)
		End if 
		
		If ($search_bien_location#0)
			QUERY SELECTION:C341([Locations:84]; [Locations:84]LOC_Bien_ID:5=$search_bien_location)
		End if 
		
		If ($search_date#!00-00-00!)
			QUERY SELECTION:C341([Locations:84]; [Locations:84]LOC_Date:2=$search_date)
		End if 
		
End case 

MultiSoc_Filter(->[Locations:84])

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
$size:=Records in selection:C76([Locations:84])

ARRAY OBJECT:C1221($tb_result; $size)
$i:=1

While (Not:C34(End selection:C36([Locations:84])))
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
	
	$loc_status:=""
	
	If ([Locations:84]LOC_Date_Sortie:10>Current date:C33(*))
		$loc_status:="encours"
	End if 
	
	OB SET:C1220($tb_result{$i}; "id"; String:C10([Locations:84]ID:1); "loc_date"; String:C10([Locations:84]LOC_Date:2); "loc_usager_name"; [HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4; "loc_bien_name"; [LesCentres:9]LC_GL_Nom_Suite:63; "loc_montant_initial"; String:C10([Locations:84]LOC_Montant_Initial:6); "loc_montant_revise"; String:C10([Locations:84]LOC_Montant_Revise:7); "loc_date_entree"; String:C10([Locations:84]LOC_Date_Entree:9); "loc_date_sortie"; String:C10([Locations:84]LOC_Date_Sortie:10); "loc_garantie_montant"; String:C10([Locations:84]LOC_Garantie_Montant:11); "loc_garantie_encaisse"; String:C10([Locations:84]LOC_Garantie_Encaisse:4); "loc_status"; $loc_status)
	
	$i:=$i+1
	NEXT RECORD:C51([Locations:84])
End while 

$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)