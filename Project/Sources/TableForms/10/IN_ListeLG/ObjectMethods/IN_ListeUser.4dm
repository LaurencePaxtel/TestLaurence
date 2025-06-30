If (Records in selection:C76([INtervenants:10])>0)
	If (i_Confirmer("Création des utilisateurs dans la liste Utilisateur des privilèges."))
		READ WRITE:C146([INtervenants:10])
		FIRST RECORD:C50([INtervenants:10])
		ARRAY LONGINT:C221(tl_UserGroupe; 0)
		$Position:=0
		gError:=0
		$ii:=0
		$ij:=Records in selection:C76([INtervenants:10])
		i_Message("Mise à jour de la liste utilisateurs …")
		Repeat 
			$ii:=$ii+1
			i_MessageSeul("Mise à jour de la liste utilisateurs  : "+String:C10($ij)+" / "+String:C10($ii))
			LOAD RECORD:C52([INtervenants:10])
			If ([INtervenants:10]IN_Login:3>"")
				$Position:=Find in array:C230(ta_UserLog; [INtervenants:10]IN_Login:3)
				If ($Position>0)
				Else 
					gError:=0
					ON ERR CALL:C155("i_Error")
					$Position:=0
					$Position:=Set user properties:C612(-2; [INtervenants:10]IN_Login:3; ""; *; 0; Current date:C33; tl_UserGroupe)
					If ($Position<-10)
						$ii:=Size of array:C274(ta_UserLog)+1
						INSERT IN ARRAY:C227(ta_UserLog; $ii; 1)
						INSERT IN ARRAY:C227(tl_UserNo; $ii; 1)
						ta_UserLog{$ii}:=[INtervenants:10]IN_Login:3
						tl_UserNo{$ii}:=$Position
						[INtervenants:10]IN_RéfUser:11:=$Position
						SAVE RECORD:C53([INtervenants:10])
					Else 
					End if 
					ON ERR CALL:C155("")
				End if 
			End if 
			UNLOAD RECORD:C212([INtervenants:10])
			NEXT RECORD:C51([INtervenants:10])
		Until (End selection:C36([INtervenants:10]))
		If (Size of array:C274(ta_UserLog)>0)
			SORT ARRAY:C229(ta_UserLog; tl_UserNo; >)
		End if 
		CLOSE WINDOW:C154
		UNLOAD RECORD:C212([INtervenants:10])
		READ ONLY:C145([INtervenants:10])
	End if 
End if 