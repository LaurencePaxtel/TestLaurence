//Script b_MajRésaFin
CONFIRM:C162("Confirmez vous la mise à jour des dates de fin de réservation ?")
If (OK=1)
	MESSAGES ON:C181
	
	If (7=8)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Réservation:91=True:C214; *)
		QUERY:C277([HeberGement:5];  & [HeberGement:5]HG_RéservationDateFin:134=!00-00-00!)
	End if 
	ALL RECORDS:C47([HeberGement:5])  //10/01/2050
	MultiSoc_Filter(->[HeberGement:5])
	
	If (Records in selection:C76([HeberGement:5])>0)
		
		READ WRITE:C146([HeberGement:5])
		APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàJRésaDateFin)
		READ ONLY:C145([HeberGement:5])
	End if 
	MESSAGES OFF:C175
	BEEP:C151
End if 
