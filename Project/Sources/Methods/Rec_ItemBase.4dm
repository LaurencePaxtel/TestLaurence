//%attributes = {}
//Rec_ItemBase
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_item1; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=vd_item2; *)

If (vd_Néle1>!00-00-00!)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_DateNéLe:24>=vd_Néle1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_DateNéLe:24<=vd_Néle2; *)
End if 

If ((ve_Age1>0) | (ve_Age2>0))
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Age:23>=ve_Age1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Age:23<ve_Age2; *)
End if 

