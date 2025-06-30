C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		vd_DateJour:=Current date:C33
		If (Size of array:C274(ta_LesObjets)>4)
			ta_LesObjets:=1
			tl_LesObjets_ID{0}:=tl_LesObjets_ID{ta_LesObjets}
			vl_MachineLe_ID:=tl_LesObjets_ID{ta_LesObjets}
			va_MachineLib:=ta_LesObjets{ta_LesObjets}
			va_MachineLibAbrev:=ta_LesObjetsCourt{ta_LesObjets}
			
		Else 
			ta_LesObjets:=0
			tl_LesObjets_ID{0}:=0
			vl_MachineLe_ID:=0
			va_MachineLib:=""
			va_MachineLibAbrev:=""
		End if 
		If (F_Planning_OB(6; ta_LesObjets))
		End if 
		P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
		
		
		
End case 