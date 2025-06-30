//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DosDup
//{
//{          Jeudi 3 juin 2004 à 10:29:00
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
	
	If (Records in selection:C76([DossierSocial:25])>0)
		ORDER BY:C49([DossierSocial:25]; [DossierSocial:25]DS_Date:4; <; *)
		ORDER BY:C49([DossierSocial:25]; [DossierSocial:25]DS_Heure:5; <)
		FIRST RECORD:C50([DossierSocial:25])
		va_IDT_TypTrans:=[DossierSocial:25]DS_EtatCivil:11
		
		P_VarDS(1)
		If (F_UnDossierEtatCivil("Fiche Dossier Social"; va_IDT_TypTrans))
			If (F_UnDossierTypeNouveau(->[DossierSocial:25]; "DS_EcranSaisie"; "Fiche Dossier Social"; 0))
			End if 
		End if 
	Else 
	End if 
End if 
