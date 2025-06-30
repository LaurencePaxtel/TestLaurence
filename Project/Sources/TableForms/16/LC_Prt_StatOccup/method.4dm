
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur impression corps:K2:18)
		vPos:=Find in array:C230(tl_CL_Centre; [LesCentres:9]LC_RéférenceID:1)
		If (vPos>0)
			vl_LC_i1:=tl_CL_Capacité{vPos}
			vl_LC_i2:=tl_CL_CapacitéCtr{vPos}
			vl_LC_i3:=tl_CL_Capacité115{vPos}
			vl_LC_i4:=tl_CL_VSM{vPos}
			vl_LC_i5:=tl_CL_CtreNb{vPos}
			vl_LC_i6:=tl_CL_CtreNew{vPos}
			vl_LC_i7:=tl_CL_CtrFam{vPos}
			vl_LC_i8:=tl_CL_CtreAdulte{vPos}
			vl_LC_i9:=tl_CL_CtreEnfant{vPos}
			vl_LC_iNom:=ta_CL_CtreNom{vPos}
		Else 
			vl_LC_i1:=0
			vl_LC_i2:=0
			vl_LC_i3:=0
			vl_LC_i4:=0
			vl_LC_i5:=0
			vl_LC_i6:=0
			vl_LC_i7:=0
			vl_LC_i8:=0
			vl_LC_i9:=0
			vl_LC_iNom:=""
		End if 
	: ($vl_Event=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 