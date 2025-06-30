//%attributes = {}
// For the tests


C_LONGINT:C283($L_Max1)
$L_Max1:=500

C_LONGINT:C283($L_ref)
$L_ref:=4D_Progression_Open("Stop")



C_BOOLEAN:C305($B_Stop)
$B_Stop:=False:C215

C_LONGINT:C283($L_Milli)
$L_Milli:=Milliseconds:C459

$L_Tempo:=0

C_LONGINT:C283($i)
For ($i; 1; $L_Max1)
	
	If (Application type:C494#4D Server:K5:6)
		If ((($i%30)=0))
			
			// la propriete STOP
			// on ne la met pas ou on met -1
			// 1 l'utilisateur a cliqué STOP
			// 2 est la valeur au demarrage
			
			C_OBJECT:C1216($O_Progression)
			OB SET:C1220($O_Progression; \
				"progress ref"; $L_ref; \
				"progress titel"; "Transfert des actions"; \
				"progress message"; "Abonnez-vous à notre newsletter "+String:C10($i); \
				"progress compteur"; $i; \
				"progress max"; $L_Max1; \
				"progress stop"; 2\
				)
			4D_Progression_Send(->$O_Progression)
		End if 
	End if 
	
	
	If (OB Get:C1224($O_Progression; "progress stop"; Est un entier long:K8:6)=1)
		$i:=$L_Max1
		ALERT:C41("On a stoppé")
	End if 
End for 
4D_Progression_Close($L_ref)

$L_Milli:=Milliseconds:C459-$L_Milli

