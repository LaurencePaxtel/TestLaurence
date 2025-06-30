//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_Planning_OP 
//{
//{          Mercredi 12 janvier 2011 à 12:06:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		C_TEXT:C284(va_Nom_1_1; va_Nom_1_2; va_Nom_1_3; va_Nom_1_4; va_Nom_1_5; va_Nom_1_6; va_Nom_1_7)
		C_TEXT:C284(va_Nom_2_1; va_Nom_2_2; va_Nom_2_3; va_Nom_2_4; va_Nom_2_5; va_Nom_2_6; va_Nom_2_7)
		C_TEXT:C284(va_Nom_3_1; va_Nom_3_2; va_Nom_3_3; va_Nom_3_4; va_Nom_3_5; va_Nom_3_6; va_Nom_3_7)
		C_TEXT:C284(va_Nom_4_1; va_Nom_4_2; va_Nom_4_3; va_Nom_4_4; va_Nom_4_5; va_Nom_4_6; va_Nom_4_7)
		C_TEXT:C284(va_Nom_5_1; va_Nom_5_2; va_Nom_5_3; va_Nom_5_4; va_Nom_5_5; va_Nom_5_6; va_Nom_5_7)
		C_TEXT:C284(va_Nom_6_1; va_Nom_6_2; va_Nom_6_3; va_Nom_6_4; va_Nom_6_5; va_Nom_6_6; va_Nom_6_7)
		
		C_LONGINT:C283(vl_NomID_1_1; vl_NomID_1_2; vl_NomID_1_3; vl_NomID_1_4; vl_NomID_1_5; vl_NomID_1_6; vl_NomID_1_7)
		C_LONGINT:C283(vl_NomID_2_1; vl_NomID_2_2; vl_NomID_2_3; vl_NomID_2_4; vl_NomID_2_5; vl_NomID_2_6; vl_NomID_2_7)
		C_LONGINT:C283(vl_NomID_3_1; vl_NomID_3_2; vl_NomID_3_3; vl_NomID_3_4; vl_NomID_3_5; vl_NomID_3_6; vl_NomID_3_7)
		C_LONGINT:C283(vl_NomID_4_1; vl_NomID_4_2; vl_NomID_4_3; vl_NomID_4_4; vl_NomID_4_5; vl_NomID_4_6; vl_NomID_4_7)
		C_LONGINT:C283(vl_NomID_5_1; vl_NomID_5_2; vl_NomID_5_3; vl_NomID_5_4; vl_NomID_5_5; vl_NomID_5_6; vl_NomID_5_7)
		C_LONGINT:C283(vl_NomID_6_1; vl_NomID_6_2; vl_NomID_6_3; vl_NomID_6_4; vl_NomID_6_5; vl_NomID_6_6; vl_NomID_6_7)
		
		C_TEXT:C284(va_OPEat_1_1; va_OPEat_1_2; va_OPEat_1_3; va_OPEat_1_4; va_OPEat_1_5; va_OPEat_1_6; va_OPEat_1_7)
		C_TEXT:C284(va_OPEat_2_1; va_OPEat_2_2; va_OPEat_2_3; va_OPEat_2_4; va_OPEat_2_5; va_OPEat_2_6; va_OPEat_2_7)
		C_TEXT:C284(va_OPEat_3_1; va_OPEat_3_2; va_OPEat_3_3; va_OPEat_3_4; va_OPEat_3_5; va_OPEat_3_6; va_OPEat_3_7)
		C_TEXT:C284(va_OPEat_4_1; va_OPEat_4_2; va_OPEat_4_3; va_OPEat_4_4; va_OPEat_4_5; va_OPEat_4_6; va_OPEat_4_7)
		C_TEXT:C284(va_OPEat_5_1; va_OPEat_5_2; va_OPEat_5_3; va_OPEat_5_4; va_OPEat_5_5; va_OPEat_5_6; va_OPEat_5_7)
		C_TEXT:C284(va_OPEat_6_1; va_OPEat_6_2; va_OPEat_6_3; va_OPEat_6_4; va_OPEat_6_5; va_OPEat_6_6; va_OPEat_6_7)
	: ($1=1)
		va_Nom_1_1:=""
		va_Nom_1_2:=""
		va_Nom_1_3:=""
		va_Nom_1_4:=""
		va_Nom_1_5:=""
		va_Nom_1_6:=""
		va_Nom_1_7:=""
		
		va_Nom_2_1:=""
		va_Nom_2_2:=""
		va_Nom_2_3:=""
		va_Nom_2_4:=""
		va_Nom_2_5:=""
		va_Nom_2_6:=""
		va_Nom_2_7:=""
		
		va_Nom_3_1:=""
		va_Nom_3_2:=""
		va_Nom_3_3:=""
		va_Nom_3_4:=""
		va_Nom_3_5:=""
		va_Nom_3_6:=""
		va_Nom_3_7:=""
		
		va_Nom_4_1:=""
		va_Nom_4_2:=""
		va_Nom_4_3:=""
		va_Nom_4_4:=""
		va_Nom_4_5:=""
		va_Nom_4_6:=""
		va_Nom_4_7:=""
		
		va_Nom_5_1:=""
		va_Nom_5_2:=""
		va_Nom_5_3:=""
		va_Nom_5_4:=""
		va_Nom_5_5:=""
		va_Nom_5_6:=""
		va_Nom_5_7:=""
		
		va_Nom_6_1:=""
		va_Nom_6_2:=""
		va_Nom_6_3:=""
		va_Nom_6_4:=""
		va_Nom_6_5:=""
		va_Nom_6_6:=""
		va_Nom_6_7:=""
		
		
		vl_NomID_1_1:=0
		vl_NomID_1_2:=0
		vl_NomID_1_3:=0
		vl_NomID_1_4:=0
		vl_NomID_1_5:=0
		vl_NomID_1_6:=0
		vl_NomID_1_7:=0
		
		vl_NomID_2_1:=0
		vl_NomID_2_2:=0
		vl_NomID_2_3:=0
		vl_NomID_2_4:=0
		vl_NomID_2_5:=0
		vl_NomID_2_6:=0
		vl_NomID_2_7:=0
		
		vl_NomID_3_1:=0
		vl_NomID_3_2:=0
		vl_NomID_3_3:=0
		vl_NomID_3_4:=0
		vl_NomID_3_5:=0
		vl_NomID_3_6:=0
		vl_NomID_3_7:=0
		
		vl_NomID_4_1:=0
		vl_NomID_4_2:=0
		vl_NomID_4_3:=0
		vl_NomID_4_4:=0
		vl_NomID_4_5:=0
		vl_NomID_4_6:=0
		vl_NomID_4_7:=0
		
		vl_NomID_5_1:=0
		vl_NomID_5_2:=0
		vl_NomID_5_3:=0
		vl_NomID_5_4:=0
		vl_NomID_5_5:=0
		vl_NomID_5_6:=0
		vl_NomID_5_7:=0
		
		vl_NomID_6_1:=0
		vl_NomID_6_2:=0
		vl_NomID_6_3:=0
		vl_NomID_6_4:=0
		vl_NomID_6_5:=0
		vl_NomID_6_6:=0
		vl_NomID_6_7:=0
		
		
		va_OPEat_1_1:=""
		va_OPEat_1_2:=""
		va_OPEat_1_3:=""
		va_OPEat_1_3:=""
		va_OPEat_1_4:=""
		va_OPEat_1_6:=""
		va_OPEat_1_7:=""
		
		va_OPEat_2_1:=""
		va_OPEat_2_2:=""
		va_OPEat_2_3:=""
		va_OPEat_2_4:=""
		va_OPEat_2_5:=""
		va_OPEat_2_6:=""
		va_OPEat_2_7:=""
		
		va_OPEat_3_1:=""
		va_OPEat_3_2:=""
		va_OPEat_3_3:=""
		va_OPEat_3_4:=""
		va_OPEat_3_5:=""
		va_OPEat_3_6:=""
		va_OPEat_3_7:=""
		
		va_OPEat_4_1:=""
		va_OPEat_4_2:=""
		va_OPEat_4_3:=""
		va_OPEat_4_4:=""
		va_OPEat_4_5:=""
		va_OPEat_4_6:=""
		va_OPEat_4_7:=""
		
		va_OPEat_5_1:=""
		va_OPEat_5_2:=""
		va_OPEat_5_3:=""
		va_OPEat_5_4:=""
		va_OPEat_5_5:=""
		va_OPEat_5_6:=""
		va_OPEat_5_7:=""
		
		va_OPEat_6_1:=""
		va_OPEat_6_2:=""
		va_OPEat_6_3:=""
		va_OPEat_6_4:=""
		va_OPEat_6_5:=""
		va_OPEat_6_6:=""
		va_OPEat_6_7:=""
End case 