//Etat civil
If (Form event code:C388=Sur clic:K2:4)
	//  : (ta_xCritères=1)  `Etat civil
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		If (Size of array:C274(ta_CritEtCiv)>0)
			If (i_Confirmer("Souhaitez-vous sauvegarder la sélection d'items Etat civil' ?"))
				vt_ii:=""
				For (vl_ii; 1; Size of array:C274(ta_CritEtCiv))
					If (te_CritEtCiv{vl_ii}=1)
						vt_ii:=vt_ii+(<>va_CR*Num:C11(vt_ii>""))+ta_CritEtCiv{vl_ii}
					End if 
				End for 
				P_HébergementDécoupageEtCv(1)
				
			End if 
		End if 
	Else 
		P_HébergementCritères(->ta_CritEtCiv; ->te_CritEtCiv; "Etat civil")
	End if 
	
End if 