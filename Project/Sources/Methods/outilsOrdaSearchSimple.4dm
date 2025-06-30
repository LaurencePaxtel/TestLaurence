//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Rémy Scanu
// Date et heure : 14/05/20, 23:05:04
// ----------------------------------------------------
// Méthode : outilsOrdaSearchSimple
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_VARIANT:C1683($1)  // Nom de la table OU indication
C_VARIANT:C1683($2)  // Nom du champ OU Nom du lien
C_VARIANT:C1683($3)  // Libellé à rechercher
C_VARIANT:C1683($4)  // EntitySelection
C_TEXT:C284($5)  // Indication à appliquer entre deux entitySelection
C_VARIANT:C1683($6)  // 2° entitySelection

C_TEXT:C284($tableName_t; $fieldName_t; $champ_t)
C_OBJECT:C1216($table_o)

If (Value type:C1509($4)=Est un pointeur:K8:14)
	$table_o:=$4->
Else 
	$table_o:=$4
End if 

Case of 
	: (Value type:C1509($1)=Est un texte:K8:3)
		
		Case of 
			: ($1="inSelectionNotSame")
				$table_o:=$6->query($2+" = :1"; $3)
			: ($1="inSelection")
				$table_o:=$table_o.query($2+" = :1"; $3)
			: ($2="allSelection")
				$table_o:=ds:C1482[$1].all()
			: ($2="multiChamp")  // A faire
				
				For each ($champ_t; $3.champ)
					
				End for each 
				
			: ($1="lien")
				$table_o:=$table_o[$2]
			Else 
				$tableName_t:=$1
				$fieldName_t:=$2
				
				$table_o:=ds:C1482[$tableName_t].query($fieldName_t+" = :1"; $3)
		End case 
		
	: (Value type:C1509($1)=Est un pointeur:K8:14)
		$tableName_t:=Table name:C256($1)
		$fieldName_t:=Field name:C257($2)
		
		$table_o:=ds:C1482[$tableName_t].query($fieldName_t+" = :1"; $3)
End case 

If (Count parameters:C259=5)
	
	If ($5="first")
		
		If ($table_o.length>0)
			$table_o:=$table_o.first()
		Else 
			$table_o:=Null:C1517
		End if 
		
	End if 
	
End if 

If (Count parameters:C259=6)
	
	Case of 
		: ($5="intersection")
			$table_o:=$table_o.and($6)
		: ($5="reunion")
			$table_o:=$table_o.or($6)
		: ($5="difference")
			$table_o:=$table_o.minus($6)
		: ($5="lien")
			$table_o:=$table_o[$6]
	End case 
	
End if 

$4->:=$table_o
