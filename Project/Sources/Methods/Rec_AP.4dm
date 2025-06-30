//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_AP
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ((rJour=1) & (rNuit=1)) | ((rJour=1) & (rNuit=1))
	USE SET:C118("E_APliste")
Else 
	USE SET:C118("E_APliste")
	If (rJour=1)
		QUERY SELECTION:C341([APpels:19]; [APpels:19]AP_Nuit:4=False:C215)
	Else 
		QUERY SELECTION:C341([APpels:19]; [APpels:19]AP_Nuit:4=True:C214)
	End if 
End if 
vl_FichAP:=Records in selection:C76([APpels:19])
ORDER BY:C49([APpels:19]; [APpels:19]AP_Date:2; <; *)
ORDER BY:C49([APpels:19]; [APpels:19]AP_Heure:3; <)