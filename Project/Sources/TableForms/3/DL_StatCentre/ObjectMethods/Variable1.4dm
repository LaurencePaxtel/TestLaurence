If (Form event code:C388=Sur clic:K2:4)
	P_taPageBt(ta_Page; 1)
	If (ta_Page=2)
		OBJECT SET ENTERABLE:C238(vd_Date1; True:C214)
		OBJECT SET ENTERABLE:C238(vd_Date2; True:C214)
	End if 
End if 