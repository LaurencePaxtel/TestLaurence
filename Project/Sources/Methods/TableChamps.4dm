//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableChamps
//{
//{          Vendredi 17 Aôut 2001 à 15:53
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)

Case of 
	: ($1=0)
		ARRAY INTEGER:C220(<>te_RubTri; $2)
		ARRAY LONGINT:C221(<>tl_RubSTR; $2)
		ARRAY TEXT:C222(<>ta_RubNom; $2)
		ARRAY TEXT:C222(<>ta_RubNomNew; $2)
		ARRAY INTEGER:C220(<>te_RubFic; $2)
		ARRAY INTEGER:C220(<>te_RubRub; $2)
		ARRAY BOOLEAN:C223(<>tb_RubSais; $2)
		ARRAY BOOLEAN:C223(<>tb_RubObli; $2)
		ARRAY BOOLEAN:C223(<>tb_RubVis; $2)
		ARRAY BOOLEAN:C223(<>tb_RubPopVis; $2)
		ARRAY BOOLEAN:C223(<>tb_RubTrans; $2)
		ARRAY BOOLEAN:C223(<>tb_RubMod; $2)
		ARRAY BOOLEAN:C223(<>tb_RubDev; $2)
		ARRAY TEXT:C222(<>ta_RubAlert; $2)
		ARRAY INTEGER:C220(<>te_RubOrdre; $2)
		
		<>te_RubTri:=0
		<>tl_RubSTR:=0
		<>ta_RubNom:=0
		<>ta_RubNomNew:=0
		<>te_RubFic:=0
		<>te_RubRub:=0
		<>tb_RubSais:=0
		<>tb_RubObli:=0
		<>tb_RubVis:=0
		<>tb_RubPopVis:=0
		<>tb_RubTrans:=0
		<>tb_RubMod:=0
		<>tb_RubDev:=0
		<>ta_RubAlert:=0
		<>te_RubOrdre:=0
		
		C_LONGINT:C283(<>ve_RubTri)
		C_LONGINT:C283(<>vl_RubSTR)
		C_TEXT:C284(<>va_RubNom)
		C_TEXT:C284(<>va_RubNomNew)
		C_LONGINT:C283(<>ve_RubFic)
		C_LONGINT:C283(<>ve_RubRub)
		C_TEXT:C284(<>va_RubAlert)
		C_LONGINT:C283(<>ve_RubOrdre)
		C_LONGINT:C283(<>vl_RubNbLignes)
		
		<>ve_RubTri:=0
		<>vl_RubSTR:=0
		<>va_RubNom:=""
		<>va_RubNomNew:=""
		<>ve_RubFic:=0
		<>ve_RubRub:=0
		<>vb_RubSais:=0
		<>vb_RubObli:=0
		<>vb_RubVis:=0
		<>vb_RubPopVis:=0
		<>vb_RubTrans:=0
		<>vb_RubMod:=0
		<>vb_RubDev:=0
		<>va_RubAlert:=""
		<>ve_RubOrdre:=0
		<>vl_RubNbLignes:=0
	: ($1=1)
		<>te_RubTri:=$2
		<>tl_RubSTR:=$2
		<>ta_RubNom:=$2
		<>ta_RubNomNew:=$2
		<>te_RubFic:=$2
		<>te_RubRub:=$2
		<>tb_RubSais:=$2
		<>tb_RubObli:=$2
		<>tb_RubVis:=$2
		<>tb_RubPopVis:=$2
		<>tb_RubTrans:=$2
		<>tb_RubMod:=$2
		<>tb_RubDev:=$2
		<>ta_RubAlert:=$2
		<>te_RubOrdre:=$2
	: ($1=2)
		COPY ARRAY:C226(<>te_RdsTri{$2}; <>te_RubTri)
		COPY ARRAY:C226(<>tl_RdsSTR{$2}; <>tl_RubSTR)
		COPY ARRAY:C226(<>ta_RdsNom{$2}; <>ta_RubNom)
		COPY ARRAY:C226(<>ta_RdsNomNew{$2}; <>ta_RubNomNew)
		COPY ARRAY:C226(<>te_RdsFic{$2}; <>te_RubFic)
		COPY ARRAY:C226(<>te_RdsRub{$2}; <>te_RubRub)
		COPY ARRAY:C226(<>tb_RdsSais{$2}; <>tb_RubSais)
		COPY ARRAY:C226(<>tb_RdsObli{$2}; <>tb_RubObli)
		COPY ARRAY:C226(<>tb_RdsVis{$2}; <>tb_RubVis)
		COPY ARRAY:C226(<>tb_RdsPopVis{$2}; <>tb_RubPopVis)
		COPY ARRAY:C226(<>tb_RdsTrans{$2}; <>tb_RubTrans)
		COPY ARRAY:C226(<>tb_RdsMod{$2}; <>tb_RubMod)
		COPY ARRAY:C226(<>tb_RdsDev{$2}; <>tb_RubDev)
		COPY ARRAY:C226(<>ta_RdsAlert{$2}; <>ta_RubAlert)
		COPY ARRAY:C226(<>te_RdsOrdre{$2}; <>te_RubOrdre)
		
		<>te_RubTri:=0
		<>tl_RubSTR:=0
		<>ta_RubNom:=0
		<>ta_RubNomNew:=0
		<>te_RubFic:=0
		<>te_RubRub:=0
		<>tb_RubSais:=0
		<>tb_RubObli:=0
		<>tb_RubVis:=0
		<>tb_RubPopVis:=0
		<>tb_RubTrans:=0
		<>tb_RubMod:=0
		<>tb_RubDev:=0
		<>ta_RubAlert:=0
		<>te_RubOrdre:=0
		<>ve_RubTri:=0
		<>vl_RubSTR:=0
		<>va_RubNom:=""
		<>va_RubNomNew:=""
		<>ve_RubFic:=0
		<>ve_RubRub:=0
		<>vb_RubSais:=0
		<>vb_RubObli:=0
		<>vb_RubVis:=0
		<>vb_RubPopVis:=0
		<>vb_RubTrans:=0
		<>vb_RubMod:=0
		<>vb_RubDev:=0
		<>va_RubAlert:=""
		<>ve_RubOrdre:=0
		<>vl_RubNbLignes:=Size of array:C274(<>te_RubOrdre)
	: ($1=3)
		<>te_RubTri:=$2
		<>tl_RubSTR:=$2
		<>ta_RubNom:=$2
		<>ta_RubNomNew:=$2
		<>te_RubFic:=$2
		<>te_RubRub:=$2
		<>tb_RubSais:=$2
		<>tb_RubObli:=$2
		<>tb_RubVis:=$2
		<>tb_RubPopVis:=$2
		<>tb_RubTrans:=$2
		<>tb_RubMod:=$2
		<>tb_RubDev:=$2
		<>ta_RubAlert:=$2
		<>te_RubOrdre:=$2
		
		If ($2>0)
			<>ve_RubTri:=<>te_RubTri{<>te_RubTri}
			<>vl_RubSTR:=<>tl_RubSTR{<>tl_RubSTR}
			<>va_RubNom:=<>ta_RubNom{<>ta_RubNom}
			<>va_RubNomNew:=<>ta_RubNomNew{<>ta_RubNomNew}
			<>ve_RubFic:=<>te_RubFic{<>te_RubFic}
			<>ve_RubRub:=<>te_RubRub{<>te_RubRub}
			<>vb_RubSais:=Num:C11(<>tb_RubSais{<>tb_RubSais}=True:C214)
			<>vb_RubObli:=Num:C11(<>tb_RubObli{<>tb_RubObli}=True:C214)
			<>vb_RubVis:=Num:C11(<>tb_RubVis{<>tb_RubVis}=True:C214)
			<>vb_RubPopVis:=Num:C11(<>tb_RubPopVis{<>tb_RubPopVis}=True:C214)
			<>vb_RubTrans:=Num:C11(<>tb_RubTrans{<>tb_RubTrans}=True:C214)
			<>vb_RubMod:=Num:C11(<>tb_RubMod{<>tb_RubMod}=True:C214)
			<>vb_RubDev:=Num:C11(<>tb_RubDev{<>tb_RubDev}=True:C214)
			<>va_RubAlert:=<>ta_RubAlert{<>ta_RubAlert}
			<>ve_RubOrdre:=<>te_RubOrdre{<>te_RubOrdre}
		Else 
			<>ve_RubTri:=0
			<>vl_RubSTR:=0
			<>va_RubNom:=""
			<>va_RubNomNew:=""
			<>ve_RubFic:=0
			<>ve_RubRub:=0
			<>vb_RubSais:=0
			<>vb_RubObli:=0
			<>vb_RubVis:=0
			<>vb_RubPopVis:=0
			<>vb_RubTrans:=0
			<>vb_RubMod:=0
			<>vb_RubDev:=0
			<>va_RubAlert:=""
			<>ve_RubOrdre:=0
		End if 
		
	: ($1=4)
		
		Case of 
			: ($2=1)
				SORT ARRAY:C229(<>te_RubTri; <>tl_RubSTR; <>ta_RubNom; <>ta_RubNomNew; <>te_RubFic; <>te_RubRub; <>tb_RubSais; <>tb_RubObli; <>tb_RubVis; <>tb_RubPopVis; <>tb_RubTrans; <>tb_RubMod; <>tb_RubDev; <>ta_RubAlert; <>te_RubOrdre; >)
			: ($2=2)
				SORT ARRAY:C229(<>ta_RubNom; <>te_RubTri; <>tl_RubSTR; <>ta_RubNomNew; <>te_RubFic; <>te_RubRub; <>tb_RubSais; <>tb_RubObli; <>tb_RubVis; <>tb_RubPopVis; <>tb_RubTrans; <>tb_RubMod; <>tb_RubDev; <>ta_RubAlert; <>te_RubOrdre; >)
			: ($2=3)
				SORT ARRAY:C229(<>ta_RubNomNew; <>te_RubTri; <>tl_RubSTR; <>ta_RubNom; <>te_RubFic; <>te_RubRub; <>tb_RubSais; <>tb_RubObli; <>tb_RubVis; <>tb_RubPopVis; <>tb_RubTrans; <>tb_RubMod; <>tb_RubDev; <>ta_RubAlert; <>te_RubOrdre; >)
			: ($2=34)
				SORT ARRAY:C229(<>te_RubOrdre; <>ta_RubNomNew; <>te_RubTri; <>tl_RubSTR; <>ta_RubNom; <>te_RubFic; <>te_RubRub; <>tb_RubSais; <>tb_RubObli; <>tb_RubVis; <>tb_RubPopVis; <>tb_RubTrans; <>tb_RubMod; <>tb_RubDev; <>ta_RubAlert; >)
		End case 
		
	: ($1=5)
		
		If (i_Confirmer(<>ta_vDSLibel{0}+Char:C90(13)+"Enregistrer les modifications d'attributs des champs ?"))
			READ WRITE:C146([LesRubriques:21])
			
			i_Message("Enregistrements en cours...")
			
			For ($ii; 1; Size of array:C274(<>te_RubTri))
				QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubNoSTR:12=(<>vlSTR+$2))
				MultiSoc_Filter(->[LesRubriques:21])
				
				QUERY SELECTION:C341([LesRubriques:21]; [LesRubriques:21]NuméroTri:1=<>te_RubTri{$ii})
				
				If (Records in selection:C76([LesRubriques:21])=1)
					LOAD RECORD:C52([LesRubriques:21])
					
					If (Not:C34(Locked:C147([LesRubriques:21])))
						[LesRubriques:21]RubNomNew:13:=<>ta_RubNomNew{$ii}
						[LesRubriques:21]RubSaississable:5:=<>tb_RubSais{$ii}
						[LesRubriques:21]RubObligatoire:6:=<>tb_RubObli{$ii}
						[LesRubriques:21]RubPopVisible:9:=<>tb_RubPopVis{$ii}  //18/7/2008
						[LesRubriques:21]RubVisible:8:=<>tb_RubVis{$ii}
						[LesRubriques:21]RubModifiable:10:=<>tb_RubMod{$ii}
						[LesRubriques:21]RubAlerte:7:=<>ta_RubAlert{$ii}
						[LesRubriques:21]RubOrdreSaisie:14:=<>te_RubOrdre{$ii}
						[LesRubriques:21]RubTrans:15:=<>tb_RubTrans{$ii}  //18/11/2008
						
						<>ta_RdsNomNew{$2}{$ii}:=<>ta_RubNomNew{$ii}
						<>tb_RdsSais{$2}{$ii}:=<>tb_RubSais{$ii}
						<>tb_RdsObli{$2}{$ii}:=<>tb_RubObli{$ii}
						<>tb_RdsPopVis{$2}{$ii}:=<>tb_RubPopVis{$ii}  //18/7/2008
						<>tb_RdsTrans{$2}{$ii}:=<>tb_RubTrans{$ii}  //31/7/2008
						<>tb_RdsVis{$2}{$ii}:=<>tb_RubVis{$ii}
						<>tb_RdsMod{$2}{$ii}:=<>tb_RubMod{$ii}
						<>ta_RdsAlert{$2}{$ii}:=<>ta_RubAlert{$ii}
						<>te_RdsOrdre{$2}{$ii}:=<>te_RubOrdre{$ii}
						
						SAVE RECORD:C53([LesRubriques:21])
					End if 
					
					UNLOAD RECORD:C212([LesRubriques:21])
				End if 
				
			End for 
			
			CLOSE WINDOW:C154
			
			UNLOAD RECORD:C212([LesRubriques:21])
			READ ONLY:C145([LesRubriques:21])
			
			ARRAY TEXT:C222(<>UTL_tt_Champ_Titre_val; 0)
			ARRAY INTEGER:C220(<>UTL_tt_Champ_Titre_RubNuméro; 0)
		End if 
		
End case 