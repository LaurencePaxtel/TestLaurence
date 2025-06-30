If (Form event code:C388=Sur chargement:K2:1)
	If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		OBJECT SET VISIBLE:C603(*; "Bt_STRAdd"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Bt_STRSup"; True:C214)
		OBJECT SET ENTERABLE:C238(vl_STRrang; True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*; "Bt_STRAdd"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Bt_STRSup"; False:C215)
		OBJECT SET ENTERABLE:C238(vl_STRrang; False:C215)
	End if 
End if 