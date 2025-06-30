//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 16/06/2020, 15:52:56
// ----------------------------------------------------
// Method: MAINT_HB_Genre
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($compteur)
$compteur:=0

READ WRITE:C146([HeBerge:4])
ALL RECORDS:C47([HeBerge:4])
READ ONLY:C145([HeberGement:5])

While (Not:C34(End selection:C36([HeBerge:4])))
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
	MultiSoc_Filter(->[HeberGement:5])
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	
	If ([HeBerge:4]HG_Genre:39#[HeberGement:5]HG_Genre:96)
		LOAD RECORD:C52([HeBerge:4])
		If (Not:C34(Locked:C147([HeBerge:4])))
			[HeBerge:4]HG_Genre:39:=[HeberGement:5]HG_Genre:96
			SAVE RECORD:C53([HeBerge:4])
			$compteur:=$compteur+1
		End if 
		UNLOAD RECORD:C212([HeBerge:4])
	End if 
	
	NEXT RECORD:C51([HeBerge:4])
End while 

ALERT:C41("Opération effectuée avec succès. "+String:C10($compteur)+" fiches corrigées")