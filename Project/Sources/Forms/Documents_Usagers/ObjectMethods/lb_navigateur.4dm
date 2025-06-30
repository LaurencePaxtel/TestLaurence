// Method File_navigateur.lb_navigateur
C_TEXT:C284($T_Path; $choix; $menu)
C_LONGINT:C283($L_Colonne; $L_Ligne; $L_Erreur; $colonne; $ligne)
C_BOOLEAN:C305($docSuppr_b)
C_BLOB:C604($X_BLOB)
C_POINTER:C301($P_Col; $P_Name; $P_Path)

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		
		If (User in group:C338(Current user:C182; <>Groupe_documents_serveur))  // #20180514-2
			LISTBOX GET CELL POSITION:C971(*; "lb_navigateur"; $L_Colonne; $L_Ligne; $P_Col)
			
			$P_Name:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_file")
			$P_Path:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_path")
			
			$T_Path:=$P_Path->{$L_Ligne}+$P_Name->{$L_Ligne}
			$L_Erreur:=FileBrowser_blobDocument(->$X_BLOB; $T_Path)  // on va sur le serveur pour rapatrier le doc
			
			$T_Path:=Temporary folder:C486+$P_Name->{$L_Ligne}
			BLOB TO DOCUMENT:C526($T_Path; $X_BLOB)
			
			OB SET:C1220(Form:C1466; "thispath"; $T_Path)
			CALL SUBFORM CONTAINER:C1086(-1)
		Else 
			CALL SUBFORM CONTAINER:C1086(-2)
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		C_LONGINT:C283(selected_row_number)
		
		LISTBOX GET CELL POSITION:C971(lb_navigateur; $colonne; $ligne)
		selected_row_number:=$ligne
		
		If (Contextual click:C713)
			$menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($menu; "Supprimer")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "Supprimer")
			
			$choix:=Dynamic pop up menu:C1006($menu)
			RELEASE MENU:C978($menu)
		End if 
		
		If ($choix="Supprimer")
			
			If (Accès_Groupe(<>Groupe_Documents_Suppression))
				$P_Name:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_file")
				$P_Path:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "col_path")
				
				$T_Path:=$P_Path->{$ligne}+$P_Name->{$ligne}
				
				// Modified by: Scanu Rémy - remy@connect-io.fr (24/02/2021)
				// Le fichier doit être supprimer sur le serveur
				$docSuppr_b:=outilsDeleteDocument($T_Path; True:C214)
				
				If ($docSuppr_b=True:C214)
					ALERT:C41("Le fichier "+outilsExtractFileNameToPath($T_Path; True:C214)+" a bien été supprimé sur le serveur")
				Else 
					ALERT:C41("Le fichier "+outilsExtractFileNameToPath($T_Path; True:C214)+" n'a pas pu être supprimé sur le serveur, merci de contacter votre administrateur réseau")
				End if 
				
				SET TIMER:C645(-1)
			End if 
			
		End if 
		
End case 