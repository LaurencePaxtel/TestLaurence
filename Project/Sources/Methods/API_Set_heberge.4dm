//%attributes = {}
// Method API_Set_heberge met à jour ou crée un hebergé
// 
// #SYNTAX: $L_Erreur:=API_Set_heberge($O_Objet;->$O_Output) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Object          : objet avec un tableau d'objet. Tableau avec 1 item 
//     $2 Object          : info de retour dont id creation message

// #DATE CREATION: 16/02/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_LONGINT:C283($0; $L_MyError)
$L_MyError:=1

C_OBJECT:C1216($1; $O_Data)
$O_Data:=$1
C_POINTER:C301($2; $P_Output)
$P_Output:=$2

// $O_Data est un objet avec un tableau d'objet
// le tableau ne contient pour le momemnt qu'un item/1 enregistrement
ARRAY OBJECT:C1221($rO_Data; 0)
OB GET ARRAY:C1229($O_Data; "heberge"; $rO_Data)

Case of 
	: (OB Is defined:C1231($O_Data; "heberge")=False:C215)
		$L_MyError:=-6
	: (Size of array:C274($rO_Data)#1)
		$L_MyError:=-5
	Else 
		C_POINTER:C301($P_Table; $P_PK)
		$P_Table:=->[HeBerge:4]
		$P_PK:=->[HeBerge:4]ID:65
		
		C_LONGINT:C283($L_ID; $L_ReferenceID)
		$L_ID:=OB Get:C1224($rO_Data{1}; Lowercase:C14(Field name:C257($P_PK)); Est un entier long:K8:6)  // $O_Data représente un enregistrement 4D avec tous les champs
		$L_ReferenceID:=MAXLONG:K35:2  // juste pour initialiser à une valeur aberrante
		Case of 
			: (Size of array:C274($rO_Data)#1)
				$L_MyError:=-3
			: ($L_ID<0)
				$L_MyError:=-4
			Else 
				
				C_BOOLEAN:C305($B_Insert)
				$B_Insert:=($L_ID=0)
				If ($L_ID=0)
					CREATE RECORD:C68($P_Table->)
					SAVE RECORD:C53($P_Table->)
				Else 
					SET QUERY LIMIT:C395(1)
					QUERY:C277($P_Table->; $P_PK->=$L_ID)
					SET QUERY LIMIT:C395(0)
				End if 
				
				$L_ID:=$P_PK->  // id existant ou qui vient d'être crée
				
				C_TEXT:C284($T_Message)
				$T_Message:=""
				Case of 
					: (Records in selection:C76($P_Table->)#1)
						$L_MyError:=-1
					Else 
						C_BOOLEAN:C305($B_RW)
						$B_RW:=4DTABLE_MakeRW($P_Table)
						
						$L_Erreur:=4DREC_Load_Record($P_Table; ->$T_Message)
						If ($L_Erreur#1)
							$L_MyError:=-2
						Else 
							// je suis sur l'enregistrement
							$L_ReferenceID:=[HeBerge:4]HB_ReferenceID:1  // capter la $L_ReferenceID en cas de modif
							$T_JSONtab:=JSON Stringify array:C1228($rO_Data)
							
							//SET TEXT TO PASTEBOARD($T_JSONtab)
							
							JSON TO SELECTION:C1235($P_Table->; $T_JSONtab)
							If ($B_Insert)
								LOAD RECORD:C52($P_Table->)  // vérifier si c'est utile
								$P_PK->:=$L_ID
								$L_ReferenceID:=Uut_Numerote(->[HeBerge:4])  // capter la $L_ReferenceID en cas de crea
								[HeBerge:4]HB_ReferenceID:1:=$L_ReferenceID
								SAVE RECORD:C53($P_Table->)
							End if 
						End if 
						UNLOAD RECORD:C212($P_Table->)
						4DTABLE_MakeRW_Restore($P_Table; $B_RW)
				End case 
		End case 
End case 

C_TEXT:C284($T_Message)
Case of 
	: ($L_MyError=-1)
		$T_Message:="L'enregistrement id "+String:C10($L_ID)+" n'a pas été trouvé"
	: ($L_MyError=-2)
		$T_Message:="L'enregistrement id "+String:C10($L_ID)+" est verrouillé"
	: ($L_MyError=-3)
		$T_Message:=Current method name:C684+" devrait recevoir 1 enregistrement. Reçu: "+String:C10(Size of array:C274($rO_Data))
	: ($L_MyError=-4)
		$T_Message:="La cle primaire est incorrecte"
	: ($L_MyError=-5)
		$T_Message:="Aucune cle primaire reçue"
	: ($L_MyError=-6)
		$T_Message:="La propriété 'heberge' n'a pas été passée"
	Else 
		$T_Message:="OK"
End case 
OB SET:C1220($P_Output->; "id"; $L_ID)
OB SET:C1220($P_Output->; "referenceid"; $L_ReferenceID)
OB SET:C1220($P_Output->; "creation"; $B_Insert)
OB SET:C1220($P_Output->; "message"; $T_Message)

$0:=$L_MyError

// EOM

