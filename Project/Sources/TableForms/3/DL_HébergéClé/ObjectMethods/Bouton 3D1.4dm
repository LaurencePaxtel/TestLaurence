//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          script : b_ValET dans [DiaLogues];"DL_HébergéClér"
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur clic:K2:4)
	
	C_TEXT:C284($T_DummyTelephone)
	$T_DummyTelephone:=""
	
	If (Is new record:C668([HeberGement:5]))
		
		If (Substring:C12(va_IDT_Nom; 1; 2)="X0")
			x_IDTG_1:=rIDTG_1
			x_IDTG_2:=rIDTG_2
			Case of 
				: ((Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)="P") & (ve_IDT_Age>=18))
					StrAlerte(35; "")
				: ((Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)#"P") & (ve_IDT_Age<18))
					StrAlerte(34; "")
				Else 
					If ([HeberGement:5]HG_HB_ID:19>0)
						
					Else 
						P_HébergéCréer(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe; ->$T_DummyTelephone)
					End if 
			End case 
		Else 
			
			Case of 
				: (va_IDT_Nom<="")
					StrAlerte(31; "")
				: (va_IDT_Pré="")
					StrAlerte(32; "")
				: (vd_IDT_NéLe=!00-00-00!)
					StrAlerte(33; "")
				: ((Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)#"P") & (ve_IDT_Age<18))
					StrAlerte(34; "")
				Else 
					If (Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)="P") & (ve_IDT_Age>=18)
						StrAlerte(35; "")
					Else 
						x_IDTG_1:=rIDTG_1
						x_IDTG_2:=rIDTG_2
						If ([HeberGement:5]HG_HB_ID:19>0)
							
						Else 
							P_HébergéCréer(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe; ->$T_DummyTelephone)
						End if 
					End if 
			End case 
		End if 
	End if 
End if 