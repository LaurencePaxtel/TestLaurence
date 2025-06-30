//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 24/05/22, 16:04:35
// ----------------------------------------------------
// Méthode : outilsHGListBoxGetA(u)tr(e)sCr(i)t(ère)sSel(e)ct(ed)
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $0 : Text
var ${1} : Pointer

var $nomVariable_t; $critereSelected_t : Text
var $i_el; $j_el; $numTable_el; $numChamp_el; $order_el : Integer
var $critereUnchecked_b : Boolean
var $critereSelected_p : Pointer
var $collection_c : Collection

$collection_c:=New collection:C1472

For ($i_el; 1; Count parameters:C259)
	RESOLVE POINTER:C394(${$i_el}; $nomVariable_t; $numTable_el; $numChamp_el)
	$critereSelected_p:=Formula from string:C1601("->"+Replace string:C233($nomVariable_t; "te"; "ta"; 1)).call()
	
	For ($j_el; 1; Size of array:C274(${$i_el}->))
		
		If ($critereUnchecked_b=False:C215)
			$critereUnchecked_b:=(${$i_el}->{$j_el}=0)  // Il y a un critère qui est décoché
		End if 
		
		If (${$i_el}->{$j_el}=1)
			
			If ($critereSelected_t="")
				$critereSelected_t:=$critereSelected_p->{$j_el}
			Else 
				$critereSelected_t:=$critereSelected_t+", "+$critereSelected_p->{$j_el}
			End if 
			
		End if 
		
	End for 
	
	If ($critereUnchecked_b=True:C214)
		$order_el:=$order_el+1
		$collection_c.push(New object:C1471("order"; $order_el; "critere"; ta_xCritères{$i_el}; "critereSelected"; $critereSelected_t))
	Else 
		$collection_c.push(New object:C1471("order"; 0; "critere"; ta_xCritères{$i_el}; "critereSelected"; "Aucun filtre"))
	End if 
	
	outilsCleanVariable(->$critereUnchecked_b; ->$critereSelected_t)
End for 

For each ($critere_o; $collection_c.query("order > 0").orderBy("order asc"))
	$0:=$0+"• Critère "+$critere_o.critere+" : "+$critere_o.critereSelected
	
	If ($collection_c.indexOf($critere_o)<$collection_c.length)
		$0:=$0+Char:C90(Retour à la ligne:K15:40)
	End if 
	
End for each 