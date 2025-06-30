vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209([HeBerge:4]HB_Santé:48; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
[HeBerge:4]HB_Santé:48:=Insert string:C231([HeBerge:4]HB_Santé:48; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210([HeBerge:4]HB_Santé:48; vPos2; vPos2)