//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21-02-19, 15:42:32
// ----------------------------------------------------
// Method: Web_FAC_Get_Loc_Details
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $type)
C_DATE:C307($2; $date_entree; $3; $date_sortie; $date_du; $date_au; $0)
C_LONGINT:C283($days_count)

$type:=$1
$date_entree:=$2
$date_sortie:=$3

Case of 
	: ((Month of:C24(Current date:C33(*))=Month of:C24($date_entree))) & (Year of:C25(Current date:C33(*))=Year of:C25($date_sortie))
		$date_du:=$date_entree
		
	: ((Month of:C24(Current date:C33(*))>Month of:C24($date_entree)) & (Year of:C25(Current date:C33(*))=Year of:C25($date_entree))) & ((Month of:C24(Current date:C33(*))<Month of:C24($date_sortie)) & (Year of:C25(Current date:C33(*))=Year of:C25($date_sortie)))
		
		$date_du:=UTL_Date_Day(Current date:C33(*); False:C215)
		
	: ((Month of:C24(Current date:C33(*))=Month of:C24($date_sortie))) & (Year of:C25(Current date:C33(*))=Year of:C25($date_entree))
		$date_du:=UTL_Date_Day($date_sortie; False:C215)
		
	Else 
		$date_du:=UTL_Date_Day(Current date:C33(*); False:C215)
End case 

$date_au:=UTL_Date_Day($date_du; True:C214)

If ((Month of:C24(Current date:C33(*))=Month of:C24($date_sortie))) & (Year of:C25(Current date:C33(*))=Year of:C25($date_sortie))
	$date_au:=$date_sortie
End if 

$days_count:=$date_au-$date_du+1

Case of 
	: ($type="date_du")
		
		$0:=$date_du
		
	: ($type="date_au")
		
		$0:=$date_au
		
	Else 
		//$0:=$days_count
End case 

