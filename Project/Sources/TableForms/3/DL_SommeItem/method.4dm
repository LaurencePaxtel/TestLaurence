If (Form event code:C388=Sur double clic:K2:5)
	If (FORM Get current page:C276=1)
		If ([Sommes:48]SM_RéférenceID:1>0)
			If (<>PR_HébergementVeille#0)
				<>va_TransVeille_Message:="Somme"
				<>va_TransVeille_Item:=va_ValeurItem
				<>va_TransVeille_Valeur:=[Sommes:48]SM_libellé:5
				<>vd_TransVeille_Date:=vd_Date1
				POST OUTSIDE CALL:C329(<>PR_HébergementVeille)
			End if 
		End if 
	End if 
End if 

