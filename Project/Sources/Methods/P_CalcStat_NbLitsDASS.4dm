//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbLitsDASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Voir P_CalcStat_NbLits
//{==================================================}
vl_lit_At:=0
vl_lit_Dist:=0
vl_lit_Rest:=0
vr_lit_Pc:=0

C_LONGINT:C283($vl_At; $vl_Dist; $vl_Rest)
$vl_At:=0
$vl_Dist:=0
$vl_Rest:=0
CREATE EMPTY SET:C140([CentresLits:16]; "E_CLCourant")
If (vd_Date1=vd_Date2)
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=vd_Date1)
Else 
	QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3>=vd_Date1; *)
	QUERY:C277([CentresLits:16];  & ; [CentresLits:16]CL_Date:3<=vd_Date2)
	MultiSoc_Filter(->[CentresLits:16])
End if 


CREATE SET:C116([CentresLits:16]; "E_CLCourant")
USE SET:C118("E_CLCourant")
QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8="J")
If (Records in selection:C76([CentresLits:16])>0)
	$vl_At:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
	$vl_Dist:=Sum:C1([CentresLits:16]CL_Distribué:6)
	$vl_Rest:=Sum:C1([CentresLits:16]CL_Restant:7)
	$vl_At:=$vl_At-$vl_Rest
End if 
USE SET:C118("E_CLCourant")
QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8="N")
If (Records in selection:C76([CentresLits:16])>0)
	vl_lit_At:=Sum:C1([CentresLits:16]CL_DispoTotal:5)
	vl_lit_Dist:=Sum:C1([CentresLits:16]CL_Distribué:6)
	vl_lit_Rest:=Sum:C1([CentresLits:16]CL_Restant:7)
End if 
vl_lit_At:=vl_lit_At+$vl_At
vl_lit_Dist:=vl_lit_Dist+$vl_Dist

If (vl_lit_At>0)
	vr_lit_Pc:=(vl_lit_Dist/vl_lit_At)*100
Else 
	vr_lit_Pc:=0
End if 
