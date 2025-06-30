//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampAttribut 
//{
//{          Vendredi : 17 août 2001 à 15:46
//{          Modifiée : 17 janvier 2005 à 11:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_LONGINT:C283($ii)

ARRAY TEXT:C222(<>ta_vDSLibel; 12)
<>ta_vDSLibel{1}:="Hébergement"

<>ta_vDSLibel{2}:="Maraude"
<>ta_vDSLibel{3}:="Dossier social"
<>ta_vDSLibel{4}:="Actions sociales"
<>ta_vDSLibel{5}:="Dossier infirmier"
<>ta_vDSLibel{6}:="Dossier psycho-social"
<>ta_vDSLibel{7}:="Dossier médical"
<>ta_vDSLibel{8}:="Hébergement Asile"
<>ta_vDSLibel{9}:="Hébergement externe"
<>ta_vDSLibel{10}:="Hébergement externe permanencier"
<>ta_vDSLibel{11}:="Dossier Santé"
<>ta_vDSLibel{12}:="Hébergement Prestations"

C_LONGINT:C283(<>vlSTR)
C_LONGINT:C283(<>vlSTR_HG)
C_LONGINT:C283(<>vlSTR_HG1)
C_LONGINT:C283(<>vlSTR_MR)
C_LONGINT:C283(<>vlSTR_DS)
C_LONGINT:C283(<>vlSTR_AA)
C_LONGINT:C283(<>vlSTR_DI)
C_LONGINT:C283(<>vlSTR_DY)
C_LONGINT:C283(<>vlSTR_DM)
C_LONGINT:C283(<>vlSTR_HGE)
C_LONGINT:C283(<>vlSTR_HGEP)
C_LONGINT:C283(<>vlSTR_HGPS)  //Hébergement Prestations

C_LONGINT:C283(<>vlSTR_DE)

<>vlSTR:=30100
<>vlSTR_HG:=30101
<>vlSTR_HG1:=30101
<>vlSTR_MR:=30102
<>vlSTR_DS:=30103
<>vlSTR_AA:=30104
<>vlSTR_DI:=30105
<>vlSTR_DY:=30106
<>vlSTR_DM:=30107
<>vlSTR_HGE:=30109
<>vlSTR_HGEP:=30110
<>vlSTR_DE:=30111
<>vlSTR_HGPS:=30112

TableChamps(0; 0)
TableChampsAttributs(0; 12; 0)


//◊ta_vDSLibel{1}:="Hébergement"
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=99)
		TableChampsAttributs(1; 1; 99)
	: ($ii=88)
		Debut_DecVarChampsHG3((30100+1))
		Debut_DecVarChampsHG4((30100+1))
		Debut_DecVarChampsHG5((30100+1))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 99)
	: ($ii=83)
		Debut_DecVarChampsHG2((30100+1))
		Debut_DecVarChampsHG3((30100+1))
		Debut_DecVarChampsHG4((30100+1))
		Debut_DecVarChampsHG5((30100+1))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 99)
	Else 
		Debut_DecVarChampsHG1((30100+1); 99)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 99)
		TableChampsAttributs(2; 1; (30100+1))
End case 

//`◊ta_vDSLibel{2}:="Maraude"
//TableChampsAttributs (0;2;74)
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+2))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#74)
	Debut_DecVarChampsMR((30100+2); 74)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+2))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 2; 74)
	TableChampsAttributs(2; 2; (30100+2))
Else 
	TableChampsAttributs(1; 2; 74)
End if 

//◊ta_vDSLibel{3}:="Dossier social"  
//TableChampsAttributs (0;3;69)
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+3))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#69)
	Debut_DecVarChampsDS((30100+3); 69)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+3))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 3; 69)
	TableChampsAttributs(2; 3; (30100+3))
Else 
	TableChampsAttributs(1; 3; 69)
End if 

//◊ta_vDSLibel{4}:="Actions sociales"  
//TableChampsAttributs (0;4;11)
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+4))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#11)
	Debut_DecVarChampsAS((30100+4); 11)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+4))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 4; 11)
	TableChampsAttributs(2; 4; (30100+4))
Else 
	TableChampsAttributs(1; 4; 11)
End if 

