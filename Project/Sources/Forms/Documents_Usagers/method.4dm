C_TEXT:C284($T_remoteFolder; $T_Cle_folder; $T_sharedFolder; $T_Remote_rootFolder; $T_Message)
C_LONGINT:C283($L_MyError; $L_Size)
C_OBJECT:C1216($O_LB)

ARRAY TEXT:C222($rT_Document_name; 0)
ARRAY TEXT:C222($rT_Document_ParentFolder; 0)
ARRAY TEXT:C222($rT_Document_uti_extension; 0)
ARRAY TEXT:C222($rT_Document_type; 0)
ARRAY DATE:C224($rD_Document_lastmodified; 0)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(col_file; 0)
		ARRAY TEXT:C222(col_type; 0)
		ARRAY TEXT:C222(col_extension; 0)
		ARRAY TEXT:C222(col_path; 0)
		
		ARRAY DATE:C224(col_size; 0)
	: (Form event code:C388=Sur minuteur:K2:25)
		$T_remoteFolder:=Form:C1466.remotefolder  // Le dossier du serveur où est stocké les documents
		$T_Cle_folder:=Form:C1466.remotefolder_cle  // Le dossier de la clé : DUPONT 13/05/1962
		$T_sharedFolder:=Form:C1466.remotefolder_shared  // Le nom du dossier qui contient les clé : DOSSIER DES CLE
		$T_Remote_rootFolder:=Form:C1466.remotefolder_root
		
		$O_LB:=New object:C1471
		
		$O_LB.remotefolder:=$T_remoteFolder
		$O_LB.remotefolder_cle:=$T_Cle_folder
		$O_LB.remotefolder_shared:=$T_sharedFolder
		$O_LB.remotefolder_root:=$T_Remote_rootFolder
		$O_LB.HB_ReferenceID:=[HeBerge:4]HB_ReferenceID:1
		$O_LB:=FileBrowser_lire_cleFolder($O_LB)
		
		$L_MyError:=$O_LB.erreur
		
		OB GET ARRAY:C1229($O_LB; "name"; $rT_Document_name)
		OB GET ARRAY:C1229($O_LB; "parent"; $rT_Document_ParentFolder)
		OB GET ARRAY:C1229($O_LB; "uti"; $rT_Document_uti_extension)
		OB GET ARRAY:C1229($O_LB; "type"; $rT_Document_type)
		
		OB GET ARRAY:C1229($O_LB; "lastmodified"; $rD_Document_lastmodified)
		
		$L_Size:=Size of array:C274($rT_Document_name)
		
		COPY ARRAY:C226($rT_Document_name; col_file)
		COPY ARRAY:C226($rT_Document_type; col_type)
		COPY ARRAY:C226($rT_Document_uti_extension; col_extension)
		COPY ARRAY:C226($rT_Document_ParentFolder; col_path)
		
		COPY ARRAY:C226($rD_Document_lastmodified; col_size)
		
		If ($L_Size=0)
			$T_Message:="Aucun document"
		Else 
			$T_Message:=String:C10($L_Size)+" document"+Choose:C955($L_Size>1; "s"; "")
		End if 
		
		Case of 
			: ($L_MyError=-1)
				OB SET:C1220(Form:C1466; "customtitel"; "Le dossier des documents est inaccessible")
			: ($L_MyError=-2)
				OB SET:C1220(Form:C1466; "customtitel"; "Le dossier de la clé est inaccessible")
		End case 
		
		OBJECT SET TITLE:C194(*; "compte_files"; $T_Message)
		OBJECT SET TITLE:C194(*; "custom_titre"; OB Get:C1224(Form:C1466; "customtitel"; Est un texte:K8:3))
		
		OBJECT SET VISIBLE:C603(*; "col_path"; False:C215)
		SET TIMER:C645(0)
	: (Form event code:C388=Sur modif variable liée:K2:52)
		SET TIMER:C645(-1)
End case 