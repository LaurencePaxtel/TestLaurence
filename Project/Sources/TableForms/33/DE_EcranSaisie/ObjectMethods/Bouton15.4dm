vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempObs; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
vt_TempObs:=Insert string:C231(vt_TempObs; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210(vt_TempObs; vPos2; vPos2)