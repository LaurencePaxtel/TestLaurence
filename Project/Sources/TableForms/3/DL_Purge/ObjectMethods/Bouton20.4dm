//SCripte b_NumFnoU

CONFIRM:C162("Confirmez vous vérifier et réparer les fiche de paramètres  ?")
If (OK=1)
	CONFIRM:C162("Vérifiez que personne n'est connecté  ?")
	If (OK=1)
		$ii:=0
		$jj:=0
		
		i_Message("Vérifier et réparer les fiche de paramètres …")
		
		Repeat 
			$ii:=$ii-1
			$jj:=$jj+1
			
			i_MessageSeul("Vérifier et réparer les fiche de paramètres : "+String:C10($jj)+" / 50")
			QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$ii)
			If (Records in selection:C76([DePart:1])>1)
				READ WRITE:C146([DePart:1])
				DELETE SELECTION:C66([DePart:1])
				READ ONLY:C145([DePart:1])
			End if 
		Until ($ii=-50)
		CLOSE WINDOW:C154
	End if 
End if 

