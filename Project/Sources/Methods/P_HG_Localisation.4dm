//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy è remy@connect-io.fr
// Date et heure : 01/07/21, 18:16:29
// ----------------------------------------------------
// Méthode : P_HG_Localisation
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($vaUn)
C_BOOLEAN:C305($vb_OK)

$vaUn:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))

If (<>vb_UserLOFT)
	
	If (Size of array:C274(<>ta_InPerm)>0)
		
		For ($ii; 1; Size of array:C274(<>ta_InPerm))
			
			If (<>ta_InPerm{$ii}=[HeberGement:5]HG_Permanencier:9)
				$vb_OK:=True:C214
			End if 
			
		End for 
		
	End if 
	
	If ($vaUn="N") & ($vb_OK)
		Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "R"; [HeberGement:5]HG_FicheNuméro:3)
		
		vb_Show:=False:C215
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
		// On ne ferme pas le formulaire
		//NE PAS VALIDER
		POST OUTSIDE CALL:C329(<>PR_Genéral)
	Else 
		StrAlerte(27; "")
	End if 
	
Else 
	
	If (<>vb_T_ModeCHRS)
		$vb_OK:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
		
		If ($vb_OK)
			
			Case of 
				: (User in group:C338(Current user:C182; <>Groupe_Jour) & User in group:C338(Current user:C182; <>Groupe_Nuit))
					$vb_OK:=True:C214
				: (User in group:C338(Current user:C182; <>Groupe_Jour))
					$vb_OK:=($vaUn="J")
				: (User in group:C338(Current user:C182; <>Groupe_Nuit))
					$vb_OK:=($vaUn="N")
			End case 
			
		End if 
		
	Else 
		$vb_OK:=True:C214
	End if 
	
	If ($vb_OK)
		Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "R"; [HeberGement:5]HG_FicheNuméro:3)
		
		vb_Show:=False:C215
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
		// On ne ferme pas le formulaire
		//NE PAS VALIDER
		
		POST OUTSIDE CALL:C329(<>PR_Genéral)
	Else 
		StrAlerte(6; "")
	End if 
	
End if 