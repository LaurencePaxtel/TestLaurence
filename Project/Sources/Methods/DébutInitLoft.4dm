//%attributes = {}
C_LONGINT:C283($1)

C_TEXT:C284($vt_Dummy)
Case of 
	: ($1=0)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-20)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			$vt_Dummy:=[DePart:1]DP_Texte:7
			
			<>vl_LOFTCtrRéf:=Num:C11(Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1))
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			<>va_LOFTCtrNom:=Substring:C12($vt_Dummy; 1; Position:C15(";"; $vt_Dummy)-1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			<>va_LOFTCtrCP:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			$vt_Dummy:=Substring:C12($vt_Dummy; Position:C15(";"; $vt_Dummy)+1)
			
			<>vl_LOFTCtrMéd:=Num:C11($vt_Dummy)
			<>vb_LOFTCtrMéd:=(<>vl_LOFTCtrMéd=1)
			UNLOAD RECORD:C212([DePart:1])
		Else 
			<>vl_LOFTCtrRéf:=0
			<>va_LOFTCtrNom:=""
			<>va_LOFTCtrCP:=""
			<>vl_LOFTCtrMéd:=0
			<>vb_LOFTCtrMéd:=False:C215
			<>va_LOFTCtrPlateF:=""
			CREATE RECORD:C68([DePart:1])
			MultiSoc_Init_Structure(->[DePart:1])
			[DePart:1]DP_ReferenceID:1:=-20
			[DePart:1]DP_Libelle:6:="Centre par défaut pour LOFT"
			[DePart:1]DP_Texte:7:=String:C10(<>vl_LOFTCtrRéf)+";"+<>va_LOFTCtrNom+";"+<>va_LOFTCtrCP+";"+String:C10(<>vl_LOFTCtrMéd)
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
		
	: ($1=1)
		READ WRITE:C146([DePart:1])
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-20)
		MultiSoc_Filter(->[DePart:1])
		If (Records in selection:C76([DePart:1])=1)
			Repeat 
				LOAD RECORD:C52([DePart:1])
			Until (Not:C34(Locked:C147([DePart:1])))
			[DePart:1]DP_Texte:7:=String:C10(<>vl_LOFTCtrRéf)+";"+<>va_LOFTCtrNom+";"+<>va_LOFTCtrCP+";"+String:C10(<>vl_LOFTCtrMéd)
			SAVE RECORD:C53([DePart:1])
			UNLOAD RECORD:C212([DePart:1])
		End if 
		READ ONLY:C145([DePart:1])
End case 