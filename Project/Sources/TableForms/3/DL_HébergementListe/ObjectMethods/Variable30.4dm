//Script b_VoirPrt
If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "Imprimer")
	Else 
		_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtVeille")
		PRINT SETTINGS:C106
		If (OK=1)
			vL_NbFiches:=Records in selection:C76([HeberGement:5])
			FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtExcusé")
			PRINT SELECTION:C60([HeberGement:5]; *)
		End if 
	End if 
End if 