vPos1:=0
vPos2:=0
GET HIGHLIGHT:C209([DePart:1]DP_Texte:7; vPos1; vPos2)
$Temp:=""
$Temp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
[DePart:1]DP_Texte:7:=Insert string:C231([DePart:1]DP_Texte:7; $Temp; vPos1)
vPos2:=vPos1+24+Length:C16(<>va_User)+4
HIGHLIGHT TEXT:C210([DePart:1]DP_Texte:7; vPos2; vPos2)