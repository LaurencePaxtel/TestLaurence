If (Form event code:C388=Sur clic:K2:4)
	If (Macintosh option down:C545 | Windows Alt down:C563)
		If ([HeberGement:5]HG_ReferenceID:1>0)
			vb_RecClé:=True:C214
			OBJECT SET TITLE:C194(b_RecNomClé; "Clé")
			[DiaLogues:3]DL_LibelléN:9:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
			vl_RecCléID:=[HeberGement:5]HG_HB_ID:19
		End if 
	Else 
		If (vb_RecClé)
			vb_RecClé:=False:C215
			OBJECT SET TITLE:C194(b_RecNomClé; "Nom")
		Else 
			vb_RecClé:=True:C214
			OBJECT SET TITLE:C194(b_RecNomClé; "Clé")
			[DiaLogues:3]DL_LibelléN:9:=""
			vl_RecCléID:=0
		End if 
	End if 
	
	// P_HébergementVeilleFind 
End if 