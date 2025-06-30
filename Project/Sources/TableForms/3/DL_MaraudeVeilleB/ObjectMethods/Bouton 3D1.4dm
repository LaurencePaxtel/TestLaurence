If (Form event code:C388=Sur clic:K2:4)
	//Script b_VoirPrt
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "'IMPRIMER'")
	Else 
		If (Records in selection:C76([Maraude:24])>0)
			_O_PAGE SETUP:C299([Maraude:24]; "MR_PrtListe")
			PRINT SETTINGS:C106
			If (OK=1)
				vL_NbFiches:=Records in selection:C76([Maraude:24])
				FORM SET OUTPUT:C54([Maraude:24]; "MR_PrtListe")
				PRINT SELECTION:C60([Maraude:24]; *)
			End if 
		Else 
			StrAlerte(23; "")
		End if 
	End if 
End if 