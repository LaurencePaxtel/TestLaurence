//%attributes = {}

C_LONGINT:C283(vijk; vijkDépart)

//a_MàJRéférence  : 06/04/1999
MESSAGES ON:C181
QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2="HéberGem@")
MultiSoc_Filter(->[ReferenceUnique:2])
If (Records in selection:C76([ReferenceUnique:2])>0)
	ALERT:C41("Il y a "+String:C10(Records in selection:C76([ReferenceUnique:2]))+" compteurs pour le fichier [HéberGement]")
	CREATE SET:C116([ReferenceUnique:2]; "F_RéfHB")
	CREATE EMPTY SET:C140([ReferenceUnique:2]; "F_RéfHBSup")
	READ WRITE:C146([ReferenceUnique:2])
	USE SET:C118("F_RéfHB")
	FIRST RECORD:C50([ReferenceUnique:2])
	Repeat 
		LOAD RECORD:C52([ReferenceUnique:2])
		If ([ReferenceUnique:2]RU_Numero:3<=1)
			ADD TO SET:C119([ReferenceUnique:2]; "F_RéfHBSup")
		End if 
		UNLOAD RECORD:C212([ReferenceUnique:2])
		NEXT RECORD:C51([ReferenceUnique:2])
	Until (End selection:C36([ReferenceUnique:2]))
	UNLOAD RECORD:C212([ReferenceUnique:2])
	If ((Records in set:C195("F_RéfHB")-Records in set:C195("F_RéfHBSup"))=1)
		If (i_Confirmer("Mise à jour des compteurs ?"))
			USE SET:C118("F_RéfHBSup")
			DELETE SELECTION:C66([ReferenceUnique:2])
			UNLOAD RECORD:C212([ReferenceUnique:2])
			READ ONLY:C145([ReferenceUnique:2])
			
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=1)
			MultiSoc_Filter(->[HeberGement:5])
			If (Records in selection:C76([HeberGement:5])>0)
				vijk:=Records in selection:C76([HeberGement:5])
				
				QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(5))
				MultiSoc_Filter(->[ReferenceUnique:2])
				If (Records in selection:C76([ReferenceUnique:2])=1)  //Ce n'est pas la première fiche
					READ WRITE:C146([ReferenceUnique:2])
					While (Locked:C147([ReferenceUnique:2]))
						$h:=Current time:C178
						While ($h=Current time:C178)
						End while 
						LOAD RECORD:C52([ReferenceUnique:2])
					End while 
					[ReferenceUnique:2]RU_Numero:3:=[ReferenceUnique:2]RU_Numero:3+50
					vijkDépart:=[ReferenceUnique:2]RU_Numero:3
					[ReferenceUnique:2]RU_Numero:3:=[ReferenceUnique:2]RU_Numero:3+vijk+50
					SAVE RECORD:C53([ReferenceUnique:2])
					UNLOAD RECORD:C212([ReferenceUnique:2])
					READ ONLY:C145([ReferenceUnique:2])
				End if 
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)
				FIRST RECORD:C50([HeberGement:5])
				READ WRITE:C146([HeberGement:5])
				APPLY TO SELECTION:C70([HeberGement:5]; wUut_MàJRéf)
				READ ONLY:C145([HeberGement:5])
			End if 
		End if 
	End if 
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
End if 
MESSAGES OFF:C175