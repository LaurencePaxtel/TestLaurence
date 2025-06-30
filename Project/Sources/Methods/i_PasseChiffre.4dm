//%attributes = {"invisible":true}
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)

C_POINTER:C301($2)  //C_ALPHA(80;$2)

C_DATE:C307($vb_Date)
$vb_Date:=Current date:C33
C_TEXT:C284($va_passe)
Case of 
	: ((Day of:C23($vb_Date)>=1) & (Day of:C23($vb_Date)<=9))
		$va_PartieDroite:="Z"+Char:C90(Day of:C23($vb_Date)+64)
	: ((Day of:C23($vb_Date)>=10) & (Day of:C23($vb_Date)<=20))
		$va_PartieDroite:="X"+Char:C90(Day of:C23($vb_Date)+64)
	: ((Day of:C23($vb_Date)>=21) & (Day of:C23($vb_Date)<=26))
		$va_PartieDroite:="a"+Char:C90(Day of:C23($vb_Date)+64)
	: (Day of:C23($vb_Date)=27)
		$va_PartieDroite:="ka"
	: (Day of:C23($vb_Date)=28)
		$va_PartieDroite:="mi"
	: (Day of:C23($vb_Date)=29)
		$va_PartieDroite:="fj"
	: (Day of:C23($vb_Date)=30)
		$va_PartieDroite:="jk"
	: (Day of:C23($vb_Date)=31)
		$va_PartieDroite:="vs"
End case 

$va_PartieCentre:=String:C10(Month of:C24($vb_Date); "00")+Substring:C12(String:C10(Year of:C25($vb_Date)); 1; 1)
$va_PartieGauche:="FPC"+String:C10(((Day of:C23($vb_Date)+Month of:C24($vb_Date)+Year of:C25($vb_Date))\Day of:C23($vb_Date)))
$va_passe:=$va_PartieCentre+$va_PartieGauche+$va_PartieDroite
If ($1=1)
	If ($2->=$va_passe)
		$0:=True:C214
	End if 
Else 
	$2->:=$va_passe
	$0:=True:C214
End if 
