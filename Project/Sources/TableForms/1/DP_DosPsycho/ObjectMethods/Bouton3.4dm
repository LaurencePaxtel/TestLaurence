//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DosSup
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_Coordinateur))
	
	If ([HeBerge:4]HB_ReferenceID:1>0)
		If ([DossierPsycho:28]DY_Référence:1>0)
			If (F_UnDossierTypeSupprimer(->[DossierPsycho:28]; ->[DossierPsycho:28]DY_Référence:1; "DY"))
				//Voir le rafraichissement    
			End if 
		End if 
	End if 
End if 
