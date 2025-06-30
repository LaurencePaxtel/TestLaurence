//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutInitWebsite
//{
//{          Vendredi 26 juin 2009 à 14:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($vl_Ref)
$vl_Ref:=-60

C_TEXT:C284($vt_Dummy)
Case of 
	: ($1=0)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Ref)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			//Date
			//Heure=Périodicité
			//Chemin du répertoire
			//Nom de document
			//Les heures choisies (rajoutées le 15/9/09)
			
			<>vd_ws_Date:=Date:C102(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			<>vh_ws_Période:=Time:C179(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			<>vt_ws_Répertoire:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			
			<>va_ws_NomDocument:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			
			If ($vt_Dummy>"")
				<>va_ws_Heures:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
			Else 
				<>va_ws_Heures:="000000000000000000000000"
			End if 
			
			
			UNLOAD RECORD:C212([DePart:1])
		Else 
			
			<>vd_ws_Date:=!00-00-00!
			<>vh_ws_Période:=?00:00:00?
			<>vt_ws_Répertoire:=""
			<>va_ws_NomDocument:=""
			<>va_ws_Heures:="000000000000000000000000"
			
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=$vl_Ref
			[DePart:1]DP_Libelle:6:="Paramètres des données website"
			[DePart:1]DP_Texte:7:=String:C10(<>vd_ws_Date; Interne date court:K1:7)+";"+String:C10(<>vh_ws_Période; h mn s:K7:1)+";"+<>vt_ws_Répertoire+";"+<>va_ws_NomDocument+";"+<>va_ws_Heures+";"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=$vl_Ref)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=String:C10(<>vd_ws_Date; Interne date court:K1:7)+";"+String:C10(<>vh_ws_Période; h mn s:K7:1)+";"+<>vt_ws_Répertoire+";"+<>va_ws_NomDocument+";"+<>va_ws_Heures+";"
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 