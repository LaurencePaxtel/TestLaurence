//%attributes = {}
// Method App Get PTR  
// 

C_POINTER:C301($1; $P_AllDay)
C_POINTER:C301($2; $P_Body)
C_POINTER:C301($3; $P_button_annuler)
C_POINTER:C301($4; $P_button_valider)
C_POINTER:C301($5; $P_Date1)
C_POINTER:C301($6; $P_Date2)
C_POINTER:C301($7; $P_ID)
C_POINTER:C301($8; $P_Lock)
C_POINTER:C301($9; $P_pop_statut)
C_POINTER:C301($10; $P_Rectangle rond)
C_POINTER:C301($11; $P_Rectangle rond1)
C_POINTER:C301($12; $P_Reminder)
C_POINTER:C301($13; $P_Subject)
C_POINTER:C301($14; $P_Time1)
C_POINTER:C301($15; $P_Time2)
C_POINTER:C301($16; $P_Tiptext)
C_POINTER:C301($17; $P_tt_app_recurrence)
C_POINTER:C301($18; $P_tt_app_recurrenceend)
C_POINTER:C301($19; $P_tt_app_yearoption1)
C_POINTER:C301($20; $P_tt_app_yearoption2)
C_POINTER:C301($21; $P_UserID)
C_POINTER:C301($22; $P_vd_app_rrule_date)
C_POINTER:C301($23; $P_vl_app_rrule_interval)
C_POINTER:C301($24; $P_vl_app_rrule_xtimes)
C_POINTER:C301($25; $P_vl_app_yearlyoption)
C_POINTER:C301($26; $P_vl_app_yearmonth1)
C_POINTER:C301($27; $P_vl_app_yearmonth10)
C_POINTER:C301($28; $P_vl_app_yearmonth11)
C_POINTER:C301($29; $P_vl_app_yearmonth12)
C_POINTER:C301($30; $P_vl_app_yearmonth2)
C_POINTER:C301($31; $P_vl_app_yearmonth3)
C_POINTER:C301($32; $P_vl_app_yearmonth4)
C_POINTER:C301($33; $P_vl_app_yearmonth5)
C_POINTER:C301($34; $P_vl_app_yearmonth6)
C_POINTER:C301($35; $P_vl_app_yearmonth7)
C_POINTER:C301($36; $P_vl_app_yearmonth8)
C_POINTER:C301($37; $P_vl_app_yearmonth9)


$P_AllDay:=OBJECT Get pointer:C1124(3; "AllDay")
$P_Body:=OBJECT Get pointer:C1124(3; "Body")
$P_button_annuler:=OBJECT Get pointer:C1124(3; "button_annuler")
$P_button_valider:=OBJECT Get pointer:C1124(3; "button_valider")
$P_Date1:=OBJECT Get pointer:C1124(3; "Date1")
$P_Date2:=OBJECT Get pointer:C1124(3; "Date2")
$P_ID:=OBJECT Get pointer:C1124(3; "ID")
$P_Lock:=OBJECT Get pointer:C1124(3; "Lock")
$P_pop_statut:=OBJECT Get pointer:C1124(3; "pop_statut")
$P_Rectangle rond:=OBJECT Get pointer:C1124(3; "Rectangle rond")
$P_Rectangle rond1:=OBJECT Get pointer:C1124(3; "Rectangle rond1")
$P_Reminder:=OBJECT Get pointer:C1124(3; "Reminder")
$P_Subject:=OBJECT Get pointer:C1124(3; "Subject")
$P_Time1:=OBJECT Get pointer:C1124(3; "Time1")
$P_Time2:=OBJECT Get pointer:C1124(3; "Time2")
$P_Tiptext:=OBJECT Get pointer:C1124(3; "Tiptext")
$P_tt_app_recurrence:=OBJECT Get pointer:C1124(3; "tt_app_recurrence")
$P_tt_app_recurrenceend:=OBJECT Get pointer:C1124(3; "tt_app_recurrenceend")
$P_tt_app_yearoption1:=OBJECT Get pointer:C1124(3; "tt_app_yearoption1")
$P_tt_app_yearoption2:=OBJECT Get pointer:C1124(3; "tt_app_yearoption2")
$P_UserID:=OBJECT Get pointer:C1124(3; "UserID")
$P_vd_app_rrule_date:=OBJECT Get pointer:C1124(3; "vd_app_rrule_date")
$P_vl_app_rrule_interval:=OBJECT Get pointer:C1124(3; "vl_app_rrule_interval")
$P_vl_app_rrule_xtimes:=OBJECT Get pointer:C1124(3; "vl_app_rrule_xtimes")
$P_vl_app_yearlyoption:=OBJECT Get pointer:C1124(3; "vl_app_yearlyoption")
$P_vl_app_yearmonth1:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth1")
$P_vl_app_yearmonth10:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth10")
$P_vl_app_yearmonth11:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth11")
$P_vl_app_yearmonth12:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth12")
$P_vl_app_yearmonth2:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth2")
$P_vl_app_yearmonth3:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth3")
$P_vl_app_yearmonth4:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth4")
$P_vl_app_yearmonth5:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth5")
$P_vl_app_yearmonth6:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth6")
$P_vl_app_yearmonth7:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth7")
$P_vl_app_yearmonth8:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth8")
$P_vl_app_yearmonth9:=OBJECT Get pointer:C1124(3; "vl_app_yearmonth9")


