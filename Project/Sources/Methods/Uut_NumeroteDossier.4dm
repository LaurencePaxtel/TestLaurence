//%attributes = {}

C_TEXT:C284($1)
C_DATE:C307($2)
C_TEXT:C284($0)
C_LONGINT:C283($ii)


$0:=""
Case of 
	: ($1="DS")
		$0:=<>va_T_Site+"s"
		<>vaCPT_DS:="DS"+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")
		$ii:=Uut_Numerote(-><>vaCPT_DS)
	: ($1="DI")
		$0:=<>va_T_Site+"i"
		<>vaCPT_DI:="DI"+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")
		$ii:=Uut_Numerote(-><>vaCPT_DI)
	: ($1="DY")
		$0:=<>va_T_Site+"p"
		<>vaCPT_DP:="DP"+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")
		$ii:=Uut_Numerote(-><>vaCPT_DP)
	: ($1="DM")
		$0:=<>va_T_Site+"m"
		<>vaCPT_DM:="DM"+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")
		$ii:=Uut_Numerote(-><>vaCPT_DM)
	: ($1="DE")
		$0:=<>va_T_Site+"é"
		<>vaCPT_DE:="DE"+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")
		$ii:=Uut_Numerote(-><>vaCPT_DE)
	: ($1="MR")
		<>vaCPT_MR:="MR"+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")
		$ii:=Uut_Numerote(-><>vaCPT_MR)
End case 
$0:=$0+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")+"-"+String:C10($ii; "00000")
