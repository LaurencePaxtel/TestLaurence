vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTE3; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
vt_TempNOTE3:=Insert string:C231(vt_TempNOTE3; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210(vt_TempNOTE3; vPos2; vPos2)
vl_Note_LG_2:=Length:C16([HeBerge:4]HB_Notes3:54)+Length:C16(vt_TempNOTE3)
OBJECT SET VISIBLE:C603(*; "TropPage_2"; (vl_Note_LG_2>vl_Note_LG_MAX))
