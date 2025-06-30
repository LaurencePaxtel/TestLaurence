//%attributes = {}
//{==================================================}
//{ LOGICIEL : DBsolutions matrice	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_CompteurGIP
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)  //Libellé de la Rubrique
C_LONGINT:C283($2)
C_POINTER:C301($3)  //Ptr sur le tableau libellé
C_POINTER:C301($4)  //Ptr sur le tableau code

C_TEXT:C284($va_Temp)
C_LONGINT:C283($ii)

<>Va_Rubrique:=$1
<>Va_Thème:=$3->{$2}

C_TEXT:C284($T_Niveau)
$T_Niveau:=$4->{$2}

$va_Temp:=(Substring:C12((Replace string:C233($T_Niveau; "/1/"; "/2/")); 1; 12)+"@")
QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=$va_Temp)
MultiSoc_Filter(->[TAbles:12])

SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_SsTh; [TAbles:12]TB_TT_Niveau:4; <>ta_SsThCd)


SORT ARRAY:C229(<>ta_SsThCd; <>ta_SsTh; >)
If (Size of array:C274(<>ta_SsThCd)>0)
	$ii:=2
Else 
	$ii:=1
End if 
INSERT IN ARRAY:C227(<>ta_SsTh; 1; $ii)
INSERT IN ARRAY:C227(<>ta_SsThCd; 1; $ii)
<>ta_SsThCd{1}:="@"
<>ta_SsTh{1}:="Tous"
If ($ii>1)
	<>ta_SsThCd{2}:="-"
	<>ta_SsTh{2}:="-"
End if 
<>ta_SsThCd:=1
<>ta_SsTh:=1


C_TIME:C306($H_Current_time)
C_DATE:C307($D_Current_date)
$D_Current_date:=Current date:C33(*)
$H_Current_time:=Current time:C178(*)

READ WRITE:C146([TablesDemande:17])
QUERY:C277([TablesDemande:17]; [TablesDemande:17]TD_TB_TT_Niveau:1=$T_Niveau; *)
MultiSoc_Filter(->[TablesDemande:17])
QUERY:C277([TablesDemande:17];  & ; [TablesDemande:17]TD_Date:2=$D_Current_date)
MultiSoc_Filter(->[TablesDemande:17])


C_LONGINT:C283($vl_NbFic)
$vl_NbFic:=Records in selection:C76([TablesDemande:17])
Case of 
	: ($vl_NbFic>1)
		//
	: ($vl_NbFic=1)
		
		If (i_NonVerrou(->[TablesDemande:17]))
			If ($H_Current_time>=?00:00:01?) & ($H_Current_time<?12:00:00?)
				[TablesDemande:17]TD_NbJ:3:=[TablesDemande:17]TD_NbJ:3+1
			End if 
			If ($H_Current_time>=?12:00:00?) & ($H_Current_time<?23:59:00?)
				[TablesDemande:17]TD_NbN:4:=[TablesDemande:17]TD_NbN:4+1
			End if 
			SAVE RECORD:C53([TablesDemande:17])
			UNLOAD RECORD:C212([TablesDemande:17])
		End if 
		
	: ($vl_NbFic=0)
		
		CREATE RECORD:C68([TablesDemande:17])
		MultiSoc_Init_Structure(->[TablesDemande:17])
		[TablesDemande:17]TD_Date:2:=$D_Current_date
		[TablesDemande:17]TD_TB_TT_Niveau:1:=$T_Niveau
		If ($H_Current_time>=?00:00:01?) & ($H_Current_time<?12:00:00?)
			[TablesDemande:17]TD_NbJ:3:=[TablesDemande:17]TD_NbJ:3+1
		End if 
		If ($H_Current_time>=?12:00:00?) & ($H_Current_time<?23:59:00?)
			[TablesDemande:17]TD_NbN:4:=[TablesDemande:17]TD_NbN:4+1
		End if 
		SAVE RECORD:C53([TablesDemande:17])
		UNLOAD RECORD:C212([TablesDemande:17])
		
End case 
READ ONLY:C145([TablesDemande:17])
UNLOAD RECORD:C212([TablesDemande:17])