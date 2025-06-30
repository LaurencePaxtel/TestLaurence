//Script b_VoirNotes
If ([HeberGement:5]HG_ReferenceID:1>0)
	
	P_HébergementTextes("TF"; -><>PR_HBTexteF; -1; "Texte fax")
	
Else 
	StrAlerte(22; "")
End if 