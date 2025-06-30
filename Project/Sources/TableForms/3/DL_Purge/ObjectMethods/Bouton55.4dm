//Script 

C_LONGINT:C283($ii)
$ii:=Records in table:C83([LesCentres:9])
If ($ii>0)
	CONFIRM:C162("Il y a "+String:C10($ii)+" Centres."+Char:C90(13)+"Confirmez-vous la suppression ?")
	If (OK=1)
		MESSAGES ON:C181
		
		READ WRITE:C146([CentresLits:16])
		ALL RECORDS:C47([CentresLits:16])
		MultiSoc_Filter(->[CentresLits:16])
		DELETE SELECTION:C66([CentresLits:16])
		UNLOAD RECORD:C212([CentresLits:16])
		READ ONLY:C145([CentresLits:16])
		
		
		READ WRITE:C146([LesCentres:9])
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		DELETE SELECTION:C66([LesCentres:9])
		UNLOAD RECORD:C212([LesCentres:9])
		READ ONLY:C145([LesCentres:9])
		
		MESSAGES OFF:C175
		BEEP:C151
	End if 
Else 
	BEEP:C151
End if 