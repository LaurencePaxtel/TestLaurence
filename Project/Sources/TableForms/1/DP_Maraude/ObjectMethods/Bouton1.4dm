//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DosDup
//{
//{          Jeudi 3 juin 2004 à 18:18:00
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
	If (Records in selection:C76([Maraude:24])>0)
		ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Date:4; <; *)
		ORDER BY:C49([Maraude:24]; [Maraude:24]MR_Heure:5; <)
		FIRST RECORD:C50([Maraude:24])
		va_IDT_TypTrans:=[Maraude:24]MR_EtatCivil:16
		p_VarMR(1)
		If (F_UnDossierEtatCivil("Fiche Dossier EMA"; va_IDT_TypTrans))
			If (F_UnDossierTypeNouveau(->[Maraude:24]; "MR_EcranSaisie"; "Fiche Dossier EMA"; 1))
			End if 
		End if 
	End if 
End if 
