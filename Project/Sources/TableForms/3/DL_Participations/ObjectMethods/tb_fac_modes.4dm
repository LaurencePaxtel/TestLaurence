// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 01/07/2020, 13:17:22
// ----------------------------------------------------
// Method: [HeBerge].HB_Notes_VFF.<>ta_GL_ModesReglements1
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($pos)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(tb_fac_modes; 0)
		
		APPEND TO ARRAY:C911(tb_fac_modes; "Prestations")
		APPEND TO ARRAY:C911(tb_fac_modes; "Participations")
		
		OBJECT SET ENTERABLE:C238(*; "tb_fac_modes"; False:C215)
		
		READ WRITE:C146([HeBerge:4])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=PAR_HB_ReferenceID)
		MultiSoc_Filter(->[HeBerge:4])
		
		If ([HeBerge:4]HB_FAC_Mode_Facturation:80#"")
			$pos:=Find in array:C230(tb_fac_modes; [HeBerge:4]HB_FAC_Mode_Facturation:80)
			
			If ($pos>0)
				Self:C308->:=$pos
				Self:C308->{0}:=[HeBerge:4]HB_FAC_Mode_Facturation:80
			End if 
			
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		[HeBerge:4]HB_FAC_Mode_Facturation:80:=tb_fac_modes{0}
End case 