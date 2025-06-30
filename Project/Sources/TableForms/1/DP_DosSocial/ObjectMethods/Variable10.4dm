//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_DemMod
//{
//{          Mardi 20 avril 1999 à 10:25:00
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