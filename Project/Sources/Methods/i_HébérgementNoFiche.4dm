//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : i_HébérgementNoFiche
//{
//{          Dimanche 26 janvier 2003 à 11:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)
C_DATE:C307($2)
C_LONGINT:C283($3)

var $ref_soc_active : Text


// Modified by: Kevin HASSAL (30-03-2019)
// Ajout de la référence de la société courante

If (Application type:C494=4D Server:K5:6) && (Count parameters:C259=4)
	$ref_soc_active:=$4
Else 
	If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
		$ref_soc_active:=Session:C1714.storage.intervenant.Ref_Structure
	Else 
		$ref_soc_active:=Storage:C1525.societeDetail.Ref_Structure
	End if 
End if 

$0:=$ref_soc_active+"-"+$1+Substring:C12(String:C10(Year of:C25($2); "0000"); 3; 2)+String:C10(Month of:C24($2); "00")+"-"+String:C10($3; "000000")  //modif 15/09/15 ES