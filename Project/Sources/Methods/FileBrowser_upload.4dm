//%attributes = {}
// Method FileBrowser_upload sélectionne des fichiers sur le PC et les place dans le dossier local 
//  
// #SYNTAX: FileBrowser_upload 
// #PARAMETERS:
//     None

// #DATE CREATION: 11/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

// #20180511-1
C_LONGINT:C283($0)

C_TEXT:C284($T_File; $T_remoteFolder; $T_localFolder; $T_Name; $T_Text_error; $position_t)
C_LONGINT:C283($L_MyError; $i; $L_Erreur)
C_BOOLEAN:C305($locked; $invisible)
C_DATE:C307($created_on; $modified_on)
C_TIME:C306($created_at; $modified_at)
C_BLOB:C604($X_BLOB)
C_OBJECT:C1216($O_Document; $O_Param; $table_o)

ARRAY TEXT:C222($rT_Selected; 0)
ARRAY TEXT:C222($rT_Document_list; 0)

$O_Param:=New object:C1471
$L_MyError:=-1  // Si OK =0

// Modifié par : Scanu Rémy (24/03/2021)
// J'enlève la sélection d'alias
$T_File:=Select document:C905(System folder:C487(Bureau:K41:16); "*"; "Sélectionnez vos documents..."; Fichiers multiples:K24:7; $rT_Selected)

If (OK=1)  // Ici on est sur le client
	$T_remoteFolder:=Form:C1466.remotefolder
	$T_localFolder:=Form:C1466.localfolder
	
	// je déplace les fichiers sélectionnés sur le poste vers le local folder qui est sur le poste
	// Si le dossier final n'est plus accessible, les doc restent dans le dossier local et seront déplacé plus tard
	CREATE FOLDER:C475($T_localFolder; *)
	
	// ici il faut que le dossier soit vide
	For ($i; 1; Size of array:C274($rT_Selected))
		
		If (Test path name:C476($rT_Selected{$i})=Est un document:K24:1)
			$O_Document:=Path to object:C1547($rT_Selected{$i}; Chemin est  système:K24:25)
			$T_Name:=Replace string:C233($O_Document.name+$O_Document.extension; "%"; "")
			
			If (Test path name:C476($T_localFolder+$T_Name)=Est un document:K24:1)
				DELETE DOCUMENT:C159($T_localFolder+$T_Name)
			End if 
			
			// Modified by: Scanu Rémy - remy@connect-io.fr (17/02/2021)
			// On tient compte d'un paramètre pour savoir si on fait l'action Couper/Coller OU Copier/Coller
			LOAD RECORD:C52([SOciete:18])
			
			If ([SOciete:18]SO_Upload_Couper_Coller:125=True:C214)
				MOVE DOCUMENT:C540($rT_Selected{$i}; $T_localFolder+$T_Name)
			Else 
				COPY DOCUMENT:C541($rT_Selected{$i}; $T_localFolder+$T_Name)
			End if 
			
			//===================================================//
			// Modified by: Kevin HASSAL (14/09/2020)
			// Création de l'enregistrement correspondant dans la base documentaire
			//===================================================//
			If (OK=1)
				QUERY:C277([Base_documentaire:90]; [Base_documentaire:90]DOC_Origine_ID:4=[HeBerge:4]HB_ReferenceID:1; *)
				QUERY:C277([Base_documentaire:90];  & ; [Base_documentaire:90]DOC_Document_Nom:6=$rT_Selected{$i})
				MultiSoc_Filter(->[Base_documentaire:90])
				
				If (Records in selection:C76([Base_documentaire:90])=0)
					GET DOCUMENT PROPERTIES:C477($T_localFolder+$T_Name; $locked; $invisible; $created_on; $created_at; $modified_on; $modified_at)
					
					$extension:=UTL_Get_File_Extension($rT_Selected{$i})
					
					CREATE RECORD:C68([Base_documentaire:90])
					MultiSoc_Init_Structure(->[Base_documentaire:90])
					
					[Base_documentaire:90]DOC_Origine_ID:4:=[HeBerge:4]HB_ReferenceID:1
					[Base_documentaire:90]DOC_Table_No:5:=Table:C252(->[HeBerge:4])
					[Base_documentaire:90]DOC_Document_Nom:6:=$T_Name
					[Base_documentaire:90]DOC_Titre:8:=Replace string:C233($T_Name; $extension; "")
					[Base_documentaire:90]DOC_Date:7:=$created_on
					[Base_documentaire:90]DOC_Extension:12:=$extension
					
					// Modifié par : Scanu Rémy (24/03/2021) et Re-modifié par Scanu Rémy (09/06/2021)
					// Ajout d'un type de document
					If ([SOciete:18]SO_Desactiver_Typage:127=False:C215)
						$table_o:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Type Document Upload")
						
						If ($table_o.length=1)
							$table_o:=outilsOrdaSearch($table_o; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
							USE ENTITY SELECTION:C1513($table_o)
							
							LOAD RECORD:C52([TAbles:12])
							MultiSoc_Filter(->[TAbles:12])
							
							$table_o:=Create entity selection:C1512([TAbles:12])
							//TableEnum_Lister 
							
							$position_t:="center"
							outilsCreateWindowsForm("selectValue"; ->$position_t; New object:C1471("collection"; $table_o.toCollection("TB_Texte").extract("TB_Texte"; "type"); \
								"property"; "type"; "selectSubTitle"; "Merci de sélectionner un type de document"; "title"; "Choix du type du document :"))
							
							[Base_documentaire:90]DOC_Document_Type:3:=selectValue_t
							SAVE RECORD:C53([Base_documentaire:90])
						Else 
							ALERT:C41("La liste d'énumération \"Type Document Upload\" n'a pas pu être trouver, merci de la créer pour pouvoir continuer")
						End if 
						
					Else 
						SAVE RECORD:C53([Base_documentaire:90])
					End if 
					
				End if 
				
			End if 
			
			//===================================================//
		End if 
		
	End for 
	
	DOCUMENT LIST:C474($T_localFolder; $rT_Document_list; Chemin absolu:K24:14+Ignorer invisibles:K24:16)
	
	For ($i; 1; Size of array:C274($rT_Document_list))
		SET BLOB SIZE:C606($X_BLOB; 0)
		DOCUMENT TO BLOB:C525($rT_Document_list{$i}; $X_BLOB)
		
		$O_Document:=Path to object:C1547($rT_Document_list{$i}; Chemin est  système:K24:25)
		
		$O_Param.remotefolder:=$T_remoteFolder
		$O_Param.remotefolder_cle:=$T_remoteFolder
		$O_Param.file:=$T_remoteFolder+$O_Document.name+$O_Document.extension
		
		$L_Erreur:=FileBrowser_local2remote($X_BLOB; $O_Param; ->$T_Text_error)
	End for 
	
	If ($L_Erreur=1)  // tous les document ont été déplacés avec succès
		DOCUMENT LIST:C474($T_localFolder; $rT_Document_list; Chemin absolu:K24:14+Ignorer invisibles:K24:16)
		
		For ($i; 1; Size of array:C274($rT_Document_list))
			
			If (Test path name:C476($rT_Document_list{$i})=Est un document:K24:1)
				DELETE DOCUMENT:C159($rT_Document_list{$i})
			End if 
			
		End for 
		
	End if 
	
	If ($L_Erreur#1)
		ALERT:C41($T_Text_error+" "+String:C10($L_Erreur))
	Else 
		$L_MyError:=1
	End if 
	
End if 

$0:=$L_MyError