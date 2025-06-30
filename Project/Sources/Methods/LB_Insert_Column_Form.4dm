//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 29/09/2020, 07:17:44
// ----------------------------------------------------
// Method: LB_Insert_Column_Form
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)  // $1 Pointeur du nom de la liste box
C_TEXT:C284($2)  // $2 ...
C_TEXT:C284($3)  // $3 Chaine Titre
C_TEXT:C284($4)  // $4 Chaine Choix visible (vrai ou faux)
C_TEXT:C284($5)  // $5 Formatage
C_LONGINT:C283($6)  // $6 largeur de la colonne
C_TEXT:C284($7)  // $7 choix saisissable (vrai ou faux)
C_TEXT:C284($8)  // $8 police
C_LONGINT:C283($9)  // $9 style
C_LONGINT:C283($10)  // $10 taille police
C_LONGINT:C283($11)  // $11 couleur
C_LONGINT:C283($12)  // $12 position de la colonne
C_LONGINT:C283($13)  // $13 Alignement

C_TEXT:C284($col; $nom_entete; $formule; $titre)
C_LONGINT:C283($combien)
C_POINTER:C301($tb_bool; $head)

$tb_bool:=$1
$formule:=$2
$titre:=$3

If (Count parameters:C259>=12)
	
	If ($12>0)
		$combien:=$12
	Else 
		$combien:=LISTBOX Get number of columns:C831($tb_bool->)+1
	End if 
	
Else 
	$combien:=LISTBOX Get number of columns:C831($tb_bool->)+1
End if 

nombre_d_insertion_de_colonne:=nombre_d_insertion_de_colonne+1

$col:="C_"+String:C10(nombre_d_insertion_de_colonne)
$nom_entete:="head"+String:C10(nombre_d_insertion_de_colonne)
$head:=Get pointer:C304($nom_entete)  //`gestion de la variable du titre de colonne adressable par changer titre"

LISTBOX INSERT COLUMN FORMULA:C970($tb_bool->; $combien; $col; $formule; Est un texte:K8:3; $titre; $head->)

OBJECT SET TITLE:C194($head->; $titre)

If (insertion_dans_tableau=False:C215)
	TA_entete{$combien}:=$nom_entete
	TA_nom_var_entete{$combien}:=$nom_entete
Else 
	INSERT IN ARRAY:C227(TE_Alignement_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TE_Style_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TT_Police_colonne; $combien; 1)
	TT_Police_colonne{$combien}:="arial"
	
	INSERT IN ARRAY:C227(TE_couleur_fond_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TE_couleur_police_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TT_formatage_colonne; $combien; 1)
	
	INSERT IN ARRAY:C227(TE_Alignement_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_Style_entete; $combien; 1)
	INSERT IN ARRAY:C227(TT_Police_entete; $combien; 1)
	TT_Police_entete{$combien}:="arial"
	
	INSERT IN ARRAY:C227(TE_couleur_fond_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_couleur_police_entete; $combien; 1)
	INSERT IN ARRAY:C227(TE_Largeur_colonne; $combien; 1)
	INSERT IN ARRAY:C227(TE_taille_police; $combien; 1)
	
	INSERT IN ARRAY:C227(TA_titre_colonne; $combien; 1)
	TA_titre_colonne{$combien}:=$titre
	
	INSERT IN ARRAY:C227(TT_contenu_colonne; $combien; 1)
	TT_contenu_colonne{$combien}:=$formule
	
	INSERT IN ARRAY:C227(TT_Type_donnee_colonne; $combien; 1)
	TT_Type_donnee_colonne{$combien}:=Est un texte:K8:3
	
	INSERT IN ARRAY:C227(TA_nom_var_entete; $combien; 1)
	TA_nom_var_entete{$combien}:=$nom_entete
	
	INSERT IN ARRAY:C227(TA_entete; $combien; 1)
	TA_entete{$combien}:=$nom_entete
	
	If (Count parameters:C259>=4)
		
		If ($4="Faux")
			OBJECT SET VISIBLE:C603(*; $col; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; $col; True:C214)
		End if 
		
	End if 
	
	If (Count parameters:C259>=5)
		
		If ($5>"")
			OBJECT SET FORMAT:C236(*; $col; $5)
			TT_formatage_colonne{$combien}:=$5
		End if 
		
	End if 
	
	If (Count parameters:C259>=6)
		LISTBOX SET COLUMN WIDTH:C833(*; $col; $6)
		TE_Largeur_colonne{$combien}:=$6
	Else 
		LISTBOX SET COLUMN WIDTH:C833(*; $col; 20)
		TE_Largeur_colonne{$combien}:=$6
	End if 
	
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
			OBJECT SET FONT SIZE:C165(*; $titre; 11)
			TE_taille_police{$combien}:=$10
		Else 
			OBJECT SET FONT SIZE:C165(*; $col; 11)
			OBJECT SET FONT SIZE:C165(*; $titre; 11)
			OBJECT SET FONT SIZE:C165($head->; 11)
			TE_taille_police{$combien}:=11
		End if 
		
	Else 
		OBJECT SET FONT SIZE:C165(*; $col; 11)
		OBJECT SET FONT SIZE:C165(*; $titre; 11)
		OBJECT SET FONT SIZE:C165($head->; 11)
		TE_taille_police{$combien}:=11
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