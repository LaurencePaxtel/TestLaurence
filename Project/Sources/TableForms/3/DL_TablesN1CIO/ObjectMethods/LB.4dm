If (Form event code:C388=Sur double clic:K2:5)
	C_COLLECTION:C1488($collection_c)
	
	OBJECT SET ENABLED:C1123(b_ValTab1; False:C215)
	
	If (Form:C1466.t_TabNiv1.length>0)
		
		If (Form:C1466.elementSelected.length>0)
			
			If (Bool:C1537(Form:C1466.multiSelected)=False:C215)
				$collection_c:=Form:C1466.t_TabNiv1.copy()
				outilsApplyToCollection(->$collection_c; False:C215; "checked")
				
				Form:C1466.t_TabNiv1:=$collection_c.copy()
				Form:C1466.t_TabNiv1[Form:C1466.elementCurrentElmtPos-1].checked:=True:C214
			End if 
			
			OBJECT SET ENABLED:C1123(b_ValTab1; True:C214)
		End if 
		
	End if 
	
End if 