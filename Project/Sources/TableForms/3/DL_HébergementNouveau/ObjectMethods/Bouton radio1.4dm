If (wresMulti=1)
	
	OBJECT SET VISIBLE:C603(*; "LibresMulti"; True:C214)
	OBJECT SET VISIBLE:C603(*; "LibresUn"; False:C215)
	OBJECT SET ENABLED:C1123(b_InFam; True:C214)
	OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
	If (7=8)
		Process_Go(-><>PR_HébergementMul; "Go_HébergementMultiple"; "ResMultiple"; 64)
		OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*1)+("Montrer les rés. multiples"*0))
	End if 
Else 
	OBJECT SET VISIBLE:C603(*; "LibresMulti"; False:C215)
	OBJECT SET VISIBLE:C603(*; "LibresUn"; True:C214)
	OBJECT SET ENABLED:C1123(b_InFam; False:C215)
	If (<>PR_HébergementMul#0)
		<>va_RéserveAction:="Quit"
		POST OUTSIDE CALL:C329(<>PR_HébergementMul)
	End if 
	ARRAY LONGINT:C221(<>tl_FamilleID; 0)
	ARRAY TEXT:C222(<>ta_FamilleClé; 0)
	ARRAY TEXT:C222(<>ta_FamilleEtCv; 0)
	<>ta_FamilleClé:=0
	If ([HeBerge:4]HB_ReferenceID:1>0)
		OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
	Else 
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
	End if 
	OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*0)+("Montrer les rés. multiples"*1))
End if 