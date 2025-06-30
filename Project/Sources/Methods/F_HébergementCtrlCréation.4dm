//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergementCtrlCréation
//{
//{          Mardi 16 mars 2004 à 12:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_DATE:C307($2)

C_LONGINT:C283($vl_Nb_J; $vl_Nb_N)
C_BOOLEAN:C305($vb_Nuit; $vb_OK)
C_DATE:C307($vd_Date)

If (Count parameters:C259=2)
	
	If ($2#!00-00-00!)
		$vd_Date:=$2
	End if 
	
End if 

If ($vd_Date=!00-00-00!)
	If ([HeberGement:5]HG_Date:4#!00-00-00!)
		$vd_Date:=[HeberGement:5]HG_Date:4
	Else 
		$vd_Date:=Current date:C33
	End if 
End if 

vb_PasseR:=True:C214
vl_NbHéberGements:=0

If ([HeBerge:4]HB_Status:18)
	vb_PasseR:=False:C215
	P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
Else 
	$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
	$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=$vd_Date)
	MultiSoc_Filter(->[HeberGement:5])
	
	vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
	
	If (<>vb_MaxFichesHG)
		
		Case of 
			: (vl_NbHéberGements=0)
			: (vl_NbHéberGements=1)
				
				If ([HeberGement:5]HG_Nuit:2)  //C'est la nuit
					$vl_Nb_N:=1
				Else 
					$vl_Nb_J:=1
				End if 
				
			: (vl_NbHéberGements>1)
				FIRST RECORD:C50([HeberGement:5])
				
				Repeat 
					
					If ([HeberGement:5]HG_Nuit:2)  //C'est la nuit
						$vl_Nb_N:=$vl_Nb_N+1
					Else 
						$vl_Nb_J:=$vl_Nb_J+1
					End if 
					
					NEXT RECORD:C51([HeberGement:5])
				Until (End selection:C36([HeberGement:5]))
				
		End case 
		
		$vb_OK:=(($1="J") & (<>vl_MaxFichesHG_J>$vl_Nb_J)) | (($1="N") & (<>vl_MaxFichesHG_N>$vl_Nb_N))
		
		If ($vb_OK)
			
			If ($kk>0)
				
				If (i_Confirmer("Attention voir SP !"))
					<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
					
					vl_IDT_Old:=1
					P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
				Else 
					vb_PasseR:=False:C215
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Il existe déjà une fiche à cette date! Vous pouvez modifier la fiche existante")
			vb_PasseR:=False:C215
		End if 
		
	Else   // Ancienne version
		
		Case of 
			: (vl_NbHéberGements=0)
				
				If ($kk>0)
					
					If (i_Confirmer("Attention voir SP !"))
						<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
						
						vl_IDT_Old:=1
						P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
					Else 
						vb_PasseR:=False:C215
					End if 
					
				End if 
				
			: (vl_NbHéberGements=1)
				$vb_Nuit:=($1="N")
				
				If ([HeberGement:5]HG_Nuit:2=$vb_Nuit)
					StrAlerte(15; "")
					vb_PasseR:=False:C215
				Else 
					
					If ([HeberGement:5]HG_Nuit:2)
						ALERT:C41("Attention cette personne a déja une fiche prestation !")
						vb_PasseR:=False:C215
					Else 
						
						If (i_Confirmer("Attention cette personne a déja une fiche d'hébergement . Confirmez-vous la création d'une fiche ?"))
							
							If ($kk>0)
								
								If (i_Confirmer("Attention voir SP !"))
									<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
									
									vl_IDT_Old:=1
									P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
								Else 
									vb_PasseR:=False:C215
								End if 
								
							End if 
							
						Else 
							vb_PasseR:=False:C215
						End if 
						
					End if 
					
				End if 
				
			: (vl_NbHéberGements>=2)
				ALERT:C41("Attention cette personne a déja une fiche d'hébergement!")
				vb_PasseR:=False:C215
		End case 
		
	End if 
	
End if 

If (vb_PasseR)
	$vb_Nuit:=($1="N")
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
	MultiSoc_Filter(->[HeberGement:5])
	
	vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
	
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
End if 

$0:=vb_PasseR