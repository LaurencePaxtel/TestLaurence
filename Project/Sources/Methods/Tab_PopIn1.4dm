//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Tab_PopIn1
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
var $1 : Text  // Nom d'appel de la méthode [ne sert pas dans cette méthode...]
var $2 : Pointer  // Ptr Tableau
var $3 : Pointer  // Ptr Variable 1 à alimenter en retour
var $4 : Boolean  // Booléen qui indique si on peut faire une sélection de plusieurs lignes [Optionnel]

var $position_t; $lib_t : Text
var $i_el : Integer
var $charIsArobase_b : Boolean
var $form_o; $element_o : Object

var $typesTables_es : cs:C1710.TypesTablesSelection
var $tables_es : cs:C1710.TAblesSelection

ARRAY TEXT:C222($lib_at; 0)
ARRAY TEXT:C222($valeur_at; 0)

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	$3->:=""
Else 
	var vaTab1NomL : Text
	var vPtrT2_Tab; vPtrT2_Var1 : Pointer
	
	ARRAY TEXT:C222(t_TabNiv1; 0)
	
	vaTab1NomL:=$1
	vPtrT2_Tab:=$2
	
	// Modifié par : Scanu Rémy (21/12/2022)
	// Si le tableau des valeurs possibles est vide, on regarde si l'énumération $1 existe
	If (Size of array:C274($2->)=0)
		$typesTables_es:=ds:C1482.TypesTables.query("TT_Libellé = :1"; $1)
		//outilsOrdaSearchByRefStctre(->$typesTables_es)
		
		$tables_es:=outilsOrdaSearch($typesTables_es; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
		$tables_es:=$tables_es.query("Ref_Structure = :1"; Storage:C1525.societeDetail.Ref_Structure)
		
		
		If ($tables_es.length>0)
			COLLECTION TO ARRAY:C1562($tables_es.toCollection("TB_Texte").extract("TB_Texte"); $valeur_at)
			vPtrT2_Tab:=->$valeur_at
		Else 
			ALERT:C41("L'énumération « "+$1+" » doit être créée")
		End if 
		
	End if 
	
	vPtrT2_Var1:=$3
	
	COPY ARRAY:C226(vPtrT2_Tab->; t_TabNiv1)
	SORT ARRAY:C229(t_TabNiv1; >)
	
	vb_Valider1:=False:C215
	
	// Modifié par : Scanu Rémy (24/03/2021)
	// On passe sur une collection et plus un tableau
	$position_t:="center"
	$form_o:=New object:C1471("t_TabNiv1"; New collection:C1472)
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (06/05/2021)
	// On revient en arrière et on ne sauvegarde plus le choix précédent et par défaut on ne donne pas la possibilité de sélectionner plusieurs items
	$form_o.multiSelected:=False:C215
	
	If (Count parameters:C259>=4)
		
		If ($4=True:C214)
			$form_o.multiSelected:=True:C214
		End if 
		
	End if 
	
	ARRAY TO COLLECTION:C1563($form_o.t_TabNiv1; t_TabNiv1; "choix")
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
	If ($3->#"")  // Il y a déjà des éléments de sélectionner
		$lib_t:=$3->
		UTL_Decoupe_texte(->$lib_t; ->$lib_at; ";")
	End if 
	
	For each ($element_o; $form_o.t_TabNiv1)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (08/11/2022)
		// Correction bug caractère arobase
		If (Length:C16($element_o.choix)=1)
			$charIsArobase_b:=($element_o.choix[[1]]=Char:C90(Arobase:K15:46))
			
			If ($charIsArobase_b=True:C214)
				
				For ($i_el; 1; Size of array:C274($lib_at))
					$lib_t:=$lib_at{$i_el}
					
					If (Length:C16($lib_t)=1)
						
						If ($lib_t[[1]]=Char:C90(Arobase:K15:46))
							$i_el:=Size of array:C274($lib_at)
							CLEAR VARIABLE:C89($charIsArobase_b)
						End if 
						
					End if 
					
				End for 
				
			End if 
			
		End if 
		
		If (Find in array:C230($lib_at; $element_o.choix)#-1) & ($charIsArobase_b=False:C215)
			$element_o.checked:=True:C214
		Else 
			$element_o.checked:=False:C215
		End if 
		
		CLEAR VARIABLE:C89($charIsArobase_b)
	End for each 
	
	outilsCreateWindowsForm("DL_TablesN1CIO"; ->$position_t; $form_o; ->[DiaLogues:3])
	
	If (OK=1)
		$3->:=""
		
		For each ($element_o; $form_o.t_TabNiv1)
			
			If ($element_o.checked=True:C214)
				$3->:=$3->+$element_o.choix
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (06/05/2021)
				If ($form_o.multiSelected=True:C214)
					$3->:=$3->+";"
				End if 
				
			End if 
			
		End for each 
		
		If ($form_o.multiSelected=True:C214)
			$3->:=Substring:C12($3->; 0; Length:C16($3->)-1)
		End if 
		
	End if 
	
End if 