var $Pos1; $Pos2 : Integer

GET HIGHLIGHT:C209(*; "Note"; $Pos1; $Pos2)

Form:C1466.note:=Insert string:C231(String:C10(Form:C1466.note); <>va_User+" - "; $Pos1)
$Pos2:=$Pos1+Length:C16(<>va_User)+3

HIGHLIGHT TEXT:C210(*; "Note"; $Pos2; $Pos2)