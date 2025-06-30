//Formule format : D_Centres
C_LONGINT:C283($vl_EventFF; $L_Erreur)

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "MasqueC"; <>vb_T_CentreCritMasquer)
		$L_Erreur:=CentreLits_Handle_query("chercher")
		
		vl_SelF1:=0
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
		
		vb_RecHéb:=False:C215
		
		If (<>vl_NoHHisto<=0)
			OBJECT SET VISIBLE:C603(*; "Historique_Bt"; False:C215)
		End if 
		
		If (<>ve_Si_ModeCHRS=1)
			OBJECT SET VISIBLE:C603(*; "Mode_115"; False:C215)
		End if 
		
		va_CtrLib:=F_Joker("DF"; va_CtrLib)
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		
		If ((vl_SourisXb>7) & (vl_SourisXb<725)) & ((vl_SourisYb>106) & (vl_SourisYb<503))
			
			If ([LesCentres:9]LC_RéférenceID:1>0)
				vb_RecHéb:=True:C214
				
				va_RH_Typ1:=[LesCentres:9]LC_Nom:4
				va_RH_Typ2:=[LesCentres:9]LC_Lieu:5
				vl_RH_RéfID:=[LesCentres:9]LC_RéférenceID:1
				vb_RH_Médic:=[LesCentres:9]LC_LitMédicalis:47
				
				CANCEL:C270
			End if 
			
		End if 
		
End case 