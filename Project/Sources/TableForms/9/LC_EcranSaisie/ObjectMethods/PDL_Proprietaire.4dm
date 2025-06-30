
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($pos)
		ARRAY TEXT:C222(PDL_Proprietaire; 0)
		ARRAY LONGINT:C221(PDL_Proprietaire_ID; 0)
		
		READ ONLY:C145([Proprietaires:83])
		ALL RECORDS:C47([Proprietaires:83])
		MultiSoc_Filter(->[Proprietaires:83])
		
		APPEND TO ARRAY:C911(PDL_Proprietaire; "")
		APPEND TO ARRAY:C911(PDL_Proprietaire_ID; 0)
		
		While (Not:C34(End selection:C36([Proprietaires:83])))
			APPEND TO ARRAY:C911(PDL_Proprietaire; [Proprietaires:83]PRO_Prenom:3+" "+[Proprietaires:83]PRO_Nom:2)
			APPEND TO ARRAY:C911(PDL_Proprietaire_ID; [Proprietaires:83]ID:1)
			NEXT RECORD:C51([Proprietaires:83])
		End while 
		
		$pos:=Find in array:C230(PDL_Proprietaire_ID; [LesCentres:9]LC_GL_Proprietaire_ID:66)
		If ($pos>0)
			PDL_Proprietaire:=$pos
			PDL_Proprietaire_ID:=$pos
		End if 
		
	Else 
		
		$pos:=Find in array:C230(PDL_Proprietaire; PDL_Proprietaire{PDL_Proprietaire})
		
		If ($pos>0)
			[LesCentres:9]LC_GL_Proprietaire_ID:66:=PDL_Proprietaire_ID{$pos}
			QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)
			MultiSoc_Filter(->[Proprietaires:83])
			[LesCentres:9]LC_GL_Proprietaire_nom:85:=[Proprietaires:83]PRO_Nom:2+" "+[Proprietaires:83]PRO_Prenom:3
		End if 
		
End case 

