//%attributes = {}
C_DATE:C307($1)

C_TIME:C306($2)

C_BOOLEAN:C305($vb_OK)
C_DATE:C307($vd_Date)
$vd_Date:=$1
vl_HeureNo:=$2\3600

$vb_OK:=False:C215
Repeat 
	If (va_ws_Heures[[vl_HeureNo]]="1")
		If (vl_HeureLast#vl_HeureNo)
			$vb_OK:=True:C214
		Else 
			If (Num:C11(va_ws_Heures)=1)
				$vb_OK:=True:C214
			Else 
				vl_HeureNo:=vl_HeureNo+1
				If (vl_HeureNo>24)
					vl_HeureNo:=1
					$vd_Date:=Add to date:C393($vd_Date; 0; 0; 1)
					
				End if 
			End if 
		End if 
	Else 
		vl_HeureNo:=vl_HeureNo+1
		If (vl_HeureNo>24)
			vl_HeureNo:=1
			$vd_Date:=Add to date:C393($vd_Date; 0; 0; 1)
		End if 
	End if 
Until ($vb_OK)

va_ws_Message:="Prochains calculs le "+String:C10($vd_Date)+" à "+String:C10(vl_HeureNo)+" H"