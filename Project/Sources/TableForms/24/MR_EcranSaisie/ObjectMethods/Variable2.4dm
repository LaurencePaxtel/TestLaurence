If (Form event code:C388=Sur clic:K2:4)
	If (ta_Page=1)
		OBJECT SET ENABLED:C1123(rJourNuit1; True:C214)
		OBJECT SET ENABLED:C1123(rJourNuit2; True:C214)
		OBJECT SET ENABLED:C1123(rReport; True:C214)
		OBJECT SET ENTERABLE:C238(vd_Date1; True:C214)
		OBJECT SET ENTERABLE:C238(vd_Date2; True:C214)
		OBJECT SET VISIBLE:C603(*; "@Bt_b_Calc"; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(rJourNuit1; False:C215)
		OBJECT SET ENABLED:C1123(rJourNuit2; False:C215)
		OBJECT SET ENABLED:C1123(rReport; False:C215)
		OBJECT SET ENTERABLE:C238(vd_Date1; False:C215)
		OBJECT SET ENTERABLE:C238(vd_Date2; False:C215)
		OBJECT SET VISIBLE:C603(*; "@Bt_b_Calc"; False:C215)
	End if 
End if 