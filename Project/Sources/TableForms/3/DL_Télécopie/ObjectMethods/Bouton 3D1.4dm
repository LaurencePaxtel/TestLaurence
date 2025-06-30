//Script b_DSOui
If ([HeberGement:5]HG_ReferenceID:1>0)
	READ WRITE:C146([HeberGement:5])
	If (i_NonVerrou(->[HeberGement:5]))
		[HeberGement:5]HG_DispoSpé:90:=True:C214
		[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
		
		SAVE RECORD:C53([HeberGement:5])
		UNLOAD RECORD:C212([HeberGement:5])
	End if 
	READ ONLY:C145([HeberGement:5])
	REDRAW:C174([HeberGement:5])
Else 
	StrAlerte(22; "")
End if 