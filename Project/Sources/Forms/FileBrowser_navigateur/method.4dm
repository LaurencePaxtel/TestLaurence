// Method File_navigateur  


// #20180511-1

Case of 
	: (Form event code:C388=Sur minuteur:K2:25)
		
		SET TIMER:C645(0)
		
		// on est sur le client
		
		// - Dossier du data
		//   - Data
		//   - remoteFolder
		//   -    folder de la clé hebergé 1
		//   -    folder de la clé hebergé 2
		//   -    folder de la clé hebergé 3
		
		// On reçoit un chemin de dossier
		C_TEXT:C284($T_remoteFolder; $T_Cle_folder; $T_sharedFolder; $T_Remote_rootFolder)
		$T_remoteFolder:=Form:C1466.remotefolder  // le dossier du data : C://dossier/dataclient/
		$T_Cle_folder:=Form:C1466.remotefolder_cle  // le dossier de la clé : DUPONT 13/05/1962
		$T_sharedFolder:=Form:C1466.remotefolder_shared  // Le nom du dossier qui contient les clé : DOSSIER DES CLE
		$T_Remote_rootFolder:=Form:C1466.remotefolder_root
		
		C_TEXT:C284($T_Message)
		$T_Message:=""
		
		C_OBJECT:C1216($O_LB)
		$O_LB:=New object:C1471
		$O_LB.remotefolder:=$T_remoteFolder
		$O_LB.remotefolder_cle:=$T_Cle_folder
		$O_LB.remotefolder_shared:=$T_sharedFolder
		$O_LB.remotefolder_root:=$T_Remote_rootFolder
		
		$O_LB:=FileBrowser_lire_cleFolder($O_LB)
		
		$L_MyError:=$O_LB.erreur
		
		ARRAY TEXT:C222($rT_Document_name; 0)
		ARRAY TEXT:C222($rT_Document_ParentFolder; 0)
		ARRAY DATE:C224($rD_Document_lastmodified; 0)
		ARRAY TEXT:C222($rT_Document_uti_type; 0)
		
		OB GET ARRAY:C1229($O_LB; "name"; $rT_Document_name)
		OB GET ARRAY:C1229($O_LB; "parent"; $rT_Document_ParentFolder)
		OB GET ARRAY:C1229($O_LB; "lastmodified"; $rD_Document_lastmodified)
		OB GET ARRAY:C1229($O_LB; "uti"; $rT_Document_uti_type)
		
		C_LONGINT:C283($L_Size)
		$L_Size:=Size of array:C274($rT_Document_name)
		
		
		ARRAY TEXT:C222($rT_ColNames; 0)
		ARRAY TEXT:C222($rT_HeadNames; 0)
		ARRAY POINTER:C280($rP_ColVars; 0)
		ARRAY POINTER:C280($rP_HeadVars; 0)
		ARRAY BOOLEAN:C223($rB_Visible; 0)
		ARRAY POINTER:C280($rP_Styles; 0)
		
		LISTBOX GET ARRAYS:C832(*; "lb_navigateur"; $rT_ColNames; $rT_HeadNames; $rP_ColVars; $rP_HeadVars; $rB_Visible; $rP_Styles)
		
		ARRAY TEXT:C222($rP_ColVars{1}->; 0)
		ARRAY TEXT:C222($rP_ColVars{2}->; 0)
		ARRAY TEXT:C222($rP_ColVars{3}->; 0)
		ARRAY DATE:C224($rP_ColVars{4}->; 0)  //#20180515-2
		
		
		COPY ARRAY:C226($rT_Document_name; $rP_ColVars{1}->)
		COPY ARRAY:C226($rT_Document_uti_type; $rP_ColVars{2}->)
		COPY ARRAY:C226($rT_Document_ParentFolder; $rP_ColVars{3}->)
		COPY ARRAY:C226($rD_Document_lastmodified; $rP_ColVars{4}->)
		
		
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
			Else 
				// rien
		End case 
		OBJECT SET TITLE:C194(*; "compte_files"; $T_Message)
		OBJECT SET TITLE:C194(*; "custom_titre"; OB Get:C1224(Form:C1466; "customtitel"; Est un texte:K8:3))
		
	: (Form event code:C388=Sur modif variable liée:K2:52)
		
		SET TIMER:C645(-1)
End case 