//%attributes = {}
If (Length:C16(Substring:C12([HeberGement:5]HG_FicheNuméro:3; 7))=5)
	
	[HeberGement:5]HG_FicheNuméro:3:=Substring:C12([HeberGement:5]HG_FicheNuméro:3; 1; 6)+"0"+Substring:C12([HeberGement:5]HG_FicheNuméro:3; 7)
End if 