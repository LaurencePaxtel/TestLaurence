C_TEXT:C284(vt_Dooo)
If (Size of array:C274(<>ta_ConsoB_Document)>0)
	
	vt_Dooo:=Substring:C12(vt_DossierChemin; 1; Length:C16(vt_DossierChemin)-1)+"2:"
	
	
	For ($ii; 1; Size of array:C274(<>ta_ConsoB_Document))
		
		COPY DOCUMENT:C541(vt_DossierChemin+<>ta_ConsoB_Document{$ii}; vt_Dooo+Replace string:C233(<>ta_ConsoB_Document{$ii}; "LU."; "."))
		
	End for 
	
End if 