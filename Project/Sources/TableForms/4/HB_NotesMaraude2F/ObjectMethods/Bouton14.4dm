vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTEMAR; vPos1; vPos2)
$Temp:=<>va_CR+("*"*<>vl_NbEtoilesTrait)+<>va_CR
vt_TempNOTEMAR:=Insert string:C231(vt_TempNOTEMAR; $Temp; vPos1)
vPos2:=Length:C16(vt_TempNOTEMAR)+1
HIGHLIGHT TEXT:C210(vt_TempNOTEMAR; vPos2; vPos2)