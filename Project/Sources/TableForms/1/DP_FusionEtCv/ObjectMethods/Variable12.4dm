ALERT:C41("Fonction inactivée !")
If (7=8)
	If (Records in selection:C76([HeberGement:5])>0)
		
		If (vl_NbItems=vl_NbEtCv)
			If (i_Confirmer("Confirmez-vous la fusion des états civils"))
				READ WRITE:C146([HeberGement:5])
				APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàJFusionEtCv)
				READ ONLY:C145([HeberGement:5])
				REDRAW:C174([HeberGement:5])
			End if 
		Else 
			ALERT:C41("Vous n'avez pas fini la correspondance de tous les items !!!")
		End if 
	Else 
		StrAlerte(1; "")
	End if 
End if 



