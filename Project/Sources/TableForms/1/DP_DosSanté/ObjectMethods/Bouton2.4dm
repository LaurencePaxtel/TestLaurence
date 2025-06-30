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
	If ([DossierSante:33]DE_Référence:1>0)
		If (F_UnDossierTypeModifié(->[DossierSante:33]; "DE_EcranSaisie"; "Fiche Dossier Santé"; 1))
		End if 
	End if 
End if 