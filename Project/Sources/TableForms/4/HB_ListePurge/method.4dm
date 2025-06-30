If (Form event code:C388=Sur affichage corps:K2:22)
	C_LONGINT:C283(ve_NbHG)
	SET QUERY DESTINATION:C396(Vers variable:K19:4; ve_NbHG)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
	MultiSoc_Filter(->[HeberGement:5])
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
End if 