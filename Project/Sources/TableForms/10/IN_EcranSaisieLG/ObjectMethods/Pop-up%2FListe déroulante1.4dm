If (Size of array:C274(ta_LesProfils)>0)
	If (ta_LesProfils>0)
		
		//Les groupes définisants les accès d'un utilisateur
		ARRAY LONGINT:C221(tl_UserGroupe; 0)
		ARRAY TEXT:C222(ta_UserGroupe; 0)
		ta_UserGroupe:=0
		tl_UserGroupe:=0
		
		ARRAY TEXT:C222(tb_ref_structure; 0)
		ARRAY LONGINT:C221($tl_UserGroupeRéf; 0)
		ARRAY LONGINT:C221($tl_UserGroupe; 0)
		ARRAY TEXT:C222($ta_UserGroupe; 0)
		ARRAY INTEGER:C220($te_UserGroupeTri; 0)
		
		QUERY:C277([IntervenantsGroupes:32]; [IntervenantsGroupes:32]IG_IP_RéférenceID:2=tl_LesProfils{ta_LesProfils})
		If (Records in selection:C76([IntervenantsGroupes:32])>0)
			ORDER BY:C49([IntervenantsGroupes:32]; [IntervenantsGroupes:32]IG_GroupeTri:5; >)
			SELECTION TO ARRAY:C260([IntervenantsGroupes:32]IG_IP_RéférenceID:2; $tl_UserGroupeRéf; [IntervenantsGroupes:32]IG_GroupeRéférence:3; $tl_UserGroupe; [IntervenantsGroupes:32]IG_GroupeLibellé:4; $ta_UserGroupe; [IntervenantsGroupes:32]IG_GroupeTri:5; $te_UserGroupeTri; [IntervenantsGroupes:32]Ref_Structure:7; tb_ref_structure)
		End if 
		If (Size of array:C274($tl_UserGroupe)>0)
			For ($ii; 1; Size of array:C274($tl_UserGroupe))
				tl_UserGroupe:=Find in array:C230(tl_UserGroupe; $tl_UserGroupe{$ii})
				If (tl_UserGroupe>0)
					ta_UserGroupe:=tl_UserGroupe
				Else 
					
					$Pos:=Size of array:C274(ta_UserGroupe)+1
					INSERT IN ARRAY:C227(ta_UserGroupe; $Pos; 1)
					INSERT IN ARRAY:C227(tl_UserGroupe; $Pos; 1)
					ta_UserGroupe{$Pos}:=$ta_UserGroupe{$ii}
					tl_UserGroupe{$Pos}:=$tl_UserGroupe{$ii}
					SORT ARRAY:C229(tl_UserGroupe; ta_UserGroupe; <)
					tl_UserGroupe:=Find in array:C230(tl_UserGroupe; $tl_UserGroupe{$ii})
					If (tl_UserGroupe>0)
						ta_UserGroupe:=tl_UserGroupe
					Else 
						ta_UserGroupe:=0
						tl_UserGroupe:=0
					End if 
				End if 
			End for 
		End if 
	End if 
	
End if 