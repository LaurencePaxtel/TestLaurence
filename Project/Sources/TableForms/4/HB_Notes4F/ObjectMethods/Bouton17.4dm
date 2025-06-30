vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTE2; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
vt_TempNOTE2:=Insert string:C231(vt_TempNOTE2; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210(vt_TempNOTE2; vPos2; vPos2)
vl_Note_LG_3:=Length:C16([HeBerge:4]HB_Notes2:50)+Length:C16(vt_TempNOTE2)
OBJECT SET VISIBLE:C603(*; "TropPage_3"; (vl_Note_LG_3>vl_Note_LG_MAX))