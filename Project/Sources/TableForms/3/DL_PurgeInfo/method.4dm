If (Form event code:C388=Sur chargement:K2:1)
	ta_InfoNom:=0
	vt_InfoTEXTE:=""
	If (Size of array:C274(ta_InfoNom)>0)
		ta_InfoNom:=1
		$ii:=Num:C11(Substring:C12(ta_InfoNom{ta_InfoNom}; 1; 5))
		vt_InfoTEXTE:=xliff_Get_text_resource($ii)
	End if 
	REDRAW:C174(vt_InfoTEXTE)
End if 