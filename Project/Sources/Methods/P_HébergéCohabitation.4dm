//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure P_HébergéCohabitation  
//{
//{          Lundi 14 décembre 2009 à 17:12:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Référence; $vl_Position1; $vl_Position2)
C_BOOLEAN:C305($vb_OK)
C_DATE:C307($vd_date)

C_TEXT:C284(va_Coha_Préfixe; va_Coha_Prenom)

Uut_HébergéCléIconnu

va_Coha_Préfixe:=""
va_Coha_Prenom:=""

//Le préfixe est dans l'énumération entre parenthèses
$vl_Position1:=Position:C15("("; <>ta_Cohabitation{<>ta_Cohabitation})
$vl_Position2:=Position:C15(")"; <>ta_Cohabitation{<>ta_Cohabitation})

$vb_OK:=($vl_Position1>0)
$vb_OK:=$vb_OK & ($vl_Position2>0)

If ($vb_OK)
	va_Coha_Préfixe:=Substring:C12(<>ta_Cohabitation{<>ta_Cohabitation}; $vl_Position1+1; $vl_Position2-$vl_Position1-1)
	va_Coha_Prenom:=Substring:C12(<>ta_Cohabitation{<>ta_Cohabitation}; 1; $vl_Position1-1)
End if 

$vb_OK:=((va_Coha_Préfixe>"") & (va_Coha_Prenom>""))

If ($vb_OK)
	If ([HeberGement:5]HG_Date:4#!00-00-00!)
		$vd_date:=[HeberGement:5]HG_Date:4
	Else 
		$vd_date:=Current date:C33
	End if 
	
	F_VariablesTransite(1; 0; False:C215)
	
	va_IDT_Clé:=""
	va_IDT_Titr:=""
	
	<>vaCPT_Cohabitation:=va_Coha_Préfixe+Substring:C12(String:C10(Year of:C25($vd_date); "0000"); 3; 2)+String:C10(Month of:C24($vd_date); "00")
	$vl_Référence:=Uut_Numerote(-><>vaCPT_Cohabitation)
	
	va_IDT_Nom:=va_Coha_Préfixe+Substring:C12(String:C10(Year of:C25($vd_date); "0000"); 3; 2)+String:C10(Month of:C24($vd_date); "00")+"-"+String:C10($vl_Référence; "00000")
	va_IDT_Pré:=Uppercase:C13(va_Coha_Prenom)
	va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
	
	Uut_HébergéAgeInconnu($vd_date)
	
	rIDTG_1:=x_IDTG_1
	rIDTG_2:=x_IDTG_2
End if 