$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur impression corps:K2:18)
		ve_Hsex:=Num:C11([HeBerge:4]HG_Genre:39=True:C214)
		$Pos:=Find in array:C230(tl_HBréfID; [HeBerge:4]HB_ReferenceID:1)
		If ($Pos>0)
			vl_HNb:=tl_HBNbMar{$Pos}
		Else 
			vl_HNb:=0
		End if 
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 
