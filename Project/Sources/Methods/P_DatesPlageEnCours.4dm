//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_DatesPlageEnCours
//{
//{          Mercredi 9 décembre 2009 à 15:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
Case of 
	: ($1=0)
		C_LONGINT:C283(ve_Date_Cas)
		ve_Date_Cas:=0
		//Aujourd'hui : 0
		//Semaine en cours : 1
		//Quinzaine  en cours : 2
		//Mois  en cours : 4
		//Trimestre  en cours : 13
		//Semestre  en cours : 16
		//Année  en cours : 12
		If ($2)
			ARRAY TEXT:C222(ta_PlageEnCours; 9)
		Else 
			ARRAY TEXT:C222(ta_PlageEnCours; 7)
		End if 
		ta_PlageEnCours{1}:="Aujourd'hui"
		ta_PlageEnCours{2}:="Semaine en cours"
		ta_PlageEnCours{3}:="Quinzaine en cours"
		ta_PlageEnCours{4}:="Mois en cours"
		ta_PlageEnCours{5}:="Trimestre en cours"
		ta_PlageEnCours{6}:="Semestre en cours"
		ta_PlageEnCours{7}:="Année en cours"
		
		If ($2)
			ta_PlageEnCours{8}:="-"
			ta_PlageEnCours{9}:="RAZ"
		End if 
		
		ta_PlageEnCours:=1
		ta_PlageEnCours{0}:=ta_PlageEnCours{ta_PlageEnCours}
		
		
	: ($1=1)
		If (Size of array:C274(ta_PlageEnCours)>0)
			If (ta_PlageEnCours>0)
			Else 
				If (Find in array:C230(ta_PlageEnCours; ta_PlageEnCours{0})>0)
					ta_PlageEnCours:=Find in array:C230(ta_PlageEnCours; ta_PlageEnCours{0})
				Else 
					ta_PlageEnCours:=1
				End if 
			End if 
			ta_PlageEnCours{0}:=ta_PlageEnCours{ta_PlageEnCours}
			Case of 
				: (ta_PlageEnCours=1)  //"Aujourd'hui"
					ve_Date_Cas:=0
				: (ta_PlageEnCours=2)  //Semaine en cours"
					ve_Date_Cas:=1
				: (ta_PlageEnCours=3)  //Quinzaine en cours"
					ve_Date_Cas:=2
				: (ta_PlageEnCours=4)  //"Mois en cours"
					ve_Date_Cas:=4
				: (ta_PlageEnCours=5)  //"Trimestre en cours"
					ve_Date_Cas:=13
				: (ta_PlageEnCours=6)  //"Semestre en cours"
					ve_Date_Cas:=16
				: (ta_PlageEnCours=7)  //"Année en cours"
					ve_Date_Cas:=12
				: (ta_PlageEnCours=9)  //"RAZ"
					ve_Date_Cas:=20
					
			End case 
		Else 
			ve_Date_Cas:=0
		End if 
		$0:=True:C214
		
End case 