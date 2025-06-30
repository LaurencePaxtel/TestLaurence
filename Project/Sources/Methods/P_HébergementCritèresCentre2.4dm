//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_HébergementCritèresCentre
//{          Mercredi 1 février 2012 à 18:33:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii; $ij)
C_BOOLEAN:C305($vbOK)

If (Size of array:C274(ta_VeilCentre)>0)
	If (Records in selection:C76([HeberGement:5])>0)
		$ij:=0
		$vbOK:=False:C215
		For ($ii; 1; Size of array:C274(ta_VeilCentre))
			$ij:=$ij+te_VeilCentre{$ii}
		End for 
		If ($ij>0) & ($ij<Size of array:C274(ta_VeilCentre))
			For ($ii; 1; Size of array:C274(ta_VeilCentre))
				If (te_VeilCentre{$ii}=1)
					If ($vbOK)
						QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_LC_ID:61=tl_VeilCentre{$ii}; *)
					Else 
						QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_VeilCentre{$ii}; *)
					End if 
					$vbOK:=True:C214
				End if 
			End for 
			QUERY SELECTION:C341([HeberGement:5])
		End if 
	End if 
End if 