//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 10/09/2020, 15:17:24
// ----------------------------------------------------
// Method: MAINT_Documents_Usagers
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($path; $path_docs)
C_LONGINT:C283($i; $j; $compteur)

$path:=Select folder:C670("Sélectionner le dossier contenant les documents des usagers")

ARRAY TEXT:C222($tb_dossiers; 0)
ARRAY TEXT:C222($tb_documents; 0)

FOLDER LIST:C473($path; $tb_dossiers)

READ ONLY:C145([HeBerge:4])
READ WRITE:C146([Base_documentaire:90])

SOC_Get_Config

For ($i; 1; Size of array:C274($tb_dossiers))
	
	$cle:=Replace string:C233($tb_dossiers{$i}; "-"; "/")
	$path_docs:=$path+$tb_dossiers{$i}
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$cle)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		
		DOCUMENT LIST:C474($path_docs; $tb_documents)
		
		For ($j; 1; Size of array:C274($tb_documents))
			
			QUERY:C277([Base_documentaire:90]; [Base_documentaire:90]DOC_Origine_ID:4=[HeBerge:4]HB_ReferenceID:1; *)
			QUERY:C277([Base_documentaire:90];  & ; [Base_documentaire:90]DOC_Document_Nom:6=$tb_documents{$j})
			MultiSoc_Filter(->[Base_documentaire:90])
			
			If (Records in selection:C76([Base_documentaire:90])=0)
				
				C_BOOLEAN:C305($locked; $invisible)
				C_DATE:C307($created_on; $modified_on)
				C_TIME:C306($created_at; $modified_at)
				C_TEXT:C284($path_doc_current)
				
				$path_doc_current:=$path_docs+Séparateur dossier:K24:12+$tb_documents{$j}
				
				GET DOCUMENT PROPERTIES:C477($path_doc_current; $locked; $invisible; $created_on; $created_at; $modified_on; $modified_at)
				
				$extension:=UTL_Get_File_Extension($tb_documents{$j})
				
				CREATE RECORD:C68([Base_documentaire:90])
				MultiSoc_Init_Structure(->[Base_documentaire:90])
				[Base_documentaire:90]DOC_Origine_ID:4:=[HeBerge:4]HB_ReferenceID:1
				[Base_documentaire:90]DOC_Table_No:5:=Table:C252(->[HeBerge:4])
				[Base_documentaire:90]DOC_Document_Nom:6:=$tb_documents{$j}
				[Base_documentaire:90]DOC_Titre:8:=Replace string:C233($tb_documents{$j}; $extension; "")
				[Base_documentaire:90]DOC_Date:7:=$created_on
				[Base_documentaire:90]DOC_Extension:12:=$extension
				SAVE RECORD:C53([Base_documentaire:90])
				
				$compteur:=$compteur+1
				
				
			End if 
			
		End for 
		
	End if 
	
End for 

ALERT:C41("Opération effectuée avec succès : "+String:C10($compteur)+" documents traités")
