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
	If ([Maraude:24]MR_RéférenceID:1>0)
		p_VarMR(-1)
		If (F_UnDossierTypeModifié(->[Maraude:24]; "MR_EcranSaisie"; "Fiche Dossier EMA"; 1))
		End if 
	End if 
End if 