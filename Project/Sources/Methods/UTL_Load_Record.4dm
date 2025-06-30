//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 27-12-18, 16:39:23
// ----------------------------------------------------
// Method: UTL_Load_Record
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $table)
$table:=$1

LOAD RECORD:C52($table->)

If (Locked:C147($table->)=True:C214)
	//UTL_Fenetre(250; 250; 4; "Procedure de numérotation")
	$vOlocked:=Get locked records info:C1316($table->)
	ASSERT:C1129(False:C215; "Conflit de numérotation")
	While (Locked:C147($table->)=True:C214)
		//POSITION MESSAGE(3; 3)
		//MESSAGE("Numérotation bloquée")
		LOAD RECORD:C52($table->)
		DELAY PROCESS:C323(Current process:C322; 60)
	End while 
End if 