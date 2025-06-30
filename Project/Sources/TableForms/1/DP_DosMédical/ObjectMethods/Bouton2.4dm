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
	If ([DossierMedical:29]DM_Référence:1>0)
		If (F_UnDossierTypeModifié(->[DossierMedical:29]; "DM_EcranSaisie"; "Fiche Dossier Médical"; 0))
		End if 
	End if 
End if 