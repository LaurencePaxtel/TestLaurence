If (Form event code:C388=Sur clic:K2:4)
	OBJECT SET VISIBLE:C603(*; "OuiExc_@"; [HeberGement:5]HG_ER_Excuse:124)
	If ([HeberGement:5]HG_ER_Excuse:124) & (Old:C35([HeberGement:5]HG_ER_Excuse:124)=False:C215)
		[HeberGement:5]HG_ER_DateDébut:125:=Current date:C33(*)
		[HeberGement:5]HG_ER_DateFin:126:=[HeberGement:5]HG_ER_DateDébut:125
		[HeberGement:5]HG_ER_NuitEnCours:127:=1
		[HeberGement:5]HG_ER_NuitTotal:128:=1
		[HeberGement:5]HG_ER_NuitReste:129:=0
		OBJECT SET ENABLED:C1123(b_ValExc; True:C214)
	End if 
	If ([HeberGement:5]HG_ER_Excuse:124=False:C215) & (Old:C35([HeberGement:5]HG_ER_NuitEnCours:127)=1)
		[HeberGement:5]HG_ER_DateDébut:125:=!00-00-00!
		[HeberGement:5]HG_ER_DateFin:126:=[HeberGement:5]HG_ER_DateDébut:125
		[HeberGement:5]HG_ER_NuitEnCours:127:=0
		[HeberGement:5]HG_ER_NuitTotal:128:=0
		[HeberGement:5]HG_ER_NuitReste:129:=0
	End if 
	If (7=8)
		$vb_OK:=([HeberGement:5]HG_ER_DateFin:126<[HeberGement:5]HG_ER_DateDébut:125)
		$vb_OK:=(($vb_OK) | ([HeberGement:5]HG_ER_DateFin:126>([HeberGement:5]HG_Date:4+[HeberGement:5]HG_NuitReste:95)))
		If ($vb_OK)
			OBJECT SET ENABLED:C1123(b_ValExc; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(b_ValExc; True:C214)
		End if 
	End if 
End if 