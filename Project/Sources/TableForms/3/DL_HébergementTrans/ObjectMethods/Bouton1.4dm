//Script b_DSOui
If (Records in selection:C76([HeberGement:5])>0)
	If (i_Confirmer("Remise à zéro de l'heure d'envoi ."))
		READ WRITE:C146([HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; P_Transfert_Raz)
		READ ONLY:C145([HeberGement:5])
	End if 
End if 

