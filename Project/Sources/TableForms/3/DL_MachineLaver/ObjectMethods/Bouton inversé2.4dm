If (vd_DateJour>!00-00-00!)
	vd_DateJour:=Add to date:C393(vd_DateJour; 0; 0; 7)
Else 
	vd_DateJour:=Current date:C33
End if 

P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
