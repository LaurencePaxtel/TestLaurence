
C_LONGINT:C283($pos)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		OBJECT SET ENTERABLE:C238(*; "<>ta_GL_ModesReglements"; False:C215)
		
		If ([HeBerge:4]HB_Mode_Reglement:77#"")
			
			$pos:=Find in array:C230(<>ta_GL_ModesReglements; [HeBerge:4]HB_Mode_Reglement:77)
			
			If ($pos>0)
				Self:C308->:=$pos
				Self:C308->{0}:=[HeBerge:4]HB_Mode_Reglement:77
			End if 
			
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		[HeBerge:4]HB_Mode_Reglement:77:=<>ta_GL_ModesReglements{<>ta_GL_ModesReglements}
		
		
End case 