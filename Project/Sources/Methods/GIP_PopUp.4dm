//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : GIP_PopUp
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)  //Libellé de la Rubrique
C_LONGINT:C283($2)
C_POINTER:C301($3)  //Ptr sur le tableau libellé
C_POINTER:C301($4)  //Ptr sur le tableau code
If ($2>0)
	
	
	<>Va_Rubrique:=""
	<>Va_Thème:=""
	<>Va_SouThème:=""
	Case of 
		: ($1=<>Va_DemP)
			<>Va_Rubrique:=<>Va_DemP
		: ($1=<>Va_AdUtil)
			<>Va_Rubrique:=<>Va_AdUtil
		: ($1=<>Va_SitPar)
			<>Va_Rubrique:=<>Va_SitPar
	End case 
	<>Vl_tPos:=$2
	<>Vptr_tTh:=$3
	<>Vptr_tThCd:=$4
	<>Va_Thème:=<>Vptr_tTh->{$2}
	
	QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=(Substring:C12(Replace string:C233(<>Vptr_tThCd->{$2}; "/1/"; "/2/"); 1; 9)+"@"))
	MultiSoc_Filter(->[TAbles:12])
	
	SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_SsTh; [TAbles:12]TB_TT_Niveau:4; <>ta_SsThCd)
	CLOSE WINDOW:C154
	SORT ARRAY:C229(<>ta_SsThCd; <>ta_SsTh; >)
	READ WRITE:C146([TablesDemande:17])
	QUERY:C277([TablesDemande:17]; [TablesDemande:17]TD_TB_TT_Niveau:1=($4->{$2}); *)
	QUERY:C277([TablesDemande:17];  & ; [TablesDemande:17]TD_Date:2=Current date:C33(*))
	
	
	$vlNbFic:=Records in selection:C76([TablesDemande:17])
	
	Case of 
		: ($vlNbFic>1)
		: ($vlNbFic=1)
			If (i_NonVerrou(->[TablesDemande:17]))
				If (Current time:C178(*)>=?00:00:01?) & (Current time:C178(*)<?12:00:00?)
					[TablesDemande:17]TD_NbJ:3:=[TablesDemande:17]TD_NbJ:3+1
				End if 
				If (Current time:C178(*)>=?12:00:00?) & (Current time:C178(*)<?23:59:00?)
					[TablesDemande:17]TD_NbN:4:=[TablesDemande:17]TD_NbN:4+1
				End if 
				SAVE RECORD:C53([TablesDemande:17])
				UNLOAD RECORD:C212([TablesDemande:17])
			End if 
		: ($vlNbFic=0)
			CREATE RECORD:C68([TablesDemande:17])
			MultiSoc_Init_Structure(->[TablesDemande:17])
			[TablesDemande:17]TD_TB_TT_Niveau:1:=($4->{$2})
			[TablesDemande:17]TD_Date:2:=Current date:C33(*)
			If (Current time:C178(*)>=?00:00:01?) & (Current time:C178(*)<?12:00:00?)
				[TablesDemande:17]TD_NbJ:3:=[TablesDemande:17]TD_NbJ:3+1
			End if 
			If (Current time:C178(*)>=?12:00:00?) & (Current time:C178(*)<?23:59:00?)
				[TablesDemande:17]TD_NbN:4:=[TablesDemande:17]TD_NbN:4+1
			End if 
			SAVE RECORD:C53([TablesDemande:17])
			UNLOAD RECORD:C212([TablesDemande:17])
	End case 
	READ ONLY:C145([TablesDemande:17])
	UNLOAD RECORD:C212([TablesDemande:17])
	//Process_Go (->◊PR_GIP;"Go_GIP";"CentresGIP";32)
	
	Process_Go(-><>PR_GIP; "Go_GIP_2"; "CentresGIP"; 128)
	
End if 