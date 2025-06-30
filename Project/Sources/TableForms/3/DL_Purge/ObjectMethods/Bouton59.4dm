C_LONGINT:C283($ii; $fiches)

//Script b_115
CONFIRM:C162("Confirmez vous la renumérotation des centre de ce 115  ?")
If (OK=1)
	MESSAGES ON:C181
	vl_ii:=0
	READ WRITE:C146([LesCentres:9])
	READ WRITE:C146([CentresLits:16])
	READ WRITE:C146([HeberGement:5])
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=vl_K_Ctre_SerieD; *)
	QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<=vl_K_Ctre_SerieF)
	MultiSoc_Filter(->[LesCentres:9])
	If (Records in selection:C76([LesCentres:9])>0)
		ALERT:C41("Il existe des centres numérotés de "+String:C10(vl_K_Ctre_SerieD)+" à "+String:C10(vl_K_Ctre_SerieF))
	Else 
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=vl_K_Ctre_SerieAD; *)
		QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<=vl_K_Ctre_SerieAF)
		MultiSoc_Filter(->[LesCentres:9])
		//   TOUT SELECTIONNER([LesCentres])
		$fiches:=Records in selection:C76([LesCentres:9])
		If ($fiches>0)
			
			SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tl_Centres)
			$fiches:=Size of array:C274($tl_Centres)
			i_Message("Renuméroter …")
			
			For ($ii; 1; $fiches)
				i_MessageSeul("Renuméroter  : "+String:C10($ii)+"/"+String:C10($fiches))
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=$tl_Centres{$ii})
				If (Records in selection:C76([LesCentres:9])=1)
					LOAD RECORD:C52([LesCentres:9])
					vl_K_Ctre_SerieNo:=vl_K_Ctre_SerieD+$ii
					QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID:2=$tl_Centres{$ii})
					If (Records in selection:C76([CentresLits:16])>0)
						APPLY TO SELECTION:C70([CentresLits:16]; uut_APP_CtreLit)
					End if 
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=$tl_Centres{$ii})
					If (Records in selection:C76([HeberGement:5])>0)
						APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_LC_ID:61:=vl_K_Ctre_SerieNo)
					End if 
					[LesCentres:9]LC_RéférenceID:1:=vl_K_Ctre_SerieNo
					SAVE RECORD:C53([LesCentres:9])
				End if 
				UNLOAD RECORD:C212([LesCentres:9])
			End for 
			CLOSE WINDOW:C154
		End if 
	End if 
	
	READ WRITE:C146([ReferenceUnique:2])
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(->[LesCentres:9]))
	MultiSoc_Filter(->[ReferenceUnique:2])
	If (Records in selection:C76([ReferenceUnique:2])=1)
		Repeat 
			LOAD RECORD:C52([ReferenceUnique:2])
		Until (Not:C34(Locked:C147([ReferenceUnique:2])))
		[ReferenceUnique:2]RU_Numero:3:=vl_K_Ctre_SerieNo
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
	Else 
		If (Records in selection:C76([ReferenceUnique:2])>1)
			DELETE SELECTION:C66([ReferenceUnique:2])
		End if 
		CREATE RECORD:C68([ReferenceUnique:2])
		[ReferenceUnique:2]RU_Fichier:2:=Table name:C256(->[LesCentres:9])
		[ReferenceUnique:2]RU_Numero:3:=vl_K_Ctre_SerieNo
		[ReferenceUnique:2]RU_ValeurApha:4:=""
		SAVE RECORD:C53([ReferenceUnique:2])
		UNLOAD RECORD:C212([ReferenceUnique:2])
	End if 
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	
	
	UNLOAD RECORD:C212([LesCentres:9])
	UNLOAD RECORD:C212([CentresLits:16])
	UNLOAD RECORD:C212([HeberGement:5])
	
	READ ONLY:C145([LesCentres:9])
	READ ONLY:C145([CentresLits:16])
	READ ONLY:C145([HeberGement:5])
	MESSAGES OFF:C175
	BEEP:C151
	ALERT:C41("C'est fini !")
End if 
