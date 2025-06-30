//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_PréparerDispos
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

//CHANGER BARRE(1)

C_DATE:C307(vd_DateSel0; vd_DateSel1; vd_DateSel2; vd_DateSelx)
C_LONGINT:C283(vl_Jour; vl_nuit)
i_Message("Chargement en cours…")
ALL RECORDS:C47([CentresLits:16])
MultiSoc_Filter(->[CentresLits:16])
ORDER BY:C49([CentresLits:16]; [CentresLits:16]CL_Date:3; <)
vd_DateSel0:=[CentresLits:16]CL_Date:3
vd_DateSel1:=vd_DateSel0+1
vd_DateSel2:=vd_DateSel1
va_Titre:="Préparation des disponibilités"
CLOSE WINDOW:C154


$vl_Fenetre:=i_FenêtreNo(466; 212; 5; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_PrépDispo")
CLOSE WINDOW:C154($vl_Fenetre)
//◊PR_PrépDis:=0
