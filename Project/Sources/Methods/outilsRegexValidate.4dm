//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 07/03/21, 11:29:47
// ----------------------------------------------------
// Méthode : outilsRegexValidate
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_VARIANT:C1683($2)

C_TEXT:C284($pattern_t)
C_LONGINT:C283($position_el; $longueur_el)

Case of 
	: ($1=1)  // Adresse email
		$pattern_t:="\\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}\\b"
	: ($1=2)  // Date au format JJ/MM/AAAA
		$pattern_t:="(^(((0[1-9]|1[0-9]|2[0-8])[\\/](0[1-9]|1[012]))|((29|30|31)[\\/](0[13578]|1[02]))|((29|30)[\\/](0[4,6,9]|11)))[\\/](19|[2-9][0-9])\\d\\d$)|(^29[\\/]02[\\/](19|[2-9][0-9])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)$)"
End case 

$0:=Match regex:C1019($pattern_t; $2; 1; $position_el; $longueur_el)