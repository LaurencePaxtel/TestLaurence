//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 01:17:18
// ----------------------------------------------------
// Method: WEB_UTL_silentLoad
// Description
// même but que Utl_charge_enregistrement mais n'affiche pas d'alerte
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_POINTER:C301($1)  // table
C_LONGINT:C283($2)  //attente (ticks). Peut etre nul si on ne veut pas attendre

C_LONGINT:C283($delai; $sommeil; $max; $n; $timeout)
C_BOOLEAN:C305($lect; $locked)

$delai:=$2
$sommeil:=2

//WARNING : l'attente se fait sur le compteur de ticks. Si celui-ci est proche de MAXLONG,
//on risque d'attendre plus de 2 ans. On limitera donc la boucle à  $max  passages
$max:=100

$lect:=Read only state:C362($1->)

If ($lect)
	READ WRITE:C146($1->)
	LOAD RECORD:C52($1->)
End if 

$locked:=Locked:C147($1->)

If ($locked) & ($delai#0)
	$timeout:=Tickcount:C458+$delai
	
	Repeat 
		$n:=$n+1
		DELAY PROCESS:C323(Current process:C322; $sommeil)
		LOAD RECORD:C52($1->)
		
		$locked:=Locked:C147($1->)
	Until (Not:C34($locked) | (Tickcount:C458>$timeout) | ($n>$max))
	
End if 

If ($lect)
	READ ONLY:C145($1->)  // Remet l'état précédent mais ne libère pas la fiche
End if 

$0:=Not:C34($locked)