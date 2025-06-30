//%attributes = {}
// Method Handle bandeau Heberge  
// 
// 
// #SYNTAX: $L_Erreur:=Handle bandeau Heberge(vrai/faux) 
// #PARAMETERS:
C_BOOLEAN:C305($1)

C_LONGINT:C283($i; $G; $H; $D; $B; $L_Offset)
C_BOOLEAN:C305($B_Bandeau)

ARRAY TEXT:C222($rT_FormObject; 0)

$B_Bandeau:=$1
FORM GET OBJECTS:C898($rT_FormObject; 0)

For ($i; Size of array:C274($rT_FormObject); 1; -1)
	
	If ($rT_FormObject{$i}#("@_demandeur_@")) & ($rT_FormObject{$i}#("@btn_P@")) & ($rT_FormObject{$i}#("@dossiers_encours@"))
		DELETE FROM ARRAY:C228($rT_FormObject; $i)
	End if 
	
End for 

OBJECT GET COORDINATES:C663(*; "bandeau"; $G; $H; $D; $B)
$L_Offset:=($B-$H)+5

If ($B_Bandeau=False:C215)
	$L_Offset:=0
End if 

For ($i; Size of array:C274($rT_FormObject); 1; -1)
	OBJECT GET COORDINATES:C663(*; $rT_FormObject{$i}; $G; $H; $D; $B)
	
	Case of 
		: ($rT_FormObject{$i}="sub@")
			OBJECT SET COORDINATES:C1248(*; $rT_FormObject{$i}; $G; $H+$L_Offset; $D; $B)
		: ($rT_FormObject{$i}="label@") | ($rT_FormObject{$i}="compte@") | ($rT_FormObject{$i}="button@") | ($rT_FormObject{$i}="img@") | ($rT_FormObject{$i}="@btn_P@") | ($rT_FormObject{$i}="@dossiers_encours@")
			OBJECT SET COORDINATES:C1248(*; $rT_FormObject{$i}; $G; $H+$L_Offset; $D; $B+$L_Offset)
		Else 
	End case 
	
End for 