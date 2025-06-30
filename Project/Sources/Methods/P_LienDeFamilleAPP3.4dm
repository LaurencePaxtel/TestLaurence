//%attributes = {}

[HeberGement:5]HG_DossierSIAO:164:=""
If (<>vb_T_ModeCHRS)
	If ([HeberGement:5]HG_FamChef:103)
		va_LDF_Type:=Substring:C12([HeberGement:5]HG_CentreNom:62; 1; 2)
		If (va_LDF_Type="00")
			[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{1}
		Else 
			[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{2}
		End if 
	Else 
		If ([HeberGement:5]HG_FamClé:104>"")
			[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{3}
		End if 
	End if 
Else 
	If ([HeberGement:5]HG_FamChef:103)
		[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{1}
	Else 
		If ([HeberGement:5]HG_FamClé:104>"")
			[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{3}
		End if 
	End if 
End if 
If ([HeberGement:5]HG_DossierSIAO:164>"")
	If (Find in array:C230(tl_DosSIAO_HG; [HeberGement:5]HG_HB_ID:19)>0)
	Else 
		vl_LDF_Indice:=Size of array:C274(tl_DosSIAO_HG)+1
		INSERT IN ARRAY:C227(tl_DosSIAO_HG; vl_LDF_Indice)
		INSERT IN ARRAY:C227(ta_DosSIAO_HG; vl_LDF_Indice)
		tl_DosSIAO_HG{vl_LDF_Indice}:=[HeberGement:5]HG_HB_ID:19
		ta_DosSIAO_HG{vl_LDF_Indice}:=[HeberGement:5]HG_DossierSIAO:164
	End if 
End if 

