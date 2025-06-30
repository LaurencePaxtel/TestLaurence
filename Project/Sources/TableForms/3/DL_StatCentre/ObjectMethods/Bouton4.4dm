If (Form event code:C388=Sur clic:K2:4)
	$vb_OK:=False:C215
	$vd_Date:=!00-00-00!
	If (Size of array:C274(<>tsC_Clé)>0)
		If (<>tsC_Clé>0)
			
			If ((Macintosh option down:C545) | (Windows Alt down:C563))
				$vb_OK:=True:C214
			Else 
				If (<>tsC_DateVérif{<>tsC_Clé}>!00-00-00!)
					ALERT:C41("Il y a déjà une date de vérification le "+String:C10(<>tsC_DateVérif{<>tsC_Clé})+" pour "+<>tsC_Clé{<>tsC_Clé})
				Else 
					If (i_Confirmer("Dater la vérification de la ligne : "+<>tsC_Clé{<>tsC_Clé}+" du "+String:C10(<>tsC_Date{<>tsC_Clé})))
						$vd_Date:=Current date:C33
						$vb_OK:=True:C214
					End if 
				End if 
			End if 
			If ($vb_OK)
				READ WRITE:C146([HeberGement:5])
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=<>tsC_IDID{<>tsC_Clé})
				MultiSoc_Filter(->[HeberGement:5])
				If (Records in selection:C76([HeberGement:5])=1)
					If (i_NonVerrou(->[HeberGement:5]))
						[HeberGement:5]HG_FamVérifiéeLe:137:=$vd_Date
						[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
						
						SAVE RECORD:C53([HeberGement:5])
						UNLOAD RECORD:C212([HeberGement:5])
						<>tsC_DateVérif{<>tsC_Clé}:=$vd_Date
					End if 
				End if 
				UNLOAD RECORD:C212([HeberGement:5])
				READ ONLY:C145([HeberGement:5])
			End if 
			
		End if 
	End if 
End if 