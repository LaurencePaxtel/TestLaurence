C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
$vb_OK:=(Records in table:C83([INtervenants:10])>0)
If ($vb_OK)
	//La liste des utilisateurs référ
	ARRAY LONGINT:C221(tl_UserNo; 0)
	ARRAY TEXT:C222(ta_UserLog; 0)
	GET USER LIST:C609(ta_UserLog; tl_UserNo)
	If (Size of array:C274(ta_UserLog)>0)
		$ii:=0
		Repeat 
			$ii:=$ii+1
			If (tl_UserNo{$ii}>=-10)  //-11 à -15010
				DELETE FROM ARRAY:C228(ta_UserLog; $ii; 1)
				DELETE FROM ARRAY:C228(tl_UserNo; $ii; 1)
				$ii:=$ii-1
			End if 
		Until ($ii=Size of array:C274(ta_UserLog))
		SORT ARRAY:C229(ta_UserLog; tl_UserNo; >)
	End if 
	
	$vb_OK:=(Size of array:C274(ta_UserLog)>0)
	If ($vb_OK)
		
	Else 
		ALERT:C41("Acune fiche utilisateur dans la table des privilèges.")
	End if 
	CONFIRM:C162("Confirmez-vous la synchronisation des références"+" utilisateurs dans la table des utilisateurs ?")
	If (OK=1)
		MESSAGES ON:C181
		READ WRITE:C146([INtervenants:10])
		
		For ($ii; 1; Size of array:C274(ta_UserLog))
			QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Login:3=ta_UserLog{$ii})
			If (Records in selection:C76([INtervenants:10])>0)
				Repeat 
					LOAD RECORD:C52([INtervenants:10])
				Until (Not:C34(Locked:C147([INtervenants:10])))
				[INtervenants:10]IN_RéfUser:11:=tl_UserNo{$ii}
				SAVE RECORD:C53([INtervenants:10])
				UNLOAD RECORD:C212([INtervenants:10])
			End if 
		End for 
		UNLOAD RECORD:C212([INtervenants:10])
		READ ONLY:C145([INtervenants:10])
		
		MESSAGES OFF:C175
		BEEP:C151
	End if 
	
Else 
	ALERT:C41("Acune fiche utilisateur dans la base.")
End if 