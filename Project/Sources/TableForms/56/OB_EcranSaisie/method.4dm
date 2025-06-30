$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		If (Is new record:C668([Objets:56]))
			MultiSoc_Init_Structure(->[Objets:56])
			SET WINDOW TITLE:C213("Objet : nouveau")
			[Objets:56]OB_RéférenceID:1:=Uut_Numerote(->[Objets:56])
			
			[Objets:56]OB_NbParJour:5:=4
			
			[Objets:56]OB_HeureDébut_1:6:=?08:00:00?
			[Objets:56]OB_HeureFin_1:7:=?10:00:00?
			
			[Objets:56]OB_HeureDébut_2:8:=?10:00:00?
			[Objets:56]OB_HeureFin_2:9:=?12:00:00?
			
			[Objets:56]OB_HeureDébut_3:10:=?14:00:00?
			[Objets:56]OB_HeureFin_3:11:=?16:00:00?
			
			[Objets:56]OB_HeureDébut_4:12:=?16:00:00?
			[Objets:56]OB_HeureFin_4:13:=?18:00:00?
			
			
			[Objets:56]OB_HeureDébut_5:14:=?00:00:00?
			[Objets:56]OB_HeureFin_5:15:=?00:00:00?
			
			[Objets:56]OB_HeureDébut_6:16:=?00:00:00?
			[Objets:56]OB_HeureFin_6:17:=?00:00:00?
			
		Else 
			SET WINDOW TITLE:C213("Objet : modifier")
		End if 
		
	: ($vl_EventFF=Sur données modifiées:K2:15)
End case 

