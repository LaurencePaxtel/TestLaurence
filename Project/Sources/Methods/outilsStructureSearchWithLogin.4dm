//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/07/23, 18:22:21
// ----------------------------------------------------
// Méthode : outilsStructureSearchWithLogin
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $pos_el : Integer
var $structure_c : Collection
var $user_o : Object

var $loginMemo_e : cs:C1710.LoginMemoEntity
var $loginMemo_es : cs:C1710.LoginMemoSelection

ARRAY TEXT:C222(Liste_entreprise; 0)
ARRAY TEXT:C222(Liste_ref_entreprise; 0)
ARRAY TEXT:C222(Liste_initiale_entreprise; 0)

USR_Get_Structures($1)

SELECTION TO ARRAY:C260([Structures:79]STRC_Nom:4; Liste_entreprise; [Structures:79]UID:1; Liste_ref_entreprise; [Structures:79]STRC_Initiales:2; Liste_initiale_entreprise)
SORT ARRAY:C229(Liste_entreprise; Liste_ref_entreprise; Liste_initiale_entreprise; >)

$structure_c:=New collection:C1472
ARRAY TO COLLECTION:C1563($structure_c; Liste_initiale_entreprise)

// Modifié par : Scanu Rémy (14/04/2023)
// Amélioration pour compatibilité avec le web en version monoposte
Use (Storage:C1525)
	Storage:C1525.structure:=New shared collection:C1527
	
	For each ($structure_t; $structure_c)
		Storage:C1525.structure.push($structure_t)
	End for each 
	
End use 

// Modifié par : Scanu Rémy (17/07/2023)
// Sauvegarde du login par nom de machine / nom de session et plus par nom de machine uniquement
$user_o:=Get system info:C1571
$loginMemo_es:=ds:C1482.LoginMemo.query("machine = :1 AND session = :2"; $user_o.machineName; $user_o.accountName)

If ($loginMemo_es.length>0)
	$loginMemo_e:=$loginMemo_es.first()
	
	If ($loginMemo_e.login=$1)
		$pos_el:=Find in array:C230(Liste_initiale_entreprise; $loginMemo_e.structure)
		
		If ($pos_el>0)
			Liste_entreprise:=$pos_el
			LISTBOX SELECT ROW:C912(*; "Zone de défilement"; $pos_el; lk remplacer sélection:K53:1)
		End if 
		
	End if 
	
End if 

If (($pos_el=0) | ($pos_el=-1)) & (Size of array:C274(Liste_entreprise)>0)
	LISTBOX SELECT ROW:C912(*; "Zone de défilement"; 1; lk remplacer sélection:K53:1)
End if 