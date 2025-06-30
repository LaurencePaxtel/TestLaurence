//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_CL_DispoCalc
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_DATE:C307($1)

vl_CHCapaJ:=0
vl_CHCapaN:=0

vl_CHRepor:=0
vl_CHReporJ:=0
vl_CHReporN:=0

vl_CHDispjJ:=0
vl_CHDispjN:=0
vl_CHDispTJ:=0
vl_CHDispTN:=0

vl_CHDistrJ:=0
vl_CHDistrN:=0

vl_CHRest:=0
vl_CHRestJ:=0
vl_CHRestN:=0
vl_CHReste:=0
vl_CHResteJ:=0
vl_CHResteN:=0

vl_CHWait:=0
vl_CHWaitJ:=0
vl_CHWaitN:=0

i_Message("Recherche en cours…")
va_DateType:=Uut_NumeroteLitsType($1; "J")

i_MessageSeul("Recherche en cours  1/6")
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
MultiSoc_Filter(->[CentresLits:16])
vl_CHCapaJ:=Sum:C1([CentresLits:16]CL_Capacité:4)
vl_CHReporJ:=Sum:C1([CentresLits:16]CL_Report:11)
vl_CHDispjJ:=Sum:C1([CentresLits:16]CL_DispoDuJour:12)
vl_CHDispTJ:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
vl_CHDistrJ:=Sum:C1([CentresLits:16]CL_Distribué:6)
vl_CHRestJ:=vl_CHDispTJ-vl_CHDistrJ

i_MessageSeul("Recherche en cours  2/6")
va_DateType:=Uut_NumeroteLitsType($1; "N")
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateType:9=va_DateType)
MultiSoc_Filter(->[CentresLits:16])
vl_CHCapaN:=Sum:C1([CentresLits:16]CL_Capacité:4)
vl_CHReporN:=Sum:C1([CentresLits:16]CL_Report:11)
vl_CHDispjN:=Sum:C1([CentresLits:16]CL_DispoDuJour:12)
vl_CHDispTN:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
vl_CHDistrN:=Sum:C1([CentresLits:16]CL_Distribué:6)
vl_CHRestN:=vl_CHDispTN-vl_CHDistrN

i_MessageSeul("Recherche en cours  3/6")
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$1; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_EnAttente:64=True:C214)
MultiSoc_Filter(->[HeberGement:5])
vl_CHWait:=Records in selection:C76([HeberGement:5])

i_MessageSeul("Recherche en cours  4/6")
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
vl_CHWaitN:=Records in selection:C76([HeberGement:5])
vl_CHWaitJ:=vl_CHWait-vl_CHWaitN

If (vl_CHWaitJ>=0)
	vl_CHResteJ:=vl_CHRestJ-vl_CHWaitJ
End if 
If (vl_CHWaitN>=0)
	vl_CHResteN:=vl_CHRestN-vl_CHWaitN
End if 

//vl_CHRpT:=0
//vl_CHRpJ:=0
//vl_CHRpN:=0

vl_CHRepor:=0
vl_CHReporJ:=0
vl_CHReporN:=0
i_MessageSeul("Recherche en cours  5/6")
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=($1-1); *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Réservation:91=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95>0; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Reporté:94#<>va_RepA)
MultiSoc_Filter(->[HeberGement:5])
vl_CHRepor:=Records in selection:C76([HeberGement:5])

i_MessageSeul("Recherche en cours  6/6")
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
vl_CHReporN:=Records in selection:C76([HeberGement:5])
vl_CHReporJ:=vl_CHRepor-vl_CHReporN

CLOSE WINDOW:C154