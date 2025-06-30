//%attributes = {"executedOnServer":true}
// Method P_CalcStat_Direction_etape1  
// 
// ce code est déplacé pour être exécuté sur le serveur

C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

ARRAY BOOLEAN:C223(<>ts_Cloturé; 0)
ARRAY BOOLEAN:C223(<>ts_Nuit; 0)
ARRAY DATE:C224(<>ts_Date; 0)
ARRAY LONGINT:C221(<>ts_IDHB; 0)
ARRAY LONGINT:C221(<>ts_IDLC; 0)

rReport:=OB Get:C1224($O_Objet; "rReport"; Est un entier long:K8:6)
u2:=OB Get:C1224($O_Objet; "u2"; Est un entier long:K8:6)
vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)
vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)
vl_DrTDem:=OB Get:C1224($O_Objet; "vl_DrTDem"; Est un entier long:K8:6)
vl_DrTHg:=OB Get:C1224($O_Objet; "vl_DrTHg"; Est un entier long:K8:6)
vl_DrTHgé:=OB Get:C1224($O_Objet; "vl_DrTHgé"; Est un entier long:K8:6)
vl_DrTHgé2:=OB Get:C1224($O_Objet; "vl_DrTHgé2"; Est un entier long:K8:6)
vl_DrTPers:=OB Get:C1224($O_Objet; "vl_DrTPers"; Est un entier long:K8:6)
vl_DrTPers2:=OB Get:C1224($O_Objet; "vl_DrTPers2"; Est un entier long:K8:6)
vl_NbHB:=OB Get:C1224($O_Objet; "vl_NbHB"; Est un entier long:K8:6)

OB GET ARRAY:C1229($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
OB GET ARRAY:C1229($O_Objet; "<>ts_Date"; <>ts_Date)
OB GET ARRAY:C1229($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
OB GET ARRAY:C1229($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
OB GET ARRAY:C1229($O_Objet; "<>ts_Nuit"; <>ts_Nuit)


If (vd_Date1=vd_Date2)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
Else 
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
End if 
If (rReport=0)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
End if 
//Sans les inconnus
If (u2=1)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21#"X0@"; *)
End if 
QUERY:C277([HeberGement:5])

MultiSoc_Filter(->[HeberGement:5])

vl_NbHB:=Records in selection:C76([HeberGement:5])
If (vl_NbHB>0)
	CREATE SET:C116([HeberGement:5]; "E_encours")
Else 
	CREATE EMPTY SET:C140([HeberGement:5]; "E_encours")
End if 
SELECTION TO ARRAY:C260([HeberGement:5]HG_Date:4; <>ts_Date; [HeberGement:5]HG_Nuit:2; <>ts_Nuit; [HeberGement:5]HG_HB_ID:19; <>ts_IDHB; [HeberGement:5]HG_LC_ID:61; <>ts_IDLC; [HeberGement:5]HG_Cloturée:67; <>ts_Cloturé)

vl_DrTDem:=Records in selection:C76([HeberGement:5])
RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
vl_DrTPers2:=Records in selection:C76([HeBerge:4])
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >)
//FIRST RECORD([HeberGement])

C_LONGINT:C283($viiRéf)
$viiRéf:=0
vl_DrTPers:=0
Repeat 
	If ([HeberGement:5]HG_HB_ID:19#$viiRéf)
		vl_DrTPers:=vl_DrTPers+1
		$viiRéf:=[HeberGement:5]HG_HB_ID:19
	End if 
	NEXT RECORD:C51([HeberGement:5])
Until (End selection:C36([HeberGement:5]))

USE SET:C118("E_encours")
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
vl_DrTHg:=Records in selection:C76([HeberGement:5])
RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
vl_DrTHgé2:=Records in selection:C76([HeBerge:4])
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >)
FIRST RECORD:C50([HeberGement:5])
$viiRéf:=0
vl_DrTHgé:=0
Repeat 
	If ([HeberGement:5]HG_HB_ID:19#$viiRéf)
		vl_DrTHgé:=vl_DrTHgé+1
		$viiRéf:=[HeberGement:5]HG_HB_ID:19
	End if 
	NEXT RECORD:C51([HeberGement:5])
Until (End selection:C36([HeberGement:5]))


OB SET:C1220($O_Objet; "rReport"; rReport)
OB SET:C1220($O_Objet; "u2"; u2)
OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
OB SET:C1220($O_Objet; "vl_DrTDem"; vl_DrTDem)
OB SET:C1220($O_Objet; "vl_DrTHg"; vl_DrTHg)
OB SET:C1220($O_Objet; "vl_DrTHgé"; vl_DrTHgé)
OB SET:C1220($O_Objet; "vl_DrTHgé2"; vl_DrTHgé2)
OB SET:C1220($O_Objet; "vl_DrTPers"; vl_DrTPers)
OB SET:C1220($O_Objet; "vl_DrTPers2"; vl_DrTPers2)
OB SET:C1220($O_Objet; "vl_NbHB"; vl_NbHB)

OB SET ARRAY:C1227($O_Objet; "<>ts_Cloturé"; <>ts_Cloturé)
OB SET ARRAY:C1227($O_Objet; "<>ts_Date"; <>ts_Date)
OB SET ARRAY:C1227($O_Objet; "<>ts_IDHB"; <>ts_IDHB)
OB SET ARRAY:C1227($O_Objet; "<>ts_IDLC"; <>ts_IDLC)
OB SET ARRAY:C1227($O_Objet; "<>ts_Nuit"; <>ts_Nuit)



$P_Objet->:=OB Copy:C1225($O_Objet)
