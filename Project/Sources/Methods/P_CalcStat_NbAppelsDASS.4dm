//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CalcStat_NbAppelsDASS
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Voir : P_CalcStat_NbAppels
//{==================================================}
vl_AP_Nb:=0
vl_AP_NbOui:=0
vl_Lit_Oui:=0
If (vd_Date1=vd_Date2)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=vd_Date1; *)
Else 
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_Date2; *)
End if 
If (rReport=0)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
End if 
QUERY:C277([HeberGement:5])
vl_AP_Nb:=Records in selection:C76([HeberGement:5])
If (vl_AP_Nb>0)
	CREATE SET:C116([HeberGement:5]; "E_HGStat")
Else 
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStat")
End if 
QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
MultiSoc_Filter(->[HeberGement:5])
vl_AP_NbOui:=Records in selection:C76([HeberGement:5])
If (vl_AP_NbOui>0)
	CREATE SET:C116([HeberGement:5]; "E_HGStatClôt")
Else 
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HGStatClôt")
End if 
vl_Lit_Oui:=vl_AP_NbOui
If (vl_AP_Nb>0)
	vl_AP_Pc:=(vl_AP_NbOui/vl_AP_Nb)*100
Else 
	vl_AP_Pc:=0
End if 