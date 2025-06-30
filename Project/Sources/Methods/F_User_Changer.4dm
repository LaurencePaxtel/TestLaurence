//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_User_Changer
//{          Lundi 28 mars 2011 à 12:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($Position; $vl_CarAZ; $vl_Car09; $vl_CarSpec)

Case of 
	: ($1=-2)
		
		For ($ii; 1; Length:C16(va_MPmot1))
			$Position:=Character code:C91(va_MPmot1[[$ii]])
			
			Case of 
				: ($Position=Character code:C91("."))
					$vl_CarSpec:=$vl_CarSpec+1
				: ($Position=Character code:C91("&"))
					$vl_CarSpec:=$vl_CarSpec+1
				: ($Position=Character code:C91("?"))
					$vl_CarSpec:=$vl_CarSpec+1
				: ($Position=Character code:C91("*"))
					$vl_CarSpec:=$vl_CarSpec+1
				: ($Position=Character code:C91("$"))
					$vl_CarSpec:=$vl_CarSpec+1
				: ($Position=Character code:C91("£"))
					$vl_CarSpec:=$vl_CarSpec+1
				: (($Position>=Character code:C91("a")) & ($Position<=Character code:C91("z")))
					$vl_CarAZ:=$vl_CarAZ+1
				: (($Position>=Character code:C91("A")) & ($Position<=Character code:C91("Z")))
					$vl_CarAZ:=$vl_CarAZ+1
				: (($Position>=Character code:C91("0")) & ($Position<=Character code:C91("9")))
					$vl_Car09:=$vl_Car09+1
			End case 
			
		End for 
		
		$Position:=$vl_Car09+$vl_CarSpec
		
		If ($vl_CarAZ>=4) & ($Position>=4)
			$0:=True:C214
		End if 
		
	: ($1=-1)
		vb_OKMP:=False:C215
		OBJECT SET VISIBLE:C603(*; "Act_@"; False:C215)
		
		va_MPmotOld:=""
		va_MPmot1:=""
		va_MPmot2:=""
		
		OBJECT SET ENABLED:C1123(b_ValMPIN; False:C215)
		
		ON ERR CALL:C155("i_Error")
		vb_OKMP:=Validate password:C638($2; va_MPmotOld)
		ON ERR CALL:C155("")
		
		OBJECT SET VISIBLE:C603(*; "Act_MPOld_OK"; vb_OKMP)
		OBJECT SET VISIBLE:C603(*; "Act_MPOld_Red"; Not:C34(vb_OKMP))
		OBJECT SET VISIBLE:C603(*; "Act_MPNew1_Red"; True:C214)
		OBJECT SET VISIBLE:C603(*; "Act_MPNew2_Red"; True:C214)
	: ($1=0)
		$vb_OK:=(Length:C16(va_MPmot1)=Length:C16(va_MPmot2))
		$vb_OK:=$vb_OK & (Length:C16(va_MPmot1)>=<>vl_T_MPLongueur)
		$vb_OK:=$vb_OK & (va_MPmot1=va_MPmot2)
		
		If ($vb_OK)
			$vb_OK:=F_User_Changer(-2)
		End if 
		
		$vb_OK:=$vb_OK & vb_OKMP
		
		If ($vb_OK)
			OBJECT SET ENABLED:C1123(b_ValMPIN; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_ValMPIN; False:C215)
		End if 
		
	: ($1=1)  //Mot de passe 1
		va_MPmot1:=Replace string:C233(va_MPmot1; Char:C90(<>vl_ArrowBase); "")
		
		$vb_OK:=(va_MPmot1>"")
		$vb_OK:=$vb_OK & (Length:C16(va_MPmot1)>=<>vl_T_MPLongueur)
		$vb_OK:=$vb_OK & F_User_Changer(-2)
		
		OBJECT SET VISIBLE:C603(*; "Act_MPNew1_OK"; $vb_OK)
		OBJECT SET VISIBLE:C603(*; "Act_MPNew1_Red"; Not:C34($vb_OK))
		
		$vb_OK:=F_User_Changer(0)
		
		va_MPmot2:=""
		
		OBJECT SET VISIBLE:C603(*; "Act_MPNew2_OK"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Act_MPNew2_Red"; True:C214)
	: ($1=2)  //Mot de passe 2
		va_MPmot2:=Replace string:C233(va_MPmot2; Char:C90(<>vl_ArrowBase); "")
		
		$vb_OK:=(va_MPmot2>"")
		$vb_OK:=$vb_OK & (Length:C16(va_MPmot2)>=<>vl_T_MPLongueur)
		$vb_OK:=$vb_OK & (va_MPmot1=va_MPmot2)
		
		If ($vb_OK)
			$vb_OK:=F_User_Changer(-2)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "Act_MPNew2_OK"; $vb_OK)
		OBJECT SET VISIBLE:C603(*; "Act_MPNew2_Red"; Not:C34($vb_OK))
		
		$vb_OK:=F_User_Changer(0)
	: ($1=3)  //Mot de passe old
		OBJECT SET VISIBLE:C603(*; "Act_MPOld_@"; False:C215)
		
		va_MPmotOld:=Replace string:C233(va_MPmotOld; Char:C90(<>vl_ArrowBase); "")
		
		ON ERR CALL:C155("i_Error")
		vb_OKMP:=Validate password:C638($2; va_MPmotOld)
		ON ERR CALL:C155("")
		
		OBJECT SET VISIBLE:C603(*; "Act_MPOld_OK"; vb_OKMP)
		OBJECT SET VISIBLE:C603(*; "Act_MPOld_Red"; Not:C34(vb_OKMP))
		
		$vb_OK:=F_User_Changer(0)
	: ($1=5)  //Modifier le mot de passe
		
		If ($2=1) | ($2=2)
			ALERT:C41("Vous avez le profil : "+("Développeur "*Num:C11($2=1))+("Administrateur "*Num:C11($2=2))+Char:C90(13)+Char:C90(13)+"La modification du mot de passe est accessible dans le menu privilèges.")
			REJECT:C38
		Else 
			
			If (i_Confirmer("-> Modification du mot de passe"+<>va_CR+<>va_CR+va_MPmot2+<>va_CR+<>va_CR+"Confirmez-vous ?"))
				
				If (Length:C16(va_MPmot2)>=<>ve_MotPasseLongueur)
					READ WRITE:C146([INtervenants:10])
					QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=<>vl_UserRéfU)
					
					MultiSoc_Filter(->[INtervenants:10])
					
					If (Records in selection:C76([INtervenants:10])=1)
						
						Repeat 
							LOAD RECORD:C52([INtervenants:10])
						Until (Not:C34(Locked:C147([INtervenants:10])))
						
						// Modifié par : Scanu Rémy (20/02/2024)
						// On abandonne la gestion des mots de passe sur 4D mais on passe par la table [INtervenants]
						[INtervenants:10]IN_HashPassword:22:=Generate password hash:C1533(va_MPmot2)
						[INtervenants:10]IN_DateDeModifDuMP:15:=Current date:C33(*)
						SAVE RECORD:C53([INtervenants:10])
					End if 
					
					UNLOAD RECORD:C212([INtervenants:10])
					READ ONLY:C145([INtervenants:10])
				Else 
					ALERT:C41("Le mot de passe doit avoir "+String:C10(<>ve_MotPasseLongueur)+" caractères minimum, veuillez réessayer.")
				End if 
				
			Else 
				REJECT:C38
			End if 
			
		End if 
		
	: ($1=6)  // Modifier le mot de passe dans la fiche
		
		If (i_Confirmer("Confirmez la modification du mot de passe ?"))
			ON ERR CALL:C155("i_Error")
			
			// Modifié par : Scanu Rémy (20/02/2024)
			[INtervenants:10]IN_HashPassword:22:=Generate password hash:C1533(va_MPmot2)
			[INtervenants:10]IN_DateDeModifDuMP:15:=Current date:C33(*)
			SAVE RECORD:C53([INtervenants:10])
			
			ON ERR CALL:C155("")
		End if 
		
End case 