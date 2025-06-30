If (Form event code:C388=Sur double clic:K2:5)
	If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
		If (<>tt_T_CheminsRegionaux>0)
			vt_CheminRepertoire:=<>tt_T_CheminsRegionaux{<>tt_T_CheminsRegionaux}
		Else 
			vt_CheminRepertoire:=""
		End if 
	End if 
End if 
