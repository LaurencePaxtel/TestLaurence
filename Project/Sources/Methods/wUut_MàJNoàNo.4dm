//%attributes = {}


vb_majWrong:=False:C215
vb_majOK:=False:C215
vl_majWrong:=0
vl_majOK:=0
vl_NbWrong:=0
vl_NbOK:=0
va_CléWrong:=""
va_CléOK:=""
va_LibNo:=""

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_PurgeMàJNo")
$vl_Fenetre:=i_FenêtreNo(532; 351; 5; "M à J n° à n° "; 18; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3]; *)
CLOSE WINDOW:C154
READ ONLY:C145([DiaLogues:3])