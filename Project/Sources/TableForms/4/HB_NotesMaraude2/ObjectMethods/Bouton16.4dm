vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209([HeBerge:4]HB_Maraude2:51; vPos1; vPos2)
$Temp:=<>va_CR+("*"*<>vl_NbEtoilesTrait)+<>va_CR
[HeBerge:4]HB_Maraude2:51:=Insert string:C231([HeBerge:4]HB_Maraude2:51; $Temp; vPos1)
vPos2:=Length:C16([HeBerge:4]HB_Maraude2:51)+1
HIGHLIGHT TEXT:C210([HeBerge:4]HB_Maraude2:51; vPos2; vPos2)