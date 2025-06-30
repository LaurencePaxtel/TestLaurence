//Script b_VoirPrt
If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "Imprimer")
	Else 
		_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtVeilleNR")
		PRINT SETTINGS:C106
		If (OK=1)
			CREATE SET:C116([HeberGement:5]; "$LePerma")
			USE SET:C118("$LePerma")
			DISTINCT VALUES:C339([HeberGement:5]HG_Permanencier:9; $ta_LesPerma)
			If (Size of array:C274($ta_LesPerma)>0)
				SORT ARRAY:C229($ta_LesPerma; >)
				For ($ii; 1; Size of array:C274($ta_LesPerma))
					USE SET:C118("$LePerma")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Permanencier:9=$ta_LesPerma{$ii})
					If (Records in selection:C76([HeberGement:5])>0)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
						ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
						
						va_NrPerma:=$ta_LesPerma{$ii}
						FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtVeilleNR")
						PRINT SELECTION:C60([HeberGement:5]; *)
					End if 
				End for 
			End if 
			USE SET:C118("$LePerma")
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
		End if 
	End if 
End if 