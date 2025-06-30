//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 12/06/2020, 18:26:58
// ----------------------------------------------------
// Method: UTL_Form_Popup
// Description
// Origine Tab_PopIn1
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305($sort)

If (Count parameters:C259>3)
	$sort:=$4
End if 

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	$3->:=""
Else 
	C_TEXT:C284(vaTab1NomL)
	C_POINTER:C301(vPtrT2_Tab)
	C_POINTER:C301(vPtrT2_Var1)
	
	vaTab1NomL:=$1
	vPtrT2_Tab:=$2
	vPtrT2_Var1:=$3
	
	ARRAY TEXT:C222(t_TabNiv1; 0)
	COPY ARRAY:C226(vPtrT2_Tab->; t_TabNiv1)
	
	If ($sort)
		SORT ARRAY:C229(t_TabNiv1; >)
	End if 
	
	vb_Valider1:=False:C215
	$vl_Fenetre:=i_FenêtreNo(356; 412; 5; $1; 3; "")
	
	DIALOG:C40([DiaLogues:3]; "DL_TablesN1")
	CLOSE WINDOW:C154($vl_Fenetre)
	
	If (OK=1)
		$3->:=t_TabNiv1{t_TabNiv1}
	End if 
	
End if 