If (Size of array:C274(ta_LesGroupes)>0)
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		If (i_Confirmer("Tous les groupes seront supprimés !"))
			
			ARRAY TEXT:C222(ta_UserGroupe; 0)
			ARRAY LONGINT:C221(tl_UserGroupe; 0)
			ta_UserGroupe:=0
			tl_UserGroupe:=0
		End if 
	Else 
		If (i_Confirmer("Tous les groupes sauf le groupe Administration seront affectés !"))
			ARRAY TEXT:C222(ta_UserGroupe; 0)
			ARRAY LONGINT:C221(tl_UserGroupe; 0)
			$ij:=Size of array:C274(ta_LesGroupes)
			$ik:=0
			For ($ii; 2; $ij)
				If (ta_LesGroupes{$ii}#"-@")
					$ik:=$ik+1
					INSERT IN ARRAY:C227(ta_UserGroupe; $ik; 1)
					INSERT IN ARRAY:C227(tl_UserGroupe; $ik; 1)
					ta_UserGroupe{$ik}:=ta_LesGroupes{$ii}
					tl_UserGroupe{$ik}:=tl_LesGroupes{$ii}
				End if 
			End for 
		End if 
		
	End if 
End if 