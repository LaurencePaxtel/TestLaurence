//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_TroisTypo
//{          Mercredi 3 février 2010 à 15:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($ii; $L_Position; $vl_Position; $ve_Ligne; $vl_Position1)
C_LONGINT:C283($ve_MoisDe)
C_TEXT:C284($va_EtCv)
ARRAY LONGINT:C221($tl_3TP_FichesMois; 0)
ARRAY LONGINT:C221($tl_3TP_FichesOld; 0)

//i_Message ("Recherche…")
//i_MessageSeul ("Recherche : la sélection")

C_DATE:C307(D_date; D_date2)
If (Application type:C494#4D Server:K5:6)
	D_date:=[DiaLogues:3]DL_Date:2
	D_date2:=[DiaLogues:3]DL_Date2:8
End if 

//Recherche de la plage de Dates et des centres
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=D_date; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=D_date2; *)
Case of 
	: (ta_MoisColDemande=1)
		
	: (ta_MoisColDemande=2)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
	: (ta_MoisColDemande=3)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215; *)
End case 
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
MultiSoc_Filter(->[HeberGement:5])
P_TroisFoisRienNovJanv
//Centres
P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_LesCentre; ->te_LesCentre)
$vl_Fiches:=Records in selection:C76([HeberGement:5])

If ($vl_Fiches>0)
	//Tri et position du mois à traiter en premier
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
	//FIRST RECORD([HeberGement])
	$ii:=0
	$ve_MoisDe:=Month of:C24([HeberGement:5]HG_Date:4)
	
	C_LONGINT:C283($L_ref)
	If (Application type:C494#4D Server:K5:6)
		$L_ref:=4D_Progression_Open("")
	End if 
	
	Repeat 
		$ii:=$ii+1
		// i_MessageSeul ("Recherche : "+String($vl_Fiches)+"/"+String($ii)+"  -  "+String([HeberGement]HG_Date)+"  <>  "+[HeberGement]HG_EtatCivil)
		
		If (Application type:C494#4D Server:K5:6)
			If (($ii%30)=0)
				C_OBJECT:C1216($O_Progression)
				OB SET:C1220($O_Progression; \
					"progress ref"; $L_ref; \
					"progress titel"; "Supervision par période mensuelle"; \
					"progress message"; "Calcul "+String:C10($ii)+"/"+String:C10($vl_Fiches)+" - "+String:C10([HeberGement:5]HG_Date:4)+" "+[HeberGement:5]HG_EtatCivil:20; \
					"progress compteur"; $ii; \
					"progress max"; $vl_Fiches; \
					"progress stop"; -1\
					)
				4D_Progression_Send(->$O_Progression)
				
			End if 
		End if 
		
		//CALCUL POUR LE MOIS : se caler sur la bonne colonne Mois
		$vl_Position:=Find in array:C230(te_MoisDateAffiche; Month of:C24([HeberGement:5]HG_Date:4))
		//••• 
		If ($vl_Position>0)
			
			$va_EtCv:=Substring:C12([HeberGement:5]HG_EtatCivil:20; Length:C16([HeberGement:5]HG_EtatCivil:20)-2; 2)  //Ancien
			$va_EtCv:=""
			$vl_Position1:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
			If ($vl_Position1>0)
				$vl_Position1:=$vl_Position1+1
				$va_EtCv:=Substring:C12([HeberGement:5]HG_EtatCivil:20; $vl_Position1; 2)
				// $va_EtCv:=$va_EtCv+")"
			End if 
			
			
			$ve_Ligne:=0
			Case of 
				: ($va_EtCv="HS")  //HOMME SEUL
					$ve_Ligne:=1
				: ($va_EtCv="FS")  //FEMME SEULE
					$ve_Ligne:=2
				: ($va_EtCv="HC") | ($va_EtCv="FC")  //COUPLES
					$ve_Ligne:=3
				: ($va_EtCv="HF") | ($va_EtCv="HE") | ($va_EtCv="FF") | ($va_EtCv="FE") | ($va_EtCv="FP") | ($va_EtCv="HP")  //FAMILLES
					$ve_Ligne:=4
			End case 
			If ($ve_Ligne>0)
				
				//•1>>>>> Affectation de la nuité
				// vp_LePointeur:=Get pointer("tl_MoisColNuit"+String($vl_Position))
				
				// remplacement 17/2/17
				Case of 
					: ($vl_Position=1)
						vp_LePointeur:=->tl_MoisColNuit1
					: ($vl_Position=2)
						vp_LePointeur:=->tl_MoisColNuit2
					: ($vl_Position=3)
						vp_LePointeur:=->tl_MoisColNuit3
					: ($vl_Position=4)
						vp_LePointeur:=->tl_MoisColNuit4
					: ($vl_Position=5)
						vp_LePointeur:=->tl_MoisColNuit5
					: ($vl_Position=6)
						vp_LePointeur:=->tl_MoisColNuit6
					: ($vl_Position=7)
						vp_LePointeur:=->tl_MoisColNuit7
					: ($vl_Position=8)
						vp_LePointeur:=->tl_MoisColNuit8
					: ($vl_Position=9)
						vp_LePointeur:=->tl_MoisColNuit9
					: ($vl_Position=10)
						vp_LePointeur:=->tl_MoisColNuit10
					: ($vl_Position=11)
						vp_LePointeur:=->tl_MoisColNuit11
					: ($vl_Position=12)
						vp_LePointeur:=->tl_MoisColNuit12
					Else 
						TRACE:C157
				End case 
				vp_LePointeur->{$ve_Ligne}:=vp_LePointeur->{$ve_Ligne}+1
				
				// `••11>>>>> Affectation de la nuité tableau des hébergements
				//vp_LePointeur:=Get pointer("tl_MoisColFicN"+String($vl_Position)+"_"+String($ve_Ligne))
				// remplacement 17/2/17
				Case of 
					: ($vl_Position=1)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN1_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN1_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN1_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN1_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=2)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN2_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN2_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN2_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN2_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=3)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN3_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN3_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN3_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN3_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=4)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN4_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN4_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN4_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN4_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=5)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN5_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN5_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN5_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN5_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=6)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN6_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN6_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN6_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN6_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=7)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN7_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN7_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN7_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN7_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=8)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN8_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN8_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN8_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN8_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=9)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN9_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN9_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN9_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN9_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=10)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN10_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN10_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN10_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN10_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=11)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN11_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN11_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN11_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN11_4
							Else 
								TRACE:C157
						End case 
						
					: ($vl_Position=12)
						
						Case of 
							: ($ve_Ligne=1)
								vp_LePointeur:=->tl_MoisColFicN12_1
							: ($ve_Ligne=2)
								vp_LePointeur:=->tl_MoisColFicN12_2
							: ($ve_Ligne=3)
								vp_LePointeur:=->tl_MoisColFicN12_3
							: ($ve_Ligne=4)
								vp_LePointeur:=->tl_MoisColFicN12_4
							Else 
								TRACE:C157
						End case 
						
					Else 
						TRACE:C157
				End case 
				INSERT IN ARRAY:C227(vp_LePointeur->; Size of array:C274(vp_LePointeur->)+1)
				vp_LePointeur->{Size of array:C274(vp_LePointeur->)}:=[HeberGement:5]HG_ReferenceID:1
				
				//•2>>>>> Personnes differentes dans la mois
				$L_Position:=Find in array:C230($tl_3TP_FichesMois; [HeberGement:5]HG_HB_ID:19)
				If ($L_Position<=0)
					INSERT IN ARRAY:C227($tl_3TP_FichesMois; Size of array:C274($tl_3TP_FichesMois)+1)
					$tl_3TP_FichesMois{Size of array:C274($tl_3TP_FichesMois)}:=[HeberGement:5]HG_HB_ID:19
					
					// `••21>>>>> Personnes differentes dans la mois calcul intermédiaire par ligne
					// vp_LePointeur:=Get pointer("tl_3TP_Pers"+String($ve_Ligne))
					// remplacement 17/2/17
					Case of 
						: ($ve_Ligne=1)
							vp_LePointeur:=->tl_3TP_Pers1
						: ($ve_Ligne=2)
							vp_LePointeur:=->tl_3TP_Pers2
						: ($ve_Ligne=3)
							vp_LePointeur:=->tl_3TP_Pers3
						: ($ve_Ligne=4)
							vp_LePointeur:=->tl_3TP_Pers4
						Else 
							TRACE:C157
					End case 
					INSERT IN ARRAY:C227(vp_LePointeur->; Size of array:C274(vp_LePointeur->)+1)
					vp_LePointeur->{Size of array:C274(vp_LePointeur->)}:=[HeberGement:5]HG_HB_ID:19
					
					// `••22>>>>> Personnes differentes la fiche d'ébergement retenue
					// vp_LePointeur:=Get pointer("tl_MoisColPersDif"+String($vl_Position))
					// remplacement 17/2/17
					Case of 
						: ($vl_Position=1)
							vp_LePointeur:=->tl_MoisColPersDif1
						: ($vl_Position=2)
							vp_LePointeur:=->tl_MoisColPersDif2
						: ($vl_Position=3)
							vp_LePointeur:=->tl_MoisColPersDif3
						: ($vl_Position=4)
							vp_LePointeur:=->tl_MoisColPersDif4
						: ($vl_Position=5)
							vp_LePointeur:=->tl_MoisColPersDif5
						: ($vl_Position=6)
							vp_LePointeur:=->tl_MoisColPersDif6
						: ($vl_Position=7)
							vp_LePointeur:=->tl_MoisColPersDif7
						: ($vl_Position=8)
							vp_LePointeur:=->tl_MoisColPersDif8
						: ($vl_Position=9)
							vp_LePointeur:=->tl_MoisColPersDif9
						: ($vl_Position=10)
							vp_LePointeur:=->tl_MoisColPersDif10
						: ($vl_Position=11)
							vp_LePointeur:=->tl_MoisColPersDif11
						: ($vl_Position=12)
							vp_LePointeur:=->tl_MoisColPersDif12
						Else 
							TRACE:C157
					End case 
					INSERT IN ARRAY:C227(vp_LePointeur->; Size of array:C274(vp_LePointeur->)+1)
					vp_LePointeur->{Size of array:C274(vp_LePointeur->)}:=[HeberGement:5]HG_ReferenceID:1
				End if 
				
				//•3>>>>> Personnes Nouvelles
				$L_Position:=Find in array:C230($tl_3TP_FichesOld; [HeberGement:5]HG_HB_ID:19)
				If ($L_Position<=0)
					INSERT IN ARRAY:C227($tl_3TP_FichesOld; Size of array:C274($tl_3TP_FichesOld)+1)
					$tl_3TP_FichesOld{Size of array:C274($tl_3TP_FichesOld)}:=[HeberGement:5]HG_HB_ID:19
					
					// vp_LePointeur:=Get pointer("vl_MoisColPersNew"+String($vl_Position))
					// vp_LePointeurNew:=Get pointer("tl_MoisColPersNew"+String($vl_Position))
					
					// remplacement 17/2/17
					Case of 
						: ($vl_Position=1)
							vp_LePointeur:=->vl_MoisColPersNew1
						: ($vl_Position=2)
							vp_LePointeur:=->vl_MoisColPersNew2
						: ($vl_Position=3)
							vp_LePointeur:=->vl_MoisColPersNew3
						: ($vl_Position=4)
							vp_LePointeur:=->vl_MoisColPersNew4
						: ($vl_Position=5)
							vp_LePointeur:=->vl_MoisColPersNew5
						: ($vl_Position=6)
							vp_LePointeur:=->vl_MoisColPersNew6
						: ($vl_Position=7)
							vp_LePointeur:=->vl_MoisColPersNew7
						: ($vl_Position=8)
							vp_LePointeur:=->vl_MoisColPersNew8
						: ($vl_Position=9)
							vp_LePointeur:=->vl_MoisColPersNew9
						: ($vl_Position=10)
							vp_LePointeur:=->vl_MoisColPersNew10
						: ($vl_Position=11)
							vp_LePointeur:=->vl_MoisColPersNew11
						: ($vl_Position=12)
							vp_LePointeur:=->vl_MoisColPersNew12
						Else 
							TRACE:C157
					End case 
					
					// remplacement 17/2/17
					Case of 
						: ($vl_Position=1)
							vp_LePointeurNew:=->tl_MoisColPersNew1
						: ($vl_Position=2)
							vp_LePointeurNew:=->tl_MoisColPersNew2
						: ($vl_Position=3)
							vp_LePointeurNew:=->tl_MoisColPersNew3
						: ($vl_Position=4)
							vp_LePointeurNew:=->tl_MoisColPersNew4
						: ($vl_Position=5)
							vp_LePointeurNew:=->tl_MoisColPersNew5
						: ($vl_Position=6)
							vp_LePointeurNew:=->tl_MoisColPersNew6
						: ($vl_Position=7)
							vp_LePointeurNew:=->tl_MoisColPersNew7
						: ($vl_Position=8)
							vp_LePointeurNew:=->tl_MoisColPersNew8
						: ($vl_Position=9)
							vp_LePointeurNew:=->tl_MoisColPersNew9
						: ($vl_Position=10)
							vp_LePointeurNew:=->tl_MoisColPersNew10
						: ($vl_Position=11)
							vp_LePointeurNew:=->tl_MoisColPersNew11
						: ($vl_Position=12)
							vp_LePointeurNew:=->tl_MoisColPersNew12
						Else 
							TRACE:C157
					End case 
					
					vp_LePointeur->:=vp_LePointeur->+1
					INSERT IN ARRAY:C227(vp_LePointeurNew->; Size of array:C274(vp_LePointeurNew->)+1)
					vp_LePointeurNew->{Size of array:C274(vp_LePointeurNew->)}:=[HeberGement:5]HG_ReferenceID:1
				End if 
				
				$ve_Ligne:=0
			End if   //••   FIN si ligne>0           
			
		End if   //•   FIN si Position>0
		
		NEXT RECORD:C51([HeberGement:5])
		
		//CHANGEMENT EVENTUEL DE MOIS SINON ON SORT DU REPETER
		If ($ve_MoisDe#Month of:C24([HeberGement:5]HG_Date:4))
			//Somme des hébergements 
			//Calcul des personnes différentes et des personnes nouvelles      
			
			$vl_Position:=Find in array:C230(te_MoisDateAffiche; $ve_MoisDe)
			If ($vl_Position>0)
				//vp_LePointeur:=Get pointer("tl_MoisColPers"+String($vl_Position))
				// remplacement 17/2/17
				Case of 
					: ($vl_Position=1)
						vp_LePointeur:=->tl_MoisColPers1
					: ($vl_Position=2)
						vp_LePointeur:=->tl_MoisColPers2
					: ($vl_Position=3)
						vp_LePointeur:=->tl_MoisColPers3
					: ($vl_Position=4)
						vp_LePointeur:=->tl_MoisColPers4
					: ($vl_Position=5)
						vp_LePointeur:=->tl_MoisColPers5
					: ($vl_Position=6)
						vp_LePointeur:=->tl_MoisColPers6
					: ($vl_Position=7)
						vp_LePointeur:=->tl_MoisColPers7
					: ($vl_Position=8)
						vp_LePointeur:=->tl_MoisColPers8
					: ($vl_Position=9)
						vp_LePointeur:=->tl_MoisColPers9
					: ($vl_Position=10)
						vp_LePointeur:=->tl_MoisColPers10
					: ($vl_Position=11)
						vp_LePointeur:=->tl_MoisColPers11
					: ($vl_Position=12)
						vp_LePointeur:=->tl_MoisColPers12
					Else 
						TRACE:C157
				End case 
				
				vp_LePointeur->{1}:=Size of array:C274(tl_3TP_Pers1)
				vp_LePointeur->{2}:=Size of array:C274(tl_3TP_Pers2)
				vp_LePointeur->{3}:=Size of array:C274(tl_3TP_Pers3)
				vp_LePointeur->{4}:=Size of array:C274(tl_3TP_Pers4)
			End if 
			
			
			ARRAY LONGINT:C221($tl_3TP_FichesMois; 0)
			$ve_MoisDe:=Month of:C24([HeberGement:5]HG_Date:4)
			
			ARRAY LONGINT:C221(tl_3TP_Pers1; 0)
			ARRAY LONGINT:C221(tl_3TP_Pers2; 0)
			ARRAY LONGINT:C221(tl_3TP_Pers3; 0)
			ARRAY LONGINT:C221(tl_3TP_Pers4; 0)
			ARRAY LONGINT:C221(tl_3TP_Fiches; 0)
		End if 
		
	Until (End selection:C36([HeberGement:5]))
	
	If (Application type:C494#4D Server:K5:6)
		4D_Progression_Close($L_ref)
	End if 
End if 

For ($ii; 1; vl_MoisLigneEtatCivil)
	
	vl_MoisColNuit1:=vl_MoisColNuit1+tl_MoisColNuit1{$ii}
	vl_MoisColNuit2:=vl_MoisColNuit2+tl_MoisColNuit2{$ii}
	vl_MoisColNuit3:=vl_MoisColNuit3+tl_MoisColNuit3{$ii}
	vl_MoisColNuit4:=vl_MoisColNuit4+tl_MoisColNuit4{$ii}
	vl_MoisColNuit5:=vl_MoisColNuit5+tl_MoisColNuit5{$ii}
	vl_MoisColNuit6:=vl_MoisColNuit6+tl_MoisColNuit6{$ii}
	vl_MoisColNuit7:=vl_MoisColNuit7+tl_MoisColNuit7{$ii}
	vl_MoisColNuit8:=vl_MoisColNuit8+tl_MoisColNuit8{$ii}
	vl_MoisColNuit9:=vl_MoisColNuit9+tl_MoisColNuit9{$ii}
	vl_MoisColNuit10:=vl_MoisColNuit10+tl_MoisColNuit10{$ii}
	vl_MoisColNuit11:=vl_MoisColNuit11+tl_MoisColNuit11{$ii}
	vl_MoisColNuit12:=vl_MoisColNuit12+tl_MoisColNuit12{$ii}
	
	
	
	vl_MoisColPers1:=vl_MoisColPers1+tl_MoisColPers1{$ii}
	vl_MoisColPers2:=vl_MoisColPers2+tl_MoisColPers2{$ii}
	vl_MoisColPers3:=vl_MoisColPers3+tl_MoisColPers3{$ii}
	vl_MoisColPers4:=vl_MoisColPers4+tl_MoisColPers4{$ii}
	vl_MoisColPers5:=vl_MoisColPers5+tl_MoisColPers5{$ii}
	vl_MoisColPers6:=vl_MoisColPers6+tl_MoisColPers6{$ii}
	vl_MoisColPers7:=vl_MoisColPers7+tl_MoisColPers7{$ii}
	vl_MoisColPers8:=vl_MoisColPers8+tl_MoisColPers8{$ii}
	vl_MoisColPers9:=vl_MoisColPers9+tl_MoisColPers9{$ii}
	vl_MoisColPers10:=vl_MoisColPers10+tl_MoisColPers10{$ii}
	vl_MoisColPers11:=vl_MoisColPers11+tl_MoisColPers11{$ii}
	vl_MoisColPers12:=vl_MoisColPers12+tl_MoisColPers12{$ii}
End for 


vl_MoisColNuitTotal:=0
vl_MoisColPersTotal:=0
vl_MoisColPersNewTotal:=0

vl_MoisColNuitTotal:=vl_MoisColNuit1+vl_MoisColNuit2+vl_MoisColNuit3+vl_MoisColNuit4
vl_MoisColNuitTotal:=vl_MoisColNuitTotal+vl_MoisColNuit5+vl_MoisColNuit6+vl_MoisColNuit7+vl_MoisColNuit8
vl_MoisColNuitTotal:=vl_MoisColNuitTotal+vl_MoisColNuit7+vl_MoisColNuit8+vl_MoisColNuit9+vl_MoisColNuit10+vl_MoisColNuit11+vl_MoisColNuit12

vl_MoisColPersTotal:=vl_MoisColPers1+vl_MoisColPers2+vl_MoisColPers3+vl_MoisColPers4
vl_MoisColPersTotal:=vl_MoisColPersTotal+vl_MoisColPers5+vl_MoisColPers6+vl_MoisColPers7+vl_MoisColPers8
vl_MoisColPersTotal:=vl_MoisColPersTotal+vl_MoisColPers9+vl_MoisColPers10+vl_MoisColPers11+vl_MoisColPers12
vl_MoisColPersTotal:=Size of array:C274($tl_3TP_FichesOld)

vl_MoisColPersNewTotal:=vl_MoisColPersNew1+vl_MoisColPersNew2+vl_MoisColPersNew3+vl_MoisColPersNew4
vl_MoisColPersNewTotal:=vl_MoisColPersNewTotal+vl_MoisColPersNew5+vl_MoisColPersNew6+vl_MoisColPersNew7+vl_MoisColPersNew8
vl_MoisColPersNewTotal:=vl_MoisColPersNewTotal+vl_MoisColPersNew9+vl_MoisColPersNew10+vl_MoisColPersNew11+vl_MoisColPersNew12



REDUCE SELECTION:C351([HeberGement:5]; 0)
vt_ColRéf_Libellé:="…"
CLOSE WINDOW:C154

