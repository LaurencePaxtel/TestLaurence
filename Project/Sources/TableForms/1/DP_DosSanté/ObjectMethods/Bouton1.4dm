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
If ([HeBerge:4]HB_ReferenceID:1=0) & (Records in selection:C76([HeBerge:4])>0)
	LOAD RECORD:C52([HeBerge:4])
End if 

If ([HeBerge:4]HB_ReferenceID:1>0)
	vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
	va_IDT_Typ1:=""
	va_IDT_Nom:=[HeBerge:4]HB_Nom:3
	va_IDT_Pré:=[HeBerge:4]HB_Prénom:4
	vd_IDT_NéLe:=[HeBerge:4]HB_DateNéLe:5
	x_IDTG_1:=Num:C11([HeBerge:4]HG_Genre:39=False:C215)
	x_IDTG_2:=Num:C11([HeBerge:4]HG_Genre:39=True:C214)
	
	If (Records in selection:C76([DossierSante:33])>0)
		ORDER BY:C49([DossierSante:33]; [DossierSante:33]DE_Date:4; <; *)
		ORDER BY:C49([DossierSante:33]; [DossierSante:33]DE_Heure:5; <)
		
		FIRST RECORD:C50([DossierSante:33])
		
		V_DosSanté_Déc(2)
		va_Dsanté_EtCV:=[DossierSante:33]DE_EtatCivil:13
	Else 
		V_DosSanté_Déc(1)
		va_Dsanté_EtCV:=""
	End if 
	
	va_IDT_Typ1:=va_Dsanté_EtCV
	
	If (F_UnDossierEtatCivil("Fiche Dossier Santé"; ""))  //(Uut_NewEtCivMa)
		F_UnDossierTypeNouveau(->[DossierSante:33]; "DE_EcranSaisie"; "Fiche Dossier Santé"; 1)
	End if 
	
End if 
