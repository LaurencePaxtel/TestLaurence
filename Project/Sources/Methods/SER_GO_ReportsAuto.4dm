//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 30-12-18, 08:10:52
// ----------------------------------------------------
// Method: SER_GO_ReportsAuto
// Description
// La méthode de lancement des reports auto côté serveur
// Pour la prise en compte de la gestion multi-sociétés
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i)

ARRAY TEXT:C222($tb_ref_structure; 0)

READ ONLY:C145([Structures:79])
ALL RECORDS:C47([Structures:79])

SELECTION TO ARRAY:C260([Structures:79]Ref_Structure:3; $tb_ref_structure)

For ($i; 1; Size of array:C274($tb_ref_structure))
	MultiSoc_Init_On_Server(2; $tb_ref_structure{$i})
	DébutInitReportAuto(4; $tb_ref_structure{$i})
	
	If (vb_ReportAuto)
		$PR_ReportServeur:=New process:C317("Go_ReportParProcess"; 0; "ReporAutoServeur : "+$tb_ref_structure{$i}; True:C214; $tb_ref_structure{$i}; *)
		DELAY PROCESS:C323(Current process:C322; 2*60*60)  //2 min
	End if 
	
End for 