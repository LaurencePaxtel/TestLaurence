If (Form event code:C388=Sur clic:K2:4)
	QUERY:C277([IntervenantsGroupes:32]; [IntervenantsGroupes:32]IG_IP_RéférenceID:2=[IntervenantsProfils:31]IP_RéférenceID:1)
	MultiSoc_Filter(->[IntervenantsGroupes:32])
	
	If (Records in selection:C76([IntervenantsGroupes:32])>0)
		READ WRITE:C146([IntervenantsGroupes:32])
		
		DELETE SELECTION:C66([IntervenantsGroupes:32])
		READ ONLY:C145([IntervenantsGroupes:32])
	End if 
	
	If (Size of array:C274(ta_UserGroupe)>0)
		
		For ($ii; 1; Size of array:C274(ta_UserGroupe))
			tl_UserGroupeRéf{$ii}:=[IntervenantsProfils:31]IP_RéférenceID:1
			te_UserGroupeTri{$ii}:=$ii
			tb_ref_structure{$ii}:=<>ref_soc_active
		End for 
		
		READ WRITE:C146([IntervenantsGroupes:32])
		ARRAY TO SELECTION:C261(tl_UserGroupeRéf; [IntervenantsGroupes:32]IG_IP_RéférenceID:2; tl_UserGroupe; [IntervenantsGroupes:32]IG_GroupeRéférence:3; ta_UserGroupe; [IntervenantsGroupes:32]IG_GroupeLibellé:4; te_UserGroupeTri; [IntervenantsGroupes:32]IG_GroupeTri:5; tb_ref_structure; [IntervenantsGroupes:32]Ref_Structure:7)
		
		READ ONLY:C145([IntervenantsGroupes:32])
	End if 
	
End if 