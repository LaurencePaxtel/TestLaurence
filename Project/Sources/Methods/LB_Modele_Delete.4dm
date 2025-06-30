//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 24/09/2020, 16:00:47
// ----------------------------------------------------
// Method: LB_Modele_Delete
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_POINTER:C301($ptr_liste_box_courante)
C_BOOLEAN:C305($liste_box_generale)

$ptr_liste_box_courante:=$1
$liste_box_generale:=$2

If (Read only state:C362([Preferences:81]))
	READ WRITE:C146([Preferences:81])
End if 

QUERY:C277([Preferences:81]; [Preferences:81]UID:1=Liste_ref_formulaire{Liste_formulaire})
DELETE SELECTION:C66([Preferences:81])

READ ONLY:C145([Preferences:81])

DELETE FROM ARRAY:C228(Liste_ref_formulaire; Liste_formulaire; 1)
DELETE FROM ARRAY:C228(Liste_type_formulaire; Liste_formulaire; 1)
DELETE FROM ARRAY:C228(Liste_formulaire; Liste_formulaire; 1)

Liste_formulaire:=1
LB_Load_Modele($ptr_liste_box_courante; $liste_box_generale)