//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_FichesAlaFoisBornes
//{          Lundi 5 mai 2011 à 12:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)

vl_AlaFois_FichesNoDe:=1+(vl_AlaFois_FichesParTour*($1-1))
vl_AlaFois_FichesNoA:=vl_AlaFois_FichesParTour+(vl_AlaFois_FichesParTour*($1-1))

If ($1=vl_AlaFois_NombreDeTours)
	If (vl_AlaFois_FichesDernierTour#vl_AlaFois_FichesParTour)
		vl_AlaFois_FichesNoA:=(vl_AlaFois_FichesParTour*($1-1))+vl_AlaFois_FichesDernierTour
	End if 
End if 