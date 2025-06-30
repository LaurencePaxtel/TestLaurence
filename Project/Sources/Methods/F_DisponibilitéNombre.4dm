//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction:  F_DisponibilitéNombre
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_DATE:C307($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)

If ($2=1)
	i_Message("Recherche en cours …")
End if 

QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=$1)
MultiSoc_Filter(->[CentresLits:16])

QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)

$3->:=Records in selection:C76([CentresLits:16])

QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8="N")
$5->:=Records in selection:C76([CentresLits:16])

QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=$1)
MultiSoc_Filter(->[CentresLits:16])

QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin; *)
QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_Type:8="J")

$4->:=Records in selection:C76([CentresLits:16])

If ($2=1)
	CLOSE WINDOW:C154
End if 

If ($3->=0) | ($5->=0) | ($4->=0)
	
	If ($2=1)
		CONFIRM:C162("Annuler si vous avez oublié de mettre à jour les absences dans les reports.")
		$0:=(OK=1)
	Else 
		$0:=True:C214  //Modifié le 7/7/2008
	End if 
	
End if 