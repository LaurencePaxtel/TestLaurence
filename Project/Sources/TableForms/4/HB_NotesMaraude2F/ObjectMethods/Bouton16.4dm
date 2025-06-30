vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTEMAR2; vPos1; vPos2)
$Temp:=<>va_CR+("*"*<>vl_NbEtoilesTrait)+<>va_CR
vt_TempNOTEMAR2:=Insert string:C231(vt_TempNOTEMAR2; $Temp; vPos1)
vPos2:=Length:C16(vt_TempNOTEMAR2)+1
HIGHLIGHT TEXT:C210(vt_TempNOTEMAR2; vPos2; vPos2)