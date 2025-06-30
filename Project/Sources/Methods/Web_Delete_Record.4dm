//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-01-19, 08:27:49
// ----------------------------------------------------
// Method: Web_Delete_Record
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text
var $3 : Boolean
var $4 : Text
var $5 : Pointer
var $6 : Pointer

var $data_label; $T_JSON; $Status; $documents_folder; $base_documentaire_path; $folder_cle : Text
var $id; $factureID_el : Integer
var $delete_document; $continu; $check_lk; $part_name_uid : Boolean
var $table; $table_lk; $field_lk : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

$table:=$1
$data_label:=$2
$delete_document:=$3
$documents_folder:=$4

If (Count parameters:C259>4)
	$table_lk:=$5
	$field_lk:=$6
	
	$check_lk:=True:C214
End if 

$O_Output:=New object:C1471
$continu:=True:C214
$status:="Failed"

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

READ WRITE:C146($table->)

If ($id#0)
	QUERY:C277($table->; champRef_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		
		If ($delete_document)
			
			If ($documents_folder#"")
				SOC_Get_Config
				
				$part_name_uid:=True:C214
				$documents_folder:=Replace string:C233($documents_folder; "%20"; " ")
				$base_documentaire_path:=SO_Chemin_GED+"base_documentaire"+Séparateur dossier:K24:12+Session:C1714.storage.intervenant.Ref_Structure+Séparateur dossier:K24:12+$documents_folder+Séparateur dossier:K24:12
				
				Case of 
					: ($documents_folder="Documents usagers")
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Base_documentaire:90]DOC_Origine_ID:4)
						MultiSoc_Filter(->[HeBerge:4])
						
						If (Records in selection:C76([HeBerge:4])=1)
							$folder_cle:=[HeBerge:4]HB_Clé:2
							$folder_cle:=Replace string:C233($folder_cle; "/"; "-")
							$folder_cle:=Replace string:C233($folder_cle; "."; "-")
							
							$part_name_uid:=False:C215
						Else 
							$continu:=False:C215
						End if 
						
				End case 
				
				If ($continu)
					
					If ($part_name_uid)
						
						If (Test path name:C476($base_documentaire_path+String:C10([Base_documentaire:90]ID:1)+[Base_documentaire:90]DOC_Extension:12)=Est un document:K24:1)
							DELETE DOCUMENT:C159($base_documentaire_path+String:C10([Base_documentaire:90]ID:1)+[Base_documentaire:90]DOC_Extension:12)
						End if 
						
					Else 
						$base_documentaire_path:=$base_documentaire_path+$folder_cle+Séparateur dossier:K24:12
						
						If (Test path name:C476($base_documentaire_path+[Base_documentaire:90]DOC_Document_Nom:6)=Est un document:K24:1)
							DELETE DOCUMENT:C159($base_documentaire_path+[Base_documentaire:90]DOC_Document_Nom:6)
						End if 
						
					End if 
					
				End if 
				
			Else 
				$status:="Failed"
			End if 
			
		End if 
		
		If ($check_lk)
			READ WRITE:C146($table_lk->)
			QUERY:C277($table_lk->; $field_lk->=champRef_p->)
			
			If (Records in selection:C76($table_lk->)=0)
				$continu:=False:C215
			End if 
			
		End if 
		
		If ($continu)
			
			If ($table=->[Factures_Lignes:87])
				$factureID_el:=[Factures_Lignes:87]FACL_Piece_ID:3
			End if 
			
			// Modifié par : Rémy Scanu (22/09/2021)
			If (Count parameters:C259>4)
				DELETE RECORD:C58($table_lk->)
			Else 
				DELETE RECORD:C58($table->)
			End if 
			
			// Modifié par : Scanu Rémy (28/08/2024)
			If ($table=->[Factures_Lignes:87])
				READ WRITE:C146([Factures:86])
				
				QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$factureID_el)
				MultiSoc_Filter(->[Factures_Lignes:87])
				
				Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
				SAVE RECORD:C53([Factures:86])
			End if 
			
			$status:="success"
		Else 
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 

OB SET:C1220($O_Output; "Status"; $status)

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)