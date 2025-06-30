//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_Item
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

If (vd_item1>!00-00-00!)
	
	If (vd_item1>vd_item2)
		vd_item0:=vd_item1
		vd_item1:=vd_item2
		vd_item2:=vd_item0
	End if 
	
	If (vd_Néle1>vd_Néle2)
		vd_Néle3:=vd_Néle2
		vd_Néle2:=vd_Néle1
		vd_Néle1:=vd_Néle3
	End if 
	
	MESSAGES ON:C181
	
	If (ta_ItemRub=8)
		
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=1)
				Rec_ItemBase
				QUERY:C277([HeberGement:5];  & ; tp_ItemRub{ta_ItemRub}->=Date:C102(va_IDT_Typ2))
				
			: (rJourNuit1=1) & (rJourNuit2=0)
				Rec_ItemBase
				
				QUERY:C277([HeberGement:5];  & ; tp_ItemRub{ta_ItemRub}->=Date:C102(va_IDT_Typ2); *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
			: (rJourNuit1=0) & (rJourNuit2=1)
				Rec_ItemBase
				
				QUERY:C277([HeberGement:5];  & ; tp_ItemRub{ta_ItemRub}->=Date:C102(va_IDT_Typ2); *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214)
			: (rJourNuit1=0) & (rJourNuit2=0)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=-100)
		End case 
		
		MultiSoc_Filter(->[HeberGement:5])
		
	Else 
		
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=1)
				Rec_ItemBase
				
				QUERY:C277([HeberGement:5];  & ; tp_ItemRub{ta_ItemRub}->=va_IDT_Typ2)
			: (rJourNuit1=1) & (rJourNuit2=0)
				Rec_ItemBase
				
				QUERY:C277([HeberGement:5];  & ; tp_ItemRub{ta_ItemRub}->=va_IDT_Typ2; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
			: (rJourNuit1=0) & (rJourNuit2=1)
				Rec_ItemBase
				
				QUERY:C277([HeberGement:5];  & ; tp_ItemRub{ta_ItemRub}->=va_IDT_Typ2; *)
				QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214)
			: (rJourNuit1=0) & (rJourNuit2=0)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=-100)
		End case 
		
	End if 
	
	MultiSoc_Filter(->[HeberGement:5])
	
	MESSAGES OFF:C175
	$0:=True:C214
Else 
	ALERT:C41("Veuillez renseigner les dates !")
End if 

vl_itemNb:=Records in selection:C76([HeberGement:5])