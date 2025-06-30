//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Uut_HébergéClé  
//{
//{          Lundi 28 Juillet 1997 à 16:53:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_TEXT:C284($0)

$0:=((Uppercase:C13($1->)+" ")*(Num:C11((Uppercase:C13($1->))>"")))
$0:=$0+((Uppercase:C13($2->)+" ")*(Num:C11((Uppercase:C13($2->))>"")))

// Modifié par : Scanu Rémy (27/11/2023)
$0:=$0+(String:C10($3->; Interne date court:K1:7)*(Num:C11(($3->)>!00-00-00!)))
