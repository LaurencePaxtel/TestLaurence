//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uMàJEnum  
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($i)

//Déclations Pour la mire
Go_MireDébut  //Mire de départ

For ($i; 1; 10)
	Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Mise à jour des énumérations…"+String:C10($i))
End for 

Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Mise à jour des enumérations…")
DébutInitTable

Process_Ordre(<>PR_Mire; -><>vt_AProposMesMes; "Message"; -><>vt_APropos; "Mise à jour des écrans…")
Debut_DecVarChampCharger

Process_Ordre(<>PR_Mire; -><>vt_AProposMes; "Quitter"; -><>vt_APropos; "")