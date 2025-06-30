//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_MemoFusion  
//{
//{          c
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
READ ONLY:C145(*)

QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=<>ve_MemoFusion)
MultiSoc_Filter(->[DePart:1])
C_BOOLEAN:C305(vb_Nouveau)
vb_Nouveau:=False:C215
If (Records in selection:C76([DePart:1])=0)
	READ WRITE:C146([DePart:1])
	CREATE RECORD:C68([DePart:1])
	MultiSoc_Init_Structure(->[DePart:1])
	[DePart:1]DP_ReferenceID:1:=<>ve_MemoFusion
	[DePart:1]DP_Texte:7:=""
	[DePart:1]DP_Libelle:6:="Memo Fusion des clés"
	SAVE RECORD:C53([DePart:1])
	UNLOAD RECORD:C212([DePart:1])
	READ ONLY:C145([DePart:1])
	vb_Nouveau:=True:C214
End if 
If (vb_Nouveau)
	QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=<>ve_MemoFusion)
	MultiSoc_Filter(->[DePart:1])
End if 
//Quit_MEMO 

If (Records in selection:C76([DePart:1])=1)
	READ WRITE:C146([DePart:1])
	If (i_NonVerrou(->[DePart:1]))
		FORM SET INPUT:C55([DePart:1]; "DP_MemoFusion")
		//   $vl_Fenetre:=i_FenêtreNo (475;457;4;"Memo";4;"Quit_MemoFusion")
		$vl_Fenetre:=i_FenêtreNo(475; 517; 4; "Memo"; 4; "Quit_MemoFusion")
		
		MODIFY RECORD:C57([DePart:1]; *)
		UNLOAD RECORD:C212([DePart:1])
		CLOSE WINDOW:C154($vl_Fenetre)
	End if 
	READ ONLY:C145([DePart:1])
	UNLOAD RECORD:C212([DePart:1])
Else 
	StrAlerte(4; "")
End if 

<>PR_FusionMem:=0

