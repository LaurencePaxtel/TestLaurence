var $jourNuit_t : Text
var $vb_OK : Boolean
var $vl_EventFF; $ii : Integer

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		va_TypeNo:=""
		
		If (Is new record:C668([GrouPe:36]))
			[GrouPe:36]GP_ReferenceID:1:=Uut_Numerote(->[GrouPe:36])
			
			// Modifié par : Scanu Rémy (27/06/2022)
			If (va_JourNuit#"JN")
				[GrouPe:36]GP_Nuit:5:=(va_JourNuit="N")
			End if 
			
			If ([GrouPe:36]GP_Nuit:5=True:C214)
				$ii:=Uut_Numerote(-><>vaCPT_GpeN)
			Else 
				$ii:=Uut_Numerote(-><>vaCPT_GpeJ)
			End if 
			
			[GrouPe:36]GP_Numéro:7:=Choose:C955([GrouPe:36]GP_Nuit:5=True:C214; "N"; "J")+"_"+String:C10($ii; "00000")
			va_TypeNo:="Format du numéro : "+Choose:C955([GrouPe:36]GP_Nuit:5=True:C214; "N"; "J")+"_00000"
		Else 
			OBJECT SET ENTERABLE:C238([GrouPe:36]GP_Numéro:7; False:C215)
		End if 
		
		OBJECT SET ENTERABLE:C238([GrouPe:36]GP_Numéro:7; False:C215)
		va_GPType:=("Nuit"*Num:C11([GrouPe:36]GP_Nuit:5=True:C214))+("Jour"*Num:C11([GrouPe:36]GP_Nuit:5=False:C215))
	: ($vl_EventFF=Sur données modifiées:K2:15)
		$jourNuit_t:=Choose:C955([GrouPe:36]GP_Nuit:5=True:C214; "N"; "J")
		
		If (Modified:C32([GrouPe:36]GP_Intitulé:4))
			[GrouPe:36]GP_Intitulé:4:=Uppercase:C13([GrouPe:36]GP_Intitulé:4)
		End if 
		
		If (Modified:C32([GrouPe:36]GP_Numéro:7))
			$vb_OK:=True:C214
			
			If ([GrouPe:36]GP_Numéro:7[[1]]=$jourNuit_t)
				
				If ([GrouPe:36]GP_Numéro:7[[2]]="_")
					$ii:=2
					
					Repeat 
						$ii:=$ii+1
						
						If ([GrouPe:36]GP_Numéro:7[[$ii]]>="0") & ([GrouPe:36]GP_Numéro:7[[$ii]]<="9")
						Else 
							$vb_OK:=False:C215
						End if 
						
					Until ($ii=7) | ($vb_OK=False:C215)
					
				Else 
					$vb_OK:=False:C215
				End if 
				
			Else 
				$vb_OK:=False:C215
			End if 
			
			If ($vb_OK=False:C215)
				REJECT:C38([GrouPe:36]GP_Numéro:7)
				ALERT:C41("Voir Format du numéro !")
			End if 
			
		End if 
		
End case 