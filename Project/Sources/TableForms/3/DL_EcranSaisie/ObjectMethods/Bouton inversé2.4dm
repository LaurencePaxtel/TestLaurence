If (Size of array:C274(<>te_RubOrdre)>0)
	If (i_Confirmer("Numéroter de 1 à "+String:C10(Size of array:C274(<>te_RubOrdre))))
		For ($ii; 1; Size of array:C274(<>te_RubOrdre))
			<>te_RubOrdre{$ii}:=$ii
		End for 
	End if 
End if 