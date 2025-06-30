//SCripte b_NumFnoU

CONFIRM:C162("Confirmez vous la renumérotation du n° unique des fiche d' hébergement  ?")
If (OK=1)
	CONFIRM:C162("Vérifiez que personne n'est connecté  ?")
	If (OK=1)
		ARRAY LONGINT:C221(<>tl_NoURéf; 0)
		ARRAY LONGINT:C221(<>tl_NoURéfBis; 0)
		C_LONGINT:C283(<>vl_NoURéf)
		C_LONGINT:C283($ii; $jj; $kk)
		<>vl_NoURéf:=0
		i_Message("Recherche et Renumérotation du n° unique …")
		ALL RECORDS:C47([HeberGement:5])
		MultiSoc_Filter(->[HeberGement:5])
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; <>tl_NoURéf)
		$jj:=Size of array:C274(<>tl_NoURéf)
		If ($jj>0)
			SORT ARRAY:C229(<>tl_NoURéf; >)
			For ($ii; 1; $jj)
				i_MessageSeul("Recherche et Renumérotation du n° unique : "+String:C10($jj)+" / "+String:C10($ii))
				If (<>tl_NoURéf{$ii}=<>vl_NoURéf)
					$kk:=Size of array:C274(<>tl_NoURéfBis)+1
					INSERT IN ARRAY:C227(<>tl_NoURéfBis; $kk)
					<>tl_NoURéfBis{$kk}:=<>tl_NoURéf{$ii}
				End if 
				<>vl_NoURéf:=<>tl_NoURéf{$ii}
			End for 
			
			If (Size of array:C274(<>tl_NoURéfBis)>0)
				QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; <>tl_NoURéfBis)
				If (Records in selection:C76([HeberGement:5])>0)
					READ WRITE:C146([HeberGement:5])
					FIRST RECORD:C50([HeberGement:5])
					$ii:=0
					Repeat 
						$ii:=$ii+1
						i_MessageSeul("Renumérotation du n° unique : "+String:C10(Size of array:C274(<>tl_NoURéfBis))+" / "+String:C10($ii))
						Repeat 
							LOAD RECORD:C52([HeberGement:5])
						Until (Not:C34(Locked:C147([HeberGement:5])))
						[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
						[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2050
						
						SAVE RECORD:C53([HeberGement:5])
						UNLOAD RECORD:C212([HeberGement:5])
						
						NEXT RECORD:C51([HeberGement:5])
					Until (End selection:C36([HeberGement:5]))
					
					READ ONLY:C145([HeberGement:5])
				End if 
			End if 
		End if 
		CLOSE WINDOW:C154
		ARRAY LONGINT:C221(<>tl_NoURéf; 0)
		ARRAY LONGINT:C221(<>tl_NoURéfBis; 0)
	End if 
End if 

