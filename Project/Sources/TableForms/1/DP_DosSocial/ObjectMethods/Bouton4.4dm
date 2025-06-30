//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DosImp
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeBerge:4]HB_ReferenceID:1>0)
	If ([DossierSocial:25]DS_Référence:1>0)
		If (F_UnDossierTypeImprimer(->[DossierSocial:25]; "DS_PrtFiche"))
			//Voir le rafraichissement    
		End if 
	End if 
End if 