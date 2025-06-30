//%attributes = {}
// Method API_Liste_type_utilisateurs retourne une liste de type d'utilisateurs 
// 
// #SYNTAX: $L_Erreur:=API_Liste_type_utilisateurs(->tableau_type) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Pointer         : pointeur sur tableau des types
//     $2 Pointer         : pointeur objet output

// #DATE CREATION: 26/02/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

// Utilisateur = 1
// Coordinateur = 2
// Régulateur = 3
// Permanencier = 4
// Infirmier = 5
// Médecin = 6
// Médecin hebergement = 7
// Assistance sociale = 8
// Opérateur = 9


C_POINTER:C301($1; $P_Type)
$P_Type:=$1
C_POINTER:C301($2; $P_Output)
$P_Output:=$2

C_LONGINT:C283($0; $L_MyError)
$L_MyError:=1

ARRAY INTEGER:C220($rL_Typexxxx; 0)
COPY ARRAY:C226($P_Type->; $rL_Typexxxx)

ARRAY OBJECT:C1221($rO_Intervenant; 0)
Case of 
	: (Size of array:C274($rL_Typexxxx)<1)
		$L_MyError:=-1
	Else 
		
		ARRAY TEXT:C222($rT_Nom; 0)
		ARRAY TEXT:C222($rT_Prenom; 0)
		ARRAY TEXT:C222($rT_Initiales; 0)
		ARRAY INTEGER:C220($rI_Type; 0)
		
		QUERY WITH ARRAY:C644([INtervenants:10]IN_Type:2; $rL_Typexxxx)
		
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Nom:4; $rT_Nom; *)
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Prénom:5; $rT_Prenom; *)
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Initiales:7; $rT_Initiales; *)
		SELECTION TO ARRAY:C260([INtervenants:10]IN_Type:2; $rI_Type)
		
		C_LONGINT:C283($L_Size)
		$L_Size:=Size of array:C274($rT_Nom)
		
		ARRAY OBJECT:C1221($rO_Intervenant; $L_Size)
		
		//ARRAY TEXT($rT_Decode_type;0)
		//LIST TO ARRAY("eTypes";$rT_Decode_type)
		
		C_LONGINT:C283($i)
		For ($i; 1; $L_Size)
			OB SET:C1220($rO_Intervenant{$i}; "nom"; $rT_Nom{$i})
			OB SET:C1220($rO_Intervenant{$i}; "prenom"; $rT_Prenom{$i})
			OB SET:C1220($rO_Intervenant{$i}; "initiales"; $rT_Initiales{$i})
			OB SET:C1220($rO_Intervenant{$i}; "type"; $rI_Type{$i})
			
			//$L_Pos:=Find in array($rT_Decode_type;String([INtervenants]IN_Type))
			//If ($L_Pos>-1)
			//$T_Label:=Substring
			//end if
			//OB SET($rO_Intervenant{$i};"label";$T_Label)
		End for 
End case 

C_TEXT:C284($T_Message)
Case of 
	: ($L_MyError=-1)
		$T_Message:="Vous n'avez pas passé de type en entrée ou une propriété est mal définie"
	Else 
		$T_Message:="OK"
End case 

OB SET ARRAY:C1227($P_Output->; "intervenants"; $rO_Intervenant)
OB SET:C1220($P_Output->; "message"; $T_Message)

$0:=$L_MyError

// EOM
