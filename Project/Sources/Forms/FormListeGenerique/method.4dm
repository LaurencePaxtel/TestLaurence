var $property_t : Text
var $i_el; $gauche_el; $haut_el; $droite_el; $bas_el; $largeurForm_el; $hauteurForm_el; $gaucheCalcul_el; $droiteCalcul_el; $j_el : Integer
var $collection_c; $fieldTraiter_c : Collection
var $pointeur_p : Pointer

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var elementSelection_c : Collection
		
		elementSelection_c:=New collection:C1472
		$fieldTraiter_c:=New collection:C1472
		
		If (Form:C1466.data.length>0)
			$collection_c:=OB Keys:C1719(Form:C1466.data[0])
		End if 
		
		For ($i_el; 1; Form:C1466.column.length)
			$pointeur_p:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Colonne"+String:C10($i_el))
			$property_t:=$collection_c[$i_el-1]
			
			If (Form:C1466.data[0]["fieldNoDisplay"]#Null:C1517)  // Il y a des propriétés à ne pas faire apparaître visuellement
				
				While (Form:C1466.data[0]["fieldNoDisplay"].indexOf($property_t)#-1) | ($fieldTraiter_c.indexOf($property_t)#-1)
					$j_el:=$j_el+1
					
					If ($i_el+$j_el-2<$collection_c.length)
						$property_t:=$collection_c[$i_el+$j_el-2]
					Else 
						CLEAR VARIABLE:C89($property_t)
					End if 
					
				End while 
				
			End if 
			
			If ($property_t#"")
				
				If ($i_el=1)
					LISTBOX SET COLUMN FORMULA:C1203(*; "Colonne1"; "This."+$property_t; Value type:C1509(Form:C1466.data[0][$property_t]))
				Else 
					LISTBOX INSERT COLUMN FORMULA:C970(*; "List Box"; $i_el+1; "Colonne"+String:C10($i_el); "This."+$property_t; Value type:C1509(Form:C1466.data[0][$property_t]); "Entête"+String:C10($i_el); $pointeur_p)
				End if 
				
				If (Form:C1466.column[$i_el-1]["text-align"]#Null:C1517)
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "Colonne"+String:C10($i_el); Form:C1466.column[$i_el-1]["text-align"])
				End if 
				
				If (Bool:C1537(Form:C1466.column[$i_el-1]["not-enterable"])=True:C214)
					OBJECT SET ENTERABLE:C238(*; "Colonne"+String:C10($i_el); False:C215)
				End if 
				
				$fieldTraiter_c.push($property_t)
				
				CLEAR VARIABLE:C89($j_el)
				OBJECT SET TITLE:C194(*; "Entête"+String:C10($i_el); Form:C1466.column[$i_el-1].titre)
			End if 
			
		End for 
		
		LISTBOX SET LOCKED COLUMNS:C1151(*; "List Box"; 1)
		
		If (Form:C1466.columnRules#Null:C1517)
			
			If (Form:C1466.columnRules.fixedColumn#Null:C1517)
				
				If (Num:C11(Form:C1466.columnRules.fixedColumn.length)=0)
					LISTBOX SET LOCKED COLUMNS:C1151(*; "List Box"; 0)
				End if 
				
			End if 
			
		End if 
		
		$columnWidth_el:=120
		
		If (Form:C1466.columnRules#Null:C1517)
			
			If (Num:C11(Form:C1466.columnRules.columnWidth)>0)
				$columnWidth_el:=Num:C11(Form:C1466.columnRules.columnWidth)
			End if 
			
		End if 
		
		LISTBOX SET COLUMN WIDTH:C833(*; "List Box"; $columnWidth_el)
		OBJECT GET COORDINATES:C663(*; "List Box"; $gauche_el; $haut_el; $droite_el; $bas_el)
		
		Case of 
			: (Form:C1466.title=Null:C1517) & (Form:C1466.subTitle=Null:C1517)
				outilsObjectFormMove(0; New collection:C1472("Zone de saisie"; "Zone de saisie1"))
			: (Form:C1466.title=Null:C1517)
				outilsObjectFormMove(0; New collection:C1472("Zone de saisie"))
				
				OBJECT SET COORDINATES:C1248(*; "Zone de saisie1"; $gauche_el; 20)
				OBJECT SET COORDINATES:C1248(*; "List Box"; $gauche_el; 60)
			: (Form:C1466.subTitle=Null:C1517)
				outilsObjectFormMove(0; New collection:C1472("Zone de saisie1"))
				OBJECT SET COORDINATES:C1248(*; "List Box"; $gauche_el; 60)
		End case 
		
		If (Bool:C1537(Form:C1466.noResize)=False:C215)  // Si on ne spécifie pas que l'on ne veut pas de redimensionnement de la fenêtre
			GET WINDOW RECT:C443($gauche_el; $haut_el; $droite_el; $bas_el; Frontmost window:C447)
			FORM GET PROPERTIES:C674("FormListeGenerique"; $largeurForm_el; $hauteurForm_el)
			
			$largeurForm_el:=$largeurForm_el+(285*(Form:C1466.column.length-1))
			$gaucheCalcul_el:=((Screen width:C187(*)/2)-10)-($largeurForm_el/2)
			
			If ($gaucheCalcul_el<0)  // La Fenêtre va être plus large que la largeur de l'écran...
				$gaucheCalcul_el:=20
				$droiteCalcul_el:=Screen width:C187(*)-60
			Else 
				$droiteCalcul_el:=((Screen width:C187(*)/2)-10)+($largeurForm_el/2)
			End if 
			
			SET WINDOW RECT:C444($gaucheCalcul_el; $haut_el; $droiteCalcul_el; $bas_el; Frontmost window:C447; *)
			GET WINDOW RECT:C443($gauche_el; $haut_el; $droite_el; $bas_el; Frontmost window:C447)
			
			If (Form:C1466.title#Null:C1517)
				OBJECT SET COORDINATES:C1248(*; "Zone de saisie"; 55; 20; $droite_el)
			End if 
			
			If (Form:C1466.subTitle#Null:C1517)
				OBJECT SET COORDINATES:C1248(*; "Zone de saisie1"; 25; 60; $droite_el)
			End if 
			
			OBJECT SET COORDINATES:C1248(*; "Rectangle1"; 20; 10; $droite_el)
			
			If (Form:C1466.textButtonValidation#Null:C1517)
				OBJECT SET TITLE:C194(*; "Bouton"; Form:C1466.textButtonValidation)
			End if 
			
			OBJECT SET COORDINATES:C1248(*; "Bouton"; $droite_el-220; 540)
			OBJECT SET COORDINATES:C1248(*; "Rectangle"; $droite_el-220; 540)
			OBJECT SET COORDINATES:C1248(*; "List Box"; 20; Choose:C955(Form:C1466.subTitle#Null:C1517; 120; 20); $droite_el)
		End if 
		
		If (Form:C1466.saveInStorageWindowsRef#Null:C1517)  // Si on souhaite mettre dans le Storage la référence de la fenêtre du formulaire
			
			If (Form:C1466.saveInStorageWindowsRef.property#Null:C1517)
				
				Use (Storage:C1525)
					Storage:C1525[Form:C1466.saveInStorageWindowsRef.property]:=New shared object:C1526
				End use 
				
				Use (Storage:C1525[Form:C1466.saveInStorageWindowsRef.property])
					Storage:C1525[Form:C1466.saveInStorageWindowsRef.property].refWindows:=Current form window:C827
				End use 
				
			End if 
			
		End if 
		
		If (Form:C1466.signal#Null:C1517)  // S'il y a un signal qui est lancé en paramètre il faut dire au reste du programme qu'on peut le libérer
			Form:C1466.signal.trigger()
		End if 
		
End case 