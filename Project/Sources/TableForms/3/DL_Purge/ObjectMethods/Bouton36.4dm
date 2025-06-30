//Script 
C_LONGINT:C283($ii; $jj; $Pos)
ARRAY LONGINT:C221($tl_Table; 0)
ARRAY LONGINT:C221($tl_Champ; 0)

C_LONGINT:C283(vType; vLong)
C_BOOLEAN:C305(vIndex; vUnique; vInvisible)

CONFIRM:C162("Réindexer la Base."+Char:C90(13)+"Confirmez-vous la réindexation ?")
If (OK=1)
	i_Message("Base : désindexation en cours")
	For ($ii; 1; Get last table number:C254)
		i_MessageSeul("Base : désindexation en cours : "+Table name:C256($ii))
		For ($jj; 1; Get last field number:C255($ii))
			GET FIELD PROPERTIES:C258($ii; $jj; vType; vLong; vIndex; vUnique; vInvisible)
			If (vIndex)
				i_MessageSeul("Base : désindexation en cours : "+Table name:C256($ii)+" - "+Field name:C257($ii; $jj))
				$Pos:=Size of array:C274($tl_Table)+1
				INSERT IN ARRAY:C227($tl_Table; $Pos; 1)
				INSERT IN ARRAY:C227($tl_Champ; $Pos; 1)
				$tl_Table{$Pos}:=$ii
				$tl_Champ{$Pos}:=$jj
				SET INDEX:C344(Field:C253($ii; $jj)->; False:C215)
			End if 
		End for 
	End for 
	i_MessageSeul("                                                                                ")
	
	i_MessageSeul("Base : résindexation en cours")
	If (Size of array:C274($tl_Table)>0)
		For ($ii; 1; Size of array:C274($tl_Table))
			i_MessageSeul("Base : résindexation en cours : "+Table name:C256($tl_Table{$ii})+" - "+Field name:C257($tl_Table{$ii}; $tl_Champ{$ii}))
			SET INDEX:C344(Field:C253($tl_Table{$ii}; $tl_Champ{$ii})->; True:C214)
		End for 
	End if 
	CLOSE WINDOW:C154
End if 
