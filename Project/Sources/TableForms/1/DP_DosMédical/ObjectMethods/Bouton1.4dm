//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DosNew
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
	va_IDT_Typ1:=""
	va_IDT_Nom:=[HeBerge:4]HB_Nom:3
	va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
	vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
	x_IDTG_1:=Num:C11([HeBerge:4]HG_Genre:39=False:C215)
	x_IDTG_2:=Num:C11([HeBerge:4]HG_Genre:39=True:C214)
	If (F_UnDossierEtatCivil("Fiche Dossier Médical"; ""))
		If (F_UnDossierTypeNouveau(->[DossierMedical:29]; "DM_EcranSaisie"; "Fiche Dossier Médical"; 0))
		End if 
	End if 
End if 
