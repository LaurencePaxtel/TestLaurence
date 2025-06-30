//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 30/06/21, 11:45:44
// ----------------------------------------------------
// Méthode : outilsManagePopupDateGenerique
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)  // Point d'entrée
C_POINTER:C301($2)  // Tableau du sélecteur de tranche de date
C_POINTER:C301($3)  // Pointeur de la variable date début
C_POINTER:C301($4)  // Pointeur de la variable date fin

C_LONGINT:C283($cas_el)

Case of 
	: ($1=1)  // Initialisation
		$2->{1}:="Aujourd'hui"
		$2->{2}:="Semaine en cours"
		$2->{3}:="Quinzaine en cours"
		$2->{4}:="Mois en cours"
		$2->{5}:="Trimestre en cours"
		$2->{6}:="Semestre en cours"
		$2->{7}:="Année en cours"
		
		$2->{0}:="Choix de la période"
	: ($1=2)  // Sur clic
		
		If (Size of array:C274($2->)>0)
			
			If ($2-><0)
				
				If (Find in array:C230($2->; $2->{0})>0)
					$2->:=Find in array:C230($2->; $2->{0})
				Else 
					$2->:=1
				End if 
				
			End if 
			
			$2->{0}:=$2->{$2->}
			
			Case of 
				: ($2->=1)  //"Aujourd'hui"
				: ($2->=2)  //Semaine en cours"
					$cas_el:=1
				: ($2->=3)  //Quinzaine en cours"
					$cas_el:=2
				: ($2->=4)  //"Mois en cours"
					$cas_el:=4
				: ($2->=5)  //"Trimestre en cours"
					$cas_el:=13
				: ($2->=6)  //"Semestre en cours"
					$cas_el:=16
				: ($2->=7)  //"Année en cours"
					$cas_el:=12
			End case 
			
		End if 
		
		F_PlageEnCours($cas_el; 0; $3; $4)
End case 