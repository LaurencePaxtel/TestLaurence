C_LONGINT:C283($vl_eventFF)

$vl_eventFF:=Form event code:C388

Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		SET WINDOW TITLE:C213("Une table")
		
		REDUCE SELECTION:C351([TAbles:12]; 0)
		
		If (Is new record:C668([TypesTables:11]))
			MultiSoc_Init_Structure(->[TypesTables:11])
			
			If ([TypesTables:11]TT_RéférenceID:1=0)
				[TypesTables:11]TT_RéférenceID:1:=Uut_Numerote(->[TypesTables:11])
			End if 
			
			[TypesTables:11]TT_NbNiveaux:2:=1
			<>Vl_TB_NbFic:=0
			
			OBJECT SET ENABLED:C1123(b_Add1Tab; False:C215)
			OBJECT SET ENABLED:C1123(b_Add2Tab; False:C215)
			OBJECT SET ENABLED:C1123(b_ModTab; False:C215)
			OBJECT SET ENABLED:C1123(b_SupTab; False:C215)
		Else 
			TableEnum_Lister
			
			If (<>Vl_TB_NbFic>0)
				OBJECT SET ENTERABLE:C238([TypesTables:11]TT_NbNiveaux:2; False:C215)
				OBJECT SET ENTERABLE:C238([TypesTables:11]TT_RéférenceID:1; False:C215)
			End if 
			
		End if 
		
		va_LibNivea:=String:C10([TypesTables:11]TT_NbNiveaux:2)+" niveau"+("x"*Num:C11([TypesTables:11]TT_NbNiveaux:2>1))
	: ($vl_eventFF=Sur données modifiées:K2:15)
		
		If (Modified:C32([TypesTables:11]TT_NbNiveaux:2))
			
			If ([TypesTables:11]TT_NbNiveaux:2<1) | ([TypesTables:11]TT_NbNiveaux:2>4)
				ALERT:C41("Le nombre de niveaux autorisés est compris entre 1 et 4 !")
				
				OBJECT SET ENABLED:C1123(b_Add1Tab; False:C215)
				OBJECT SET ENABLED:C1123(b_Add2Tab; False:C215)
				OBJECT SET ENABLED:C1123(b_ModTab; False:C215)
				OBJECT SET ENABLED:C1123(b_SupTab; False:C215)
			Else 
				OBJECT SET ENABLED:C1123(b_Add1Tab; True:C214)
				OBJECT SET ENABLED:C1123(b_Add2Tab; True:C214)
				OBJECT SET ENABLED:C1123(b_ModTab; True:C214)
				OBJECT SET ENABLED:C1123(b_SupTab; True:C214)
			End if 
			
			va_LibNivea:=String:C10([TypesTables:11]TT_NbNiveaux:2)+" niveau"+("x"*Num:C11([TypesTables:11]TT_NbNiveaux:2>1))
		End if 
		
End case 