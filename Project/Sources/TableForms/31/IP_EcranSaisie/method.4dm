var $vl_EventFF : Integer

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		//Les groupes définisants les accès d'un utilisateur
		ARRAY TEXT:C222(tb_ref_structure; 0)
		ARRAY TEXT:C222(ta_UserGroupe; 0)
		
		ARRAY INTEGER:C220(te_UserGroupeTri; 0)
		
		ARRAY LONGINT:C221(tl_UserGroupeRéf; 0)
		ARRAY LONGINT:C221(tl_UserGroupe; 0)
		
		If (Is new record:C668([IntervenantsProfils:31]))
			SET WINDOW TITLE:C213("Profil : nouveau")
			MultiSoc_Init_Structure(->[IntervenantsProfils:31])
			
			[IntervenantsProfils:31]IP_RéférenceID:1:=Uut_Numerote(->[IntervenantsProfils:31])
			OBJECT SET VISIBLE:C603(*; "Bt_INsup"; False:C215)
		Else 
			SET WINDOW TITLE:C213("Profil : modifier")
			
			QUERY:C277([IntervenantsGroupes:32]; [IntervenantsGroupes:32]IG_IP_RéférenceID:2=[IntervenantsProfils:31]IP_RéférenceID:1)
			MultiSoc_Filter(->[IntervenantsGroupes:32])
			
			If (Records in selection:C76([IntervenantsGroupes:32])>0)
				ORDER BY:C49([IntervenantsGroupes:32]; [IntervenantsGroupes:32]IG_GroupeTri:5; >)
				SELECTION TO ARRAY:C260([IntervenantsGroupes:32]IG_IP_RéférenceID:2; tl_UserGroupeRéf; [IntervenantsGroupes:32]IG_GroupeRéférence:3; \
					tl_UserGroupe; [IntervenantsGroupes:32]IG_GroupeLibellé:4; ta_UserGroupe; [IntervenantsGroupes:32]IG_GroupeTri:5; te_UserGroupeTri; \
					[IntervenantsGroupes:32]Ref_Structure:7; tb_ref_structure)
			End if 
			
		End if 
		
		va_Type:=""
		
		If ([IntervenantsProfils:31]IP_Type:2>0) & ([IntervenantsProfils:31]IP_Type:2<10)
			va_Type:=Substring:C12(<>ta_Types{[IntervenantsProfils:31]IP_Type:2}; 5)
		Else 
			va_Type:=""
		End if 
		
End case 