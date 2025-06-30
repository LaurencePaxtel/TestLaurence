Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (([Structures:79]Ref_Structure:3#"TMP") & ([Structures:79]STRC_Societe_ID:6#0))
			OBJECT SET ENTERABLE:C238(Self:C308->; False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(Self:C308->; True:C214)
		End if 
End case 
