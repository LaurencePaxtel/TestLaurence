If (Form event code:C388=Sur impression corps:K2:18)
	vl_IndiceLg:=vl_IndiceLg+1
	va_Dist:=ta_xfaxDis{vl_IndiceLg}
	vl_NbT:=tl_xfaxDisT{vl_IndiceLg}
	$Pos:=vl_Indice
	vl_Nb1:=te_xfaxDis{vl_IndiceLg}{$Pos}
	$Pos:=vl_Indice+1
	If ($Pos<=v_NbPers)
		vl_Nb2:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb2:=0
	End if 
	$Pos:=vl_Indice+2
	If ($Pos<=v_NbPers)
		vl_Nb3:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb3:=0
	End if 
	$Pos:=vl_Indice+3
	If ($Pos<=v_NbPers)
		vl_Nb4:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb4:=0
	End if 
	$Pos:=vl_Indice+4
	If ($Pos<=v_NbPers)
		vl_Nb5:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb5:=0
	End if 
	$Pos:=vl_Indice+5
	If ($Pos<=v_NbPers)
		vl_Nb6:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb6:=0
	End if 
	$Pos:=vl_Indice+6
	If ($Pos<=v_NbPers)
		vl_Nb7:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb7:=0
	End if 
	$Pos:=vl_Indice+7
	If ($Pos<=v_NbPers)
		vl_Nb8:=te_xfaxDis{vl_IndiceLg}{$Pos}
	Else 
		vl_Nb8:=0
	End if 
	
	
End if 