vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209([HeBerge:4]HB_Notes2:50; vPos1; vPos2)
$Temp:=<>va_CR+("*"*<>vl_NbEtoilesTrait)+<>va_CR
[HeBerge:4]HB_Notes2:50:=Insert string:C231([HeBerge:4]HB_Notes2:50; $Temp; vPos1)
vPos2:=Length:C16([HeBerge:4]HB_Notes2:50)+1
HIGHLIGHT TEXT:C210([HeBerge:4]HB_Notes2:50; vPos2; vPos2)