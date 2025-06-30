//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : DébutInitConsoR
//{          Lundi 31 janvier 2011 à 16:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_TEXT:C284($vt_Dummy; $vt_DummyDefaut)
C_LONGINT:C283($vl_Référence)

$vl_Référence:=-65  //••••••••••••••La valeur de la référence••••••••••
Case of 
	: ($1=0)  //Création de la fiche avec les valeurs par défaut
		<>vb_ConsoRAuto:=False:C215
		<>vl_ConsoRAuto:=0
		
		<>vh_ConsoRAuto1:=?00:01:00?
		<>vh_ConsoRAuto2:=?23:58:00?
		<>vh_ConsoR_Periode:=?02:00:00?  //toutes les 2 heures
		
		<>vl_ConsoRTicks:=3600
		<>vh_ConsoRTicks:=<>vl_ConsoRTicks/60
		
		<>vb_ConsoRServeurAuto:=False:C215
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; Position:C15("\\"; [DePart:1]DP_Texte:7)+1)
			If ($vt_Dummy>"")
				<>vl_ConsoRAuto:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				<>vb_ConsoRAuto:=(<>vl_ConsoRAuto=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_ConsoRAuto1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_ConsoRAuto2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_ConsoR_Periode:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vl_ConsoRTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				If (<>vl_ConsoRTicks=0)
					<>vl_ConsoRTicks:=36000
				End if 
				<>vh_ConsoRTicks:=<>vl_ConsoRTicks/60
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vb_ConsoRServeurAuto:=($vt_Dummy="1")
				
			End if 
		Else 
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=$vl_Référence
			[DePart:1]DP_Libelle:6:="Paramètres de la consolidation Régionale"
			[DePart:1]DP_Date:2:=Current date:C33
			[DePart:1]DP_DerniereMAJ:5:=Current date:C33
			
			$vt_Dummy:=""
			$vt_Dummy:=String:C10(Num:C11(<>vb_ConsoRAuto))+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vh_ConsoRAuto1; h mn:K7:2)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vh_ConsoRAuto2; h mn:K7:2)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vh_ConsoR_Periode; h mn:K7:2)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vl_ConsoRTicks)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(Num:C11(<>vb_ConsoRServeurAuto))
			
			[DePart:1]DP_Texte:7:=$vt_Dummy+"\\"+$vt_Dummy
			
			SAVE RECORD:C53([DePart:1])
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
		
	: ($1=1)  //Enregistrement des modifications
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				IDLE:C311
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; Position:C15("\\"; [DePart:1]DP_Texte:7)+1)
			$vt_DummyDefaut:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			
			$vt_Dummy:=""
			$vt_Dummy:=String:C10(Num:C11(<>vb_ConsoRAuto))+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vh_ConsoRAuto1; h mn:K7:2)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vh_ConsoRAuto2; h mn:K7:2)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vh_ConsoR_Periode; h mn:K7:2)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(<>vl_ConsoRTicks)+";"
			$vt_Dummy:=$vt_Dummy+String:C10(Num:C11(<>vb_ConsoRServeurAuto))
			
			[DePart:1]DP_Texte:7:=$vt_DummyDefaut+"\\"+$vt_Dummy
			[DePart:1]DP_DerniereMAJ:5:=Current date:C33
			
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
		
	: ($1=2)  //Chargement des données par defaut de la fiche dans les variables
		READ ONLY:C145([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; Position:C15("\\"; [DePart:1]DP_Texte:7)+1)
			$vt_DummyDefaut:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			If ($vt_DummyDefaut>"")
				<>vl_ConsoRAuto:=Num:C11(Substring:C12($vt_DummyDefaut; 1; Position:C15(";"; $vt_DummyDefaut)-1))
				<>vb_ConsoRAuto:=(<>vl_ConsoRAuto=1)
				
				$vt_DummyDefaut:=Substring:C12($vt_DummyDefaut; Position:C15(";"; $vt_DummyDefaut)+1)
				<>vh_ConsoRAuto1:=Time:C179(Substring:C12($vt_DummyDefaut; 1; Position:C15(";"; $vt_DummyDefaut)-1))
				
				$vt_DummyDefaut:=Substring:C12($vt_DummyDefaut; Position:C15(";"; $vt_DummyDefaut)+1)
				<>vh_ConsoRAuto2:=Time:C179(Substring:C12($vt_DummyDefaut; 1; Position:C15(";"; $vt_DummyDefaut)-1))
				
				$vt_DummyDefaut:=Substring:C12($vt_DummyDefaut; Position:C15(";"; $vt_DummyDefaut)+1)
				<>vh_ConsoR_Periode:=Time:C179(Substring:C12($vt_DummyDefaut; 1; Position:C15(";"; $vt_DummyDefaut)-1))
				
				
				$vt_DummyDefaut:=Substring:C12($vt_DummyDefaut; Position:C15(";"; $vt_DummyDefaut)+1)
				<>vl_ConsoRTicks:=Num:C11(Substring:C12($vt_DummyDefaut; 1; Position:C15(";"; $vt_DummyDefaut)-1))
				If (<>vl_ConsoRTicks=0)
					<>vl_ConsoRTicks:=36000
				End if 
				<>vh_ConsoRTicks:=<>vl_ConsoRTicks/60
				
				$vt_DummyDefaut:=Substring:C12($vt_DummyDefaut; Position:C15(";"; $vt_DummyDefaut)+1)
				<>vb_ConsoRServeurAuto:=($vt_DummyDefaut="1")
			End if 
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=4)  //Chargement des données par modifiables de la fiche dans les variables
		
		READ ONLY:C145([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; Position:C15("\\"; [DePart:1]DP_Texte:7)+1)
			$vt_DummyDefaut:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			If ($vt_Dummy>"")
				<>vl_ConsoRAuto:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				<>vb_ConsoRAuto:=(<>vl_ConsoRAuto=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_ConsoRAuto1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_ConsoRAuto2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_ConsoR_Periode:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vl_ConsoRTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				If (<>vl_ConsoRTicks=0)
					<>vl_ConsoRTicks:=36000
				End if 
				<>vh_ConsoRTicks:=<>vl_ConsoRTicks/60
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vb_ConsoRServeurAuto:=($vt_Dummy="1")
				<>vb_ConsoRServeurAuto:=False:C215
			End if 
			
		End if 
		READ ONLY:C145([DePart:1])
		
End case 