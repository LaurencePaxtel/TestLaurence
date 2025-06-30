C_LONGINT:C283($ij; $kk)

Case of 
	: (Form event code:C388=Sur clic:K2:4)  // 15/8/17
		CONFIRM:C162("Voulez-vous enregistrer les modifications ?"; "Oui"; "Non")
		
		If (OK=1)
			Quit_HBAction(True:C214)
			SAVE RECORD:C53([HeBerge:4])
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Actions))
			
			If ([HeberGement:5]HG_ReferenceID:1>0)
				va_NomClé:=Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24)
				va_Rép:=""
				
				If ([HeberGement:5]HG_NuitenCours:92>1)
					va_Rép:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
				End if 
				
				vh_Htr:=Current time:C178()
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
				MultiSoc_Filter(->[HeBerge:4])
				
				If (Records in selection:C76([HeBerge:4])=1)
					vt_Action:=[HeBerge:4]HG_Actions:40
				Else 
					vt_Action:=""
				End if 
				
				_O_PAGE SETUP:C299([HeberGement:5]; "HG_PrtActionA")
				CONFIRM:C162("Cliquez 'OK' pour le format B3 ou 'annuler' pour le format A4.")
				
				If (OK=1)
					$ij:=Length:C16(vt_Action)
					
					If ($ij>0)
						
						For ($ii; 1; $ij)
							
							If (Character code:C91(vt_Action[[$ii]])=13)
								$kk:=$kk+1
							End if 
							
						End for 
						
					End if 
					
					If ($kk>12)
						CLEAR VARIABLE:C89($kk)
						
						Repeat 
							
							If (Character code:C91(vt_Action[[$ij]])=13)
								$kk:=$kk+1
							End if 
							
							$ij:=$ij-1
						Until ($kk=12) | ($ij=1)
						
						vt_Action:="... "+Substring:C12(vt_Action; $ij+1)
					End if 
					
					If (Length:C16(vt_Action)>700) & (7=8)
						vt_Action:="… "+Substring:C12(vt_Action; Length:C16(vt_Action)-700)
					End if 
					
					FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtActionB")
					FORM SET INPUT:C55([HeberGement:5]; "HG_PrtActionB")
				Else 
					
					If (Length:C16(vt_Action)>1000)
						vt_Action:="... "+Substring:C12(vt_Action; Length:C16(vt_Action)-1000)
					End if 
					
					FORM SET OUTPUT:C54([HeberGement:5]; "HG_PrtActionA")
					FORM SET INPUT:C55([HeberGement:5]; "HG_PrtActionA")
				End if 
				
				PRINT RECORD:C71([HeberGement:5])
			End if 
			
		Else 
			StrAlerte(6; "'Imprimer Actions'")
		End if 
		
End case 