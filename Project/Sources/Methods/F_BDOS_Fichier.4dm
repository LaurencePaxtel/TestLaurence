//%attributes = {}
C_TEXT:C284($0)
$0:=""
C_LONGINT:C283($1)
C_TEXT:C284($va_Dept)

C_LONGINT:C283($vl_Cas)
$vl_Cas:=Length:C16(<>va_T_Departement)
Case of 
	: ($vl_Cas>2)
		$va_Dept:=Substring:C12(<>va_T_Departement; 1; 2)
	: ($vl_Cas<2)
		$va_Dept:=<>va_T_Departement+("X"*(2-Length:C16(<>va_T_Departement)))
	Else 
		$va_Dept:=<>va_T_Departement
End case 

$0:="VPAXT"+<>ta_BDOS_FichierCode{$1}+$va_Dept+String:C10(Year of:C25([DiaLogues:3]DL_Date:2); "0000")+String:C10(Month of:C24([DiaLogues:3]DL_Date:2); "00")+String:C10(Day of:C23([DiaLogues:3]DL_Date:2); "00")