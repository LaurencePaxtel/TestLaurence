//Script b_EtatHB
If (Form event code:C388=Sur clic:K2:4)
	If (Read only state:C362([HeberGement:5]))
		READ WRITE:C146([HeberGement:5])
		OBJECT SET TITLE:C194(b_EtatHB; "Lecture seulement")
	Else 
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
		OBJECT SET TITLE:C194(b_EtatHB; "Lecture écriture")
		
	End if 
End if 

