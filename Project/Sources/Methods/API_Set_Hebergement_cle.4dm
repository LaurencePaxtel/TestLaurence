//%attributes = {}
// Method API_Set_Hebergement_cle  
// 
// 
// #SYNTAX: $L_Erreur:=API_Set_Hebergement_cle(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 03/04/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_OBJECT:C1216($1; $O_Data)
$O_Data:=$1
C_POINTER:C301($2; $P_User_output)
$P_User_output:=$2

C_LONGINT:C283($L_MyError)
$L_MyError:=1


C_POINTER:C301($P_Table; $P_PK)
$P_Table:=->[HeberGement:5]
$P_PK:=->[HeberGement:5]ID:168

ARRAY OBJECT:C1221($rO_Record; 0)
OB GET ARRAY:C1229($O_Data; "hebergement_cle"; $rO_Record)  // A ce jour on n'a qu'un energistrement dans le tableau


// je vais lire cette valeur pour prévenir un doublon
C_TEXT:C284($T_Property)
$T_Property:=FieldName_to_property(->[HeberGement:5]HG_FicheNuméro:3)

// si id = 0 c'est une création sinon MAJ
// $L_ID:=OB Get($rO_Record{1};Lowercase(Field name($P_PK));Is longint)

C_LONGINT:C283($l_ID)
$l_ID:=$rO_Record{1}.id
C_TEXT:C284($T_Fichenum)
$T_Fichenum:=$rO_Record{1}.hg_fichenumero

C_LONGINT:C283($L_Trouve)
If ($l_ID=0)
	SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Trouve)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=$T_Fichenum)
	MultiSoc_Filter(->[HeberGement:5])
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
End if 

Case of 
	: ($l_ID=0) & ($L_Trouve#0)
		$L_MyError:=-2
	Else 
		
		C_BOOLEAN:C305($B_Insert)
		$B_Insert:=False:C215
		If ($L_ID=0)
			$B_Insert:=True:C214
			CREATE RECORD:C68($P_Table->)
			MultiSoc_Init_Structure($P_Table)
			[HeberGement:5]HG_FicheNuméro:3:=$T_Fichenum  // unique  // #20180604-1
			SAVE RECORD:C53($P_Table->)
		Else 
			SET QUERY LIMIT:C395(1)
			QUERY:C277($P_Table->; $P_PK->=$L_ID)
			MultiSoc_Filter($P_Table)
			SET QUERY LIMIT:C395(0)
		End if 
		
		$L_ID:=$P_PK->
		
		C_BOOLEAN:C305($B_RW)
		$B_RW:=4DTABLE_MakeRW($P_Table)
		
		C_TEXT:C284($T_Message)
		C_LONGINT:C283($L_Erreur)
		$L_Erreur:=4DREC_Load_Record($P_Table; ->$T_Message)
		If ($L_Erreur#1)
			$L_MyError:=-1
		Else 
			// je suis sur l'enregistrement
			// $O_Data va le mettre à jour
			C_TEXT:C284($T_JSON)
			$T_JSON:=JSON Stringify array:C1228($rO_Record)
			JSON TO SELECTION:C1235($P_Table->; $T_JSON)
			If ($B_Insert)
				// l'ID reçue dans le JSON était à 0
				LOAD RECORD:C52($P_Table->)
				$P_PK->:=$L_ID
				SAVE RECORD:C53($P_Table->)
			End if 
		End if 
		UNLOAD RECORD:C212($P_Table->)
		4DTABLE_MakeRW_Restore($P_Table; $B_RW)
		
End case 


Case of 
	: ($L_MyError=-1)
		$T_Message:=$T_Message
	: ($L_MyError=-2)
		$T_Message:="Vous tentez de créer un hebergement avec un numéro de fiche existant hg_fichenumero: "+$T_Fichenum
	Else 
		$T_Message:="OK"
End case 

OB SET:C1220($P_User_output->; "message"; $T_Message)
OB SET:C1220($P_User_output->; "id"; $L_ID)

$0:=$L_MyError

// EOM
