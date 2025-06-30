//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 12/07/21, 17:55:28
// ----------------------------------------------------
// Méthode : F_HebergementPrestation
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)

C_TEXT:C284($1)  //Cas
C_TEXT:C284($2)  //Nom de la table 
C_DATE:C307($3)
C_TEXT:C284($4)

C_TEXT:C284(va_CasRecherche)
C_DATE:C307(vd_DateRecherche)
C_TEXT:C284(va_GpeRecherche)

READ ONLY:C145([LesCentres:9])
READ ONLY:C145([CentresLits:16])

va_CasRecherche:=$1

If ($3>!00-00-00!)
	vd_DateRecherche:=$3
Else 
	If ([HeberGement:5]HG_Date:4#!00-00-00!)
		vd_DateRecherche:=[HeberGement:5]HG_Date:4
	Else 
		vd_DateRecherche:=Current date:C33
	End if 
	
End if 

va_CtrLib:=$4
va_GpeRecherche:=$4

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Centres")

If (va_CasRecherche="P")
	$vl_Fenetre:=i_FenêtreNo(786; 543; 16; "Sélectionner une "+xliff_Txt_Get_Indexed_String_(31011; 5); 12; "Quit_Simple")
Else 
	$vl_Fenetre:=i_FenêtreNo(786; 543; 16; "Sélectionner un "+$2; 12; "Quit_Simple")
End if 

ADD RECORD:C56([DiaLogues:3]; *)  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)

va_CtrLib:=F_Joker("DF"; va_CtrLib)

$0:=vb_RecHéb