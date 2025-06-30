//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementNR
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//b_NR

If (User in group:C338(Current user:C182; <>Groupe_Pressé))
	P_HébergementRubNR(<>vlSTR_Std-<>vlSTR)
Else 
	If ([HeberGement:5]HG_EtatCivil:20="Enfant@") | ([HeberGement:5]HG_Nom:21="X0@")
		
		P_HébergementRubNR(<>vlSTR_Std-<>vlSTR)
	Else 
		StrAlerte(41; "")
	End if 
End if 