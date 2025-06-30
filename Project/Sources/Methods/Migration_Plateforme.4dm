//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Migration_Plateforme
//{          Mardi 25 octobre 2011 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
C_TIME:C306($vh_RefDoc; $vh_HeureDebut; $vh_HeureFin)
C_TEXT:C284($vt_Chemin)
C_LONGINT:C283($ii; $jj; $vl_fiches)



C_LONGINT:C283(vl_Type; vl_Long)
C_BOOLEAN:C305(vb_Index)

CONFIRM:C162("Export pour migration versions 6.7 ou 2004 vers la version v12 ?")
If (OK=1)
	$vt_Chemin:=Select folder:C670("Selectionner le dossier d'export pour la migration.")
	If (OK=1)
		$vh_HeureDebut:=Current time:C178
		<>vl_Migrer_Fichier:=Size of array:C274(<>tt_Migrer_Fichier)
		i_Message("Export en cours…")
		For ($ii; 1; <>vl_Migrer_Fichier)
			
			If (Records in table:C83(<>tp_Migrer_Table{$ii}->)>0)
				
				Case of 
					: (<>tp_Migrer_Table{$ii}=(->[SOciete:18]))
						QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
						MultiSoc_Filter(->[SOciete:18])
					: (<>tp_Migrer_Table{$ii}=(->[DePart:1]))
						QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1#0)
						MultiSoc_Filter(->[DePart:1])
					Else 
						ALL RECORDS:C47(<>tp_Migrer_Table{$ii}->)
				End case 
				
				$vl_fiches:=Records in selection:C76(<>tp_Migrer_Table{$ii}->)
				If ($vl_fiches>0)
					
					$vh_RefDoc:=Create document:C266($vt_Chemin+<>tt_Migrer_Fichier{$ii})
					If (OK=1)
						USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
						
						$jj:=0
						FIRST RECORD:C50(<>tp_Migrer_Table{$ii}->)
						Repeat 
							$jj:=$jj+1
							i_MessageSeul("Export : "+String:C10($ii)+"/"+String:C10(<>vl_Migrer_Fichier)+"  -  "+<>tt_Migrer_Fichier{$ii}+" : "+String:C10($jj)+"/"+String:C10($vl_fiches))
							
							Migration_Appliquer($vh_RefDoc; <>tp_Migrer_Table{$ii})
							
							NEXT RECORD:C51(<>tp_Migrer_Table{$ii}->)
						Until (End selection:C36(<>tp_Migrer_Table{$ii}->))
						SEND PACKET:C103($vh_RefDoc; "SSPFINEXPORTSSP"+Char:C90(13))
						
						USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
						CLOSE DOCUMENT:C267($vh_RefDoc)
					End if 
				End if 
			End if 
		End for 
		
		CLOSE WINDOW:C154
		$vh_HeureFin:=Current time:C178
		ALERT:C41("Export migration : de "+String:C10($vh_HeureDebut; h mn:K7:2)+" à "+String:C10($vh_HeureFin; h mn:K7:2)+" > "+String:C10($vh_HeureFin-$vh_HeureDebut; h mn:K7:2))
	End if 
End if 