// Method hmCal.button_export  
// 
Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible; $P_Date_end_export; $P_Date_start_export; $P_pop_filtre_export)
		Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible; ->$P_Date_end_export; ->$P_Date_start_export; ->$P_pop_filtre_export)
		
		
		
		C_DATE:C307($D_Date1; $D_Date2)
		$D_Date1:=$P_Date_start_export->
		$D_Date2:=$P_Date_end_export->
		
		C_LONGINT:C283($L_Filtre)
		GET LIST ITEM:C378($P_pop_filtre_export->; *; $L_Filtre; $T_Label)
		
		ARRAY LONGINT:C221($rL_Permanenciers_ID; 0)
		ARRAY LONGINT:C221($rL_Heberges_ID; 0)
		
		// Usagers
		ARRAY TEXT:C222($rT_Heberges_cle; 0)
		C_POINTER:C301($P_LB_Usager)
		$P_LB_Usager:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "lb_usagers")
		For ($i; 1; Size of array:C274($P_LB_Usager->))
			
			If ($P_LB_Usager->{$i})
				APPEND TO ARRAY:C911($rT_Heberges_cle; $P_Usagers_cle->{$i})
			End if 
		End for 
		QUERY WITH ARRAY:C644([HeBerge:4]HB_Clé:2; $rT_Heberges_cle)
		SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $rL_Heberges_ID)
		
		// Permanencier
		C_POINTER:C301($P_Pop_permanenciers)
		$P_Pop_permanenciers:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "pop_permanencier")
		APPEND TO ARRAY:C911($rL_Permanenciers_ID; $P_Permanenciers_pk_invisible->{$P_Pop_permanenciers->})
		
		// Export
		C_OBJECT:C1216($O_Param)
		OB SET:C1220($O_Param; "filtre"; $L_Filtre; "date_start"; $D_Date1; "date_end"; $D_Date2)
		OB SET ARRAY:C1227($O_Param; "permanenciers"; $rL_Permanenciers_ID)
		OB SET ARRAY:C1227($O_Param; "heberges"; $rL_Heberges_ID)
		
		$L_Erreur:=Planning export("object"; $O_Param)  // #20180306-1
		If ($L_Erreur#1)
			ALERT:C41(OB Get:C1224($O_Param; "message"; Est un texte:K8:3))
		Else 
			$L_Erreur:=Planning export("TXT"; $O_Param)  // #20180306-1
			If ($L_Erreur#1)
				ALERT:C41(OB Get:C1224($O_Param; "message"; Est un texte:K8:3))
			Else 
				C_TIME:C306($H_Doc)
				$H_Doc:=Create document:C266(""; "TXT")
				If (OK=1)
					C_TEXT:C284($T_TXT)
					$T_TXT:=OB Get:C1224($O_Param; "output"; Est un texte:K8:3)
					SEND PACKET:C103($H_Doc; $T_TXT)
					CLOSE DOCUMENT:C267($H_Doc)
					
					CONFIRM:C162("Montrer le fichier ?")
					If (OK=1)
						SHOW ON DISK:C922(document)
					End if 
				End if 
			End if 
		End if 
		
		
		
		
End case 