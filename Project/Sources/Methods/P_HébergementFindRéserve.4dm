//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementFindRéserve
//{
//{          Mercredi 9 décembre 2009 à 15:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($vl_Fenetre)
Case of 
	: ($1=0)
		//éléments de recherche supplémentaire
		//Pour les réservation
		//Touts 0/DernièreNuit 1/Pas dernière nuit 2
		C_LONGINT:C283(ve_RecReservation)  //O;1;2
		C_LONGINT:C283(ve_RecResDer1)
		C_LONGINT:C283(ve_RecResDer2)
		C_LONGINT:C283(ve_RecResPasDer1)
		C_LONGINT:C283(ve_RecResPasDer2)
		ve_RecReservation:=0
		ve_RecResDer1:=0
		ve_RecResDer2:=0
		ve_RecResPasDer1:=0
		ve_RecResPasDer2:=0
		
	: ($1=1)
		$vl_Fenetre:=i_FenêtreNo(466; 252; 5; "Critères de recherche par réservation"; 4; "")
		DIALOG:C40([DiaLogues:3]; "DL_RecReservation")
		CLOSE WINDOW:C154($vl_Fenetre)
		
End case 