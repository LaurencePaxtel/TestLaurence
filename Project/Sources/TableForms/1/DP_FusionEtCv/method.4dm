
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vd_Item1:=!00-00-00!
		vd_Item2:=!00-00-00!
		
		vl_itemNb:=0
		If (Application type:C494=4D mode local:K5:1)
			OBJECT SET ENABLED:C1123(b_ModTout; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_ModTout; False:C215)
		End if 
End case 