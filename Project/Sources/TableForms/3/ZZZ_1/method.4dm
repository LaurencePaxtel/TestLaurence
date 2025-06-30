//Formule Format : "DL_CentresLitsLarge"

C_LONGINT:C283($vl_eventFF)
C_BOOLEAN:C305($vb_OK)

$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur chargement:K2:1)
		$vb_OK:=(User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_ADMIN)))
		$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_Coordinateur)))
		$vb_OK:=($vb_OK | (User in group:C338(Current user:C182; <>Groupe_Régulateur)))
		If ($vb_OK)
			OBJECT SET ENABLED:C1123(b_New; True:C214)
			OBJECT SET ENABLED:C1123(b_Cop; True:C214)
			OBJECT SET ENABLED:C1123(b_SaisOui; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b_New; False:C215)
			OBJECT SET ENABLED:C1123(b_Cop; False:C215)
			OBJECT SET ENABLED:C1123(b_SaisOui; False:C215)
		End if 
		<>vd_DtJour:=!00-00-00!
		If (vd_DateEnCours>!00-00-00!)
			<>vd_DtJour:=vd_DateEnCours
		Else 
			<>vd_DtJour:=Current date:C33
		End if 
		[DiaLogues:3]DL_Date:2:=<>vd_DtJour
		P_JourNuit(->rJourNuit1; ->rJourNuit2)
		<>va_BtTitreCentreL:="Consolidation"
		OBJECT SET TITLE:C194(b_Conso; <>va_BtTitreCentreL)
		OBJECT SET VISIBLE:C603(b_Conso; ((User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_Consolidation))))
		OBJECT SET ENTERABLE:C238([CentresLits:16]CL_Distribué:6; False:C215)
		Rec_CentreLits
		
		OBJECT SET VISIBLE:C603(*; "CopierDISpoAdm"; ((User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN))))
		
		
	: ($vl_eventFF=Sur données modifiées:K2:15)
		If (FORM Get current page:C276=1)
			If (Modified:C32([CentresLits:16]CL_DispoDuJour:12) | Modified:C32([CentresLits:16]CL_Absents:13))
				[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_DispoTotal:5+[CentresLits:16]CL_DispoDuJour:12
				[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5-[CentresLits:16]CL_Distribué:6  // [CentresLits]CL_Restant
				REDRAW:C174([CentresLits:16])
			End if 
		End if 
		
		
		If (FORM Get current page:C276=2)
			If (Modified:C32([CentresLits:16]CL_DispoDuJour:12) | Modified:C32([CentresLits:16]CL_RestantsVeille:16) | Modified:C32([CentresLits:16]CL_Distribué:6))
				Case of 
					: (Modified:C32([CentresLits:16]CL_DispoDuJour:12))
						[CentresLits:16]CL_DispoTotal:5:=[CentresLits:16]CL_DispoTotal:5+[CentresLits:16]CL_DispoDuJour:12
					: (Modified:C32([CentresLits:16]CL_Distribué:6))
				End case 
				
				[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_DispoTotal:5-[CentresLits:16]CL_Distribué:6
				REDRAW:C174([CentresLits:16])
			End if 
		End if 
		
		
		
	: ($vl_eventFF=Sur appel extérieur:K2:11)
End case 