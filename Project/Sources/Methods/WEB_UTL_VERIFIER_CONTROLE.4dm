//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 03:28:54
// ----------------------------------------------------
// Méthode : WEB_UTL_VERIFIER_CONTROLE
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($class; $new_class; $validate; $out; $masque)
C_LONGINT:C283($pos_start_masq; $pos_end_masq)

ARRAY TEXT:C222($tb_saisie; 0)
ARRAY TEXT:C222($tb_chaine; 0)
ARRAY TEXT:C222($tb_params; 0)
ARRAY TEXT:C222($tb_taille; 0)

ARRAY TEXT:C222($tb_class1; 0)
ARRAY TEXT:C222($tb_class2; 0)

$class:=$1

If (Position:C15("controle"; $class)#0)
	UTL_Decoupe_texte(->$class; ->$tb_saisie; "controle(")
	UTL_Decoupe_texte(->$tb_saisie{2}; ->$tb_chaine; ")")
	UTL_Decoupe_texte(->$tb_chaine{1}; ->$tb_params; ";")
	
	$validate:=" validate["
	
	For ($i; 1; Size of array:C274($tb_params))
		
		Case of 
			: ($tb_params{$i}="OBG")
				
				If ($validate=" validate[")
					$validate:=$validate+"required"
				Else 
					$validate:=$validate+",required"
				End if 
				
			: (Position:C15(":"; $tb_params{$i})#0)
				
				If (Position:C15("MAX"; $tb_params{$i})#0)
					UTL_Decoupe_texte(->$tb_params{$i}; ->$tb_taille; ":")
					
					If ($validate=" validate[")
						$validate:=$validate+"maxSize["+$tb_taille{2}+"]"
					Else 
						$validate:=$validate+",maxSize["+$tb_taille{2}+"]"
					End if 
					
				End if 
				
				If (Position:C15("MIN"; $tb_params{$i})#0)
					UTL_Decoupe_texte(->$tb_params{$i}; ->$tb_taille; ":")
					
					If ($validate=" validate[")
						$validate:=$validate+"minSize["+$tb_taille{2}+"]"
					Else 
						$validate:=$validate+",minSize["+$tb_taille{2}+"]"
					End if 
					
				End if 
				
			: (Position:C15("EMAIL"; $tb_params{$i})#0)
				
				If ($validate=" validate[")
					$validate:=$validate+"custom[email]"
				Else 
					$validate:=$validate+",custom[email]"
				End if 
				
			: (Position:C15("URL"; $tb_params{$i})#0)
				
				If ($validate=" validate[")
					$validate:=$validate+"custom[url]"
				Else 
					$validate:=$validate+",custom[url]"
				End if 
				
			: ($tb_params{$i}="NUM")
				$out:=$out+" numericonly"
			: ($tb_params{$i}="FLOAT")
				$out:=$out+" float"
			: ($tb_params{$i}="TEXT")
				$out:=$out+" textonly"
			: ($tb_params{$i}="ALPHA")
				$out:=$out+" alphaonly"
			: ($tb_params{$i}="MAJ")
				$out:=$out+" alluppercase"
		End case 
		
	End for 
	
	UTL_Decoupe_texte(->$class; ->$tb_class1; "controle(")
	$new_class:=$new_class+$tb_class1{1}
	
	UTL_Decoupe_texte(->$tb_class1{2}; ->$tb_class2; ")")
	
	For ($j; 2; Size of array:C274($tb_class2))
		$new_class:=$new_class+$tb_class2{$j}
	End for 
	
	$validate:=$validate+"]"
	$new_class:=$new_class+$validate+$out
	$class:=$new_class
End if 

If (Position:C15("masque"; $class)#0)
	
	Case of 
		: ($class="@masque(datefr)@")
			$class:=$class+" mask-datefr"
		: ($class="@masque(tel)@")
			$class:=$class+" mask-phone"
		: ($class="@masque(tel2)@")
			$class:=$class+" mask-iphone"
		: ($class="@masque(perc)@")
			$class:=$class+" mask-pct"
		Else 
			$pos_start_masq:=Position:C15("masque("; $class)
			$pos_end_masq:=Position:C15(")"; $class; $pos_start_masq)
			
			$masque:=Substring:C12($class; $pos_start_masq+7; $pos_end_masq-1)
			$class:=$class+" mask-perso:"+$masque
	End case 
	
End if 

$0:=$class