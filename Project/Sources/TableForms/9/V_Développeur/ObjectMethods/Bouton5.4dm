
If (Form event code:C388=Sur clic:K2:4)
	If (vb_OK)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		OBJECT SET TITLE:C194(b_Lien; "Liens automatiques")
		vb_OK:=False:C215
	Else 
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		OBJECT SET TITLE:C194(b_Lien; "Liens manuels")
		vb_OK:=True:C214
	End if 
	REDRAW WINDOW:C456
End if 