//%attributes = {}
P_EtatCivil("Sexe_HG_Genre"; [HeberGement:5]HG_EtatCivil:20)

RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)
If (Records in selection:C76([HeBerge:4])=1)
	[HeBerge:4]HG_Genre:39:=[HeberGement:5]HG_Genre:96
End if 