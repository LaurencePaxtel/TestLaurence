//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	@
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitConso115
//{          
//{          Vendrdi 7 novembre 2008 à 11:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_TEXT:C284($vt_Dummy)
C_LONGINT:C283($vl_Référence)

$vl_Référence:=-61  //••••••••••••••La valeur de la référence••••••••••

Case of 
	: ($1=-1)  //Suppression de la fiche
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			DELETE RECORD:C58([DePart:1])
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
		
	: ($1=0)  //Création de la fiche avec les valeurs par défaut
		<>vb_Conso115Clt:=False:C215
		<>vl_Conso115Clt:=0
		
		<>vh_Conso115Clt1:=?00:01:00?
		<>vh_Conso115Clt2:=?23:58:00?
		
		<>vl_Conso115CltTicks:=3600
		
		<>vb_Conso115ServeurCltAuto:=False:C215
		
		
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			If ($vt_Dummy>"")
				<>vl_Conso115Clt:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				<>vb_Conso115Clt:=(<>vl_Conso115Clt=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_Conso115Clt1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_Conso115Clt2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vl_Conso115CltTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				If (<>vl_Conso115CltTicks=0)
					<>vl_Conso115CltTicks:=36000
				End if 
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vb_Conso115ServeurCltAuto:=($vt_Dummy="1")
				
			End if 
		Else 
			
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=$vl_Référence
			[DePart:1]DP_Libelle:6:="Paramètres de la consolidation Client"
			[DePart:1]DP_Date:2:=Current date:C33
			[DePart:1]DP_DerniereMAJ:5:=Current date:C33
			
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_Conso115Clt))+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vh_Conso115Clt1; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vh_Conso115Clt2; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vl_Conso115CltTicks)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(Num:C11(<>vb_Conso115ServeurCltAuto))
			
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"\\"+[DePart:1]DP_Texte:7
			
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
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_Conso115Clt))+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vh_Conso115Clt1; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vh_Conso115Clt2; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vl_Conso115CltTicks)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(Num:C11(<>vb_Conso115ServeurCltAuto))
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+"\\"+$vt_Dummy
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
		
		
	: ($1=2)  //Chargement des données de la fiche dans les variables
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			If ($vt_Dummy>"")
				
				<>vl_Conso115Clt:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				<>vb_Conso115Clt:=(<>vl_Conso115Clt=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_Conso115Clt1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_Conso115Clt2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vl_Conso115CltTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				If (<>vl_Conso115CltTicks=0)
					<>vl_Conso115CltTicks:=36000
				End if 
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vb_Conso115ServeurCltAuto:=($vt_Dummy="1")
				
			End if 
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
		
		
	: ($1=3)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				IDLE:C311
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			$vt_Dummy:=Substring:C12([DePart:1]DP_Texte:7; 1; Position:C15("\\"; [DePart:1]DP_Texte:7)-1)
			[DePart:1]DP_Texte:7:=""
			[DePart:1]DP_Texte:7:=String:C10(Num:C11(<>vb_Conso115Clt))+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vh_Conso115Clt1; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vh_Conso115Clt2; h mn:K7:2)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(<>vl_Conso115CltTicks)+";"
			[DePart:1]DP_Texte:7:=[DePart:1]DP_Texte:7+String:C10(Num:C11(<>vb_Conso115ServeurCltAuto))
			[DePart:1]DP_Texte:7:=$vt_Dummy+"\\"+[DePart:1]DP_Texte:7
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		UNLOAD RECORD:C212([DePart:1])
		READ ONLY:C145([DePart:1])
		
	: ($1=4)
		
		<>vb_Conso115Clt:=False:C215
		<>vl_Conso115Clt:=0
		
		<>vh_Conso115Clt1:=?00:01:00?
		<>vh_Conso115Clt2:=?23:58:00?
		
		
		<>vl_Conso115CltTicks:=36000
		
		<>vb_Conso115ServeurCltAuto:=False:C215
		
		
		READ ONLY:C145([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Référence)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			If ($vt_Dummy>"")
				<>vl_Conso115Clt:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				<>vb_Conso115Clt:=(<>vl_Conso115Clt=1)
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_Conso115Clt1:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vh_Conso115Clt2:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vl_Conso115CltTicks:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
				If (<>vl_Conso115CltTicks=0)
					<>vl_Conso115CltTicks:=36000
				End if 
				
				$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
				<>vb_Conso115ServeurCltAuto:=($vt_Dummy="1")
				
			End if 
		End if 
		READ ONLY:C145([DePart:1])
End case 
