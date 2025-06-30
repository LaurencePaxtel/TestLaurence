//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 04/05/21, 16:50:13
// ----------------------------------------------------
// Méthode : outilsManagePopupDate
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_LONGINT:C283($4)

Case of 
	: ($1=1)  // Initialisation
		C_LONGINT:C283(ve_Date_Cas)
		
		ARRAY TEXT:C222(ta_PlageEnCours; 7)
		
		ta_PlageEnCours{1}:="Aujourd'hui"
		ta_PlageEnCours{2}:="Semaine en cours"
		ta_PlageEnCours{3}:="Quinzaine en cours"
		ta_PlageEnCours{4}:="Mois en cours"
		ta_PlageEnCours{5}:="Trimestre en cours"
		ta_PlageEnCours{6}:="Semestre en cours"
		ta_PlageEnCours{7}:="Année en cours"
		
		ta_PlageEnCours{0}:="Choix de la période"
	: ($1=2)  // Sur clic
		
		If (Size of array:C274(ta_PlageEnCours)>0)
			
			If (ta_PlageEnCours<0)
				
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
			End case 
			
		Else 
			ve_Date_Cas:=0
		End if 
		
		F_PlageEnCours(ve_Date_Cas; 0; $2; $3)
	: ($1=3)  // Sur clic navigation rapide
		F_PlageEnCours(ve_Date_Cas; $4; $2; $3)
End case 