//%attributes = {}

C_LONGINT:C283($nbFic)
C_TEXT:C284($aTotFic)
MESSAGES OFF:C175
READ ONLY:C145([HeBerge:4])
READ WRITE:C146([HeberGement:5])
ALL RECORDS:C47([HeBerge:4])
MultiSoc_Filter(->[HeBerge:4])
$aTotFic:=String:C10(Records in selection:C76([HeBerge:4]))
$nbFic:=0
FIRST RECORD:C50([HeBerge:4])
i_Message("Mise à jour en cours …")
i_Stop
ON EVENT CALL:C190("i_Stop_ESC")
Repeat 
	$nbFic:=$nbFic+1
	i_MessageSeul("Mise à jour en cours  : "+String:C10($nbFic)+"/"+$aTotFic)
	If (<>vb_StopEven=False:C215)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			APPLY TO SELECTION:C70([HeberGement:5]; wUut_MajEtFPl)
		End if 
	End if 
	NEXT RECORD:C51([HeBerge:4])
Until (End selection:C36([HeBerge:4]) | (<>vb_StopEven=True:C214))
ON EVENT CALL:C190("")
CLOSE WINDOW:C154
READ ONLY:C145([HeBerge:4])
UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])
MESSAGES ON:C181