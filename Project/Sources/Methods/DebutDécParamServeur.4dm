//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : DebutDécParamServeur
//{
//{          Mercredi 18 février 2009 à 21:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_DATE:C307(<>vd_SD_Serveur; <>vd_SD_Jour)
C_TIME:C306(<>vh_SD_Serveur; <>vh_SD_Jour)
C_TEXT:C284(<>va_HG_Coordinateur)
<>va_HG_Coordinateur:=""
C_TEXT:C284(<>va_HG_Régulateur)
<>va_HG_Régulateur:=""
DébutInitCoord(0)

DébutInitFam(0)

C_TEXT:C284(<>va_HG_SignalF1)
C_TEXT:C284(<>va_HG_SignalF2)
C_TEXT:C284(<>va_HG_SignalF3)
<>va_HG_SignalF1:=""
<>va_HG_SignalF2:=""
<>va_HG_SignalF3:=""
DébutInitSignal(0)


//C_TEXTE(<>va_CentreEXC)
//C_BOOLÉEN(<>vb_CentreEXC)
//<>va_CentreEXC:="N"
//<>vb_CentreEXC:=Faux
//C_TEXTE(<>va_CentreEXCExc)
//<>va_CentreEXCExc:="N"
//C_BOOLÉEN(<>vb_CentreEXCExc)
//<>vb_CentreEXCExc:=Faux
//C_TEXTE(<>va_CentreEXCSor)
//<>va_CentreEXCExc:="N"

//Plage horaire nuit
C_TIME:C306(<>vh_CentreEXChD)
C_TIME:C306(<>vh_CentreEXChF)
<>vh_CentreEXChD:=?00:00:01?
<>vh_CentreEXChF:=?23:59:59?

//C_BOOLÉEN(<>vb_CentreEXClits)
//<>vb_CentreEXClits:=Faux
//DébutInitCentreEXC(0)

C_TEXT:C284(<>va_HG_AutreSolStd)
C_TEXT:C284(<>va_HG_AutreSolExc)
C_TEXT:C284(<>va_HG_AutreSolRemp)
DébutInitASol(0)

C_TEXT:C284(<>va_RADAutresolution)
<>va_RADAutresolution:="RAD Excusée"

C_TEXT:C284(<>va_SADAutresolution)
<>va_SADAutresolution:="SAD Remplaçant"

C_BOOLEAN:C305(<>vb_AvecProlongation)
<>vb_AvecProlongation:=False:C215


C_BOOLEAN:C305(<>vb_ProLg_Prolongation)
C_BOOLEAN:C305(<>vb_ProLg_FinMois)
C_LONGINT:C283(<>ve_ProLg_Le)
C_LONGINT:C283(<>ve_ProLg_MaxMois)

<>vb_ProLg_Prolongation:=False:C215
<>ve_ProLg_Le:=0
<>ve_ProLg_MaxMois:=0
DébutInitProLg(0)