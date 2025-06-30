//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure:  P_DisponibilitéNewCentre
//{
//{          Lundi 27 décembre 2004 à 15:27:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($forcePassage_b)
C_DATE:C307($vd_Date)

QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=$vd_Date)
MultiSoc_Filter(->[CentresLits:16])

If (Count parameters:C259=0)
	$vd_Date:=Current date:C33
Else 
	$vd_Date:=Date:C102(Request:C163("A quelle date souhaitez vous créer les disponibilités ?"; String:C10(Current date:C33)))
	$forcePassage_b:=$1
	If (ok=0)
		return 
	End if 
End if 

If (Records in selection:C76([CentresLits:16])>0) | ($forcePassage_b=True:C214)
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2=[LesCentres:9]LC_RéférenceID:1)
	
	If (Records in selection:C76([CentresLits:16])=0)
		READ WRITE:C146([CentresLits:16])
		
		If ([LesCentres:9]LC_Fermé:53=False:C215)
			P_DisponibilitéCréer(3; "J"; $vd_Date; 0; 0; 0; 0; 0)
			P_DisponibilitéCréer(3; "N"; $vd_Date; 0; 0; 0; 0; 0)
		End if 
		
		READ ONLY:C145([CentresLits:16])
	End if 
	
End if 