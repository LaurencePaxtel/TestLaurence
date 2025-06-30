//%attributes = {}
/*------------------------------------------------------------------------------
Méthode : Web_StrAlerte
LOGICIEL : Samu Social de Paris

Reprise de la méthode StrAlerte optimisé pour etre thread safe.

Historique
06/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/

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

w_visiteur.notificationError:=va_LibelléAlerte
