//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/06/22, 14:00:46
// ----------------------------------------------------
// Méthode : Uut_HébergéCléIconnu
// Description
// 
//
// Paramètres
// ----------------------------------------------------

var $vl_num : Integer
var $vd_date : Date
var $vaCPT_inconnu_t : Text
var $structure_t : Text

If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

If ([HeberGement:5]HG_Date:4#!00-00-00!)
	$vd_date:=[HeberGement:5]HG_Date:4
Else 
	$vd_date:=Current date:C33
End if 

F_VariablesTransite(1; 0; False:C215)

va_IDT_Clé:=""
va_IDT_Titr:=""

$vaCPT_inconnu_t:="X0"+Substring:C12(String:C10(Year of:C25($vd_date); "0000"); 3; 2)+String:C10(Month of:C24($vd_date); "00")
$vl_num:=Uut_Numerote(->$vaCPT_inconnu_t)

va_IDT_Nom:="X0"+Substring:C12(String:C10(Year of:C25($vd_date); "0000"); 3; 2)+String:C10(Month of:C24($vd_date); "00")+"-"+String:C10($vl_num; "00000")


va_IDT_Pré:=$structure_t
va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)

Uut_HébergéAgeInconnu($vd_date)