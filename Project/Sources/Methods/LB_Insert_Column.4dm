//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 25/09/2020, 06:54:30
// ----------------------------------------------------
// Method: LB_Insert_Column
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)  // $1 Pointeur du nom de la liste box
C_POINTER:C301($2)  // $2 Pointeur vers champ
C_TEXT:C284($3)  // $3 Chaine Titre
C_TEXT:C284($4)  // $4 Chaine Choix visible (vrai ou faux)
C_TEXT:C284($5)  // $5 Formatage
C_LONGINT:C283($6)  // $6 largeur de la colonne
C_TEXT:C284($7)  // $7 choix saisissable (vrai ou faux)
C_TEXT:C284($8)  // $8 police
C_LONGINT:C283($9)  // $9 style
C_LONGINT:C283($10)  // $10 taille police
C_LONGINT:C283($11)  // $11couleur
C_LONGINT:C283($12)  // $12 position de la colonne
C_LONGINT:C283($13)  // $13 Alignement

C_TEXT:C284($titre; $header_name; $col; $nom_entete; $nom_table; $nom_table2; $ref_champs; $footerName_t; $footerVar_t)
C_LONGINT:C283($combien)
C_POINTER:C301($tb_bool; $ptr_champ; $head; $footer_p)

$tb_bool:=$1
$ptr_champ:=$2

If (Count parameters:C259>=12)
	
	If ($12>0)
		$combien:=$12
	Else 
		$combien:=LISTBOX Get number of columns:C831($tb_bool->)+1
	End if 
	
Else 
	$combien:=LISTBOX Get number of columns:C831($tb_bool->)+1
End if 

$titre:=$3

If ($titre="")
	$titre:=UTL_Champ_Get_Titre(Table:C252(->[HeberGement:5]); Field:C253($2))
End if 

// Modifié par : Scanu Rémy (24/03/2023)
// Je limite au 23° premier caractère, car le nombre maximal de caractère pour nommer une variable est 31, on enlève 8 caractère pour la chaine "FooterXX" qui suit
$header_name:=Substring:C12(LB_Field_Header_Clean($titre); 1; 23)

If (insertion_dans_tableau=False:C215)
	$col:="C_"+String:C10($combien)
	$nom_entete:=$header_name+String:C10($combien)
	
	nombre_d_insertion_de_colonne:=$combien
Else 
	nombre_d_insertion_de_colonne:=nombre_d_insertion_de_colonne+1
	$col:="C_"+String:C10(nombre_d_insertion_de_colonne)
	
	$nom_entete:=$header_name+String:C10(nombre_d_insertion_de_colonne)
End if 

$head:=Get pointer:C304($nom_entete)

ON ERR CALL:C155("Web_Detect_Error")

// Modifié par : Scanu Rémy (04/11/2022)
// Gestion des colonnes de type numérique ou entier
$footerName_t:=$header_name+"Footer"

If (insertion_dans_tableau=False:C215)
	$footerVar_t:=$footerName_t+String:C10($combien)
Else 
	$footerVar_t:=$footerName_t+String:C10(nombre_d_insertion_de_colonne)
End if 

$footer_p:=Get pointer:C304($footerVar_t)
LISTBOX INSERT COLUMN:C829($tb_bool->; $combien; $col; $ptr_champ->; $header_name; $head->; $footerName_t; $footer_p->)

$nom_table:=Table name:C256(Table:C252($ptr_champ))
$nom_table2:=Table name:C256(Table:C252(the_ptr_file_liste_box_courante))

