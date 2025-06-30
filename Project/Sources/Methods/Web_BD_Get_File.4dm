//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 20-01-15, 09:57:08
// ----------------------------------------------------
// Method: Web_BD_Get_File
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)  // ID
C_TEXT:C284($2)  // folder

C_TEXT:C284($base_documentaire_path; $documents_folder; $folder_cle)
C_LONGINT:C283($id)
C_BLOB:C604($blob)
C_OBJECT:C1216($O_Output)

ARRAY TEXT:C222($champ; 0)
ARRAY TEXT:C222($valeur; 0)

$id:=$1
$documents_folder:=$2

$O_Output:=New object:C1471

QUERY:C277([Base_documentaire:90]; [Base_documentaire:90]ID:1=$id)
SOC_Get_Config

If (Records in selection:C76([Base_documentaire:90])=1)
	// Modifié par : Scanu Rémy (14/06/2023)
	$base_documentaire_path:=[SOciete:18]SO_Chemin_GED:96+"base_documentaire"+Séparateur dossier:K24:12+Session:C1714.storage.intervenant.Ref_Structure+Séparateur dossier:K24:12+$documents_folder+Séparateur dossier:K24:12
	
	Case of 
		: ($documents_folder="Documents usagers")
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Base_documentaire:90]DOC_Origine_ID:4)
			MultiSoc_Filter(->[HeBerge:4])
			
			If (Records in selection:C76([HeBerge:4])=1)
				$folder_cle:=[HeBerge:4]HB_Clé:2
				$folder_cle:=Replace string:C233($folder_cle; "/"; "-")
				$folder_cle:=Replace string:C233($folder_cle; "."; "-")
				
				$base_documentaire_path:=$base_documentaire_path+$folder_cle+Séparateur dossier:K24:12
				$base_documentaire_path:=$base_documentaire_path+[Base_documentaire:90]DOC_Document_Nom:6
			End if 
			
		Else 
			$base_documentaire_path:=$base_documentaire_path+String:C10([Base_documentaire:90]ID:1)+[Base_documentaire:90]DOC_Extension:12
	End case 
	
	If (Test path name:C476($base_documentaire_path)=Est un document:K24:1)
		DOCUMENT TO BLOB:C525($base_documentaire_path; $blob)
		
		APPEND TO ARRAY:C911($champ; "X-STATUS")
		APPEND TO ARRAY:C911($champ; "Cache-Control")
		APPEND TO ARRAY:C911($champ; "Expires")
		APPEND TO ARRAY:C911($champ; "Content-disposition")
		APPEND TO ARRAY:C911($champ; "Content-type")
		
		APPEND TO ARRAY:C911($valeur; "200 OK")
		APPEND TO ARRAY:C911($valeur; "private, must-revalidate, max-age=0")
		APPEND TO ARRAY:C911($valeur; "-1")
		APPEND TO ARRAY:C911($valeur; "filename="+[Base_documentaire:90]DOC_Document_Nom:6)
		APPEND TO ARRAY:C911($valeur; Web_UTL_Get_TypeMime([Base_documentaire:90]DOC_Extension:12))
		
		WEB SET HTTP HEADER:C660($champ; $valeur)
		WEB SEND RAW DATA:C815($blob)
	End if 
	
End if 