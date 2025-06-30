//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure:  P_DisponibilitéCréer
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée : 18 mars 2008 à 15:13:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  // Quel cas
C_TEXT:C284($2)  // Jour ou nuit
C_DATE:C307($3)
C_LONGINT:C283($4)  // Report
C_LONGINT:C283($5)  // Sortants
C_LONGINT:C283($6)  // Prolongés
C_LONGINT:C283($7)  // Retour excusés
C_LONGINT:C283($8)  // Les remplaçants
C_LONGINT:C283($9)  // Les distribués

C_TEXT:C284($T_Type)
C_LONGINT:C283($L_Report; $L_Sortants; $L_Prolonges; $L_Excuses; $L_Remplacants; $L_Distribues)
C_DATE:C307($D_Date)

$T_Type:=$2
$D_Date:=$3
$L_Report:=$4
$L_Sortants:=$5
$L_Prolonges:=$6
$L_Excuses:=$7
$L_Remplacants:=$8

// Modifié par : Scanu Rémy (24/08/2022)
If (Count parameters:C259=9)
	$L_Distribues:=$9
End if 

Case of 
	: ($1=0)
		CREATE RECORD:C68([CentresLits:16])
		MultiSoc_Init_Structure(->[CentresLits:16])
		
		[CentresLits:16]CL_LC_ID:2:=[LesCentres:9]LC_RéférenceID:1
		[CentresLits:16]CL_Date:3:=$D_Date
		[CentresLits:16]CL_LC_ID_date:1:=Uut_NumeroteLits([CentresLits:16]CL_Date:3; [CentresLits:16]CL_LC_ID:2)
		[CentresLits:16]CL_Type:8:=$T_Type
		
		If ([CentresLits:16]CL_Type:8="J")
			[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoJour:48
		Else 
			[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoNuit:22
		End if 
		
		[CentresLits:16]CL_DateType:9:=Uut_NumeroteLitsType([CentresLits:16]CL_Date:3; $T_Type)
		[CentresLits:16]CL_DateTypeIDLC:10:=[CentresLits:16]CL_DateType:9+Uut_NumeroteLitsID([CentresLits:16]CL_LC_ID:2)
		[CentresLits:16]CL_Niveau:17:=[LesCentres:9]LC_Niveau:52
		
		//Si ([CentresLits]CL_Niveau=1)  `15/11/2010
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($D_Date-1); *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214)
		
		//4/11/2008
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61>=<>vl_T_CentreCodeDebut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61<=<>vl_T_CentreCodeFin; *)
		//Fin 4/11/2008
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=($T_Type="N"))
		MultiSoc_Filter(->[HeberGement:5])
		
		// Modifié par : Scanu Rémy (24/08/2022)
		[CentresLits:16]CL_Distribué:6:=$L_Distribues
		
		[CentresLits:16]CL_Report:11:=Records in selection:C76([HeberGement:5])
		[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5-[CentresLits:16]CL_Report:11-[CentresLits:16]CL_Distribué:6  // [CentresLits]CL_Restant
		//Fin de si 
		
		SAVE RECORD:C53([CentresLits:16])
		UNLOAD RECORD:C212([CentresLits:16])
	: ($1=1)
		CREATE RECORD:C68([CentresLits:16])
		MultiSoc_Init_Structure(->[CentresLits:16])
		
		[CentresLits:16]CL_LC_ID:2:=[LesCentres:9]LC_RéférenceID:1
		[CentresLits:16]CL_Date:3:=$D_Date
		
		[CentresLits:16]CL_LC_ID_date:1:=Uut_NumeroteLits([CentresLits:16]CL_Date:3; [CentresLits:16]CL_LC_ID:2)
		
		[CentresLits:16]CL_Type:8:=$T_Type
		
		//RAZ pour être sur
		[CentresLits:16]CL_DispoTotal:5:=0
		[CentresLits:16]CL_Distribué:6:=0
		[CentresLits:16]CL_Restant:7:=0  // [CentresLits]CL_Restant
		
		[CentresLits:16]CL_Report:11:=0
		[CentresLits:16]CL_DispoDuJour:12:=0
		[CentresLits:16]CL_Absents:13:=0
		[CentresLits:16]CL_Excusés:14:=0
		[CentresLits:16]CL_Sortants:15:=0
		[CentresLits:16]CL_RestantsVeille:16:=0
		
		[CentresLits:16]CL_RetourExcusés:26:=0
		[CentresLits:16]CL_NouveauxRemplacants:27:=0
		[CentresLits:16]CL_Remplacants:28:=0
		//FIN RAZ pour être sur
		
		If ([CentresLits:16]CL_Type:8="J")
			[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoJour:48
		Else 
			[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoNuit:22
		End if 
		
		[CentresLits:16]CL_DateType:9:=Uut_NumeroteLitsType([CentresLits:16]CL_Date:3; $2)
		[CentresLits:16]CL_DateTypeIDLC:10:=[CentresLits:16]CL_DateType:9+Uut_NumeroteLitsID([CentresLits:16]CL_LC_ID:2)
		[CentresLits:16]CL_Niveau:17:=[LesCentres:9]LC_Niveau:52
		
		//Si ([CentresLits]CL_Niveau=1)  `15/11/2010
		[CentresLits:16]CL_Report:11:=$4
		[CentresLits:16]CL_RetourExcusés:26:=$7
		
		[CentresLits:16]CL_Report:11:=[CentresLits:16]CL_Report:11+$7
		If (<>vb_CentreEXClits) & ([LesCentres:9]LC_Excuse:49)
			[CentresLits:16]CL_Sortants:15:=$5
		End if 
		
		[CentresLits:16]CL_Remplacants:28:=$8
		
		[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_DispoDuJour:12\
			+[CentresLits:16]CL_Report:11\
			+[CentresLits:16]CL_Excusés:14\
			+[CentresLits:16]CL_Sortants:15\
			-[CentresLits:16]CL_RetourExcusés:26+[CentresLits:16]CL_Capacité:4  // #20170705-1
		
		[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Capacité:4-[CentresLits:16]CL_Distribué:6+[CentresLits:16]CL_DispoDuJour:12  // #20170705-1
		
		SAVE RECORD:C53([CentresLits:16])
		UNLOAD RECORD:C212([CentresLits:16])
	: ($1=2)
		
		Repeat 
			LOAD RECORD:C52([CentresLits:16])
		Until (Not:C34(Locked:C147([CentresLits:16])))
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[CentresLits:16]CL_LC_ID:2)
		
		If (<>vb_CentreEXClits) & ([LesCentres:9]LC_Excuse:49)
			[CentresLits:16]CL_RestantsVeille:16:=$L_Report
			[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_RestantsVeille:16+[CentresLits:16]CL_DispoDuJour:12+[CentresLits:16]CL_Report:11+[CentresLits:16]CL_Excusés:14+[CentresLits:16]CL_Sortants:15-[CentresLits:16]CL_RetourExcusés:26
		End if 
		
		[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Capacité:4-[CentresLits:16]CL_Distribué:6+[CentresLits:16]CL_DispoDuJour:12  // #20170705-1
		
		SAVE RECORD:C53([CentresLits:16])
		UNLOAD RECORD:C212([CentresLits:16])
	: ($1=3)
		CREATE RECORD:C68([CentresLits:16])
		MultiSoc_Init_Structure(->[CentresLits:16])
		
		[CentresLits:16]CL_LC_ID:2:=[LesCentres:9]LC_RéférenceID:1
		[CentresLits:16]CL_Date:3:=$3
		[CentresLits:16]CL_LC_ID_date:1:=Uut_NumeroteLits([CentresLits:16]CL_Date:3; [CentresLits:16]CL_LC_ID:2)
		[CentresLits:16]CL_Type:8:=$2
		
		//RAZ pour être sur
		[CentresLits:16]CL_DispoTotal:5:=0
		[CentresLits:16]CL_Distribué:6:=0
		[CentresLits:16]CL_Restant:7:=0  // [CentresLits]CL_Restant
		
		[CentresLits:16]CL_Report:11:=0
		[CentresLits:16]CL_DispoDuJour:12:=0
		[CentresLits:16]CL_Absents:13:=0
		[CentresLits:16]CL_Excusés:14:=0
		[CentresLits:16]CL_Sortants:15:=0
		[CentresLits:16]CL_RestantsVeille:16:=0
		
		[CentresLits:16]CL_RetourExcusés:26:=0
		[CentresLits:16]CL_NouveauxRemplacants:27:=0
		[CentresLits:16]CL_Remplacants:28:=0
		//FIN RAZ pour être sur
		
		If ([CentresLits:16]CL_Type:8="J")
			[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoJour:48
		Else 
			[CentresLits:16]CL_Capacité:4:=[LesCentres:9]LC_DispoNuit:22
		End if 
		
		[CentresLits:16]CL_DateType:9:=Uut_NumeroteLitsType([CentresLits:16]CL_Date:3; $2)
		[CentresLits:16]CL_DateTypeIDLC:10:=[CentresLits:16]CL_DateType:9+Uut_NumeroteLitsID([CentresLits:16]CL_LC_ID:2)
		[CentresLits:16]CL_Niveau:17:=[LesCentres:9]LC_Niveau:52
		
		// Si ([CentresLits]CL_Niveau=1) `15/11/2010
		[CentresLits:16]CL_Report:11:=$4
		[CentresLits:16]CL_RetourExcusés:26:=$7
		[CentresLits:16]CL_Remplacants:28:=$8
		
		[CentresLits:16]CL_DispoDuJour:12:=[LesCentres:9]LC_DispoJour:48
		[CentresLits:16]CL_DispoTotal:5:=[LesCentres:9]LC_DispoJour:48
		[CentresLits:16]CL_Restant:7:=[LesCentres:9]LC_DispoJour:48  // [CentresLits]CL_Restant
		//Fin de si 
		
		SAVE RECORD:C53([CentresLits:16])
		UNLOAD RECORD:C212([CentresLits:16])
End case 