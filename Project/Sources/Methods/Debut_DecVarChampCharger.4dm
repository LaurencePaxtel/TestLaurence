//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampCharger
//{
//{          Vendredi : 18 juillet 2008 à 16:30
//{          Modifiée : 29 septembre 2009 à 11:30
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($vl_STR; $vl_NbChamps)

// Modifié par : Scanu Rémy (25/01/2023)
/*
$vl_STR:=30100+1  //◊ta_vDSLibel{1}:="Hébergement"
$vl_STR:=30100+2  //◊ta_vDSLibel{2}:="Maraude"
$vl_STR:=30100+3  //◊ta_vDSLibel{3}:="Dossier social"  
$vl_STR:=30100+4  //◊ta_vDSLibel{4}:="Actions sociales"  
$vl_STR:=30100+5  //◊ta_vDSLibel{5}:="Dossier infirmier"
$vl_STR:=30100+6  //◊ta_vDSLibel{6}:="Dossier psycho-social"
$vl_STR:=30100+7  //◊ta_vDSLibel{7}:="Dossier médical"
$vl_STR:=30100+8  //◊ta_vDSLibel{8}:="Asile"
$vl_STR:=30100+9  //◊ta_vDSLibel{9}:="Hébergement externe"
$vl_STR:=30100+10  //◊ta_vDSLibel{10}:="Hébergement externe permanencier"
$vl_STR:=30100+11  //◊ta_vDSLibel{11}:="Dossier Santé"
$vl_STR:=30100+12  //◊ta_vDSLibel{12}:="Hébergement Prestations"
*/

// Modifié par : Scanu Rémy (25/01/2023)
/*
$vl_NbChamps:=112
$vl_NbChamps:=115  //15/11/2010
$vl_NbChamps:=116  //??/07/2011
$vl_NbChamps:=124  //29/11/2011
$vl_NbChamps:=125  //13/12/2011
$vl_NbChamps:=128  //19/12/2011
$vl_NbChamps:=129  //06/02/2012
$vl_NbChamps:=130  //06/03/2012
*/

//LPC 05/12/2023
// Modifié par : Scanu Rémy (23/02/2023)
$vl_NbChamps:=133  //10/04/2017  // #HPOP2017 //LPC 05/12/2023

$vl_STR:=30100+1  //◊ta_vDSLibel{1}:="Hébergement"
Debut_DecVarChampHébergement($vl_STR; $vl_NbChamps; 1)

$vl_STR:=30100+8  //◊ta_vDSLibel{8}:="Asile"
Debut_DecVarChampHébergement($vl_STR; $vl_NbChamps; 8)

$vl_STR:=30100+9  //◊ta_vDSLibel{9}:="Hébergement externe"
Debut_DecVarChampHébergement($vl_STR; $vl_NbChamps; 9)

$vl_STR:=30100+10  //◊ta_vDSLibel{10}:="Hébergement externe permanencier"
Debut_DecVarChampHébergement($vl_STR; $vl_NbChamps; 10)

$vl_STR:=30100+12  //◊ta_vDSLibel{12}:="Hébergement Prestations"
Debut_DecVarChampHébergement($vl_STR; $vl_NbChamps; 12)

$vl_NbChamps:=77
$vl_STR:=30100+2  //◊ta_vDSLibel{2}:="Maraude"

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsMR($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 2; $vl_NbChamps)
	TableChampsAttributs(2; 2; $vl_STR)
Else 
	TableChampsAttributs(1; 2; $vl_NbChamps)
End if 

$vl_NbChamps:=69
$vl_STR:=30100+3  //◊ta_vDSLibel{3}:="Dossier social"  

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsDS($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 3; $vl_NbChamps)
	TableChampsAttributs(2; 3; $vl_STR)
Else 
	TableChampsAttributs(1; 3; $vl_NbChamps)
End if 

$vl_NbChamps:=11
$vl_STR:=30100+4  //◊ta_vDSLibel{4}:="Actions sociales" 

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsAS($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 4; $vl_NbChamps)
	TableChampsAttributs(2; 4; $vl_STR)
Else 
	TableChampsAttributs(1; 4; $vl_NbChamps)
End if 

$vl_NbChamps:=23
$vl_STR:=30100+5  //◊ta_vDSLibel{5}:="Dossier infirmier"

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsDI($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 5; $vl_NbChamps)
	TableChampsAttributs(2; 5; $vl_STR)
Else 
	TableChampsAttributs(1; 5; $vl_NbChamps)
End if 

$vl_NbChamps:=20
$vl_STR:=30100+6  //◊ta_vDSLibel{6}:="Dossier psycho-social"

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsDY($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 6; $vl_NbChamps)
	TableChampsAttributs(2; 6; $vl_STR)
Else 
	TableChampsAttributs(1; 6; $vl_NbChamps)
End if 

$vl_NbChamps:=66
$vl_STR:=30100+7  //◊ta_vDSLibel{7}:="Dossier médical"

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsDM($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 7; $vl_NbChamps)
	TableChampsAttributs(2; 7; $vl_STR)
Else 
	TableChampsAttributs(1; 7; $vl_NbChamps)
End if 

$vl_NbChamps:=122
$vl_STR:=30100+11  //◊ta_vDSLibel{11}:="Dossier Santé"

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])#$vl_NbChamps)
	Debut_DecVarChampsDE($vl_STR; $vl_NbChamps)
	
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=$vl_STR)
	MultiSoc_Filter(->[LesRubriques:21])
	
	TableChampsAttributs(1; 11; $vl_NbChamps)
	TableChampsAttributs(2; 11; $vl_STR)
Else 
	TableChampsAttributs(1; 11; $vl_NbChamps)
End if 