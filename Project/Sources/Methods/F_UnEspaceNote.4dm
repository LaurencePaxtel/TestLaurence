//%attributes = {}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305(vb_OK; vb_OKVal)
C_LONGINT:C283($vl_Fenetre)
vb_OK:=False:C215
vt_UnTexte:=$1
vb_OKVal:=$3
READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_EspaceNote")
$vl_Fenetre:=i_FenêtreNo(466; 272; 4; $2; 3; "")
ADD RECORD:C56([DePart:1])  //lpc 08122017 ascenceur
If (vb_OK)
	If (vt_UnTexte#$1)
		$0:=True:C214
	End if 
End if 
READ ONLY:C145([DePart:1])
CLOSE WINDOW:C154($vl_Fenetre)