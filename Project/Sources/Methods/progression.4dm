//%attributes = {}
// La méthode test_progression  
// 
// 
// #SYNTAX: test_progression 
// #PARAMETERS:
//     Aucun

// #DATE CREATION: 13/06/2014  #AUTHOR: Bertrand SOUBEYRAND soub@soub.org
// #DATE MODIFICATION: 00/00/0000
// #NOTE: 4D Progress component provided with 4D is mandatory

// #HEADER VERSION: 2

C_LONGINT:C283($L_Max)
$L_Max:=25

C_LONGINT:C283($L_ref)
$L_ref:=4D_Progression_Open("Stop")

C_OBJECT:C1216($O_Progression; $O_Progression1)

C_BOOLEAN:C305($B_Stop)
$B_Stop:=False:C215

C_LONGINT:C283($i)
For ($i; 1; $L_Max)
	
	OB SET:C1220($O_Progression; \
		"progress ref"; $L_ref; \
		"progress titel"; "Transfert des actions"; \
		"progress message"; "Abonnez-vous à notre newsletter"; \
		"progress value"; 4D_Progression_pourcent($i; $L_Max); \
		"progress stop"; -1\
		)
	
	4D_Progression_Send(->$O_Progression)
	
	$B_Stop:=OB Get:C1224($O_Progression; "progress stop"; Est un booléen:K8:9)
	If ($B_Stop)
		$i:=$L_Max
		//ALERT("On a stoppé")
	End if 
	
	C_LONGINT:C283($L_ref1)
	$L_ref1:=4D_Progression_Open("stop")
	
	C_LONGINT:C283($j)
	For ($j; 1; 30)
		
		OB SET:C1220($O_Progression1; \
			"progress ref"; $L_ref1; \
			"progress titel"; "Découpage des tranches"; \
			"progress message"; "Du bon travail"; \
			"progress value"; 4D_Progression_pourcent($j; 30); \
			"progress stop"; -1\
			)
		
		4D_Progression_Send(->$O_Progression1)
		DELAY PROCESS:C323(Current process:C322; 2)
	End for 
	4D_Progression_Close($L_ref1)
	
	DELAY PROCESS:C323(Current process:C322; 4)
End for 
4D_Progression_Close($L_ref)

