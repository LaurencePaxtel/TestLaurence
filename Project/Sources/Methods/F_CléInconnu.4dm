//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_CléInconnu
//{          Mardi 29 mars 2011 à 11:58
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_DATE:C307($1)

C_LONGINT:C283($vl_num)
var $vaCPT_inconnu_t : Text

$vaCPT_inconnu_t:="X0"+Substring:C12(String:C10(Year of:C25($1); "0000"); 3; 2)+String:C10(Month of:C24($1); "00")
$vl_num:=Uut_Numerote(->$vaCPT_inconnu_t)

va_IDT_Nom:="X0"+Substring:C12(String:C10(Year of:C25($1); "0000"); 3; 2)+String:C10(Month of:C24($1); "00")+"-"+String:C10($vl_num; "00000")
va_IDT_Pré:=<>va_T_Site
vd_IDT_NéLe:=Date:C102("1/1/"+String:C10((Year of:C25($1)-<>ve_ageHom); "0000"))
ve_IDT_Age:=Uut_HébergéAgeSimple(->vd_IDT_NéLe; $1)
va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)