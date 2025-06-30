//Script b_115
$vb_OK:=False:C215
If (vd_DtDéb6>!00-00-00!)
	If (vd_DtDéb6<=vd_DtFin6)
		$vb_OK:=True:C214
	End if 
End if 
If ($vb_OK)
	CONFIRM:C162("Confirmez vous la renumérotation à 6 chiffres du n° d' hébergement  ?")
	If (OK=1)
		MESSAGES ON:C181
		READ WRITE:C146([HeberGement:5])
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_DtDéb6; *)
		QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_Date:4<=vd_DtFin6)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			APPLY TO SELECTION:C70([HeberGement:5]; wUut_Màj6ChHébergement)
		Else 
			ALERT:C41("Aucune fiche trouvée !")
		End if 
		READ ONLY:C145([HeberGement:5])
		MESSAGES OFF:C175
	End if 
Else 
	ALERT:C41("Veuillez vérifier vos dates !")
End if 