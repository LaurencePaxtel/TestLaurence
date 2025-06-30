//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementHBClic
//{
//{          Mardi 9 mars 2004 à 10:20
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)  //1=Un click; 2=Double Clic

C_LONGINT:C283($ii; $pos)

If ($2=1)  // Un clic
	
	If ($1>0)
		
		Case of 
			: (Macintosh control down:C544) | (Windows Ctrl down:C562)
				<>vt_Trans:=[HeBerge:4]HB_Clé:2
				
				If (<>PR_AppelMem#0)
					POST OUTSIDE CALL:C329(<>PR_AppelMem)
				Else 
					QUERY:C277([MemO:30]; [MemO:30]MO_UserID:1=<>vl_UserRéfU)
					MultiSoc_Filter(->[MemO:30])
					
					If (Records in selection:C76([MemO:30])=1)
						READ WRITE:C146([MemO:30])
						
						If (i_NonVerrou(->[MemO:30]))
							[MemO:30]MO_Note:5:=[MemO:30]MO_Note:5+<>va_CR+<>vt_Trans
							SAVE RECORD:C53([MemO:30])
							
							UNLOAD RECORD:C212([MemO:30])
						End if 
						
						READ ONLY:C145([MemO:30])
					Else 
						StrAlerte(4; "")
					End if 
					
					UNLOAD RECORD:C212([MemO:30])
				End if 
				
			: (Macintosh option down:C545) | (Windows Alt down:C563)
				$ii:=[HeBerge:4]HB_ReferenceID:1
				
				QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=[HeBerge:4]HB_ReferenceID:1)
				MultiSoc_Filter(->[GroupeHeberges:37])
				
				If (Records in selection:C76([GroupeHeberges:37])>0)
					SELECTION TO ARRAY:C260([GroupeHeberges:37]GH_GP_Référence:2; $tl_réfGP)
					QUERY WITH ARRAY:C644([GrouPe:36]GP_ReferenceID:1; $tl_réfGP)
				Else 
					REDUCE SELECTION:C351([GrouPe:36]; 0)
				End if 
				
				vL_Nb_GP:=Records in selection:C76([GrouPe:36])
				
				If (vL_Nb_GP>0)
					ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
					POST CLICK:C466(20; 390)
					
					If ([GrouPe:36]GP_ReferenceID:1>0)
						P_Tab_GP(4; 0)
						P_Tab_GP(12; $ii)
					Else 
						P_Tab_GP(0; 0)
					End if 
					
				Else 
					P_Tab_GP(0; 0)
				End if 
				
		End case 
		
		Rec_Hébergements1(->vL_Nb_HG_F)
		va_NNN:=F_AfficheCléHébergé
		
		P_HébergementNotesBt(1)
		
		If (wresMulti=0)
			OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
		End if 
		
	Else   // Aucun demandeur sélectionné
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		
		vL_Nb_HG_F:=0
		va_NNN:=""
		P_HébergementNotesBt(0)
		
		If (wresMulti=0)
			OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		End if 
		
	End if 
	
Else 
	
	If ($1>0)
		
		If (Macintosh control down:C544) | (Windows Ctrl down:C562)
			P_HébergementMembreAdd
		Else 
			
			If (wresMulti=1)
				$pos:=Find in array:C230(<>tl_FamilleID; $1)
				
				If ($pos<=0)
					
					If (F_HébergementCtrlCréation(va_JourNuit))
						Tab_PopIn1n("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
						
						If (va_IDT_Typ1>"")
							INSERT IN ARRAY:C227(<>tl_FamilleID; Size of array:C274(<>tl_FamilleID)+1)
							<>tl_FamilleID{Size of array:C274(<>tl_FamilleID)}:=[HeBerge:4]HB_ReferenceID:1
							
							INSERT IN ARRAY:C227(<>ta_FamilleClé; Size of array:C274(<>ta_FamilleClé)+1)
							<>ta_FamilleClé{Size of array:C274(<>ta_FamilleClé)}:=[HeBerge:4]HB_Clé:2
							
							INSERT IN ARRAY:C227(<>ta_FamilleEtCv; Size of array:C274(<>ta_FamilleEtCv)+1)
							<>ta_FamilleEtCv{Size of array:C274(<>ta_FamilleEtCv)}:=va_IDT_Typ1
							<>va_RéserveAction:="Redessiner"
							
							POST OUTSIDE CALL:C329(<>PR_AppelRéserve)
							
							va_IDT_Typ1:=""
							REDRAW:C174(va_IDT_Typ1)
							
							If (<>PR_HébergementMul#0)
								<>va_RéserveAction:="Redessiner"
								POST OUTSIDE CALL:C329(<>PR_HébergementMul)
							End if   //  Si (◊PR_HébergementMul#0)
							
						End if   //Si (va_IDT_Typ1>"")
						
					End if   //  Si (F_HébergementCtrlCréation (va_JourNuit))
					
				End if   //   Si ($pos>0)
				
			End if 
			
		End if 
		
	End if 
	
End if 