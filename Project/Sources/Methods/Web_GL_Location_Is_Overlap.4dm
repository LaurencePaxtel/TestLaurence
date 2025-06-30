//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 31-01-19, 16:38:15
// ----------------------------------------------------
// Method: Web_GL_Location_Is_Overlap
// Description
// Il ne faut pas permettre la création de plusieurs 
// locations pendant la même durée.
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_DATE:C307($1)
C_DATE:C307($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($bien_id; $id)
C_BOOLEAN:C305($overlap)
C_DATE:C307($loc_date_entree; $loc_date_sortie)

$loc_date_entree:=$1
$loc_date_sortie:=$2
$bien_id:=$3
$id:=$4

READ ONLY:C145([Locations:84])
QUERY:C277([Locations:84]; [Locations:84]LOC_Bien_ID:5=$bien_id)

While (Not:C34(End selection:C36([Locations:84])))
	
	If ((($loc_date_entree<=[Locations:84]LOC_Date_Sortie:10) & ([Locations:84]LOC_Date_Entree:9<=$loc_date_sortie)) & ([Locations:84]ID:1#$id))
		$overlap:=True:C214
	End if 
	
	NEXT RECORD:C51([Locations:84])
End while 

$0:=$overlap