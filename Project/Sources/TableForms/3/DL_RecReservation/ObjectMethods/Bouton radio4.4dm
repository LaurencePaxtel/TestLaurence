If (Form event code:C388=Sur clic:K2:4)
	ve_RecReservation:=3
	OBJECT SET VISIBLE:C603(*; "CH_RecRes@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecResDer@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecRes1"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecRes2"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecResPasDer@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecRes3"; True:C214)
	OBJECT SET VISIBLE:C603(*; "CH_RecRes4"; True:C214)
End if 