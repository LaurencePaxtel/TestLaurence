//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script b_InFam
//{
//{          Lundi 28 Juillet 1997 à 17:10:16
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (<>PR_HébergementMul=0)
	OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*1)+("Montrer les rés. multiples"*0))
	Process_Go(-><>PR_HébergementMul; "Go_HébergementMultiple"; "ResMultiple"; 64)
Else 
	<>va_RéserveAction:="Quit"
	POST OUTSIDE CALL:C329(<>PR_HébergementMul)
	OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*0)+("Montrer les rés. multiples"*1))
End if 