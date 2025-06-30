If (Form event code:C388=Sur clic:K2:4)
	If (Size of array:C274(ta_IndexChamp)>0)
		$jj:=0
		For ($ii; 1; Size of array:C274(ta_IndexChamp))
			$jj:=$jj+te_IndexCheck{$ii}
		End for 
		If ($jj>0)
			MESSAGES ON:C181
			i_Message("Action en cours…")
			For ($ii; 1; Size of array:C274(ta_IndexChamp))
				If (te_IndexCheck{$ii}>0)
					tb_IndexIndexé{$ii}:=Not:C34(tb_IndexIndexé{$ii})
					te_IndexIndexé{$ii}:=Num:C11(tb_IndexIndexé{$ii}=True:C214)
					SET INDEX:C344(Field:C253(te_IndexFichier{$ii}; te_IndexChamp{$ii})->; tb_IndexIndexé{$ii})
				End if 
			End for 
			
			CLOSE WINDOW:C154
			MESSAGES OFF:C175
		Else 
			ALERT:C41("Aucun champ n'est sélectionné !")
		End if 
	End if 
End if 