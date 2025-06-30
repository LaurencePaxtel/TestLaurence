//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Disponibilités
//{
//{          Lundi 27 décembre 2004 à 15:02:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (<>Va_CentreCtrl>"")
	
	If (Length:C16(<>Va_CentreCtrl)>10)
		<>Va_CentreCtrl:=Substring:C12(<>Va_CentreCtrl; 1; 10)
	End if 
	
	Process_Go(-><>PR_LitsFacil; "Go_DisposLitsFacil"; "MàJLits"; 64)
Else 
	Process_Go(-><>PR_Lits; "Go_DisposLits"; "MàJLits"; 128)
End if 