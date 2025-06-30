//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 18-01-19, 09:57:11
// ----------------------------------------------------
// Method: WEB_UTL_Clean_Document
// Description
// Cette méthode supprime les entêtes dans le document 
// reçu par téléchargement à partir d'une page web
//
// Parameters
// ----------------------------------------------------

C_BLOB:C604($file; $1; $0)
$file:=$1

If (BLOB size:C605($file)#0)
	$nb_CrLf:=3  //On coupera au troisième CrLf
	$indice:=0
	$count:=0
	$ni:=BLOB size:C605($file)
	For ($i; 1; $ni-1)  //On commence à 1
		If ($file{$i-1}=Retour chariot:K15:38) & ($file{$i}=Retour à la ligne:K15:40)
			$count:=$count+1
			If ($count=$nb_CrLf)
				$indice:=$i
				$i:=$ni+10  //Break
			End if 
		End if 
	End for 
	If ($indice>0)
		DELETE FROM BLOB:C560($file; 0; $indice+1)
	End if 
End if 

$0:=$file