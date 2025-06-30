C_LONGINT:C283($vl_EventFF)

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		If (vb_EstChéf=False:C215)
			OBJECT SET ENABLED:C1123(b_NewChef; False:C215)
		End if 
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		
		If ((vl_SourisX>7) & (vl_SourisX<474)) & ((vl_SourisY>53) & (vl_SourisY<272))
			
			If ([HeBerge:4]HB_ReferenceID:1>0)
				va_LeNoFAM:=[HeBerge:4]HB_CléFam:47
				CANCEL:C270
			Else 
				StrAlerte(2; "")
			End if 
			
		End if 
		
End case 