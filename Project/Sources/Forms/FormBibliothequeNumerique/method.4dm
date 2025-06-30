Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_LONGINT:C283($i_el; $pos_el; $gauche_el; $haut_el; $droite_el; $bas_el; $nbImpaire_el; $largeurForm_el; $hauteurForm_el)
		C_POINTER:C301($pointeur_p)
		C_OBJECT:C1216($enregistrement_o; $formule_o)
		
		ARRAY TEXT:C222($tag_at; 0)
		ARRAY TEXT:C222(triUniqueDossier_at; 0)
		
		For each ($enregistrement_o; Form:C1466.DOCWPRO)
			
			If ($enregistrement_o.tag="[@")
				JSON PARSE ARRAY:C1219($enregistrement_o.tag; $tag_at)
			End if 
			
			For ($i_el; 1; Size of array:C274($tag_at))
				
				If (Length:C16($tag_at{$i_el})#32)
					$pos_el:=Find in array:C230(triUniqueDossier_at; $tag_at{$i_el})
					
					If ($pos_el<0)
						APPEND TO ARRAY:C911(triUniqueDossier_at; $tag_at{$i_el})
					End if 
					
				End if 
				
			End for 
			
		End for each 
		
		SORT ARRAY:C229(triUniqueDossier_at; >)
		triUniqueDossier_at{0}:="Sélectionner un dossier"
		
		For ($i_el; 1; Size of array:C274(triUniqueDossier_at))
			
			If ($i_el>1)
				
				If ($i_el%2=0)  // Paire
					OBJECT DUPLICATE:C1111(*; "imageDossier"+String:C10($i_el-1); "imageDossier"+String:C10($i_el); $pointeur_p; ""; 200; 0)
					OBJECT DUPLICATE:C1111(*; "Variable"+String:C10($i_el-1); "Variable"+String:C10($i_el); ->triUniqueDossier_at{$i_el})
					
					$formule_o:=Formula from string:C1601("OBJET DEPLACER:C664(*;\"Variable"+String:C10($i_el)+"\";200;0)")
					$formule_o.call()
				Else   // Impaire
					OBJECT DUPLICATE:C1111(*; "imageDossier"+String:C10($i_el-2); "imageDossier"+String:C10($i_el); $pointeur_p; ""; 0; 200)
					OBJECT DUPLICATE:C1111(*; "Variable"+String:C10($i_el-2); "Variable"+String:C10($i_el); ->triUniqueDossier_at{$i_el})
					
					$formule_o:=Formula from string:C1601("OBJET DEPLACER:C664(*;\"Variable"+String:C10($i_el)+"\";0;200)")
					$formule_o.call()
					
					$nbImpaire_el:=$nbImpaire_el+1
				End if 
				
			End if 
			
		End for 
		
		GET WINDOW RECT:C443($gauche_el; $haut_el; $droite_el; $bas_el; Frontmost window:C447)
		FORM GET PROPERTIES:C674("FormBibliothequeNumerique"; $largeurForm_el; $hauteurForm_el)
		
		$hauteurForm_el:=$hauteurForm_el+(200*$nbImpaire_el)
		
		If ($hauteurForm_el>Screen height:C188(*))
			$hauteurForm_el:=$hauteurForm_el-180
		End if 
		
		SET WINDOW RECT:C444($gauche_el; ((Screen height:C188(*)/2)-10)-($hauteurForm_el/2); $droite_el; ((Screen height:C188(*)/2)-10)+($hauteurForm_el/2); Frontmost window:C447; *)
End case 