//◊ta_vDSLibel{5}:="Dossier infirmier"
//TableChampsAttributs (0;5;23)
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+5))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#23)
	Debut_DecVarChampsDI((30100+5); 23)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+5))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 5; 23)
	TableChampsAttributs(2; 5; (30100+5))
Else 
	TableChampsAttributs(1; 5; 23)
End if 

//◊ta_vDSLibel{6}:="Dossier psycho-social"
//TableChampsAttributs (0;6;20)
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+6))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#20)
	Debut_DecVarChampsDY((30100+6); 20)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+6))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 6; 20)
	TableChampsAttributs(2; 6; (30100+6))
Else 
	TableChampsAttributs(1; 6; 20)
End if 

//◊ta_vDSLibel{7}:="Dossier médical"
//TableChampsAttributs (0;7;66)
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+7))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#66)
	Debut_DecVarChampsDM((30100+7); 66)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+7))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 7; 66)
	TableChampsAttributs(2; 7; (30100+7))
Else 
	TableChampsAttributs(1; 7; 66)
End if 

//◊ta_vDSLibel{8}:="Asile"
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=99)
		TableChampsAttributs(1; 8; 99)
	: ($ii=98)
		Debut_DecVarChampsHG5((30100+8))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 99)
		
	: ($ii=97)
		Debut_DecVarChampsHG4((30100+8))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 99)
	: ($ii=88)
		Debut_DecVarChampsHG3((30100+8))
		Debut_DecVarChampsHG4((30100+8))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 99)
	: ($ii=83)
		Debut_DecVarChampsHG2((30100+8))
		Debut_DecVarChampsHG3((30100+8))
		Debut_DecVarChampsHG4((30100+8))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 99)
		
	Else 
		Debut_DecVarChampsHG1A((30100+8); 99)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 99)
		TableChampsAttributs(2; 8; (30100+8))
End case 


//◊ta_vDSLibel{9}:="Hébergement externe"
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=99)
		TableChampsAttributs(1; 9; 99)
	: ($ii=88)
		Debut_DecVarChampsHG3((30100+9))
		Debut_DecVarChampsHG4((30100+9))
		Debut_DecVarChampsHG5((30100+9))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 9; 99)
	: ($ii=83)
		Debut_DecVarChampsHG2((30100+9))
		Debut_DecVarChampsHG3((30100+9))
		Debut_DecVarChampsHG4((30100+9))
		Debut_DecVarChampsHG5((30100+9))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 9; 99)
	Else 
		Debut_DecVarChampsHG1((30100+9); 99)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 99)
		TableChampsAttributs(2; 9; (30100+9))
End case 


//◊ta_vDSLibel{10}:="Hébergement externe permanencier"
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=99)
		TableChampsAttributs(1; 10; 99)
	: ($ii=88)
		Debut_DecVarChampsHG3((30100+10))
		Debut_DecVarChampsHG4((30100+10))
		Debut_DecVarChampsHG5((30100+10))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 10; 99)
	: ($ii=83)
		Debut_DecVarChampsHG2((30100+10))
		Debut_DecVarChampsHG3((30100+10))
		Debut_DecVarChampsHG4((30100+10))
		Debut_DecVarChampsHG5((30100+10))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 10; 99)
	Else 
		Debut_DecVarChampsHG1((30100+9); 99)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 99)
		TableChampsAttributs(2; 10; (30100+10))
End case 


//◊ta_vDSLibel{11}:="Dossier Santé"
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+11))
MultiSoc_Filter(->[LesRubriques:21])
If (Records in selection:C76([LesRubriques:21])#122)
	Debut_DecVarChampsDE((30100+11); 122)
	QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+11))
	MultiSoc_Filter(->[LesRubriques:21])
	TableChampsAttributs(1; 11; 122)
	TableChampsAttributs(2; 11; (30100+11))
Else 
	TableChampsAttributs(1; 11; 122)
End if 


//◊ta_vDSLibel{12}:="Hébergement Prestations"
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+12))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=99)
		TableChampsAttributs(1; 12; 99)
	Else 
		Debut_DecVarChampsHGPs((30100+12); 99)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+12))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 12; 99)
		TableChampsAttributs(2; 12; (30100+12))
End case 
