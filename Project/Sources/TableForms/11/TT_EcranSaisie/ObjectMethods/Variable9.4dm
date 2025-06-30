If (OK=1)
	CONFIRM:C162("Supprimer la fiche : "+Substring:C12([TypesTables:11]TT_Libellé:4; 1; 15)+"…"+Char:C90(13)+"Etes-vous certain ?")
	
	If (OK=1)
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=[TypesTables:11]TT_RéférenceID:1)
		MultiSoc_Filter(->[TAbles:12])
		
		If (Records in selection:C76([TAbles:12])>0)
			DELETE SELECTION:C66([TAbles:12])
		End if 
		
	End if 
	
End if 