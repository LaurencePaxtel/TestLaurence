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
	If ([DossierSocial:25]DS_Référence:1>0)
		P_VarDS(-1)
		If (F_UnDossierTypeModifié(->[DossierSocial:25]; "DS_EcranSaisie"; "Fiche Dossier Social"; 0))
		End if 
	End if 
End if 