//%attributes = {}
C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

C_LONGINT:C283($ii; $ij)


C_LONGINT:C283($vl_Table)
//On rend tout non saississable
If ($1>0)
	$vb_OK:=($1>=<>vl_T_CentreCodeDebut)
	$vb_OK:=$vb_OK & ($1<=<>vl_T_CentreCodeFin)
	If ($vb_OK)
		$vb_OK:=False:C215
	Else 
		$vb_OK:=True:C214
	End if 
End if 


If ($vb_OK)
	$ij:=Get last field number:C255(->[LesCentres:9])
	$vl_Table:=Table:C252(->[LesCentres:9])
	For ($ii; 1; $ij)
		OBJECT SET ENTERABLE:C238(Field:C253($vl_Table; $ii)->; False:C215)
		
	End for 
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
	OBJECT SET ENABLED:C1123(b_Sup; False:C215)
	OBJECT SET ENABLED:C1123(b_Chemin; False:C215)
	OBJECT SET ENABLED:C1123(b_Plateforme; False:C215)
	OBJECT SET VISIBLE:C603(*; "RP_ico"; False:C215)
	OBJECT SET VISIBLE:C603(*; "PL_ico"; False:C215)
	
End if 