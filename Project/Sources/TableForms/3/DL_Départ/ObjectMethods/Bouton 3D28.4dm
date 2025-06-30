If (7=8)
	If (User in group:C338(Current user:C182; <>Groupe_MajEnum))
		If (i_Confirmer("Mise à jour des énumérations ?"))
			Go_uMàJEnum
		End if 
	End if 
Else 
	If (Size of array:C274(<>ta_UserPlateforme)>0)
		Tab_PopIn1("Plateforme"; -><>ta_UserPlateforme; -><>va_UserPlateforme)
		<>Va_CentreCtrl:=<>va_UserPlateforme
		ALERT:C41("Votre acces plateforme est : "+<>va_UserPlateforme)
	Else 
		ALERT:C41("Votre acces plateforme est unique : "+<>va_UserPlateforme)
	End if 
End if 

