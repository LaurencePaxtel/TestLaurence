//%attributes = {}

vb_majWrong:=False:C215
vb_majOK:=False:C215

va_LibTab:=""
vl_NumTab:=0
va_CléWrong:=""
vl_NbWrong:=0
vl_RefWrong:=0

va_NewLibTa:=""
vl_NewNumTa:=0

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_PurgeMaJTab")
$vl_Fenetre:=i_FenêtreNo(532; 351; 5; "M à J table"; 18; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154
READ ONLY:C145([DiaLogues:3])