vPos1:=0
vPos2:=0
$vPosTemp:=0
GET HIGHLIGHT:C209(vt_TempActi; vPos1; vPos2)
$Temp:=""
If (7=8)
	$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
	vt_TempActi:=Insert string:C231(vt_TempActi; $Temp; vPos1)
	vPos2:=vPos1+24+Length:C16(<>va_User)+4
	HIGHLIGHT TEXT:C210(vt_TempActi; vPos2; vPos2)
Else 
	
	
	$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_CR
	$vPosTemp:=Length:C16($Temp)
	vt_TempActi:=Insert string:C231(vt_TempActi; $Temp; vPos1)
	vPos2:=vPos1+$vPosTemp+4
	HIGHLIGHT TEXT:C210(vt_TempActi; vPos2; vPos2)
	
End if 