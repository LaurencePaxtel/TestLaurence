//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementFindAge
//{
//{          Mercredi 9 décembre 2009 à 15:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($vl_Fenetre)
Case of 
	: ($1=0)
		C_LONGINT:C283(ve_RecAge; ve_RecAgeDebut; ve_RecAgeFin)
		C_DATE:C307(vd_RecAge; vd_RecAgeDebut; vd_RecAgeFin)
		ve_RecAge:=0
		ve_RecAgeDebut:=0
		ve_RecAgeFin:=0
		vd_RecAge:=Current date:C33
		vd_RecAgeDebut:=!00-00-00!
		vd_RecAgeFin:=!00-00-00!
		
	: ($1=1)
		$vl_Fenetre:=i_FenêtreNo(466; 252; 5; "Critères de recherche par tranches d'âges"; 4; "")
		DIALOG:C40([DiaLogues:3]; "DL_RecTrAges")
		CLOSE WINDOW:C154($vl_Fenetre)
End case 