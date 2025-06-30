//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 02/11/18, 04:04:12
// ----------------------------------------------------
// Méthode : Web_JSON_Get_Liste_Utilisateurs
// Description
// Retourne une liste des d'utilisateurs selon le type passé en paramètre
//
// Paramètres
// Utilisateur = 1
// Coordinateur = 2
// Régulateur = 3
// Permanencier = 4
// Infirmier = 5
// Médecin = 6
// Médecin hebergement = 7
// Assistance sociale = 8
// Opérateur = 9
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($titre; $T_Message)
C_LONGINT:C283($L_MyError; $L_Size; $i)
C_POINTER:C301($P_Type)

ARRAY TEXT:C222($rT_Nom; 0)
ARRAY TEXT:C222($rT_Prenom; 0)
ARRAY TEXT:C222($rT_Initiales; 0)

ARRAY LONGINT:C221($rI_ID; 0)

ARRAY OBJECT:C1221($rO_Intervenant; 0)

$P_Type:=$1
$L_MyError:=1

Case of 
	: (Size of array:C274($P_Type->)<1)
		$L_MyError:=-1
	Else 
		QUERY WITH ARRAY:C644([INtervenants:10]IN_Type:2; $P_Type->)
		
		// Modifié par : Scanu Rémy (06/08/2021)
		MultiSoc_Filter(->[INtervenants:10])
		
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Nom:4; $rT_Nom; *)
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Prénom:5; $rT_Prenom; *)
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Initiales:7; $rT_Initiales; *)
		SELECTION TO ARRAY:C260([INtervenants:10]ID:16; $rI_ID)
		
		$L_Size:=Size of array:C274($rT_Nom)
		
		ARRAY OBJECT:C1221($rO_Intervenant; $L_Size)
		
		For ($i; 1; $L_Size)
			OB SET:C1220($rO_Intervenant{$i}; "id"; String:C10($rI_ID{$i}))
			OB SET:C1220($rO_Intervenant{$i}; "value"; $rT_Nom{$i}+" "+$rT_Prenom{$i})
		End for 
		
End case 

Case of 
	: ($L_MyError=-1)
		$T_Message:="Vous n'avez pas passé de type en entrée ou une propriété est mal définie"
	Else 
		$T_Message:="OK"
End case 

If (Size of array:C274($P_Type->)=1)
	
	Case of 
		: ($P_Type->{1}=1)
			$titre:="Utilisateur"
		: ($P_Type->{1}=2)
			$titre:="Coordinateur"
		: ($P_Type->{1}=3)
			$titre:="Régulateur"
		: ($P_Type->{1}=4)
			$titre:="Permanencier"
		: ($P_Type->{1}=5)
			$titre:="Infirmier"
		: ($P_Type->{1}=6)
			$titre:="Médecin"
		: ($P_Type->{1}=7)
			$titre:="Médecin hebergement"
		: ($P_Type->{1}=8)
			$titre:="Assistance sociale"
		: ($P_Type->{1}=9)
			$titre:="Opérateur"
		Else 
			$titre:="Utilisateur"
	End case 
	
Else 
	$titre:="Utilisateurs"
End if 

$object:=New object:C1471("title"; $titre; "type"; "radio"; "value"; $titre)
OB SET ARRAY:C1227($object; "list"; $rO_Intervenant)

$JSON:=JSON Stringify:C1217($object)

WEB SEND TEXT:C677($JSON)