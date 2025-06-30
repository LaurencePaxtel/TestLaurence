//%attributes = {}
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_TEXT:C284(va_LibelléAlerte)

va_LibelléAlerte:=xliff_Txt_Get_Indexed_String_(30001; $1)

If (Position:C15("^LF"; va_LibelléAlerte)>0)
	$1:=$1+1
	va_LibelléAlerte:=va_LibelléAlerte+xliff_Txt_Get_Indexed_String_(30001; $1)
	va_LibelléAlerte:=Replace string:C233(va_LibelléAlerte; "^LF"; "")
End if 

va_LibelléAlerte:=Replace string:C233(va_LibelléAlerte; "^CR"; Char:C90(Retour chariot:K15:38))
va_LibelléAlerte:=Replace string:C233(va_LibelléAlerte; "^1"; $2)

If (Value type:C1509(w_visiteur)=Est une variable indéfinie:K8:13) || (w_visiteur=Null:C1517) || (JSON Stringify:C1217(w_visiteur)="undefined")
	ALERT:C41(va_LibelléAlerte)
Else 
	w_visiteur.notificationError:=va_LibelléAlerte
End if 