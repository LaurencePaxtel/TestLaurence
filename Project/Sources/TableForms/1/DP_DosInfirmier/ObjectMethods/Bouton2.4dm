//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DosMod
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	If ([DossierInfirmie:27]DI_Référence:1>0)
		If (F_UnDossierTypeModifié(->[DossierInfirmie:27]; "DI_EcranSaisie"; "Fiche Dossier Infirmier"; 0))
		End if 
	End if 
End if 