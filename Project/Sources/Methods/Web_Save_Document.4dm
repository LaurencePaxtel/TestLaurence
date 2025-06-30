//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18-01-19, 10:21:54
// ----------------------------------------------------
// Method: Web_Save_Document
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_POINTER:C301($5)

C_TEXT:C284($libelle; $Status; $documents_folder; $extension; $extension_old; $JSON; $folder_cle; $doc_name_previous; \
$Part_Name; $Part_MimeType; $Part_FileName)
C_LONGINT:C283($id_table_origine; $doc_origine_id; $i)
C_BOOLEAN:C305($continu; $part_name_uid)
C_BLOB:C604($Part_ContentBlob)
C_POINTER:C301($table; $champ_origin; $POST_Content)
C_OBJECT:C1216($O_Output)

$table:=$1
$champ_origin:=$2
$libelle:=$3
$documents_folder:=$4

If (Count parameters:C259>4)
	$POST_Content:=$5
End if 

If ($documents_folder="")
	$documents_folder:=WEB_URL_GET_PARAM($POST_Content->; "table_name")
End if 

$doc_origine_id:=Num:C11(WEB_URL_GET_PARAM($POST_Content->; "doc_origine_id"))
$doc_name_previous:=WEB_URL_GET_PARAM($POST_Content->; "doc_name_previous")

$status:="failed"

$continu:=True:C214
$part_name_uid:=True:C214

If ($documents_folder#"") & ($continu)
	SOC_Get_Config
	
	$documents_folder:=Replace string:C233($documents_folder; "%20"; " ")
	$doc_name_previous:=Replace string:C233($doc_name_previous; "%20"; " ")
	
	$O_Output:=New object:C1471
	$id_table_origine:=Table:C252($table)
	
	// Modifié par : Scanu Rémy (14/06/2023)
	$base_documentaire_path:=[SOciete:18]SO_Chemin_GED:96+"base_documentaire"+Séparateur dossier:K24:12+Session:C1714.storage.intervenant.Ref_Structure+Séparateur dossier:K24:12+$documents_folder+Séparateur dossier:K24:12
	
	If (Test path name:C476($base_documentaire_path)#0)
		CREATE FOLDER:C475($base_documentaire_path; *)
	End if 
	
	Case of 
		: ($documents_folder="Documents usagers")
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$doc_origine_id)
			MultiSoc_Filter(->[HeBerge:4])
			
			If (Records in selection:C76([HeBerge:4])=1)
				$folder_cle:=[HeBerge:4]HB_Clé:2
				$folder_cle:=Replace string:C233($folder_cle; "/"; "-")
				$folder_cle:=Replace string:C233($folder_cle; "."; "-")
				
				$base_documentaire_path:=$base_documentaire_path+$folder_cle+Séparateur dossier:K24:12
				
				If (Test path name:C476($base_documentaire_path)#0)
					CREATE FOLDER:C475($base_documentaire_path; *)
				End if 
				
				$part_name_uid:=False:C215
			Else 
				$continu:=False:C215
			End if 
			
	End case 
	
	If ($continu)
		
		For ($i; 1; WEB Get body part count:C1211)
			WEB GET BODY PART:C1212($i; $Part_ContentBlob; $Part_Name; $Part_MimeType; $Part_FileName)
			$Part_FileName:=Replace string:C233($Part_FileName; "%"; "")
			If ($Part_FileName#"")
				$extension_old:=""
				$extension:=UTL_Get_Document_Type($Part_FileName)
				
				// Pour remplacer l'ancien document
				READ WRITE:C146([Base_documentaire:90])
				QUERY:C277([Base_documentaire:90]; [Base_documentaire:90]ID:1=Num:C11($Part_Name))
				
				If (Records in selection:C76([Base_documentaire:90])=1)
					$extension_old:=[Base_documentaire:90]DOC_Extension:12
					
					[Base_documentaire:90]DOC_Document_Nom:6:=$Part_FileName
					SAVE RECORD:C53([Base_documentaire:90])
				End if 
				
				UNLOAD RECORD:C212([Base_documentaire:90])
				
				If ($part_name_uid)
					
					If (Test path name:C476($base_documentaire_path+$Part_Name+$extension_old)=Est un document:K24:1)
						DELETE DOCUMENT:C159($base_documentaire_path+$Part_Name+$extension_old)
					End if 
					
					If (Test path name:C476($base_documentaire_path+$Part_Name+$extension)=Est un document:K24:1)
						DELETE DOCUMENT:C159($base_documentaire_path+$Part_Name+$extension)
					End if 
					
					BLOB TO DOCUMENT:C526($base_documentaire_path+$Part_Name+$extension; $Part_ContentBlob)
				Else 
					
					If (Test path name:C476($base_documentaire_path+$Part_FileName)=Est un document:K24:1)
						DELETE DOCUMENT:C159($base_documentaire_path+$Part_FileName)
					End if 
					
					If (Test path name:C476($base_documentaire_path+$doc_name_previous)=Est un document:K24:1)
						DELETE DOCUMENT:C159($base_documentaire_path+$doc_name_previous)
					End if 
					
					BLOB TO DOCUMENT:C526($base_documentaire_path+$Part_FileName; $Part_ContentBlob)
				End if 
				
				$status:="success"
			End if 
			
		End for 
		
	Else 
		$status:="Failed"
	End if 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)

$JSON:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($JSON)