//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_SaisieDifféréeDate
//{
//{          Lundi 2 août 2004 à 15:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (<>vh_SD_Jour<?08:00:00?)
	<>vh_SD_Serveur:=?16:00:00?+<>vh_SD_Jour
Else 
	<>vh_SD_Serveur:=<>vh_SD_Jour-?08:00:00?
End if 

If (<>vh_SD_Serveur>=?00:00:00?) & (<>vh_SD_Serveur<=<>vh_SD_Jour)
	<>vd_SD_Serveur:=<>vd_SD_Jour
Else 
	<>vd_SD_Serveur:=Add to date:C393(<>vd_SD_Jour; 0; 0; -1)
End if 

If (Current date:C33=(<>vd_SD_Jour+1))
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=<>vd_SD_Jour)
	MultiSoc_Filter(->[HeberGement:5])
	
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Reporté:94=<>va_RepR; *)
	QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_Reporté:94=<>va_RepRE; *)
	<>vb_RéservationActive:=(Records in selection:C76([HeberGement:5])=0)
Else 
	<>vb_RéservationActive:=False:C215
End if 