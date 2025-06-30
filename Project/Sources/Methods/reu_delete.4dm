//%attributes = {}
// Method reu_delete supprime tous les rendez-vous et/ou réunion
// Pour débogage
// 
// #SYNTAX:reu_delete("selecteur") 
// #PARAMETERS:
//     None

// #DATE CREATION: 12/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_TEXT:C284($1; $T_Selecteur)
$T_Selecteur:=$1

If ($T_Selecteur="reunion") | ($T_Selecteur="rendez-vous")
	
	CONFIRM:C162("Tous supprimer ?")
	If (OK=1)
		
		C_BOOLEAN:C305($B_RO)
		$B_RO:=4DTABLE_MakeRW(->[APPOINT_REUNION:74])
		ALL RECORDS:C47([APPOINT_REUNION:74])
		MultiSoc_Filter(->[APPOINT_REUNION:74])
		DELETE SELECTION:C66([APPOINT_REUNION:74])
		4DTABLE_MakeRW_Restore(->[APPOINT_REUNION:74]; $B_RO)
		
		If ($T_Selecteur="rendez-vous")
			
			$B_RO:=4DTABLE_MakeRW(->[APPOINTMENTS:73])
			ALL RECORDS:C47([APPOINTMENTS:73])
			MultiSoc_Filter(->[APPOINTMENTS:73])
			DELETE SELECTION:C66([APPOINTMENTS:73])
			4DTABLE_MakeRW_Restore(->[APPOINTMENTS:73]; $B_RO)
			
		End if 
	End if 
Else 
	TRACE:C157
End if 


