// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 24/09/2020, 22:47:35
// ----------------------------------------------------
// Method: Save_LB_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN)) | (User in group:C338(Current user:C182; "PartageModele"))
			OBJECT SET VISIBLE:C603(*; "B2"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "B2"; False:C215)
		End if 
		
		If (B1=0) & (B2=0)
			B1:=1
		End if 
		
End case 