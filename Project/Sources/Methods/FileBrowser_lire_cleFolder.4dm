//%attributes = {"executedOnServer":true}
// Method FileBrowser_lire_cleFolder  
// 
// 
// #SYNTAX: $L_Erreur:=FileBrowser_lire_cleFolder(object) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 07/06/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

// on est sur le serveur
C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_TEXT:C284($T_remoteFolder; $T_Cle_folder; $T_sharedFolder; $T_Remote_rootFolder; $T_ParentFolder; $T_Name; $T_Ext)
C_LONGINT:C283($L_MyError; $L_Size; $i)
C_BOOLEAN:C305($B_Folder; $B_locked; $B_invisible)
C_DATE:C307($D_modified_on; $D_created_on)
C_TIME:C306($H_created_at; $H_modified_at)
C_COLLECTION:C1488($collection_c)
C_OBJECT:C1216($O_LB; $O_Chemin)

ARRAY TEXT:C222($rT_Document_list; 0)

$O_LB:=$1

$L_MyError:=1

$T_remoteFolder:=$O_LB.remotefolder  // chemin vers le dossier de l'usager
$T_Cle_folder:=$O_LB.remotefolder_cle
$T_sharedFolder:=$O_LB.remotefolder_shared
$T_Remote_rootFolder:=$O_LB.remotefolder_root

Case of 
	: (Test path name:C476($T_Remote_rootFolder+$T_sharedFolder)#Est un dossier:K24:2)  // le dossier commun
		$L_MyError:=-1
	: (Test path name:C476($T_remoteFolder)#Est un dossier:K24:2)  // le dossier de la clé
		$L_MyError:=-2
	Else 
		DOCUMENT LIST:C474($T_remoteFolder; $rT_Document_list; Chemin absolu:K24:14+Ignorer invisibles:K24:16+Chemin récursif:K24:13)
		
		SORT ARRAY:C229($rT_Document_list; >)
		$L_Size:=Size of array:C274($rT_Document_list)
		
		ARRAY TEXT:C222($rT_Document_name; $L_Size)
		ARRAY TEXT:C222($rT_Document_ParentFolder; $L_Size)
		ARRAY TEXT:C222($rT_Document_uti_extension; $L_Size)  // #20180515-1
		ARRAY TEXT:C222($rT_Document_type; $L_Size)
		
		ARRAY DATE:C224($rD_Document_lastmodified; $L_Size)
		
		For ($i; 1; $L_Size)
			$O_Chemin:=Path to object:C1547($rT_Document_list{$i}; Chemin est  système:K24:25)
			
			$T_ParentFolder:=OB Get:C1224($O_Chemin; "parentFolder"; Est un texte:K8:3)
			$T_Name:=OB Get:C1224($O_Chemin; "name"; Est un texte:K8:3)
			$T_Ext:=OB Get:C1224($O_Chemin; "extension"; Est un texte:K8:3)
			
			If (Length:C16($T_Ext)>1)
				$T_Name:=$T_Name+$T_Ext
			End if 
			
			$B_Folder:=OB Get:C1224($O_Chemin; "isFolder"; Est un booléen:K8:9)
			
			$rT_Document_name{$i}:=$T_Name
			$rT_Document_ParentFolder{$i}:=$T_ParentFolder
			$rT_Document_uti_extension{$i}:=Get file description($T_Name)  // #20180515-1
			
			GET DOCUMENT PROPERTIES:C477($rT_Document_list{$i}; $B_locked; $B_invisible; $D_created_on; $H_created_at; $D_modified_on; $H_modified_at)
			$rD_Document_lastmodified{$i}:=$D_modified_on
		End for 
		
		OB SET ARRAY:C1227($O_LB; "name"; $rT_Document_name)
		OB SET ARRAY:C1227($O_LB; "parent"; $rT_Document_ParentFolder)
		OB SET ARRAY:C1227($O_LB; "lastmodified"; $rD_Document_lastmodified)
		OB SET ARRAY:C1227($O_LB; "uti"; $rT_Document_uti_extension)
		
		// Modifié par : Scanu Rémy (19/07/2023)
		// Si le chemin de la base documentaire a été changé et que dans l'ancien chemin on avait stocké des documents, \
						les enregistrements eux n'ont pas disparu donc ça provoque des incohérences
		If (Num:C11($O_LB.HB_ReferenceID)#0) & (Size of array:C274($rT_Document_name)>0)
			$collection_c:=New collection:C1472
			$collection_c:=ds:C1482.Base_documentaire.query("DOC_Origine_ID is :1"; $O_LB.HB_ReferenceID).orderBy("DOC_Document_Nom asc")\
				.toCollection("DOC_Document_Type").extract("DOC_Document_Type")
			
			COLLECTION TO ARRAY:C1562($collection_c; $rT_Document_type)
		End if 
		
		OB SET ARRAY:C1227($O_LB; "type"; $rT_Document_type)
End case 

$O_LB.erreur:=$L_MyError

$0:=$O_LB