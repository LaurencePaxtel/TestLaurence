//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_InfoDansDepart
//{          Mercredi 6 juin 2012 à 15:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($ii; $vl_fiches)
C_TEXT:C284($vt_TXTlibellé)

Case of 
	: ($1="Chargement")
		
		For ($ii; 30201; 30211)
			QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-$ii)
			MultiSoc_Filter(->[DePart:1])
			
			If (Records in selection:C76([DePart:1])=1)
				$vt_TXTlibellé:=[DePart:1]DP_Texte:7
				
				ASSERT:C1129(False:C215; "BS à deboguer")
				_O_SET TEXT RESOURCE:C505($ii; $vt_TXTlibellé)
			End if 
			
		End for 
		
	: ($1="Création")
		ARRAY TEXT:C222(ta_STR; 0)
		
		xliff_STRING_LIST_TO_ARRAY_(30007; ->ta_STR)
		
		If (Size of array:C274(ta_STR)=11)
			READ WRITE:C146([DePart:1])
			
			For ($ii; 30201; 30211)
				QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-$ii)
				MultiSoc_Filter(->[DePart:1])
				
				If (Records in selection:C76([DePart:1])=0)
					CREATE RECORD:C68([DePart:1])
					MultiSoc_Init_Structure(->[DePart:1])
					[DePart:1]DP_ReferenceID:1:=-$ii
					[DePart:1]DP_Date:2:=Current date:C33
					[DePart:1]DP_DerniereMAJ:5:=[DePart:1]DP_Date:2
					[DePart:1]DP_Libelle:6:=ta_STR{$ii-30200}
					[DePart:1]DP_Texte:7:=xliff_Get_text_resource($ii)
					SAVE RECORD:C53([DePart:1])
					
					UNLOAD RECORD:C212([DePart:1])
				End if 
				
			End for 
			
			UNLOAD RECORD:C212([DePart:1])
			READ ONLY:C145([DePart:1])
		End if 
		
		ARRAY TEXT:C222(ta_STR; 0)
	: ($1="Maj")
		ARRAY TEXT:C222(ta_STR; 0)
		
		xliff_STRING_LIST_TO_ARRAY_(30007; ->ta_STR)
		
		If (Size of array:C274(ta_STR)=11)
			READ WRITE:C146([DePart:1])
			
			For ($ii; 30201; 30211)
				QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-$ii)
				MultiSoc_Filter(->[DePart:1])
				
				If (Records in selection:C76([DePart:1])=0)
					CREATE RECORD:C68([DePart:1])
					MultiSoc_Init_Structure(->[DePart:1])
					[DePart:1]DP_ReferenceID:1:=-$ii
					[DePart:1]DP_Date:2:=Current date:C33
				Else 
					LOAD RECORD:C52([DePart:1])
				End if 
				
				[DePart:1]DP_DerniereMAJ:5:=Current date:C33
				[DePart:1]DP_Libelle:6:=ta_STR{$ii-30200}
				[DePart:1]DP_Texte:7:=xliff_Get_text_resource($ii)
				SAVE RECORD:C53([DePart:1])
				
				UNLOAD RECORD:C212([DePart:1])
			End for 
			
			UNLOAD RECORD:C212([DePart:1])
			READ ONLY:C145([DePart:1])
		End if 
		
		ARRAY TEXT:C222(ta_STR; 0)
	: ($1="Validation")
		READ WRITE:C146([DePart:1])
		
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-$2)
		MultiSoc_Filter(->[DePart:1])
		
		$vl_fiches:=Records in selection:C76([DePart:1])
		Case of 
			: ($vl_fiches=0)
				CREATE RECORD:C68([DePart:1])
				MultiSoc_Init_Structure(->[DePart:1])
				[DePart:1]DP_ReferenceID:1:=-$2
				[DePart:1]DP_Date:2:=Current date:C33
				[DePart:1]DP_DerniereMAJ:5:=[DePart:1]DP_Date:2
				[DePart:1]DP_Libelle:6:=$3
				[DePart:1]DP_Texte:7:=$4
				SAVE RECORD:C53([DePart:1])
				
				UNLOAD RECORD:C212([DePart:1])
			: ($vl_fiches=1)
				LOAD RECORD:C52([DePart:1])
				
				Repeat 
					LOAD RECORD:C52([DePart:1])
				Until ((Not:C34(Locked:C147([DePart:1]))))
				
				[DePart:1]DP_Texte:7:=$4
				
				SAVE RECORD:C53([DePart:1])
				UNLOAD RECORD:C212([DePart:1])
			: ($vl_fiches=2)
				DELETE SELECTION:C66([DePart:1])
				
				CREATE RECORD:C68([DePart:1])
				MultiSoc_Init_Structure(->[DePart:1])
				[DePart:1]DP_ReferenceID:1:=-$2
				[DePart:1]DP_Date:2:=Current date:C33
				[DePart:1]DP_DerniereMAJ:5:=[DePart:1]DP_Date:2
				[DePart:1]DP_Libelle:6:=$3
				[DePart:1]DP_Texte:7:=$4
				SAVE RECORD:C53([DePart:1])
				
				UNLOAD RECORD:C212([DePart:1])
		End case 
		
		READ ONLY:C145([DePart:1])
	: ($1="Affectation")
		<>vt_SiaoHgTips_103:=xliff_Get_text_resource(30202)  //Chef de famille
		<>vt_SiaoHgTips_104:=xliff_Get_text_resource(30203)  //Clé de lien
		<>vt_SiaoHgTips_156:=xliff_Get_text_resource(30204)  //Priorité DAHO
		<>vt_SiaoHgTips_157:=xliff_Get_text_resource(30206)  //Violence
		<>vt_SiaoHgTips_158:=xliff_Get_text_resource(30205)  //Capacité d'acccès
		<>vt_SiaoHgTips_159:=xliff_Get_text_resource(30208)  //Logement autonome
		
		<>vt_SiaoHgTips_160:=xliff_Get_text_resource(30209)  //Logement souhaité
		<>vt_SiaoHgTips_161:=xliff_Get_text_resource(30207)  //Orientation correspondante
		<>vt_SiaoHgTips_162:=xliff_Get_text_resource(30211)  //Refus par structure
		<>vt_SiaoHgTips_163:=xliff_Get_text_resource(30210)  //Refus par demandeur
		<>vt_SiaoHgTips_164:=xliff_Get_text_resource(30201)  //Orientation Dossier SIAO
		
		
		<>vt_SiaoQuoi_1:=<>vt_SiaoHgTips_103
		<>vt_SiaoQuoi_2:=<>vt_SiaoHgTips_104
		<>vt_SiaoQuoi_3:=<>vt_SiaoHgTips_164
End case 