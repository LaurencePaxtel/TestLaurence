//%attributes = {}
// Method w_Get_hebergements_individu retourne tous les hebergements d'un individu 
// 
// #SYNTAX: $O_Hebergements:=w_Get_hebergements_individu([HeBerge]HB_ReferenceID) 
// #PARAMETERS:
//     $0 Object          : Objet avec les hébergement d'une personne
//     $1 Long            : cle de la personne

// #DATE CREATION: 18/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_OBJECT:C1216($0; $O_Output)
$O_Output:=JSON Parse:C1218("{}")  // starting from 16R3 use Create object

C_LONGINT:C283($1; $L_ID)
$L_ID:=$1

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$L_ID)

C_LONGINT:C283($L_Trouve)
$L_Trouve:=Records in selection:C76([HeberGement:5])

ARRAY OBJECT:C1221($rO_Output; $L_Trouve)

C_LONGINT:C283($i)
For ($i; 1; $L_Trouve)
	
	$rO_Output{$i}:=4DREC_Record_to_Object(->[HeberGement:5])
	
	C_TEXT:C284($T_a_Gpe)
	$T_a_Gpe:=Choose:C955(([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115"); ""; "DA")
	
	C_TEXT:C284($T_a_Rep2)
	$T_a_Rep2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
	
	C_TEXT:C284($T_a_LesOrentes0; $T_a_LesOrentes1; $T_a_LesOrentes2)
	// redondance avec l'enregistrement mais ça simplifie
	// Dans l'interface HTML un popup à 3 choix
	// selon le choix:
	$T_a_LesOrentes0:=[HeberGement:5]HG_Orientation1:58
	$T_a_LesOrentes1:=[HeberGement:5]HG_Orientation2:60
	$T_a_LesOrentes2:=[HeberGement:5]HG_AutreSolutio:88
	
	OB SET:C1220($rO_Output{$i}; "$T_a_Gpe"; $T_a_Gpe)
	OB SET:C1220($rO_Output{$i}; "$T_a_Rep2"; $T_a_Rep2)
	OB SET:C1220($rO_Output{$i}; "$T_a_LesOrentes0"; $T_a_LesOrentes0)
	OB SET:C1220($rO_Output{$i}; "$T_a_LesOrentes1"; $T_a_LesOrentes1)
	OB SET:C1220($rO_Output{$i}; "$T_a_LesOrentes2"; $T_a_LesOrentes2)
	
	NEXT RECORD:C51([HeberGement:5])
End for 

OB SET ARRAY:C1227($O_Output; "liste_heberg_individu"; $rO_Output)

$0:=$O_Output

// EOM
