//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_appelListe
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

HIDE PROCESS:C324(<>PR_Appel)
SET MENU BAR:C67(1)
READ ONLY:C145(*)

C_LONGINT:C283(xxrJour)
C_LONGINT:C283(xxrNuit)

QUERY:C277([APpels:19]; [APpels:19]AP_UserID:1=<>vl_UserRéfU; *)
QUERY:C277([APpels:19];  & ; [APpels:19]AP_Date:2=Current date:C33)
vl_FichAP:=Records in selection:C76([APpels:19])
If (vl_FichAP>0)
	CREATE SET:C116([APpels:19]; "E_APliste")
Else 
	CREATE EMPTY SET:C140([APpels:19]; "E_APliste")
End if 
If (Current time:C178>=?08:00:00?) & (Current time:C178<=?20:00:00?)
	xxrJour:=1
	xxrNuit:=0
	QUERY SELECTION:C341([APpels:19]; [APpels:19]AP_Nuit:4=False:C215)
Else 
	xxrJour:=0
	xxrNuit:=1
	QUERY SELECTION:C341([APpels:19]; [APpels:19]AP_Nuit:4=True:C214)
End if 
vl_FichAP:=Records in selection:C76([APpels:19])
ORDER BY:C49([APpels:19]; [APpels:19]AP_Date:2; <; *)
ORDER BY:C49([APpels:19]; [APpels:19]AP_Heure:3; <)
READ WRITE:C146([APpels:19])
FORM SET INPUT:C55([APpels:19]; "AP_EcranSaisie")
$vl_Fenetre:=i_FenêtreNo(347; 339; 4; "Appels : liste"; 3; "")
FORM SET INPUT:C55([DePart:1]; "DP_Appels")
ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([APpels:19])

Process_Show(<>PR_Appel)
<>PR_AppelLis:=0