//Script b_ModCléHG
If (vb_majWrong) & (vb_majOK) & (vl_NbWrong>0)
	CONFIRM:C162("Confirmez la m à jour n° à n°  vers l'hébérgé : "+va_CléOK)
	If (OK=1)
		READ WRITE:C146([HeberGement:5])
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_majWrong)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_HB_ID:19:=vl_majOK)
		End if 
		READ ONLY:C145([HeberGement:5])
		
		va_LibNo:="Action effectuée !"
		
		BEEP:C151
		BEEP:C151
	Else 
		va_LibNo:="Action annulée !"
	End if 
Else 
	ALERT:C41("Vous devez faire vos recherches !")
End if 