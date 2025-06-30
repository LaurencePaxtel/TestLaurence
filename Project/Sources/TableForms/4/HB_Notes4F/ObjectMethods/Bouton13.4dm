vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTE; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
vt_TempNOTE:=Insert string:C231(vt_TempNOTE; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210(vt_TempNOTE; vPos2; vPos2)
vl_Note_LG_1:=Length:C16([HeBerge:4]Notes:6)+Length:C16(vt_TempNOTE)
OBJECT SET VISIBLE:C603(*; "TropPage_1"; (vl_Note_LG_1>vl_Note_LG_MAX))
