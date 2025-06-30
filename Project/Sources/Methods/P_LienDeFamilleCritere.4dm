//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($vl_taille; $vl_RefID)
ARRAY LONGINT:C221($tl_Hebergement; 0)
ARRAY LONGINT:C221($tl_Personne; 0)
ARRAY TEXT:C222($ta_Lien; 0)

Case of 
	: ($1="Renuméroter")
		USE SET:C118("E_LDF_Selection")
		va_LDF_Temp:=<>va_T_Site+<>va_T_Departement+"@"
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104>""; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104#va_LDF_Temp; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_FamChef:103=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		$vl_taille:=Records in selection:C76([HeberGement:5])
		If ($vl_taille>0)
			vh_LDF_DebutRenum:=Current time:C178
			
			i_Message("Renuméroter les liens ")
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
			
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_Hebergement; [HeberGement:5]HG_HB_ID:19; $tl_Personne; [HeberGement:5]HG_FamClé:104; $ta_Lien)
			READ WRITE:C146([HeBerge:4])
			READ WRITE:C146([HeberGement:5])
			$vl_RefID:=0
			For ($ii; 1; $vl_taille)
				i_MessageSeul("Renuméroter les liens : "+String:C10($ii)+"/"+String:C10($vl_taille))
				If ($vl_RefID=$tl_Personne{$ii})
				Else 
					
					$vl_RefID:=$tl_Personne{$ii}
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$tl_Personne{$ii})
					If (Records in selection:C76([HeBerge:4])=1)
						Repeat 
							IDLE:C311
							LOAD RECORD:C52([HeBerge:4])
						Until (Not:C34(Locked:C147([HeBerge:4])))
						If ([HeBerge:4]HB_CléFam:47="")
							[HeBerge:4]HB_CléFam:47:=$ta_Lien{$ii}
						End if 
						
						[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
						[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
						
						va_LDF_Lien:=[HeBerge:4]HB_CléFam:47
						va_LDF_LienTrans:=[HeBerge:4]HB_Trans_CléFam:56
						
						SAVE RECORD:C53([HeBerge:4])
						UNLOAD RECORD:C212([HeBerge:4])
						If (va_LDF_LienTrans>"")
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FamClé:104=va_LDF_LienTrans)
							If (Records in selection:C76([HeberGement:5])>0)
								APPLY TO SELECTION:C70([HeberGement:5]; P_LienDeFamilleAPP)
							End if 
						End if 
					End if 
					
				End if 
				
				
			End for 
			UNLOAD RECORD:C212([HeBerge:4])
			READ ONLY:C145([HeBerge:4])
			UNLOAD RECORD:C212([HeberGement:5])
			READ ONLY:C145([HeberGement:5])
			CLOSE WINDOW:C154
			vh_LDF_FinRenum:=Current time:C178
			vh_LDF_DureRenum:=vh_LDF_FinRenum-vh_LDF_DebutRenum
		Else 
			ALERT:C41("Aucune fiche à traiter.")
		End if 
		
		
	: ($1="ChefDefamille")
		USE SET:C118("E_LDF_Selection")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104="")
		$vl_taille:=Records in selection:C76([HeberGement:5])
		If ($vl_taille>0)
			If (i_Confirmer("2- Cette fonction s'applique aux HS et FS non chef de famille"+" qui n'ont pas de lien"+<>va_CR+"Confirmer-vous la modification ?"))
				
				vh_LDF_DebutChef:=Current time:C178
				
				i_Message("Chef de famille ")
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
				$vl_RefID:=0
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_Hebergement; [HeberGement:5]HG_HB_ID:19; $tl_Personne; [HeberGement:5]HG_FamClé:104; $ta_Lien)
				READ WRITE:C146([HeBerge:4])
				READ WRITE:C146([HeberGement:5])
				For ($ii; 1; $vl_taille)
					i_MessageSeul("ChefDefamille : "+String:C10($ii)+"/"+String:C10($vl_taille))
					If ($vl_RefID=$tl_Personne{$ii})
					Else 
						$vl_RefID:=$tl_Personne{$ii}
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$tl_Personne{$ii})
						If (Records in selection:C76([HeBerge:4])=1)
							Repeat 
								IDLE:C311
								LOAD RECORD:C52([HeBerge:4])
							Until (Not:C34(Locked:C147([HeBerge:4])))
							
							
							[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
							[HeBerge:4]HB_Trans_CléFam:56:=""
							
							va_LDF_Lien:=[HeBerge:4]HB_CléFam:47
							va_LDF_LienTrans:=[HeBerge:4]HB_Trans_CléFam:56
							vl_LDF_ID:=[HeBerge:4]HB_ReferenceID:1
							
							SAVE RECORD:C53([HeBerge:4])
							UNLOAD RECORD:C212([HeBerge:4])
							If (vl_LDF_ID>0)
								QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_LDF_ID)
								If (Records in selection:C76([HeberGement:5])>0)
									APPLY TO SELECTION:C70([HeberGement:5]; P_LienDeFamilleAPP2)
								End if 
							End if 
						End if 
					End if 
				End for 
				UNLOAD RECORD:C212([HeBerge:4])
				READ ONLY:C145([HeBerge:4])
				UNLOAD RECORD:C212([HeberGement:5])
				READ ONLY:C145([HeberGement:5])
				CLOSE WINDOW:C154
				vh_LDF_FinChef:=Current time:C178
				vh_LDF_DureChef:=vh_LDF_FinChef-vh_LDF_DebutChef
			End if 
		Else 
			ALERT:C41("Aucune fiche à traiter.")
		End if 
		
	: ($1="Orientation")
		USE SET:C118("E_LDF_Selection")
		$vl_taille:=Records in selection:C76([HeberGement:5])
		If ($vl_taille>0)
			vh_LDF_DebutCas:=Current time:C178
			ARRAY LONGINT:C221(tl_DosSIAO_HG; 0)
			ARRAY TEXT:C222(ta_DosSIAO_HG; 0)
			i_Message("Orientation")
			READ WRITE:C146([HeberGement:5])
			APPLY TO SELECTION:C70([HeberGement:5]; P_LienDeFamilleAPP3)
			UNLOAD RECORD:C212([HeberGement:5])
			$vl_taille:=Size of array:C274(tl_DosSIAO_HG)
			If ($vl_taille>0)
				For ($ii; 1; $vl_taille)
					i_MessageSeul("Orientation : "+String:C10($ii)+"/"+String:C10($vl_taille))
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=tl_DosSIAO_HG{$ii}; *)
					QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_DossierSIAO:164#ta_DosSIAO_HG{$ii})
					MultiSoc_Filter(->[HeberGement:5])
					If (Records in selection:C76([HeberGement:5])>0)
						APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_DossierSIAO:164:=ta_DosSIAO_HG{$ii})
					End if 
					
				End for 
			End if 
			READ ONLY:C145([HeberGement:5])
			CLOSE WINDOW:C154
			vh_LDF_FinCas:=Current time:C178
			vh_LDF_DureCas:=vh_LDF_FinCas-vh_LDF_DebutCas
		Else 
			ALERT:C41("Aucune fiche à traiter.")
		End if 
		
		
	: ($1="NonCheffamille")
		USE SET:C118("E_LDF_Selection")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamChef:103=False:C215; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104>"")
		$vl_taille:=Records in selection:C76([HeberGement:5])
		If ($vl_taille>0)
			If (i_Confirmer("3 - Cette fonction s'applique aux HS et FS non chef de famille"+" qui ont cependant un lien"+<>va_CR+"Confirmer-vous la modification ?"))
				
				vh_LDF_DebutNonChef:=Current time:C178
				
				i_Message("Non chef de famille ")
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
				$vl_RefID:=0
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_Hebergement; [HeberGement:5]HG_HB_ID:19; $tl_Personne; [HeberGement:5]HG_FamClé:104; $ta_Lien)
				READ WRITE:C146([HeBerge:4])
				READ WRITE:C146([HeberGement:5])
				For ($ii; 1; $vl_taille)
					i_MessageSeul("NonChefDefamille : "+String:C10($ii)+"/"+String:C10($vl_taille))
					If ($vl_RefID=$tl_Personne{$ii})
					Else 
						$vl_RefID:=$tl_Personne{$ii}
						QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$tl_Personne{$ii})
						If (Records in selection:C76([HeBerge:4])=1)
							Repeat 
								IDLE:C311
								LOAD RECORD:C52([HeBerge:4])
							Until (Not:C34(Locked:C147([HeBerge:4])))
							
							[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
							[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
							
							
							va_LDF_Lien:=[HeBerge:4]HB_CléFam:47
							va_LDF_LienTrans:=[HeBerge:4]HB_Trans_CléFam:56
							vl_LDF_ID:=[HeBerge:4]HB_ReferenceID:1
							
							SAVE RECORD:C53([HeBerge:4])
							UNLOAD RECORD:C212([HeBerge:4])
							If (vl_LDF_ID>0)
								QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_LDF_ID)
								If (Records in selection:C76([HeberGement:5])>0)
									APPLY TO SELECTION:C70([HeberGement:5]; P_LienDeFamilleAPP2Suite)
								End if 
							End if 
						End if 
					End if 
				End for 
				UNLOAD RECORD:C212([HeBerge:4])
				READ ONLY:C145([HeBerge:4])
				UNLOAD RECORD:C212([HeberGement:5])
				READ ONLY:C145([HeberGement:5])
				CLOSE WINDOW:C154
				vh_LDF_FinNonChef:=Current time:C178
				vh_LDF_DureNonChef:=vh_LDF_FinNonChef-vh_LDF_DebutNonChef
			End if 
		Else 
			ALERT:C41("Aucune fiche à traiter.")
		End if 
		
		
	: ($1="Dossier")
		If (<>vb_T_ModeCHRS)
			ALERT:C41("Fonction active uniquement au 115 .")
		Else 
			USE SET:C118("E_LDF_Selection")
			$vl_taille:=Records in selection:C76([HeberGement:5])
			If ($vl_taille>0)
				vh_LDF_DebutDos:=Current time:C178
				i_Message("Création des dossiers SIAO")
				vl_LDF_Indice:=0
				vl_LDF_Taille:=$vl_taille
				If (7=8)
					READ WRITE:C146([HeberGement:5])
					APPLY TO SELECTION:C70([HeberGement:5]; P_LienDeFamilleAPP4)
					UNLOAD RECORD:C212([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
				Else 
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
					ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
					$vl_RefID:=0
					SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_Hebergement; [HeberGement:5]HG_HB_ID:19; $tl_Personne)
					READ WRITE:C146([HeberGement:5])
					For ($ii; 1; $vl_taille)
						If ($vl_RefID=$tl_Personne{$ii})
						Else 
							$vl_RefID:=$tl_Personne{$ii}
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$tl_Hebergement{$ii})
							If (Records in selection:C76([HeberGement:5])=1)
								P_LienDeFamilleAPP4
							End if 
						End if 
						UNLOAD RECORD:C212([HeberGement:5])
					End for 
					UNLOAD RECORD:C212([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
				End if 
				CLOSE WINDOW:C154
				vh_LDF_FinDos:=Current time:C178
				vh_LDF_DureDos:=vh_LDF_FinDos-vh_LDF_DebutDos
			End if 
		End if 
		
		
	: ($1="BasculeChef")
		USE SET:C118("E_LDF_Selection")
		If (Records in set:C195("E_LDF_Selection")=1)
			If ([HeberGement:5]HG_FamChef:103=False:C215) & ([HeberGement:5]HG_FamClé:104>"")
				If (i_Confirmer("Cette fonction s'applique à une personne ayant "+"un code lien et qui n'est pas chef de famille"+<>va_CR+"Confirmer-vous la modification en chef de famille ?"))
					vl_LDF_ID:=[HeberGement:5]HG_HB_ID:19
					va_LDF_Lien:=[HeberGement:5]HG_FamClé:104
					UNLOAD RECORD:C212([HeberGement:5])
					READ WRITE:C146([HeberGement:5])
					READ WRITE:C146([HeBerge:4])
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_LDF_ID)
					If (Records in selection:C76([HeBerge:4])=1)
						Repeat 
							IDLE:C311
							LOAD RECORD:C52([HeBerge:4])
						Until (Not:C34(Locked:C147([HeBerge:4])))
						[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
						[HeBerge:4]HB_CléFam:47:=va_LDF_Lien
						va_LDF_LienTrans:=[HeBerge:4]HB_Trans_CléFam:56
						SAVE RECORD:C53([HeBerge:4])
						UNLOAD RECORD:C212([HeBerge:4])
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_LDF_ID)
						If (Records in selection:C76([HeberGement:5])>0)
							APPLY TO SELECTION:C70([HeberGement:5]; P_LienDeFamilleAPP2Suite)
						End if 
					End if 
					UNLOAD RECORD:C212([HeBerge:4])
					READ ONLY:C145([HeBerge:4])
					READ WRITE:C146([HeberGement:5])
				End if 
			Else 
				ALERT:C41("Fonction active uniquement sur une seule fiche dans la sélection"+" ayant un code lien et qui n'est pas chef de famille.")
			End if 
		Else 
			ALERT:C41("Fonction active uniquement sur une seule fiche dans la sélection"+" ayant un code lien et qui n'est pas chef de famille.")
		End if 
		
	: ($1="BasculeNonChef")
		USE SET:C118("E_LDF_Selection")
		If (Records in set:C195("E_LDF_Selection")=1)
			If ([HeberGement:5]HG_FamChef:103=True:C214) & ([HeberGement:5]HG_FamClé:104>"")
				If (i_Confirmer("Cette fonction s'applique à une personne ayant "+"un code lien et qui est chef de famille"+<>va_CR+"Confirmer-vous la modification en non chef de famille ?"))
					vl_LDF_ID:=[HeberGement:5]HG_HB_ID:19
					UNLOAD RECORD:C212([HeberGement:5])
					READ WRITE:C146([HeberGement:5])
					READ WRITE:C146([HeBerge:4])
					QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=vl_LDF_ID)
					If (Records in selection:C76([HeBerge:4])=1)
						Repeat 
							IDLE:C311
							LOAD RECORD:C52([HeBerge:4])
						Until (Not:C34(Locked:C147([HeBerge:4])))
						[HeBerge:4]HB_CléFam:47:=""
						[HeBerge:4]HB_Trans_CléFam:56:=""
						SAVE RECORD:C53([HeBerge:4])
						UNLOAD RECORD:C212([HeBerge:4])
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_LDF_ID)
						If (Records in selection:C76([HeberGement:5])>0)
							APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_FamChef:103:=False:C215)
						End if 
					End if 
					UNLOAD RECORD:C212([HeBerge:4])
					READ ONLY:C145([HeBerge:4])
					READ WRITE:C146([HeberGement:5])
				End if 
			Else 
				ALERT:C41("Fonction active uniquement sur une seule fiche dans la sélection"+" ayant un code lien et qui est chef de famille.")
			End if 
		Else 
			ALERT:C41("Fonction active uniquement sur une seule fiche dans la sélection"+" ayant un code lien et qui est chef de famille.")
		End if 
		
End case 

