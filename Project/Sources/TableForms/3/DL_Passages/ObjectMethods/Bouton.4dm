var $textToCopy_t : Text
var $i_el : Integer

For ($i_el; 1; Size of array:C274(tl_PasS_Séjour))
	$textToCopy_t:=$textToCopy_t+String:C10(tl_PasS_Séjour{$i_el})+Char:C90(Tabulation:K15:37)+String:C10(td_PasS_Date1{$i_el})+\
		Char:C90(Tabulation:K15:37)+String:C10(td_PasS_Date2{$i_el})+Char:C90(Tabulation:K15:37)+String:C10(tl_PasS_NbNuits{$i_el})+\
		Char:C90(Tabulation:K15:37)+String:C10(tt_PasS_Service{$i_el})
	
	If ($i_el<Size of array:C274(tl_PasS_Séjour))
		$textToCopy_t:=$textToCopy_t+Char:C90(Retour à la ligne:K15:40)
	End if 
	
End for 

SET TEXT TO PASTEBOARD:C523($textToCopy_t)
ALERT:C41("Le contenu du tableau a bien été copié, vous pouvez le coller dans excel ou bloc-note par exemple")