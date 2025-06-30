//%attributes = {}
// Method RDV interface  
// 
C_POINTER:C301($P_AllDay; \
$P_Body; \
$P_button_annuler; \
$P_button_valider; \
$P_Date1; \
$P_Date2; \
$P_ID; \
$P_Lock; \
$P_pop_statut; \
$P_Rectangle rond; \
$P_Rectangle rond1; \
$P_Reminder; \
$P_Subject; \
$P_Time1; \
$P_Time2; \
$P_Tiptext; \
$P_tt_app_recurrence; \
$P_tt_app_recurrenceend; \
$P_tt_app_yearoption1; \
$P_tt_app_yearoption2; \
$P_UserID; \
$P_vd_app_rrule_date; \
$P_vl_app_rrule_interval; \
$P_vl_app_rrule_xtimes; \
$P_vl_app_yearlyoption; \
$P_vl_app_yearmonth1; \
$P_vl_app_yearmonth10; \
$P_vl_app_yearmonth11; \
$P_vl_app_yearmonth12; \
$P_vl_app_yearmonth2; \
$P_vl_app_yearmonth3; \
$P_vl_app_yearmonth4; \
$P_vl_app_yearmonth5; \
$P_vl_app_yearmonth6; \
$P_vl_app_yearmonth7; \
$P_vl_app_yearmonth8; \
$P_vl_app_yearmonth9)


App Get PTR(->$P_AllDay; \
->$P_Body; \
->$P_button_annuler; \
->$P_button_valider; \
->$P_Date1; \
->$P_Date2; \
->$P_ID; \
->$P_Lock; \
->$P_pop_statut; \
->$P_Rectangle rond; \
->$P_Rectangle rond1; \
->$P_Reminder; \
->$P_Subject; \
->$P_Time1; \
->$P_Time2; \
->$P_Tiptext; \
->$P_tt_app_recurrence; \
->$P_tt_app_recurrenceend; \
->$P_tt_app_yearoption1; \
->$P_tt_app_yearoption2; \
->$P_UserID; \
->$P_vd_app_rrule_date; \
->$P_vl_app_rrule_interval; \
->$P_vl_app_rrule_xtimes; \
->$P_vl_app_yearlyoption; \
->$P_vl_app_yearmonth1; \
->$P_vl_app_yearmonth10; \
->$P_vl_app_yearmonth11; \
->$P_vl_app_yearmonth12; \
->$P_vl_app_yearmonth2; \
->$P_vl_app_yearmonth3; \
->$P_vl_app_yearmonth4; \
->$P_vl_app_yearmonth5; \
->$P_vl_app_yearmonth6; \
->$P_vl_app_yearmonth7; \
->$P_vl_app_yearmonth8; \
->$P_vl_app_yearmonth9)


C_BOOLEAN:C305($B_Valide)
$B_Valide:=(Length:C16($P_Subject->)#0)
$B_Valide:=$B_Valide & ($P_Date1->#!00-00-00!) & ($P_Date2->#!00-00-00!)
$B_Valide:=$B_Valide & ($P_Time1->#?00:00:00?) & ($P_Time2->#?00:00:00?)
//$B_Valide:=$B_Valide & ($P_Lock->#True)
$B_Valide:=$B_Valide & ($P_Date1-><=$P_Date2->)
If ($P_Date1->=$P_Date2->)
	$B_Valide:=$B_Valide & ($P_Time1-><$P_Time2->)
End if 

OBJECT SET ENABLED:C1123($P_button_valider->; $B_Valide)