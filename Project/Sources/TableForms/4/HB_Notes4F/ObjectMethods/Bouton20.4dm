vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209(vt_TempNOTETRANS; vPos1; vPos2)
$Temp:=<>va_CR+("*"*<>vl_NbEtoilesTrait)+<>va_CR
vt_TempNOTETRANS:=Insert string:C231(vt_TempNOTETRANS; $Temp; vPos1)
vPos2:=Length:C16(vt_TempNOTETRANS)+1
HIGHLIGHT TEXT:C210(vt_TempNOTETRANS; vPos2; vPos2)
vl_Note_LG_4:=Length:C16([HeBerge:4]HB_NotesTrans:53)+Length:C16(vt_TempNOTETRANS)
OBJECT SET VISIBLE:C603(*; "TropPage_4"; (vl_Note_LG_4>vl_Note_LG_MAX))