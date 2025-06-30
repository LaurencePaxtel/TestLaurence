//%attributes = {}
C_BOOLEAN:C305($0)
$0:=False:C215
C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_BOOLEAN:C305(vb_EstChéf)


C_TEXT:C284(va_LaFamille)

vb_EstChéf:=$1
va_LeNoFAM:=""
va_CléFam:=$2+" : "+[HeberGement:5]HG_FamClé:104
If ([HeberGement:5]HG_FamClé:104="")
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_CléFam:47#[HeberGement:5]HG_FamClé:104)
Else 
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_CléFam:47=[HeberGement:5]HG_FamClé:104)
End if 
MultiSoc_Filter(->[HeBerge:4])
ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementFamilleLien")

C_LONGINT:C283($vl_Fenetre)
$vl_Fenetre:=i_FenêtreNo(491; 311; 5; $2; 4; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
If (va_LeNoFAM>"")
	$0:=True:C214
End if 