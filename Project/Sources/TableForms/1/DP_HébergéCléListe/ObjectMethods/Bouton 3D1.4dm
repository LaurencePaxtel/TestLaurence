//Script b_ModCléHG
If ([HeBerge:4]HB_ReferenceID:1>0)
	vl_IDT_RéfU:=[HeBerge:4]HB_ReferenceID:1
	va_IDT_Old:=[HeBerge:4]HB_Clé:2
	va_IDT_Nom:=[HeBerge:4]HB_Nom:3
	va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
	vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
	vl_IDT_Stat:=Num:C11([HeBerge:4]HB_Status:18=True:C214)
	
	$vl_Fenetre:=i_FenêtreNo(352; 362; 5; "Modifier la clé"; 3; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_HébergéCléModifier")
	CLOSE WINDOW:C154($vl_Fenetre)
	
Else 
	StrAlerte(2; "")
End if 
FIRST RECORD:C50([HeBerge:4])
PREVIOUS RECORD:C110([HeBerge:4])