// Method hmCal.hmCal  
// 

C_LONGINT:C283($L_Zone; $L_ZoneMini)
$L_Zone:=hm_Get_Zoneref("hmCal")
$L_ZoneMini:=hm_Get_Zoneref("hmCalmini")

C_LONGINT:C283($L_Event)
$L_Event:=hmCal_Get Last Event($L_Zone)
Case of 
	: ($L_Event=Sur clic:K2:4)
		
		$vl_ziel:=0
		$vd_datum:=!00-00-00!
		$vl_zeit:=0
		$vl_userid:=0
		hmCal_GET LAST DESTINATION($L_Zone; $vl_ziel; $vd_datum; $vl_zeit; $vl_userid)
		
		If ($vl_ziel=1)  //Header
			
			If ($vd_datum#!00-00-00!)
				
				hmCal_DELETE ALL SPECIAL DAYS($vl_area)
				hmCal_Add Special Day($vl_area; $vd_datum; -1; -1; -1)
				
				hmCal_mini_SET DATE($vl_miniarea; $vd_datum)
				
			End if 
			
		End if 
		
	: ($L_Event=Sur double clic:K2:5)
		
End case 


