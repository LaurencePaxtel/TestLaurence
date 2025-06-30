vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTE; vPos1; vPos2)
$Temp:=<>va_CR+("*"*<>vl_NbEtoilesTrait)+<>va_CR
vt_TempNOTE:=Insert string:C231(vt_TempNOTE; $Temp; vPos1)
vPos2:=Length:C16(vt_TempNOTE)+1
HIGHLIGHT TEXT:C210([HeBerge:4]Notes:6; vPos2; vPos2)

vl_Note_LG_1:=Length:C16([HeBerge:4]Notes:6)+Length:C16(vt_TempNOTE)
OBJECT SET VISIBLE:C603(*; "TropPage_1"; (vl_Note_LG_1>vl_Note_LG_MAX))