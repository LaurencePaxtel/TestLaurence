Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		ARRAY TEXT:C222(Var_Tables; 0)
		ARRAY INTEGER:C220(Var_Tables_Num; 0)
		
		
		C_POINTER:C301($table)
		
		For (vCounter; 1; Get last table number:C254)
			
			$table:=Table:C252(vCounter)
			
			
			APPEND TO ARRAY:C911(Var_Tables; Table name:C256($table))
			APPEND TO ARRAY:C911(Var_Tables_Num; vCounter)
			
			ARRAY TEXT:C222(Var_Forms; 0)
			FORM GET NAMES:C1167($table->; Var_Forms)
			
			For (i; 1; Size of array:C274(Var_Forms))
				
				APPEND TO ARRAY:C911(Var_Forms; Var_Forms{i})
				
			End for 
		End for 
		
		If ([NAV_Sous_Menus:78]NS_Menu_Table:8#0)
			$pos:=Find in array:C230(Var_Tables_Num; [NAV_Sous_Menus:78]NS_Menu_Table:8)
			Var_Tables{Var_Tables}:=Var_Tables{$pos}
			Var_Forms{Var_Forms}:=[NAV_Sous_Menus:78]NS_Menu_Formulaire:5
		End if 
		
		
		
		
	: (Form event code:C388=Sur clic:K2:4)
		
		//$table:=Var_Tables{Var_Tables}
		
		$pos:=Find in array:C230(Var_Tables; Var_Tables{Var_Tables})
		$table:=Table:C252(Var_Tables_Num{$pos})
		
		[NAV_Sous_Menus:78]NS_Menu_Table:8:=$pos
		
		ARRAY TEXT:C222(Var_Forms; 0)
		FORM GET NAMES:C1167($table->; Var_Forms)
		
		For (i; 1; Size of array:C274(Var_Forms))
			
			APPEND TO ARRAY:C911(Var_Forms; Var_Forms{i})
			
		End for 
		
End case 
