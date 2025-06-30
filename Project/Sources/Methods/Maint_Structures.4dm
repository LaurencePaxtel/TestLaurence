//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 24/06/2020, 15:55:29
// ----------------------------------------------------
// Method: Maint_Structures
// Description
// 
//
// Parameters
// ----------------------------------------------------
READ ONLY:C145([SOciete:18])
READ WRITE:C146([Structures:79])

ALL RECORDS:C47([SOciete:18])

While (Not:C34(End selection:C36([SOciete:18])))
	
	If (([SOciete:18]SO_Libel00:2#"") & ([SOciete:18]Ref_Structure:97#"") & ([SOciete:18]Ref_Structure:97#"TMP"))
		
		QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=[SOciete:18]Ref_Structure:97)
		
		Case of 
			: (Records in selection:C76([Structures:79])=0)
				
				QUERY:C277([Structures:79]; [Structures:79]Ref_Structure:3=[SOciete:18]Ref_Structure:97)
				
				If (Records in selection:C76([Structures:79])=0)
					CREATE RECORD:C68([Structures:79])
					[Structures:79]UID:1:=Generate UUID:C1066
					[Structures:79]STRC_Societe_ID:6:=[SOciete:18]ID:94
					[Structures:79]Ref_Structure:3:=[SOciete:18]Ref_Structure:97
					[Structures:79]STRC_Initiales:2:=[SOciete:18]Ref_Structure:97
					[Structures:79]STRC_Nom:4:=[SOciete:18]SO_Libel00:2
					SAVE RECORD:C53([Structures:79])
				End if 
				
			: (Records in selection:C76([Structures:79])=1)
				
				[Structures:79]STRC_Societe_ID:6:=[SOciete:18]ID:94
				SAVE RECORD:C53([Structures:79])
				
			Else 
				TRACE:C157
		End case 
		
	End if 
	
	NEXT RECORD:C51([SOciete:18])
End while 

UNLOAD RECORD:C212([SOciete:18])
UNLOAD RECORD:C212([Structures:79])

READ ONLY:C145([Structures:79])

ALERT:C41("Opération effectuée avec succès.")