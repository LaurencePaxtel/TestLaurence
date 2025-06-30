//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementCritères
//{
//{          Lundi 26 juillet 2004 à 11:03:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)  // Tableau : libellé
C_POINTER:C301($2)  // Tableau : Cas
C_TEXT:C284($3)  // Titre
C_COLLECTION:C1488($4)  // Collection qui permet de rajouter à la volée des éléments dans le tableau

C_LONGINT:C283($vl_Fenetre; $nbElement_el)
C_OBJECT:C1216($element_o)

ARRAY TEXT:C222(<>ta_xLibellé; 0)
ARRAY INTEGER:C220(<>te_xCheck; 0)

COPY ARRAY:C226($1->; <>ta_xLibellé)
COPY ARRAY:C226($2->; <>te_xCheck)

If (Count parameters:C259=4)
	$nbElement_el:=Size of array:C274(<>ta_xLibellé)
	
	For each ($element_o; $4)
		
		If (Find in array:C230(<>ta_xLibellé; $element_o.label)=-1)  // Si le label n'a pas déjà été ajouté
			APPEND TO ARRAY:C911(<>ta_xLibellé; $element_o.label)
			APPEND TO ARRAY:C911(<>te_xCheck; $element_o.select)
		End if 
		
	End for each 
	
End if 

$vl_Fenetre:=i_FenêtreNo(357; 399; 5; $3; 4; "")
DIALOG:C40([DiaLogues:3]; "DL_TabCritère")

CLOSE WINDOW:C154($vl_Fenetre)

If (Count parameters:C259=4)  // On remet les tableaux en place
	//SUPPRIMER DANS TABLEAU(<>ta_xLibellé; $nbElement_el+1; Taille tableau(<>ta_xLibellé)-$nbElement_el)
	//SUPPRIMER DANS TABLEAU(<>te_xCheck; $nbElement_el+1; Taille tableau(<>te_xCheck)-$nbElement_el)
End if 

COPY ARRAY:C226(<>ta_xLibellé; $1->)
COPY ARRAY:C226(<>te_xCheck; $2->)