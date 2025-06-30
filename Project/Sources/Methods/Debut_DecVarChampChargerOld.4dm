//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_DecVarChampAChargerOld
//{
//{          Vendredi : 18 juillet 2008 à 16:30
//{          Modifiée : 17 septembre 2008 à 12:30
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii)
//{1}
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=108)
		TableChampsAttributs(1; 1; 108)
	: ($ii=100)
		Debut_DecVarChampsHG101((30100+1))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 108)
	: ($ii=99)
		Debut_DecVarChampsHG100((30100+1))
		Debut_DecVarChampsHG101((30100+1))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 108)
	Else 
		Debut_DecVarChampsHG1((30100+1); 109)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+1))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 109)
		TableChampsAttributs(2; 1; (30100+1))
End case 

//{2}
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

//{3}
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

//{4}
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

//{5}
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

//{6}
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

//{7}
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

//{8}
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=108)
		TableChampsAttributs(1; 8; 108)
	: ($ii=100)
		Debut_DecVarChampsHG101((30100+8))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 108)
	: ($ii=99)
		Debut_DecVarChampsHG100((30100+8))
		Debut_DecVarChampsHG101((30100+8))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 108)
	Else 
		Debut_DecVarChampsHG1A((30100+8); 108)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+8))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 8; 108)
		TableChampsAttributs(2; 8; (30100+8))
End case 

//{9}
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=108)
		TableChampsAttributs(1; 9; 108)
	: ($ii=100)
		Debut_DecVarChampsHG101((30100+9))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 9; 108)
	: ($ii=99)
		Debut_DecVarChampsHG100((30100+9))
		Debut_DecVarChampsHG101((30100+9))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 9; 108)
	Else 
		Debut_DecVarChampsHG1((30100+9); 108)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+9))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 108)
		TableChampsAttributs(2; 9; (30100+9))
End case 

//{10}
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=108)
		TableChampsAttributs(1; 10; 108)
	: ($ii=100)
		Debut_DecVarChampsHG101((30100+10))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 10; 108)
	: ($ii=99)
		Debut_DecVarChampsHG100((30100+10))
		Debut_DecVarChampsHG101((30100+10))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 10; 108)
	Else 
		Debut_DecVarChampsHG1((30100+10); 108)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+10))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 108)
		TableChampsAttributs(2; 10; (30100+10))
End case 

//{11}
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


//{12}
QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+12))
MultiSoc_Filter(->[LesRubriques:21])
$ii:=Records in selection:C76([LesRubriques:21])
Case of 
	: ($ii=108)
		TableChampsAttributs(1; 12; 108)
	: ($ii=100)
		Debut_DecVarChampsHG101((30100+12))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+12))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 1; 108)
	: ($ii=99)
		Debut_DecVarChampsHG100((30100+12))
		Debut_DecVarChampsHG101((30100+12))
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+12))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 12; 108)
	Else 
		Debut_DecVarChampsHGPs((30100+12); 108)
		QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(30100+12))
		MultiSoc_Filter(->[LesRubriques:21])
		TableChampsAttributs(1; 12; 108)
		TableChampsAttributs(2; 12; (30100+12))
End case 
