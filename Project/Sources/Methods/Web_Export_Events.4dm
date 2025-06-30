//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/04/20, 15:29:37
// ----------------------------------------------------
// Method: Web_Export_Events
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($send; $AutosaveDirectory; $file_name; $file_name_path)
C_TEXT:C284($filtre_heberge; $filtre_type; $filtre_presence; $filtre_titre)
C_LONGINT:C283($i; $nb_fiches)

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
//=================================//
$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"

$AutosaveDirectory:=Get 4D folder:C485(Dossier 4D actif:K5:10)+"print_job"+Séparateur dossier:K24:12

//$file_name:="Liste_des_événements.csv"
$file_name:="Liste_des_evenements.csv"
$file_name_path:=$AutosaveDirectory+$file_name

USE CHARACTER SET:C205("windows-1252"; 0)

$ref_doc:=Create document:C266($file_name_path)

$send:="Hébergé"+$sep+"Type"+$sep+"Présence"+$sep+"Titre"+$sep+"Date du"+$sep+"Date au"+$sep+"Heure du"+$sep+"Heure au"+$sep+"Rappel"+$sep+"Récurrence"+$sep+"Propriétaire"+$cr
$i:=0

$nb_fiches:=Records in selection:C76([Events:103])


While (Not:C34(End selection:C36([Events:103])))
	
	QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=[Events:103]EVE_User_ID:9)
	MultiSoc_Filter(->[INtervenants:10])
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
	MultiSoc_Filter(->[HeBerge:4])
	
	$send:=$send+[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4+$sep+[Events:103]EVE_Type:10+$sep+[Events:103]EVE_Presence:11+$sep+[Events:103]EVE_Titre:3+$sep+String:C10([Events:103]EVE_Date_Du:5)+$sep+String:C10([Events:103]EVE_Date_Au:6)+$sep+String:C10([Events:103]EVE_Heure_Du:7)+$sep+String:C10([Events:103]EVE_Heure_Au:8)+$sep+[Events:103]EVE_Rappel:12+$sep+[Events:103]EVE_Recurrence:13+$sep+[Events:103]EVE_User_NomPrenom:16+$cr
	
	NEXT RECORD:C51([Events:103])
End while 

If (String:C10($ref_doc)#"00:00:00")
	
	C_BLOB:C604($blob_send)
	
	CONVERT FROM TEXT:C1011($send; "windows-1252"; $blob_send)
	
	SEND PACKET:C103($ref_doc; $blob_send)
	
	CLOSE DOCUMENT:C267($ref_doc)
	
	C_BLOB:C604($blob)
	
	DOCUMENT TO BLOB:C525($file_name_path; $blob)
	
	If (Test path name:C476($file_name_path)=1)
		ON ERR CALL:C155("WEB_IO_TRAITEMENT_ERREURS")
		DELETE DOCUMENT:C159($file_name_path)
		ON ERR CALL:C155("")
	End if 
	
	ARRAY TEXT:C222($champ; 0)
	
	APPEND TO ARRAY:C911($champ; "X-STATUS")
	APPEND TO ARRAY:C911($champ; "Cache-Control")
	APPEND TO ARRAY:C911($champ; "Expires")
	APPEND TO ARRAY:C911($champ; "Content-disposition")
	APPEND TO ARRAY:C911($champ; "Content-type")
	
	ARRAY TEXT:C222($valeur; 0)
	
	APPEND TO ARRAY:C911($valeur; "200 OK")
	APPEND TO ARRAY:C911($valeur; "private, must-revalidate, max-age=0")
	APPEND TO ARRAY:C911($valeur; "-1")
	APPEND TO ARRAY:C911($valeur; "filename="+$file_name)
	APPEND TO ARRAY:C911($valeur; "application/csv")  // charset=UTF-8
	
	WEB SET HTTP HEADER:C660($champ; $valeur)
	WEB SEND RAW DATA:C815($blob)
	
	ABORT:C156
End if 




