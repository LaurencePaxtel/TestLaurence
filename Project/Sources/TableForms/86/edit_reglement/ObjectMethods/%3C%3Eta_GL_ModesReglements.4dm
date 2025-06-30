C_LONGINT:C283($pos)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If ([Reglements:93]REG_Mode_Reglement:7#"")
			$pos:=Find in array:C230(<>ta_GL_ModesReglements; [Reglements:93]REG_Mode_Reglement:7)
			
			If ($pos>0)
				Self:C308->:=$pos
				Self:C308->{0}:=[Reglements:93]REG_Mode_Reglement:7
			End if 
			
		Else 
			$pos:=Find in array:C230(<>ta_GL_ModesReglements; [HeBerge:4]HB_Mode_Reglement:77)
			
			If ($pos>0)
				Self:C308->:=$pos
				Self:C308->{0}:=[HeBerge:4]HB_Mode_Reglement:77
			End if 
			
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		[Reglements:93]REG_Mode_Reglement:7:=<>ta_GL_ModesReglements{<>ta_GL_ModesReglements}
End case 