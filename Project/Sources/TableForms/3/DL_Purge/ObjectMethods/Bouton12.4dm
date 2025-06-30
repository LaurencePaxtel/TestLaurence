//Script b_MajRésaFin
CONFIRM:C162("Confirmez vous la mise à jour du niveau (1) des (dispos) centres ?")
If (OK=1)
	MESSAGES ON:C181
	READ WRITE:C146([CentresLits:16])
	ALL RECORDS:C47([CentresLits:16])
	MultiSoc_Filter(->[CentresLits:16])
	If (7=8)
		ALL RECORDS:C47([LesCentres:9])
		MultiSoc_Filter(->[LesCentres:9])
		SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_ID; [LesCentres:9]LC_Niveau:52; $tl_Niveau)
		If (Size of array:C274($tl_ID)>0)
			For ($ii; 1; Size of array:C274($tl_ID))
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID:2=$tl_ID{$ii})
				If (Records in selection:C76([CentresLits:16])>0)
					APPLY TO SELECTION:C70([CentresLits:16]; [CentresLits:16]CL_Niveau:17:=$tl_Niveau{$ii})
				End if 
			End for 
		End if 
	End if 
	
	APPLY TO SELECTION:C70([CentresLits:16]; [CentresLits:16]CL_Niveau:17:=1)
	
	UNLOAD RECORD:C212([CentresLits:16])  //vielle habitude peut-être bien que c'est inutile
	READ ONLY:C145([CentresLits:16])
	
	READ WRITE:C146([LesCentres:9])
	ALL RECORDS:C47([LesCentres:9])
	MultiSoc_Filter(->[LesCentres:9])
	APPLY TO SELECTION:C70([LesCentres:9]; [LesCentres:9]LC_Niveau:52:=1)
	UNLOAD RECORD:C212([LesCentres:9])  //vielle habitude peut-être bien que c'est inutile
	READ ONLY:C145([LesCentres:9])
	
	MESSAGES OFF:C175
	BEEP:C151
End if 
