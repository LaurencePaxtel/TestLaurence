//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_FichesAlaFois
//{          Lundi 5 mai 2011 à 12:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)

//Ici repeter la boucle car tout charger en une fois est périlleux
//Alors on en prend 50 à la fois


vl_AlaFois_FichesNombre:=$1
vl_AlaFois_FichesParTour:=50

vl_AlaFois_NombreDeTours:=vl_AlaFois_FichesNombre\vl_AlaFois_FichesParTour

vl_AlaFois_FichesDernierTour:=vl_AlaFois_FichesNombre%vl_AlaFois_FichesParTour

If (vl_AlaFois_NombreDeTours<=0)
	vl_AlaFois_NombreDeTours:=1
	vl_AlaFois_FichesDernierTour:=vl_AlaFois_FichesNombre
Else 
	If (vl_AlaFois_FichesDernierTour>0)
		vl_AlaFois_NombreDeTours:=vl_AlaFois_NombreDeTours+1
	Else 
		vl_AlaFois_FichesDernierTour:=vl_AlaFois_FichesParTour
	End if 
	
End if 