//Script 

CONFIRM:C162("Recomposer le n° SIAO."+Char:C90(13)+"Confirmez-vous la recomposition ?")
If (OK=1)
	i_Message("SIAO : recomposition en cours")
	READ WRITE:C146([SIAO:50])
	ALL RECORDS:C47([SIAO:50])
	
	APPLY TO SELECTION:C70([SIAO:50]; wUut_SiaoNo)
	
	
	READ ONLY:C145([SIAO:50])
	CLOSE WINDOW:C154
End if 