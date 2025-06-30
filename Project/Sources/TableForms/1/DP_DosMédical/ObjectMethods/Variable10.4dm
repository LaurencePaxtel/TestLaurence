//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DemMod
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (User in group:C338(Current user:C182; <>Groupe_Externe))
	StrAlerte(6; "'MODIFIER LA CLE'")
Else 
	If ([HeBerge:4]HB_ReferenceID:1>0)
		vl_HGUU:=[HeBerge:4]HB_ReferenceID:1
		va_HGUU:=[HeBerge:4]HB_Nom:3
		va_CléClé:=[HeBerge:4]HB_Clé:2
		If (F_UnDossierCléModifier)
		End if 
	End if 
End if 