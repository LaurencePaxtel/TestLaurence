If (Form event code:C388=Sur affichage corps:K2:22)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
	MultiSoc_Filter(->[HeberGement:5])
	ve_NbHG:=Records in selection:C76([HeberGement:5])
End if 