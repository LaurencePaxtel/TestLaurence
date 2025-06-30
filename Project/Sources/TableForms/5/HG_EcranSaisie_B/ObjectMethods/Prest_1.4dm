C_BOOLEAN:C305($vb_OK)

$vb_OK:=(User in group:C338(Current user:C182; <>Groupe_DemPrestations)=False:C215)
$vb_OK:=$vb_OK | (User in group:C338(Current user:C182; <>Groupe_DemAdrUtil)=False:C215)
$vb_OK:=$vb_OK | (User in group:C338(Current user:C182; <>Groupe_DemSitPart)=False:C215)

If ($vb_OK)
	StrAlerte(6; "")
Else 
	P_HébergementPrestation([HeberGement:5]HG_HB_ID:19; Uut_HébergéClé(->[HeberGement:5]HG_Nom:21; ->[HeberGement:5]HG_Prénom:22; ->[HeberGement:5]HG_DateNéLe:24); "115")
End if 