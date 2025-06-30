//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : GIP_PopUpRG
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
	
	SORT ARRAY:C229(<>ta_SsThCd; <>ta_SsTh; >)
	Process_Go(-><>PR_GIPRG; "Go_GIP_RG"; "CentresGIPRG"; 32)
End if 