If (Form event code:C388=Sur clic:K2:4)
	ve_RecReservation:=1
	OBJECT SET VISIBLE:C603(*; "CH_RecRes@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecResDer@"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CH_RecResPasDer@"; False:C215)
End if 