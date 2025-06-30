//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergéCtrlCréation
//{
//{          Mercredi 5 mai 2004 à 17:46:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($0)
$0:=0

C_LONGINT:C283($1)
C_LONGINT:C283($2)

If ($2=1)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
	MultiSoc_Filter(->[HeBerge:4])
End if 
If ([HeBerge:4]HB_Status:18)
	$0:=-1
Else 
	$0:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
	$0:=$0+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
End if 
