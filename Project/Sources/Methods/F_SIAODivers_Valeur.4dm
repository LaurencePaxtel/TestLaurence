//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Fonction : F_SIAODivers_Valeur
//{          Mardi 29 mars 2011 à 15:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_TEXT:C284($1)
$0:=""
QUERY:C277([SIAO_Divers:58]; [SIAO_Divers:58]Sd_Clé:2=$1)
MultiSoc_Filter(->[SIAO_Divers:58])
If (Records in selection:C76([SIAO_Divers:58])=1)
	$0:=[SIAO_Divers:58]Sd_Valeur:4
End if 