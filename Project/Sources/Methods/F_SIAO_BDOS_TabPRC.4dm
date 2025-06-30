//%attributes = {}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)

C_LONGINT:C283($vl_fiche)
Case of 
	: ($1="Declarer")
		ARRAY LONGINT:C221(tl_Parcours_Code; 0)
		ARRAY LONGINT:C221(tl_Parcours_Demande; 0)
		ARRAY LONGINT:C221(tl_Parcours_Demandeur; 0)
		ARRAY LONGINT:C221(tl_Parcours_SIAO; 0)
		
		
	: ($1="Inserer")
		$vl_fiche:=Size of array:C274(tl_Parcours_Code)+1
		INSERT IN ARRAY:C227(tl_Parcours_Code; $vl_fiche; 1)
		INSERT IN ARRAY:C227(tl_Parcours_Demande; $vl_fiche; 1)
		INSERT IN ARRAY:C227(tl_Parcours_Demandeur; $vl_fiche; 1)
		INSERT IN ARRAY:C227(tl_Parcours_SIAO; $vl_fiche; 1)
		tl_Parcours_Code{$vl_fiche}:=[HeberGement:5]HG_ReferenceID:1
		tl_Parcours_Demande{$vl_fiche}:=[HeberGement:5]HG_ReferenceID:1
		tl_Parcours_Demandeur{$vl_fiche}:=[HeberGement:5]HG_HB_ID:19
		tl_Parcours_SIAO{$vl_fiche}:=[SIAO_Personnes:51]Sp_SIAO_ID:2
		
	: ($1="YaFiches")
		$0:=(Size of array:C274(tl_Parcours_Code)>0)
		
		
End case 