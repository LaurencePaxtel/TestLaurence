//%attributes = {}
//{==================================================}
//{          Procédure : Go_àProposV
//{
//{          Vendredi 10 Janvier 1997 à 15:37:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284(tx_apropos)

ARRAY TEXT:C222(ta_Apropos; 4)

SET MENU BAR:C67(1)

Open window:C153((Screen width:C187/2)-(360/2); (Screen height:C188/2)-(374/2); (Screen width:C187/2)+(360/2); (Screen height:C188/2)+(374/2); 2; "")

ta_Apropos{1}:="©"
ta_Apropos{2}:="Notes"
ta_Apropos{3}:="Environnement"
ta_Apropos{4}:="Quitter"

tx_apropos:=xliff_Get_text_resource(30000)

DIALOG:C40([DiaLogues:3]; "DL_APropos")
CLOSE WINDOW:C154

<>vt_AProposMes:=""
<>vt_APropos:=""
<>PR_APropos:=0
