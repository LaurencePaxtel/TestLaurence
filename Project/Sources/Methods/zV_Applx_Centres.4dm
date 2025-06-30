//%attributes = {}
If (7=8)
	If ([LesCentres:9]LC_Nom:4[[1]]=" ")
		[LesCentres:9]LC_Nom:4:=Substring:C12([LesCentres:9]LC_Nom:4; 2)
	End if 
End if 
If (7=8)
	ALL RECORDS:C47([HeberGement:5])
	MultiSoc_Filter(->[HeberGement:5])
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Réf)
	If (Size of array:C274(tl_Réf)>0)
		i_Message("Recherche…")
		ARRAY LONGINT:C221(tl_RéfBis; 0)
		SORT ARRAY:C229(tl_Réf; >)
		vl_Réf:=0
		For ($ii; 1; Size of array:C274(tl_Réf))
			i_MessageSeul("Recherche :"+String:C10(Size of array:C274(tl_Réf))+"/"+String:C10($ii))
			If (tl_Réf{$ii}=vl_Réf)
				$jj:=Size of array:C274(tl_RéfBis)+1
				INSERT IN ARRAY:C227(tl_RéfBis; $jj)
				tl_RéfBis{$jj}:=tl_Réf{$ii}
			End if 
			vl_Réf:=tl_Réf{$ii}
		End for 
		
		
		CLOSE WINDOW:C154
	End if 
End if 