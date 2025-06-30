//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CL_LitsExcusés
//{
//{          Mercredi 12 mai 2004 à 14:52:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($vb_SToP)
$vb_SToP:=False:C215
READ WRITE:C146([CentresLits:16])
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID_date:1=Uut_NumeroteLits($1; $2))
MultiSoc_Filter(->[CentresLits:16])
If (Records in selection:C76([CentresLits:16])>0)
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8=$4)
	If (Records in selection:C76([CentresLits:16])=1)
		Repeat 
			LOAD RECORD:C52([CentresLits:16])
			i_Message("Veuillez patienter !")
			If (Locked:C147([CentresLits:16]))
				i_MessageSeul("Veuillez patienter !")
			Else 
				$vb_SToP:=True:C214
				[CentresLits:16]CL_Excusés:14:=[CentresLits:16]CL_Excusés:14-$3
				[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6-$3
				[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7+$3  // [CentresLits]CL_Restant
				SAVE RECORD:C53([CentresLits:16])
				UNLOAD RECORD:C212([CentresLits:16])
			End if 
			CLOSE WINDOW:C154
		Until ($vb_SToP)
	End if 
End if 
UNLOAD RECORD:C212([CentresLits:16])
READ ONLY:C145([CentresLits:16])