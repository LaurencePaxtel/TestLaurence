// Method File_navigateur.lb_navigateur  
// 
// 

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		
		If (User in group:C338(Current user:C182; <>Groupe_documents_serveur))  // #20180514-2
			
			C_POINTER:C301($P_Col)
			C_LONGINT:C283($L_Colonne; $L_Ligne)
			LISTBOX GET CELL POSITION:C971(*; "lb_navigateur"; $L_Colonne; $L_Ligne; $P_Col)
			
			C_POINTER:C301($P_Name; $P_Path)
			$P_Name:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_file")
			$P_Path:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_path")
			
			C_TEXT:C284($T_Path)
			$T_Path:=$P_Path->{$L_Ligne}+$P_Name->{$L_Ligne}
			
			C_LONGINT:C283($L_Erreur)
			C_BLOB:C604($X_BLOB)
			$L_Erreur:=FileBrowser_blobDocument(->$X_BLOB; $T_Path)  // on va sur le serveur pour rapatrier le doc
			
			$T_Path:=Temporary folder:C486+$P_Name->{$L_Ligne}
			BLOB TO DOCUMENT:C526($T_Path; $X_BLOB)
			
			OB SET:C1220(Form:C1466; "thispath"; $T_Path)
			
			CALL SUBFORM CONTAINER:C1086(-1)
			
		Else 
			CALL SUBFORM CONTAINER:C1086(-2)
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		C_LONGINT:C283($colonne; $ligne; selected_row_number)
		LISTBOX GET CELL POSITION:C971(lb_navigateur; $colonne; $ligne)
		
		selected_row_number:=$ligne
		
		If (Contextual click:C713)
			
			$menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($menu; "Supprimer")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "Supprimer")
			
			$choix:=Dynamic pop up menu:C1006($menu)
			RELEASE MENU:C978($menu)
			
		Else 
			$choix:=""
		End if 
		
		Case of 
			: ($choix="Supprimer")
				
				If (Accès_Groupe(<>Groupe_Documents_Suppression))
					
					
					C_POINTER:C301($P_Name; $P_Path)
					$P_Name:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_file")
					$P_Path:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_path")
					
					C_TEXT:C284($T_Path)
					$T_Path:=$P_Path->{$ligne}+$P_Name->{$ligne}
					
					
					If (Test path name:C476($T_Path)=Est un document:K24:1)
						DELETE DOCUMENT:C159($T_Path)
					End if 
					
					SET TIMER:C645(-1)
					
				End if 
				
		End case 
		
		
		
End case 