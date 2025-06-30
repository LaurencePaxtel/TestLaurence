var $noNbjour; $noij; $noii : Integer

If (Form event code:C388=Sur clic:K2:4)
	
	If (vd_DateSel1#!00-00-00!) & (vd_DateSel1<=vd_DateSel2) & ((rNuit=1) | (rJour=1))
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=vd_DateSel1)
		MultiSoc_Filter(->[CentresLits:16])
		
		If (Records in selection:C76([CentresLits:16])>0)
			ALERT:C41("Des disponibilités existent entre le "+String:C10(vd_DateSel1)+" et le "+String:C10(vd_DateSel2))
		Else 
			CONFIRM:C162("Voulez-vous créer les disponibilités entre le "+String:C10(vd_DateSel1)+" et le "+String:C10(vd_DateSel2))
			
			If (OK=1)
				ALL RECORDS:C47([LesCentres:9])
				MultiSoc_Filter(->[LesCentres:9])
				
				FIRST RECORD:C50([LesCentres:9])
				
				If (Records in selection:C76([LesCentres:9])>0)
					i_Message("Création en cours …")
					
					READ WRITE:C146([CentresLits:16])
					vd_DateSelx:=vd_DateSel1
					
					Repeat 
						$noNbjour:=$noNbjour+1
						
						ALL RECORDS:C47([LesCentres:9])
						MultiSoc_Filter(->[LesCentres:9])
						
						$noij:=Records in selection:C76([LesCentres:9])
						FIRST RECORD:C50([LesCentres:9])
						
						i_MessageSeul("Création en cours du : "+String:C10(vd_DateSelx))
						CLEAR VARIABLE:C89($noii)
						
						Repeat 
							$noii:=$noii+1
							i_MessageSeul("Création en cours du : "+String:C10(vd_DateSelx)+" - "+String:C10($noij)+"/"+String:C10($noii))
							
							If ([LesCentres:9]LC_Fermé:53=False:C215) & ([LesCentres:9]LC_Prestation:55=False:C215)
								
								If (rJour=1)
									P_DisponibilitéCréer(3; "J"; vd_DateSelx; 0; 0; 0; 0; 0)
								End if 
								
								If (rNuit=1)
									P_DisponibilitéCréer(3; "N"; vd_DateSelx; 0; 0; 0; 0; 0)
								End if 
								
							End if 
							
							NEXT RECORD:C51([LesCentres:9])
						Until (End selection:C36([LesCentres:9]))
						
						vd_DateSelx:=vd_DateSel1+$noNbjour
					Until (vd_DateSelx>vd_DateSel2)
					
					READ ONLY:C145([CentresLits:16])
					CLOSE WINDOW:C154
				End if 
				
			End if 
			
		End if 
		
	Else 
		ALERT:C41("Veuillez vérifier les dates et le type jour ou/et nuit !")
	End if 
	
End if 