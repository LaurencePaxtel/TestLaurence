// Method hmCal.list_vues  
// 
// 
// #SYNTAX: $L_Erreur:=hmCal.list_vues(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 06/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_POINTER:C301($P_This)
$P_This:=OBJECT Get pointer:C1124

C_LONGINT:C283($L_Zone)
$L_Zone:=hm_Get_Zoneref("hmCal")
Case of 
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		C_LONGINT:C283($L_Ref)
		C_TEXT:C284($T_Label)
		GET LIST ITEM:C378($P_This->; *; $L_Ref; $T_Label)
		
		//ALERT(String($L_Zone)+", "+String($L_Ref))
		//ALERT(String(hmCal_Get Version ))
		
		hmCal_SET VIEW($L_Zone; $L_Ref)
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($L_List)
		$L_List:=New list:C375
		APPEND TO LIST:C376($L_List; "Vue jour"; hmCal_DayView)
		APPEND TO LIST:C376($L_List; "Vue multi jours"; hmCal_MultiDayView)
		APPEND TO LIST:C376($L_List; "Vue mois"; hmCal_MonthView)
		//APPEND TO LIST($L_List;"Vue année";hmCal_YearView)
		APPEND TO LIST:C376($L_List; "Vue permanenciers jour"; hmCal_UserView)
		//APPEND TO LIST($L_List;"Vue permanenciers semaine";hmCal_DayUserView)
		APPEND TO LIST:C376($L_List; "Vue permanenciers multi jours"; hmCal_UserMultiDayView)
		//APPEND TO LIST($L_List;"Vue projet";hmCal_ProjectView)
		//APPEND TO LIST($L_List;"Vue resources";hmCal_ResourcesView)
		
		VARIABLE TO VARIABLE:C635(Current process:C322; $P_This->; $L_List)
		
		C_LONGINT:C283($L_Default_vue)
		$L_Default_vue:=hmCal_MultiDayView
		SELECT LIST ITEMS BY REFERENCE:C630($P_This->; $L_Default_vue)
		hmCal_SET VIEW($L_Zone; $L_Default_vue)
		
	: (Form event code:C388=Sur libération:K2:2)
		
		CLEAR LIST:C377($P_This->)
End case 

