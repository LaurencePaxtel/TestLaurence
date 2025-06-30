//%attributes = {"executedOnServer":true}
// Method CentreLits_dispo_lire retourne le nombre place dispo sur le jour ou la nuit 
// 
// 
// #SYNTAX: $L_Trouve:=CentreLits_dispo_lire(->Objet) 
// #PARAMETERS:
//     $0 Long            : Places trouvées
//     $1 Pointer         : Objet

// #DATE CREATION: 26/01/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// sur le serveur !


If (Application type:C494=4D Server:K5:6)
	READ ONLY:C145(*)
End if 

C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1

C_DATE:C307($D_DateRecherche)
$D_DateRecherche:=OB Get:C1224($P_Objet->; "date"; Est une date:K8:7)
C_TEXT:C284($T_JourNuit)
$T_JourNuit:=OB Get:C1224($P_Objet->; "journuit"; Est un texte:K8:3)
C_LONGINT:C283($L_ID_Centre)
$L_ID_Centre:=OB Get:C1224($P_Objet->; "centre"; Est un entier long:K8:6)

C_TEXT:C284($T_Cle)
$T_Cle:=Uut_NumeroteLitsType($D_DateRecherche; $T_JourNuit)+Uut_NumeroteLitsID($L_ID_Centre)




SET QUERY LIMIT:C395(1)
QUERY BY FORMULA:C48([CentresLits:16]; [CentresLits:16]CL_DateTypeIDLC:10=$T_Cle)
MultiSoc_Filter(->[CentresLits:16])
SET QUERY LIMIT:C395(0)

OB SET:C1220($P_Objet->; "restant"; [CentresLits:16]CL_Restant:7)
OB SET:C1220($P_Objet->; "type"; [CentresLits:16]CL_Type:8)

// EOM

