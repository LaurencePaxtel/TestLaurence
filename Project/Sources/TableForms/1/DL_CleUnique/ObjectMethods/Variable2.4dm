
If (Form event code:C388=Sur données modifiées:K2:15)
	vd_IDT_NéLe:=Uut_HébergéNéle(->ve_IDT_PCAge)
	
	ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
End if 