//%attributes = {"executedOnServer":true}
// Method P_CalcSat_EMA_partie1  
// 

C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

rJourNuit1:=OB Get:C1224($O_Objet; "rJourNuit1"; Est un entier long:K8:6)
rJourNuit2:=OB Get:C1224($O_Objet; "rJourNuit2"; Est un entier long:K8:6)
vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)
vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)
vl_NbHB:=OB Get:C1224($O_Objet; "vl_NbHB"; Est un entier long:K8:6)
vl_NbHBd:=OB Get:C1224($O_Objet; "vl_NbHBd"; Est un entier long:K8:6)
vl_NbHBdf:=OB Get:C1224($O_Objet; "vl_NbHBdf"; Est un entier long:K8:6)
vl_NbHBdm:=OB Get:C1224($O_Objet; "vl_NbHBdm"; Est un entier long:K8:6)
vl_NbHBf:=OB Get:C1224($O_Objet; "vl_NbHBf"; Est un entier long:K8:6)
vl_NbHBm:=OB Get:C1224($O_Objet; "vl_NbHBm"; Est un entier long:K8:6)



If (vd_Date1=vd_Date2)
	QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4=vd_Date1; *)
Else 
	QUERY:C277([Maraude:24]; [Maraude:24]MR_Date:4>=vd_Date1; *)
	QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Date:4<=vd_Date2; *)
End if 

If (rJourNuit1=1) & (rJourNuit2=1)  //Jour et nuit
	
Else 
	If (rJourNuit1=1)  //Jour
		QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=False:C215; *)
	End if 
	If (rJourNuit2=1)  //nuit
		QUERY:C277([Maraude:24];  & ; [Maraude:24]MR_Nuit:2=True:C214; *)
	End if 
End if 
QUERY:C277([Maraude:24])
MultiSoc_Filter(->[Maraude:24])
vl_NbHB:=Records in selection:C76([Maraude:24])


If (vl_NbHB>0)
	CREATE SET:C116([Maraude:24]; "E_encours")
	USE SET:C118("E_encours")
	vl_NbHB:=Records in set:C195("E_encours")
	QUERY SELECTION:C341([Maraude:24]; [Maraude:24]MR_Genre:42=False:C215)
	vl_NbHBm:=Records in selection:C76([Maraude:24])
	vl_NbHBf:=vl_NbHB-vl_NbHBm
Else 
	CREATE EMPTY SET:C140([Maraude:24]; "E_encours")
	//Nombre de fiches ; Hommes; Femmes
	vl_NbHB:=0
	vl_NbHBm:=0
	vl_NbHBf:=0
	//Nombre de personnes ; Hommes; Femmes
	vl_NbHBd:=0
	vl_NbHBdm:=0
	vl_NbHBdf:=0
End if 


OB SET:C1220($O_Objet; "rJourNuit1"; rJourNuit1)
OB SET:C1220($O_Objet; "rJourNuit2"; rJourNuit2)
OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)
OB SET:C1220($O_Objet; "vd_Date2"; vd_Date2)
OB SET:C1220($O_Objet; "vl_NbHB"; vl_NbHB)
OB SET:C1220($O_Objet; "vl_NbHBd"; vl_NbHBd)
OB SET:C1220($O_Objet; "vl_NbHBdf"; vl_NbHBdf)
OB SET:C1220($O_Objet; "vl_NbHBdm"; vl_NbHBdm)
OB SET:C1220($O_Objet; "vl_NbHBf"; vl_NbHBf)
OB SET:C1220($O_Objet; "vl_NbHBm"; vl_NbHBm)

$P_Objet->:=OB Copy:C1225($O_Objet)