// Modifié par : Scanu Rémy (07/11/2022)
If (Type:C295($ptr_champ->)=Est un entier long:K8:6) | (Type:C295($ptr_champ->)=Est un numérique:K8:4)
	
	If (Form:C1466.footerVar#Null:C1517)
		Formula from string:C1601($footerVar_t+":=0").call()
		Form:C1466.footerVar.push(New object:C1471(\
			"varName"; $footerVar_t; \
			"varSource"; "["+$nom_table+"]"+Field name:C257($ptr_champ); \
			"varTable"; $nom_table; \
			"varChamp"; Field name:C257($ptr_champ); \
			"varCalcul"; "sum"))
	End if 
	
End if 

Case of 
	: ($nom_table#($nom_table2+"@"))
		OBJECT SET TITLE:C194($head->; $titre+" ("+Table name:C256(Table:C252($ptr_champ))+")")
	Else 
		OBJECT SET TITLE:C194($head->; $titre)
End case 

If (insertion_dans_tableau=False:C215)
	
	If (Size of array:C274(TA_entete)>=$combien)
		TA_entete{$combien}:=$nom_entete
	End if 
	
	If (Size of array:C274(TA_nom_var_entete)>=$combien)
		TA_nom_var_entete{$combien}:=$nom_entete
	End if 
	
Else 
	$ref_champs:=String:C10(UTL_Table_Field_Get($2))
	
	INSERT IN ARRAY:C227(TE_Alignement_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TE_Style_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TT_Police_colonne; $combien; 1)
	
	INSERT IN ARRAY:C227(TE_couleur_fond_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TE_couleur_police_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TT_formatage_colonne; $combien; 1)
	
	INSERT IN ARRAY:C227(TE_Alignement_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_Style_entete; $combien; 1)
	INSERT IN ARRAY:C227(TT_Police_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_couleur_fond_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_couleur_police_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_Largeur_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TE_taille_police; $combien; 1)
	INSERT IN ARRAY:C227(TA_titre_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TT_contenu_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TT_Type_donnee_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TA_nom_var_entete; $combien; 1)
	INSERT IN ARRAY:C227(TA_entete; $combien; 1)
	
	TT_Police_entete{$combien}:="arial"
	TA_titre_colonne{$combien}:=$titre
	TT_contenu_colonne{$combien}:=$ref_champs
	TT_Type_donnee_colonne{$combien}:=0
	TA_nom_var_entete{$combien}:=$nom_entete
	TA_entete{$combien}:=$nom_entete
	
	If (Count parameters:C259>=4)
		
		If ($4="Faux")
			OBJECT SET VISIBLE:C603(*; $col; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; $col; True:C214)
		End if 
		
	End if 
	
	If (Count parameters:C259>=5)
		
		If (Length:C16($5)>0)
			OBJECT SET FORMAT:C236($2->; $5)
			TT_formatage_colonne{$combien}:=$5
		End if 
		
	End if 
	
	If (Count parameters:C259>=6)
		LISTBOX SET COLUMN WIDTH:C833(*; $col; $6)
	Else 
		LISTBOX SET COLUMN WIDTH:C833(*; $col; 20)
	End if 
	
	TE_Largeur_colonne{$combien}:=$6
	
	If (Count parameters:C259>=7)
		
		If (($7="Faux") | ($7=""))
			OBJECT SET ENTERABLE:C238(*; $col; False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(*; $col; True:C214)
		End if 
		
	Else 
		OBJECT SET ENTERABLE:C238(*; $col; False:C215)
	End if 
	
	If (Count parameters:C259>=8)
		
		If ($8>"")
			OBJECT SET FONT:C164(*; $col; $8)
			OBJECT SET FONT:C164(*; $titre; $8)
			TT_Police_colonne{$combien}:=$8
			TT_Police_entete{$combien}:=$8
		Else 
			OBJECT SET FONT:C164(*; $col; "Arial")
			OBJECT SET FONT:C164(*; $titre; "Arial")
			TT_Police_colonne{$combien}:="arial"
			TT_Police_entete{$combien}:="arial"
		End if 
		
	Else 
		OBJECT SET FONT:C164(*; $col; "Arial")
		OBJECT SET FONT:C164(*; $titre; "Arial")
		TT_Police_colonne{$combien}:="arial"
		TT_Police_entete{$combien}:="arial"
	End if 
	
	If (Count parameters:C259>=9)
		
		If ($9>0)
			OBJECT SET FONT STYLE:C166(*; $titre; $9)
			OBJECT SET FONT STYLE:C166(*; $col; $9)
		End if 
		
	Else 
		OBJECT SET FONT STYLE:C166(*; $titre; Normal:K14:1)
		OBJECT SET FONT STYLE:C166(*; $col; Normal:K14:1)
		TE_Style_colonne{$combien}:=Normal:K14:1
		TE_Style_entete{$combien}:=Normal:K14:1
	End if 
	
	If (Count parameters:C259>=10)
		
		If ($10>0)
			OBJECT SET FONT SIZE:C165(*; $col; $10)
			OBJECT SET FONT SIZE:C165(*; $titre; 14)
			TE_taille_police{$combien}:=$10
		Else 
			OBJECT SET FONT SIZE:C165(*; $col; 14)
			OBJECT SET FONT SIZE:C165(*; $titre; 14)
			TE_taille_police{$combien}:=14
		End if 
		
	Else 
		OBJECT SET FONT SIZE:C165(*; $col; 14)
		OBJECT SET FONT SIZE:C165(*; $titre; 14)
		TE_taille_police{$combien}:=14
	End if 
	
	If (Count parameters:C259>=11)
		
		If ($11>0)
			OBJECT SET RGB COLORS:C628(*; $col; 15; $11)
			TE_couleur_fond_colonne{$combien}:=$11
		End if 
		
	End if 
	
	If (Count parameters:C259>=13)
		
		If ($13>0)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $col; $13)
			TE_Alignement_colonne{$combien}:=$13
		End if 
		
	Else 
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $col; Aligné à gauche:K42:2)
		TE_Alignement_colonne{$combien}:=Aligné à gauche:K42:2
	End if 
	
End if 