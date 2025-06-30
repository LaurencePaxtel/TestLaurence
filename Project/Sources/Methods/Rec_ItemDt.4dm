//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_ItemDt
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
MESSAGES ON:C181
If (vd_item1>!00-00-00!)
	If (vd_item1>vd_item2)
		vd_item0:=vd_item1
		vd_item1:=vd_item2
		vd_item2:=vd_item0
	End if 
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=1)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_item1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_item2)
			
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_item1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_item2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		: (rJourNuit1=0) & (rJourNuit2=1)
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_item1; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_item2; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214)
		: (rJourNuit1=0) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=-100)
	End case 
	
	
	
Else 
	Case of 
		: (rJourNuit1=1) & (rJourNuit2=1)
			ALL RECORDS:C47([HeberGement:5])
			MultiSoc_Filter(->[HeberGement:5])
		: (rJourNuit1=1) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		: (rJourNuit1=0) & (rJourNuit2=1)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
		: (rJourNuit1=0) & (rJourNuit2=0)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=-100)
	End case 
End if 
MESSAGES OFF:C175
MultiSoc_Filter(->[HeberGement:5])
FIRST RECORD:C50([HeberGement:5])
vl_itemNb:=Records in selection:C76([HeberGement:5])
