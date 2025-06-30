If (Form event code:C388=Sur clic:K2:4)
	C_LONGINT:C283(v_hebergement_id)
	$vb_OK:=False:C215
	$vaUn:=""
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=v_hebergement_id)
	
	If (8=8)
		If ([HeberGement:5]HG_ReferenceID:1>0)
			P_HG_Localisation
		Else 
			StrAlerte(8; "")
		End if 
		
		
	Else 
		If ([HeberGement:5]HG_ReferenceID:1>0)
			$vaUn:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))
			
			//Permanencier
			$vb_OK:=False:C215
			If (Size of array:C274(<>ta_InPerm)>0)
				For ($ii; 1; Size of array:C274(<>ta_InPerm))
					If (<>ta_InPerm{$ii}=[HeberGement:5]HG_Permanencier:9)
						$vb_OK:=True:C214
					End if 
				End for 
			End if 
			
			If (<>vb_UserLOFT)
				If ($vaUn="N") & ($vb_OK)
					Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "R"; [HeberGement:5]HG_FicheNuméro:3)
					vb_Show:=False:C215
					CANCEL:C270
					POST OUTSIDE CALL:C329(<>PR_Genéral)
					
				Else 
					StrAlerte(27; "")
				End if 
			Else 
				Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "R"; [HeberGement:5]HG_FicheNuméro:3)
				vb_Show:=False:C215
				CANCEL:C270
				POST OUTSIDE CALL:C329(<>PR_Genéral)
			End if 
		Else 
			StrAlerte(8; "")
		End if 
	End if 
End if 
