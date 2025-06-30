//%attributes = {}
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([CentresLits:16])



C_TEXT:C284($1)  //Nom de la table 
C_DATE:C307($2)
C_TEXT:C284($3)  //Groupe

C_DATE:C307(vd_DateRecherche)
C_TEXT:C284(va_GpeRecherche)


If ($2>!00-00-00!)
	vd_DateRecherche:=$2
Else 
	If ([HeberGement:5]HG_Date:4#!00-00-00!)
		vd_DateRecherche:=[HeberGement:5]HG_Date:4
	Else 
		vd_DateRecherche:=Current date:C33
	End if 
End if 
va_GpeRecherche:=$3

C_LONGINT:C283($vl_Fenetre)

C_BOOLEAN:C305($0)
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Centres")
If (<>ve_Si_ModeCHRS=1)
	If (7=8)
		$vl_Fenetre:=i_FenêtreNo(732; 508; 16; "Sélectionner une "+xliff_Txt_Get_Indexed_String_(31011; 5); 12; "Quit_Simple")
	End if 
	$vl_Fenetre:=i_FenêtreNo(786; 508; 16; "Sélectionner une "+xliff_Txt_Get_Indexed_String_(31011; 5); 12; "Quit_Simple")
Else 
	If (7=8)
		$vl_Fenetre:=i_FenêtreNo(732; 508; 16; "Sélectionner un "+$1; 12; "Quit_Simple")
	End if 
	$vl_Fenetre:=i_FenêtreNo(786; 508; 16; "Sélectionner un "+$1; 12; "Quit_Simple")
End if 
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
$0:=vb_RecHéb
