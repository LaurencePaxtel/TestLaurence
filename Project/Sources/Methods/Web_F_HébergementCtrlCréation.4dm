//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergementCtrlCréation
//{
//{          Mardi 16 mars 2004 à 12:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($vb_Nuit)

vb_PasseR:=True:C214
vl_NbHéberGements:=0

If (vb_PasseR)
	$vb_Nuit:=($1="N")
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=$vb_Nuit)
	MultiSoc_Filter(->[HeberGement:5])
	
	vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
End if 

$0:=vb_PasseR