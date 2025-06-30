vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTEMAR; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
vt_TempNOTEMAR:=Insert string:C231(vt_TempNOTEMAR; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210(vt_TempNOTEMAR; vPos2; vPos2)