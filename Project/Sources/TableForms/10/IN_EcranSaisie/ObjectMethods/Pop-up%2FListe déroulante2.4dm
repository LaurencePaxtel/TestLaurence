If (Size of array:C274(ta_LesGroupes)>0)
	
	If (ta_LesGroupes>0)
		tl_UserGroupe:=Find in array:C230(tl_UserGroupe; tl_LesGroupes{ta_LesGroupes})
		
		If (tl_UserGroupe>0)
			ta_UserGroupe:=tl_UserGroupe
		Else 
			$ii:=Size of array:C274(ta_UserGroupe)+1
			
			INSERT IN ARRAY:C227(ta_UserGroupe; $ii; 1)
			INSERT IN ARRAY:C227(tl_UserGroupe; $ii; 1)
			
			ta_UserGroupe{$ii}:=ta_LesGroupes{ta_LesGroupes}
			
			// Modifié par : Scanu Rémy (03/02/2023)
			tl_UserGroupe{$ii}:=Abs:C99(tl_LesGroupes{ta_LesGroupes})
			
			SORT ARRAY:C229(tl_UserGroupe; ta_UserGroupe; <)
			tl_UserGroupe:=Find in array:C230(tl_UserGroupe; tl_LesGroupes{ta_LesGroupes})
			
			If (tl_UserGroupe>0)
				ta_UserGroupe:=tl_UserGroupe
			Else 
				ta_UserGroupe:=0
				tl_UserGroupe:=0
			End if 
			
		End if 
		
	End if 
	
End if 