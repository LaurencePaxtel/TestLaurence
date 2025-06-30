//%attributes = {}
// Method w_Get_hebergement_parDate retourne des hebergement par date avec info individu 
// 
// #SYNTAX: $O_Hebergement_Date:=w_Get_hebergement_parDate($D_Start;$D_End) 
// #PARAMETERS:
//     None
//     $0 Object          : Objet avec les hebergementd par date
//     $1 Date            : Date début
//     $2 Date            : Date fin

// #DATE CREATION: 18/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_OBJECT:C1216($0; $O_Output)
$O_Output:=JSON Parse:C1218("{}")  // starting from 16R3 use Create object

C_DATE:C307($1; $D_Debut)
$D_Debut:=$1
C_DATE:C307($2; $D_Fin)
$D_Fin:=$2

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$D_Debut; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$D_Fin)

MultiSoc_Filter(->[HeberGement:5])

C_LONGINT:C283($L_Trouve)
$L_Trouve:=Records in selection:C76([HeberGement:5])

ARRAY OBJECT:C1221($rO_Output; $L_Trouve)
ARRAY OBJECT:C1221($rO_Output2; 0)

ARRAY LONGINT:C221($rL_Traceur_Individu; 0)

C_LONGINT:C283($i)
For ($i; 1; $L_Trouve)
	
	$rO_Output{$i}:=4DREC_Record_to_Object(->[HeberGement:5])
	
	C_TEXT:C284($T_a_Rep2)
	$T_a_Rep2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
	
	OB SET:C1220($rO_Output{$i}; "$T_a_Rep2"; $T_a_Rep2)
	
	
	
	C_LONGINT:C283($L_Pos)
	$L_Pos:=Find in array:C230($rL_Traceur_Individu; [HeberGement:5]HG_HB_ID:19)
	If ($L_Pos=-1)
		APPEND TO ARRAY:C911($rL_Traceur_Individu; [HeberGement:5]HG_HB_ID:19)
		RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)
		
		APPEND TO ARRAY:C911($rO_Output2; 4DREC_Record_to_Object(->[HeBerge:4]))
	End if 
	NEXT RECORD:C51([HeberGement:5])
End for 

OB SET ARRAY:C1227($O_Output; "hebergement_par_date"; $rO_Output)
OB SET ARRAY:C1227($O_Output; "hebergement_par_date_individu"; $rO_Output2)

$0:=$O_Output

// EOM
