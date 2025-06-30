//%attributes = {}
// ----------------------------------------------------
// User name (OS): KEvin HASSAL
// Date and time: 02-05-19, 06:47:11
// ----------------------------------------------------
// Method: Web_Get_ETL_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($table; $1)
C_TEXT:C284($data_label; $2; $JSON; $libelle_id; $etl_type)
C_OBJECT:C1216($O_Output; $O_Data; $o_data_record)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id)

var champID_p : Pointer

$table:=$1
$data_label:=$2
$O_Output:=New object:C1471
$continu:=True:C214
$libelle_id:="id"

If (Count parameters:C259>2)
	$libelle_id:=$3
End if 

EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]"+$libelle_id)

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
$etl_type:=OB Get:C1224($O_Data; "etl_type"; Est un texte:K8:3)

READ ONLY:C145($table->)

If ($id#0)
	
	If ($etl_type="")
		QUERY:C277($table->; champID_p->=$id)
	Else 
		QUERY:C277([Etat_des_lieux:97]; [Etat_des_lieux:97]ETL_ID_Location:9=$id; *)
		QUERY:C277([Etat_des_lieux:97];  & ; [Etat_des_lieux:97]ETL_Type:2=$etl_type)
	End if 
	
	MultiSoc_Filter(->[Etat_des_lieux:97])
	
	If (Records in selection:C76($table->)=1)
		
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		
		//Get Signature
		C_TEXT:C284($base64Text_bailleur; $base64Text_locataire; $base_documentaire_path)
		C_BLOB:C604($Part_ContentBlob)
		
		$base64Text:=""
		$base_documentaire_path:=SO_Chemin_GED+"base_documentaire"+Séparateur dossier:K24:12+Session:C1714.storage.intervenant.Ref_Structure+Séparateur dossier:K24:12+"etl_signatures"+Séparateur dossier:K24:12
		
		// Bailleur
		If (Test path name:C476($base_documentaire_path+String:C10([Etat_des_lieux:97]ID:1)+"_bailleur.png")=Est un document:K24:1)
			DOCUMENT TO BLOB:C525($base_documentaire_path+String:C10([Etat_des_lieux:97]ID:1)+"_bailleur.png"; $Part_ContentBlob)
		End if 
		BASE64 ENCODE:C895($Part_ContentBlob; $base64Text_bailleur)
		
		// Locataire
		If (Test path name:C476($base_documentaire_path+String:C10([Etat_des_lieux:97]ID:1)+"_locataire.png")=Est un document:K24:1)
			DOCUMENT TO BLOB:C525($base_documentaire_path+String:C10([Etat_des_lieux:97]ID:1)+"_locataire.png"; $Part_ContentBlob)
		End if 
		BASE64 ENCODE:C895($Part_ContentBlob; $base64Text_locataire)
		
		$o_data_record:=Web_UTL_Record_To_JSON($table)
		
		OB SET:C1220($o_data_record; "etl_signature_bailleur"; $base64Text_bailleur)
		OB SET:C1220($o_data_record; "etl_signature_locataire"; $base64Text_locataire)
		
		$JSON:=JSON Stringify:C1217($o_data_record)
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 

WEB SEND TEXT:C677($JSON)

