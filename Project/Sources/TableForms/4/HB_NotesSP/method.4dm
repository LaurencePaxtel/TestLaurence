$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (7=8)
			If (User in group:C338(Current user:C182; <>Groupe_SP))
			Else 
				For ($ii; 1; Get last field number:C255(->[HeBerge:4]))
					OBJECT SET ENTERABLE:C238(Field:C253(Table:C252(->[HeBerge:4]); $ii)->; False:C215)
				End for 
			End if 
			
			OBJECT SET ENTERABLE:C238([HeBerge:4]HB_Status:18; (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP)))
		End if 
		
		
		OBJECT SET VISIBLE:C603(*; "Pers_NG@"; User in group:C338(Current user:C182; <>Groupe_DEVELOP))  //29/3/2011
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		CANCEL:C270
End case 