$1->:=$P_AllDay  // Page: 1 - Objet: type checkbox
$2->:=$P_Body  // Page: 1 - Objet: type text input
$3->:=$P_button_annuler  // Page: 1 - Objet: type push button
$4->:=$P_button_valider  // Page: 1 - Objet: type push button
$5->:=$P_Date1  // Page: 1 - Objet: type text input
$6->:=$P_Date2  // Page: 1 - Objet: type text input
$7->:=$P_ID  // Page: 1 - Objet: type text input
$8->:=$P_Lock  // Page: 1 - Objet: type checkbox
$9->:=$P_pop_statut  // Page: 1 - Objet: type hierarchical popup
$10->:=$P_Rectangle rond  // Page: 1 - Objet: type rounded rectangle
$11->:=$P_Rectangle rond1  // Page: 1 - Objet: type rounded rectangle
$12->:=$P_Reminder  // Page: 1 - Objet: type checkbox
$13->:=$P_Subject  // Page: 1 - Objet: type text input
$14->:=$P_Time1  // Page: 1 - Objet: type text input
$15->:=$P_Time2  // Page: 1 - Objet: type text input
$16->:=$P_Tiptext  // Page: 1 - Objet: type text input
$17->:=$P_tt_app_recurrence  // Page: 1 - Objet: type popup drop down
$18->:=$P_tt_app_recurrenceend  // Page: 1 - Objet: type popup drop down
$19->:=$P_tt_app_yearoption1  // Page: 1 - Objet: type popup drop down
$20->:=$P_tt_app_yearoption2  // Page: 1 - Objet: type popup drop down
$21->:=$P_UserID  // Page: 1 - Objet: type text input
$22->:=$P_vd_app_rrule_date  // Page: 1 - Objet: type text input
$23->:=$P_vl_app_rrule_interval  // Page: 1 - Objet: type text input
$24->:=$P_vl_app_rrule_xtimes  // Page: 1 - Objet: type text input
$25->:=$P_vl_app_yearlyoption  // Page: 1 - Objet: type checkbox
$26->:=$P_vl_app_yearmonth1  // Page: 1 - Objet: type 3D checkbox
$27->:=$P_vl_app_yearmonth10  // Page: 1 - Objet: type 3D checkbox
$28->:=$P_vl_app_yearmonth11  // Page: 1 - Objet: type 3D checkbox
$29->:=$P_vl_app_yearmonth12  // Page: 1 - Objet: type 3D checkbox
$30->:=$P_vl_app_yearmonth2  // Page: 1 - Objet: type 3D checkbox
$31->:=$P_vl_app_yearmonth3  // Page: 1 - Objet: type 3D checkbox
$32->:=$P_vl_app_yearmonth4  // Page: 1 - Objet: type 3D checkbox
$33->:=$P_vl_app_yearmonth5  // Page: 1 - Objet: type 3D checkbox
$34->:=$P_vl_app_yearmonth6  // Page: 1 - Objet: type 3D checkbox
$35->:=$P_vl_app_yearmonth7  // Page: 1 - Objet: type 3D checkbox
$36->:=$P_vl_app_yearmonth8  // Page: 1 - Objet: type 3D checkbox
$37->:=$P_vl_app_yearmonth9  // Page: 1 - Objet: type 3D checkbox


// EOM


If (False:C215)
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
End if 

