var $typeFiche_t : Text
var $vli_Fenetre : Integer
var $vbOK : Boolean

If (Form event code:C388=Sur clic:K2:4)
	
	If (i_Paramnum(1))
		$vli_Fenetre:=Open window:C153((<>vl_EcranL/2)-(412/2); 160; (<>vl_EcranL/2)+(412/2); 160+267; 5; "Erreur")
		
		DIALOG:C40([DiaLogues:3]; "DL_Erreur")
		CLOSE WINDOW:C154($vli_Fenetre)
	Else 
		
		If ([HeberGement:5]HG_NuitTOTAL:93<=0)
			ALERT:C41("Le nombre de Nuits Total doit être supérieur ou égal à 1 !")
		Else 
			$vbOK:=True:C214
			
			If (<>vb_T_ModeCHRS=True:C214)
				
				If ([HeberGement:5]HG_Nuit:2=False:C215)
					
					If (([HeberGement:5]HG_FamGroupe:102=((<>va_UserPlateforme+"@"))) | ([HeberGement:5]HG_FamGroupe:102=((Substring:C12([HeberGement:5]HG_Plateforme:139; 1; 4)+"@"))))
					Else 
						ALERT:C41(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}+" :  pas de correspondance pas avec votre plateforme !")
						$vbOK:=False:C215
					End if 
					
				End if 
				
			End if 
			
			If (<>ve_Si_ModeCHRS=1)  //C'est une prestation
			Else 
				
				If (va_FormatFrom="A")
					
					If (x1=0) & (x2=0)  // On laisse la fiche à l'écran "Vous devez renseigner le responsabilité de famille !")
						StrAlerte(36; "")
						
						$vbOK:=False:C215
					End if 
					
				End if 
				
			End if 
			
			If (<>ve_Si_ModeCHRS=1)  //C'est une prestation
			Else 
				
				If ($vbOK)
					
					If (<>va_Dup_Ctr="O") & (<>vl_Dup_CtrRéf>0)  //Pour toul mettre le centre vide
						
						If ([HeberGement:5]HG_LC_ID:61=0)
							
							If (i_Confirmer("Confirmer-vous que ce n'est pas pour un hébergement ?"))
								[HeberGement:5]HG_LC_ID:61:=<>vl_Dup_CtrRéf
								[HeberGement:5]HG_CentreNom:62:=<>va_Dup_CtrNom
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			End if 
			
			If ($vbOK)
				
				If (<>vb_UserLOFT)
					
					If (Is new record:C668([HeberGement:5]))
						
						If (<>vl_LOFTCtrRéf>0)
							[HeberGement:5]HG_Cloturée:67:=True:C214
							P_HG_StatutClôturé(0)
						End if 
						
					End if 
					
				End if 
				
				If ([HeberGement:5]HG_NuitTOTAL:93<=1)
					[HeberGement:5]HG_Réservation:91:=False:C215
				End if 
				
				If ([HeberGement:5]HG_LC_ID:61>0)
					QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
					MultiSoc_Filter(->[LesCentres:9])
					
					If (Records in selection:C76([LesCentres:9])=1)
						
						If ([HeberGement:5]HG_CentreNom:62#[LesCentres:9]LC_Nom:4)
							[HeberGement:5]HG_CentreNom:62:=[LesCentres:9]LC_Nom:4
						End if 
						
					End if 
					
				End if 
				
				$typeFiche_t:=va_JourNuit
				
				If ($typeFiche_t="JN")
					$typeFiche_t:=Substring:C12([HeberGement:5]HG_FicheNuméro:3; 5; 1)
				End if 
				
				P_HébergementValider($typeFiche_t)
			End if 
			
		End if 
		
	End if 
	
End if 