If (Form event code:C388=Sur clic:K2:4)
	vd_RecAge:=Current date:C33
	vd_RecAgeFin:=Add to date:C393(vd_RecAge; -ve_RecAgeDebut; 0; 0)
	vd_RecAgeDebut:=Add to date:C393(vd_RecAge; -ve_RecAgeFin; 0; 0)
End if 
