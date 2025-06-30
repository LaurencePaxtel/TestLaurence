//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DemNew
//{
//{          mercredi 14 avril 1999 à 13:37:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (F_UnDossierCléNouveau)
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
	FIRST RECORD:C50([HeBerge:4])
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	vL_Nb_HG_F:=0
	va_Nb_HG_F:=""
	REDUCE SELECTION:C351([DossierPsycho:28]; 0)
	vL_Nb_MR_F:=0
	va_Nb_MR_F:=""
	K_BoutonDossierDem(False:C215)
	K_BoutonDossierDos(False:C215)
End if 