var $structure_e : cs:C1710.StructuresEntity

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			OBJECT SET VISIBLE:C603(*; "bImage1"; True:C214)
			
			OBJECT SET VISIBLE:C603(*; "Vers2004_@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "bImage1"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Vers2004_@"; False:C215)
		End if 
		
		vl_ColorCadreH:=i_Color(1; [SOciete:18]SO_CouleurCadreH:14)
		vl_ColorCadreC:=i_Color(1; [SOciete:18]SO_CouleurCadreC:15)
		vl_ColorCadreB:=i_Color(1; [SOciete:18]SO_CouleurCadreB:16)
		
		P_CodeCentre(-><>vl_T_CentreCodeDebut; -><>vl_T_CentreCodeFin; [SOciete:18]SO_CodeCentre:23)
		
		ModeConsoR1:=Num:C11([SOciete:18]SO_ConsoRégion_Mode:46=0)
		ModeConsoR2:=Num:C11([SOciete:18]SO_ConsoRégion_Mode:46=1)
		ModeConsoR3:=Num:C11([SOciete:18]SO_ConsoRégion_Mode:46=2)
		
		
		SIAO_1:=Num:C11(([SOciete:18]SO_SIAO:70=1) | ([SOciete:18]SO_SIAO:70=3))
		SIAO_2:=Num:C11(([SOciete:18]SO_SIAO:70=2) | ([SOciete:18]SO_SIAO:70=3))
		
		OBJECT SET TITLE:C194(ColSit0; xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 48))
		OBJECT SET TITLE:C194(ColSit1; xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 49))
		OBJECT SET TITLE:C194(ColSit2; xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 50))
		
		ColSit0:=Num:C11([SOciete:18]SO_ColonneOrienter:72=0)  //13/3/2012
		ColSit1:=Num:C11([SOciete:18]SO_ColonneOrienter:72=1)
		ColSit2:=Num:C11([SOciete:18]SO_ColonneOrienter:72=2)
		
		// Modified by: Kevin HASSAL (22-01-2019)
		// Coordonnées bancaires
		READ WRITE:C146([Banques:91])
		
		QUERY:C277([Banques:91]; [Banques:91]BQE_Origine_ID:17=[SOciete:18]ID:94; *)
		QUERY:C277([Banques:91];  & ; [Banques:91]BQE_Origine_No_Table:18=Table:C252(->[SOciete:18]))
		MultiSoc_Filter(->[Banques:91])
		
		If (Records in selection:C76([Banques:91])=0)
			CREATE RECORD:C68([Banques:91])
			MultiSoc_Init_Structure(->[Banques:91])
			
			[Banques:91]BQE_Origine_No_Table:18:=Table:C252(->[SOciete:18])
			[Banques:91]BQE_Origine_ID:17:=[SOciete:18]ID:94
		End if 
		
		// Modifié par : Scanu Rémy (17/11/2021)
		If ([SOciete:18]SO_Direction:128=Null:C1517)
			[SOciete:18]SO_Direction:128:=New object:C1471("civilite"; ""; "nom"; ""; "prenom"; "")
		End if 
		
		// Modifié par : Scanu Rémy (04/03/2023)
		If ([SOciete:18]comptabilite:134=Null:C1517)
			[SOciete:18]comptabilite:134:=New object:C1471("loyer"; 708280; "participation"; 0; "hebergement"; 0)
		End if 
		
		If ([SOciete:18]comptabilite:134.location=Null:C1517)
			[SOciete:18]comptabilite:134.location:=New object:C1471(\
				"eau"; 0; \
				"electricite"; 0; \
				"gaz"; 0; \
				"internet"; 0; \
				"telephone"; 0; \
				"autre"; 0)
		End if 
		
		If ([SOciete:18]comptabilite:134.ph=Null:C1517)
			[SOciete:18]comptabilite:134.ph:=New object:C1471(\
				"eau"; 0; \
				"electricite"; 0; \
				"gaz"; 0; \
				"internet"; 0; \
				"telephone"; 0; \
				"autre"; 0)
		End if 
		
		// Modifié par : Scanu Rémy (20/04/2023)
		If ([SOciete:18]modele:135=Null:C1517)
			[SOciete:18]modele:135:=New object:C1471("web"; New collection:C1472; "4D"; New collection:C1472)
			
			[SOciete:18]modele:135.web.push(New object:C1471(\
				"table"; Table:C252(->[Factures:86]); \
				"type"; "location"; \
				"modele"; "Ancien modèle"))
			
			[SOciete:18]modele:135["4D"].push(New object:C1471(\
				"table"; Table:C252(->[Factures:86]); \
				"type"; "participation"; \
				"modele"; "Ancien modèle"))
		End if 
		
		// Modifié par : Scanu Rémy (27/10/2023)
		If ([SOciete:18]SO_SynchroApplicationMobile:138=Null:C1517)
			[SOciete:18]SO_SynchroApplicationMobile:138:=New object:C1471("nbMinute"; 10; "lastTimeStampImport"; 0; "lastTimeStampExport"; 0; "activer"; False:C215)
		End if 
		
		Form:C1466.applicationMobileProchainImport:="Le "+outilsTimeStampRead("date"; Num:C11([SOciete:18]SO_SynchroApplicationMobile:138.lastTimeStampImport))+" à "+outilsTimeStampRead("heure"; Num:C11([SOciete:18]SO_SynchroApplicationMobile:138.lastTimeStampImport))
		Form:C1466.applicationMobileProchainExport:="Le "+outilsTimeStampRead("date"; Num:C11([SOciete:18]SO_SynchroApplicationMobile:138.lastTimeStampExport))+" à "+outilsTimeStampRead("heure"; Num:C11([SOciete:18]SO_SynchroApplicationMobile:138.lastTimeStampExport))
		
		// Modifié par : Scanu Rémy (18/01/2024)
		If ([SOciete:18]SO_LDAP:141=Null:C1517)
			[SOciete:18]SO_LDAP:141:=New object:C1471("activer"; False:C215; "url"; ""; "entryPoint"; "")
		End if 
		
		// Modifié par : Scanu Rémy (31/03/2023)
		outilsOrdaSearchSimple("Structures"; "Ref_Structure"; [SOciete:18]Ref_Structure:97; ->$structure_e; "first")
		
		Form:C1466.Structure_e:=$structure_e
		Form:C1466.FactureExport_es:=Form:C1466.Structure_e.AllFactureExport
End case 