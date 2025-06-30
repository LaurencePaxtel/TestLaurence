//%attributes = {}
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

$0:="L'état civil : "+$1+<>va_CR+"L'âge : "+String:C10($2)+"an"+("s"*Num:C11($2>1))+<>va_CR+" sont incompatibles."