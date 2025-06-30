//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 09/02/24, 18:24:41
// ----------------------------------------------------
// Méthode : outilsWebtableEdit
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $propriete_t : Text
var $stop_b : Boolean
var $retour_o; $table_o; $enregistrement_o; $data_o : Object
var $field_c; $fieldExist_c : Collection

$retour_o:=New object:C1471
$json_o:=JSON Parse:C1218(w_visiteur.json)

If (ds:C1482[String:C10($json_o.table)]#Null:C1517)
	$field_c:=outilsTableGetFieldDetail(String:C10($json_o.table); False:C215)
	
	If (String:C10($json_o.champRecherche)#"")
		
		If (outilsTableCheckIfFieldExist(String:C10($json_o.table); String:C10($json_o.champRecherche))=True:C214)
			outilsOrdaSearchSimple(String:C10($json_o.table); String:C10($json_o.champRecherche); String:C10($json_o.enregistrementID); ->$table_o)
			
			If ($table_o.length>0)
				$enregistrement_o:=$table_o.first()
			End if 
			
		End if 
		
	Else 
		$enregistrement_o:=ds:C1482[String:C10($json_o.table)].get(String:C10($json_o.enregistrementID))
	End if 
	
	If ($enregistrement_o#Null:C1517)
		
		If (outilsCheckStringIsObject(JSON Stringify:C1217($json_o.data))=True:C214)
			$data_o:=OB Get:C1224($json_o; "data"; Est un objet:K8:27)
			
			For each ($propriete_t; $data_o) Until ($stop_b=True:C214)
				$fieldExist_c:=$field_c.query("fieldName = :1"; $propriete_t)
				$stop_b:=($fieldExist_c.length=0)
				
				If ($stop_b=False:C215)
					
					Case of 
						: ($fieldExist_c[0].type="string")
							$enregistrement_o[$propriete_t]:=$data_o[$propriete_t]
						: ($fieldExist_c[0].type="number")
							$enregistrement_o[$propriete_t]:=Num:C11($data_o[$propriete_t])
						: ($fieldExist_c[0].type="bool")
							$enregistrement_o[$propriete_t]:=Bool:C1537($data_o[$propriete_t])
						: ($fieldExist_c[0].type="date")
							$enregistrement_o[$propriete_t]:=Date:C102($data_o[$propriete_t])
					End case 
					
				Else 
					$retour_o.notificationError:="Le champ "+$propriete_t+" n'existe pas pour la table "+String:C10($json_o.table)
				End if 
				
			End for each 
			
			If ($stop_b=False:C215)
				$retour_o:=$enregistrement_o.save()
			End if 
			
		End if 
		
	Else 
		$retour_o.notificationError:="L'enregistrement "+String:C10($json_o.enregistrementID)+"de la table "+String:C10($json_o.table)+" n'existe pas dans la base de données"
	End if 
	
Else 
	$retour_o.notificationError:="La table "+String:C10($json_o.table)+" n'existe pas dans la base de données"
End if 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o; *))