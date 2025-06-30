//%attributes = {}
If ([HeberGement:5]HG_Nom:21#[HeBerge:4]HB_Nom:3) | ([HeberGement:5]HG_Prénom:22#[HeBerge:4]HB_Prénom:4) | ([HeberGement:5]HG_DateNéLe:24#[HeBerge:4]HB_DateNéLe:5)
	[HeberGement:5]HG_Nom:21:=[HeBerge:4]HB_Nom:3
	[HeberGement:5]HG_Prénom:22:=[HeBerge:4]HB_Prénom:4
	[HeberGement:5]HG_DateNéLe:24:=[HeBerge:4]HB_DateNéLe:5
	[HeberGement:5]HG_Genre:96:=[HeBerge:4]HG_Genre:39
	If (Year of:C25([HeberGement:5]HG_DateNéLe:24)>0)
		If (Month of:C24([HeberGement:5]HG_Date:4)>Month of:C24([HeberGement:5]HG_DateNéLe:24))
			[HeberGement:5]HG_Age:23:=Year of:C25([HeberGement:5]HG_Date:4)-Year of:C25([HeberGement:5]HG_DateNéLe:24)
		Else 
			[HeberGement:5]HG_Age:23:=Year of:C25([HeberGement:5]HG_Date:4)-Year of:C25([HeberGement:5]HG_DateNéLe:24)-1
		End if 
	End if 
End if 