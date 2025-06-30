//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 17/11/21, 14:18:37
// ----------------------------------------------------
// Méthode : outilsWProMethode
// Description
// Méthode qui est appelé dans les documents 4DWPro
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_OBJECT:C1216($table_o; $enregistrement_o)

Case of 
	: ($1=1)  //Permet de retrouver les enfants d'un hébergé et de les afficher
		
		If (Records in selection:C76([HeBerge:4])>0)
			$table_o:=ds:C1482.HeberGement.query("HG_FamClé = :1 AND HG_HB_ID # :2"; [HeBerge:4]HB_CléFam:47; [HeBerge:4]HB_ReferenceID:1).HG_HB_ID_1_HB_ReferenceID
			
			For each ($enregistrement_o; $table_o)
				$0:=$0+$enregistrement_o.HB_Nom+" "+$enregistrement_o.HB_Prénom+" né(e) le "+String:C10($enregistrement_o.HB_DateNéLe)
				
				If ($table_o.length>1)
					
					If ($enregistrement_o.indexOf($table_o)=0) | ($enregistrement_o.indexOf($table_o)<($table_o.length-1))
						$0:=$0+Char:C90(Retour chariot:K15:38)
					End if 
					
				End if 
				
			End for each 
			
		End if 
		
	: ($1=2)  //Permet de retrouver l'adresse (Adresse1) d'un hébergé
		$table_o:=Create entity selection:C1512([HeBerge:4])
		$table_o:=outilsOrdaSearch($table_o; "ID"; "Adresses"; "AD_ID_Origine")
		
		If ($table_o.length>0)
			$enregistrement_o:=$table_o.first()
			
			$0:=$enregistrement_o.AD_Adresse1
		Else 
			$0:="Adresse inconnue"
		End if 
		
	: ($1=3)  //Permet de retrouver CP + ville de l'hébergé
		$table_o:=Create entity selection:C1512([HeBerge:4])
		$table_o:=outilsOrdaSearch($table_o; "ID"; "Adresses"; "AD_ID_Origine")
		
		If ($table_o.length>0)
			$enregistrement_o:=$table_o.first()
			
			$0:=$enregistrement_o.AD_Code_postal+" "+$enregistrement_o.AD_Ville
		Else 
			$0:="CP Ville inconnu"
		End if 
		
	: ($1=4)  //Permet de retrouver l'adresse complète d'un hébergé
		$table_o:=Create entity selection:C1512([HeBerge:4])
		$table_o:=outilsOrdaSearch($table_o; "ID"; "Adresses"; "AD_ID_Origine")
		
		If ($table_o.length>0)
			$enregistrement_o:=$table_o.first()
			
			$0:=$enregistrement_o.AD_Adresse1+" "+$enregistrement_o.AD_Code_postal+" "+$enregistrement_o.AD_Ville
		Else 
			$0:="Adresse complète inconnue"
		End if 
		
	: ($1=5)  //Permet de retrouver l'adresse (Adresse1 + Adresse2 + Adresse3) d'un hébergé (entête de courrier)
		$table_o:=Create entity selection:C1512([HeBerge:4])
		$table_o:=outilsOrdaSearch($table_o; "ID"; "Adresses"; "AD_ID_Origine")
		
		If ($table_o.length>0)
			$enregistrement_o:=$table_o.first()
			
			$0:=$enregistrement_o.AD_Adresse1
			
			If ($enregistrement_o.AD_Adresse2#"")
				
				If ($0#"")
					$0:=$0+Char:C90(Retour chariot:K15:38)+Char:C90(Tabulation:K15:37)
				End if 
				
				$0:=$0+$enregistrement_o.AD_Adresse2
			End if 
			
			If ($enregistrement_o.AD_Adresse3#"")
				
				If ($0#"")
					$0:=$0+Char:C90(Retour chariot:K15:38)+Char:C90(Tabulation:K15:37)
				End if 
				
				$0:=$0+$enregistrement_o.AD_Adresse3
			End if 
			
		Else 
			$0:="Adresse inconnue"
		End if 
		
	: ($1=6)  //Permet de retrouver l'adresse (Adresse1 + Adresse2 + Adresse3) d'un hébergé (sur une seule ligne)
		$table_o:=Create entity selection:C1512([HeBerge:4])
		$table_o:=outilsOrdaSearch($table_o; "ID"; "Adresses"; "AD_ID_Origine")
		
		If ($table_o.length>0)
			$enregistrement_o:=$table_o.first()
			
			$0:=$enregistrement_o.AD_Adresse1
			
			If ($enregistrement_o.AD_Adresse2#"")
				
				If ($0#"")
					$0:=$0+" - "
				End if 
				
				$0:=$0+$enregistrement_o.AD_Adresse2
			End if 
			
			If ($enregistrement_o.AD_Adresse3#"")
				
				If ($0#"")
					$0:=$0+" - "
				End if 
				
				$0:=$0+$enregistrement_o.AD_Adresse3
			End if 
			
			$0:=$0+" - "+$enregistrement_o.AD_Code_postal+" "+$enregistrement_o.AD_Ville
		Else 
			$0:="Adresse inconnue"
		End if 
		
	: ($1=7)  // Permet de retrouver le nom du propriétaire du centre pour une fiche Hébergement
		$table_o:=Create entity selection:C1512([HeberGement:5])
		
End case 