//%attributes = {"executedOnServer":true}
// Method P_CalcStat_Direction2_etape4  
// 
// #DATE CREATION: 06/11/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_POINTER:C301($1)

C_LONGINT:C283($ii)
C_POINTER:C301($P_Objet)
C_OBJECT:C1216($O_Objet)

ARRAY TEXT:C222(<>ta_PopCT_Centre; 0)

ARRAY LONGINT:C221(<>tl_PopCT_DrTDem; 0)
ARRAY LONGINT:C221(<>tl_PopCT_DrTHg; 0)
ARRAY LONGINT:C221(<>tl_PopCT_DrTHgé; 0)
ARRAY LONGINT:C221(<>tl_PopCT_DrTPers; 0)
ARRAY LONGINT:C221(<>tl_PopCT_ID; 0)
ARRAY LONGINT:C221(<>ts_IDHB; 0)
ARRAY LONGINT:C221(<>ts_IDLC; 0)

ARRAY BOOLEAN:C223(<>ts_Cloturé; 0)
ARRAY BOOLEAN:C223(<>ts_Nuit; 0)

ARRAY DATE:C224(<>ts_Date; 0)

$P_Objet:=$1
$O_Objet:=OB Copy:C1225($P_Objet->)

OB GET ARRAY:C1229($O_Objet; "<>ta_PopCT_Centre"; <>ta_PopCT_Centre)
OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTDem"; <>tl_PopCT_DrTDem)
OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTHg"; <>tl_PopCT_DrTHg)
OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTHgé"; <>tl_PopCT_DrTHgé)
OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_DrTPers"; <>tl_PopCT_DrTPers)
OB GET ARRAY:C1229($O_Objet; "<>tl_PopCT_ID"; <>tl_PopCT_ID)
OB GET ARRAY:C1229($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
OB GET ARRAY:C1229($O_Objet; "<>ts_Date"; <>ts_Date)
OB GET ARRAY:C1229($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
OB GET ARRAY:C1229($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
OB GET ARRAY:C1229($O_Objet; "<>ts_Nuit"; <>ts_Nuit)

For ($ii; 1; Size of array:C274(<>ta_PopCT_Centre))
	USE SET:C118("E_encours")
	
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=<>tl_PopCT_ID{$ii})
	SELECTION TO ARRAY:C260([HeberGement:5]HG_Date:4; <>ts_Date; [HeberGement:5]HG_Nuit:2; <>ts_Nuit; [HeberGement:5]HG_HB_ID:19; <>ts_IDHB; [HeberGement:5]HG_LC_ID:61; <>ts_IDLC; [HeberGement:5]HG_Cloturée:67; <>ts_Cloturé)
	
	<>tl_PopCT_DrTDem{$ii}:=Records in selection:C76([HeberGement:5])
	
	RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
	MultiSoc_Filter(->[HeBerge:4])
	
	<>tl_PopCT_DrTPers{$ii}:=Records in selection:C76([HeBerge:4])
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
	
	<>tl_PopCT_DrTHg{$ii}:=Records in selection:C76([HeberGement:5])
	RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
	
	MultiSoc_Filter(->[HeBerge:4])
	
	<>tl_PopCT_DrTHgé{$ii}:=Records in selection:C76([HeBerge:4])
	P_ClacDirTab($ii)
End for 

OB SET ARRAY:C1227($O_Objet; "<>ta_PopCT_Centre"; <>ta_PopCT_Centre)
OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTDem"; <>tl_PopCT_DrTDem)
OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTHg"; <>tl_PopCT_DrTHg)
OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTHgé"; <>tl_PopCT_DrTHgé)
OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_DrTPers"; <>tl_PopCT_DrTPers)
OB SET ARRAY:C1227($O_Objet; "<>tl_PopCT_ID"; <>tl_PopCT_ID)
OB SET ARRAY:C1227($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
OB SET ARRAY:C1227($O_Objet; "<>ts_Date"; <>ts_Date)
OB SET ARRAY:C1227($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
OB SET ARRAY:C1227($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
OB SET ARRAY:C1227($O_Objet; "<>ts_Nuit"; <>ts_Nuit)

$P_Objet->:=OB Copy:C1225($O_Objet)