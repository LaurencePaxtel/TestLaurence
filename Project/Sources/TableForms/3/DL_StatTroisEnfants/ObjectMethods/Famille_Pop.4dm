If (Size of array:C274(ta_ColRéfFam_Code)>0)
	If (ta_ColRéfFam_Code>0)
		If (ta_ColRéfFam_Code=Size of array:C274(ta_ColRéfFam_Code))
			USE SET:C118("E_LaSel")
			vt_ColRéf_Libellé:=F_HébergementDécoupageLibellé(ve_ColMois; ve_ColType; True:C214)
		Else 
			If (Records in selection:C76([HeberGement:5])>0)
				USE SET:C118("E_LaSel")
				QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamClé:104=ta_ColRéfFam_Code{ta_ColRéfFam_Code})
				vt_ColRéf_Libellé:=F_HébergementDécoupageLibellé(ve_ColMois; ve_ColType; False:C215)
			End if 
		End if 
	End if 
End if 

