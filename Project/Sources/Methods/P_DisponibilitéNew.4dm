//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure:  P_DisponibilitéNew
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)  // Afficher ou pas de message
C_LONGINT:C283($3)  // 0 sans 1 avec : prolongation

C_BOOLEAN:C305($vb_OK)

C_LONGINT:C283(vl_NbLits; vl_NbLitsJour; vl_NbLitsNuit)

CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrep")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepP")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepS")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepE")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepRp")

<>vl_CtrRepStdJ:=0
<>vl_CtrRepStdN:=0

<>vl_CtrRepRetJ:=0
<>vl_CtrRepRetN:=0

<>vl_CtrRepSorJ:=0
<>vl_CtrRepSorN:=0
<>vl_CtrRepExcJ:=0
<>vl_CtrRepExcN:=0

<>vl_CtrRepRplJ:=0
<>vl_CtrRepRplN:=0

<>vl_CtrRepProJ:=0
<>vl_CtrRepProN:=0

Tab_PR_data(0; 0)

//Voulez-vous saisir les disponiblités pour le
$vb_OK:=F_DisponibilitéDate($1; $2)

If ($vb_OK)  // Recherche de l'existance des disponibilités
	$vb_OK:=F_DisponibilitéNombre($1; $2; ->vl_NbLits; ->vl_NbLitsJour; ->vl_NbLitsNuit)
End if 

If ($vb_OK)  // Recherche des hébergements à reporter  
	$vb_OK:=F_DisponibilitéHébergnt($1; $3)
	$vb_OK:=F_DisponibilitéCentres($1; 0; $3; ->vl_NbLitsJour; ->vl_NbLitsNuit)  // Création des disponibilités des centres
End if 

If ($vb_OK)  //Mise à jour des disponibilités des centres
	$vb_OK:=F_DisponibilitéCentresMaJ($1; 0; ->vl_NbLitsJour; ->vl_NbLitsNuit)
End if 

Tab_PR_data(0; 0)

If ($2=1)
	i_Message("Recherche en cours...")
	Rec_CentreLits
	
	CLOSE WINDOW:C154
End if 

$vb_OK:=(User in group:C338(Current user:C182; <>Groupe_DEVELOP))
$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_ADMIN)))
$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_Coordinateur)))
$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_Régulateur)))
$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_Différé)))

If ($vb_OK)
	READ WRITE:C146([CentresLits:16])
Else 
	READ ONLY:C145([CentresLits:16])
End if 