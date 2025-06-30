//%attributes = {"executedOnServer":true}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_TranchesDureeSansInter
//{
//{          Lundi 28 juin 2010 à 14:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_POINTER:C301($1; $P_Objet)
$P_Objet:=$1
C_OBJECT:C1216($O_Objet)
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

ARRAY LONGINT:C221(tl_xCentre; 0)
ARRAY INTEGER:C220(te_xCentre; 0)

ARRAY LONGINT:C221(tl_TrancheCol1; 0)
ARRAY LONGINT:C221(tl_TrancheCol2; 0)
ARRAY LONGINT:C221(tl_TrancheCol3; 0)
ARRAY LONGINT:C221(tl_TrancheCol4; 0)
ARRAY LONGINT:C221(tl_TrancheCol5; 0)
ARRAY LONGINT:C221(tl_TrancheCol6; 0)
ARRAY LONGINT:C221(tl_TrancheCol7; 0)
ARRAY LONGINT:C221(tl_TrancheCol8; 0)
ARRAY LONGINT:C221(tl_TrancheCol9; 0)
ARRAY LONGINT:C221(tl_TrancheCol10; 0)
ARRAY LONGINT:C221(tl_TrancheCol11; 0)
ARRAY LONGINT:C221(tl_TrancheCol12; 0)
ARRAY LONGINT:C221(tl_HGRupture; 0)
ARRAY INTEGER:C220(te_TrancheAfficheDebut; 0)
ARRAY INTEGER:C220(te_TrancheAfficheFin; 0)

OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
OB GET ARRAY:C1229($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
OB GET ARRAY:C1229($O_Objet; "tl_HGRupture"; tl_HGRupture)

OB GET ARRAY:C1229($O_Objet; "te_TrancheAfficheDebut"; te_TrancheAfficheDebut)
OB GET ARRAY:C1229($O_Objet; "te_TrancheAfficheFin"; te_TrancheAfficheFin)


vl_TrancheLigneEtatCivil:=OB Get:C1224($O_Objet; "vl_TrancheLigneEtatCivil")
vt_ColRéf_LibelléRupture:=OB Get:C1224($O_Objet; "vt_ColRéf_LibelléRupture")
vL_NbFichesRupture:=OB Get:C1224($O_Objet; "vL_NbFichesRupture")

C_DATE:C307(D_Date; D_Date2)
D_Date:=OB Get:C1224($O_Objet; "date"; Est une date:K8:7)
D_Date2:=OB Get:C1224($O_Objet; "date2"; Est une date:K8:7)

// Modifiée BS pour optimisation serveur 09/11/16


C_LONGINT:C283($ii; $jj; $kk; $vl_TrancheEnCours; $vl_TrancheLigne; $vl_bcle; $vl_Position1)
C_BOOLEAN:C305($vb_OK)

C_LONGINT:C283($vl_Jours; $vl_Position1)
C_TEXT:C284($va_EtCv)

C_DATE:C307($vd_PasaPasDate)

ARRAY LONGINT:C221($tl_FicheID; 0)
ARRAY LONGINT:C221($tl_HebergeID; 0)
ARRAY TEXT:C222($ta_HebergeEtCv; 0)
ARRAY BOOLEAN:C223($tb_FicheContinue; 0)
ARRAY LONGINT:C221($tl_FicheNuits; 0)

ARRAY LONGINT:C221($tl_FicheIDTemp; 0)


// i_Message ("RAZ…")
C_BOOLEAN:C305($B_Dummy)
$B_Dummy:=P_TranchesEnCours(2)

vL_NbFichesRupture:=0
vt_ColRéf_LibelléRupture:=""

// i_MessageSeul ("Recherche…")
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=D_Date2; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)

MultiSoc_Filter(->[HeberGement:5])

C_LONGINT:C283($vl_Fiches)
$vl_Fiches:=Records in selection:C76([HeberGement:5])
//Centre 
If ($vl_Fiches>0)
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_xCentre; ->te_xCentre)
End if 
$vl_Fiches:=Records in selection:C76([HeberGement:5])
If ($vl_Fiches>0)
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_FicheID; [HeberGement:5]HG_HB_ID:19; $tl_HebergeID; [HeberGement:5]HG_EtatCivil:20; $ta_HebergeEtCv)
	ARRAY BOOLEAN:C223($tb_FicheContinue; $vl_Fiches)
	ARRAY LONGINT:C221($tl_FicheNuits; $vl_Fiches)
	For ($ii; 1; $vl_Fiches)
		$tb_FicheContinue{$ii}:=False:C215
		$tl_FicheNuits{$ii}:=0
	End for 
	
	C_LONGINT:C283($L_ref)
	If (Application type:C494#4D Server:K5:6)
		$L_ref:=4D_Progression_Open("")
	End if 
	
	For ($ii; 1; $vl_Fiches)
		// i_MessageSeul ("Calcul : "+String($vl_Fiches)+"/"+String($ii))
		
		If (Application type:C494#4D Server:K5:6)
			If ((($ii%30)=0))
				
				// la propriete STOP
				// on ne la met pas ou on met -1
				// 1 l'utilisateur a cliqué STOP
				// 2 est la valeur au demarrage
				
				C_OBJECT:C1216($O_Progression)
				OB SET:C1220($O_Progression; \
					"progress ref"; $L_ref; \
					"progress titel"; "Supervision par tranche"; \
					"progress message"; "Calcul en cours... "+String:C10($ii)+"/"+String:C10($vl_Fiches); \
					"progress compteur"; $ii; \
					"progress max"; $vl_Fiches; \
					"progress stop"; -1\
					)
				4D_Progression_Send(->$O_Progression)
			End if 
		End if 
		
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=D_Date; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=D_Date2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_HB_ID:19=$tl_HebergeID{$ii}; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])>0)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_FicheIDTemp; [HeberGement:5]HG_Date:4; $tl_FicheDate)
			
			$vb_OK:=True:C214
			$vl_Jours:=Size of array:C274($tl_FicheIDTemp)
			$vd_PasaPasDate:=$tl_FicheDate{1}
			$kk:=0
			Repeat 
				$kk:=$kk+1
				If ($vd_PasaPasDate=$tl_FicheDate{$kk})
					$vd_PasaPasDate:=Add to date:C393($vd_PasaPasDate; 0; 0; 1)
				Else 
					$vb_OK:=False:C215
				End if 
			Until (($kk>=$vl_Jours) | ($vb_OK=False:C215))
			
			If ($vb_OK)
				$tb_FicheContinue{$ii}:=True:C214
				$tl_FicheNuits{$ii}:=$vl_Jours
				
				$va_EtCv:=Substring:C12($ta_HebergeEtCv{$ii}; Length:C16($ta_HebergeEtCv{$ii})-2; 2)  //Ancien
				$va_EtCv:=""
				$vl_Position1:=Position:C15("("; $ta_HebergeEtCv{$ii})
				If ($vl_Position1>0)
					$vl_Position1:=$vl_Position1+1
					$va_EtCv:=Substring:C12($ta_HebergeEtCv{$ii}; $vl_Position1; 2)
					//$va_EtCv:=$va_EtCv+")"
				End if 
				
				$vl_TrancheLigne:=0
				Case of 
					: ($va_EtCv="HS")  //HOMME SEUL
						$vl_TrancheLigne:=1
					: ($va_EtCv="FS")  //FEMME SEULE
						$vl_TrancheLigne:=2
					: ($va_EtCv="HC") | ($va_EtCv="FC")  //COUPLES
						$vl_TrancheLigne:=3
					: ($va_EtCv="HF") | ($va_EtCv="HE") | ($va_EtCv="FF") | ($va_EtCv="FE") | ($va_EtCv="FP") | ($va_EtCv="HP")  //FAMILLES
						$vl_TrancheLigne:=4
				End case 
				
				$vl_TrancheEnCours:=0
				Repeat 
					$vl_TrancheEnCours:=$vl_TrancheEnCours+1
				Until ((($vl_Jours>=te_TrancheAfficheDebut{$vl_TrancheEnCours}) & ($vl_Jours<=te_TrancheAfficheFin{$vl_TrancheEnCours})) | ($vl_TrancheEnCours>=Size of array:C274(te_TrancheAfficheDebut)))
				
				$vb_OK:=(($vl_TrancheEnCours>0) & ($vl_TrancheEnCours<=Size of array:C274(te_TrancheAfficheDebut)))
				$vb_OK:=$vb_OK & ($vl_TrancheLigne>0)
				
				If ($vb_OK)
					// remplacement get pointer 17/2/17
					//vp_LePointeur:=Get pointer("tl_TrancheCol"+String($vl_TrancheEnCours))
					Case of 
						: ($vl_TrancheEnCours=1)
							vp_LePointeur:=->tl_TrancheCol1
						: ($vl_TrancheEnCours=2)
							vp_LePointeur:=->tl_TrancheCol2
						: ($vl_TrancheEnCours=3)
							vp_LePointeur:=->tl_TrancheCol3
						: ($vl_TrancheEnCours=4)
							vp_LePointeur:=->tl_TrancheCol4
						: ($vl_TrancheEnCours=5)
							vp_LePointeur:=->tl_TrancheCol5
						: ($vl_TrancheEnCours=6)
							vp_LePointeur:=->tl_TrancheCol6
						: ($vl_TrancheEnCours=7)
							vp_LePointeur:=->tl_TrancheCol7
						: ($vl_TrancheEnCours=8)
							vp_LePointeur:=->tl_TrancheCol8
						: ($vl_TrancheEnCours=9)
							vp_LePointeur:=->tl_TrancheCol9
						: ($vl_TrancheEnCours=10)
							vp_LePointeur:=->tl_TrancheCol10
						: ($vl_TrancheEnCours=11)
							vp_LePointeur:=->tl_TrancheCol11
						: ($vl_TrancheEnCours=12)
							vp_LePointeur:=->tl_TrancheCol12
						Else 
							TRACE:C157
					End case 
					vp_LePointeur->{$vl_TrancheLigne}:=vp_LePointeur->{$vl_TrancheLigne}+1
					
					If (Size of array:C274($tl_FicheIDTemp)>0)
						
						// remplacement get pointer 17/2/17
						//vp_LePointeur:=Get pointer("tl_TrancheCol"+String($vl_TrancheEnCours)+"_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheEnCours=1)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol1_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol1_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol1_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol1_4
									Else 
										TRACE:C157
								End case 
							: ($vl_TrancheEnCours=2)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol2_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol2_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol2_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol2_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=3)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol3_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol3_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol3_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol3_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=4)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol4_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol4_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol4_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol4_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=5)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol5_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol5_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol5_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol5_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=6)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol6_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol6_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol6_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol6_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=7)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol7_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol7_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol7_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol7_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=8)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol8_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol8_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol8_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol8_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=9)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol9_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol9_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol9_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol9_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=10)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol10_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol10_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol10_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol10_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=11)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol11_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol11_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol11_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol11_4
									Else 
										TRACE:C157
								End case 
								
							: ($vl_TrancheEnCours=12)
								
								Case of 
									: ($vl_TrancheLigne=1)
										vp_LePointeur:=->tl_TrancheCol12_1
									: ($vl_TrancheLigne=2)
										vp_LePointeur:=->tl_TrancheCol12_2
									: ($vl_TrancheLigne=3)
										vp_LePointeur:=->tl_TrancheCol12_3
									: ($vl_TrancheLigne=4)
										vp_LePointeur:=->tl_TrancheCol12_4
									Else 
										TRACE:C157
								End case 
								
							Else 
								TRACE:C157
						End case 
						
						For ($vl_bcle; 1; Size of array:C274($tl_FicheIDTemp))
							INSERT IN ARRAY:C227(vp_LePointeur->; Size of array:C274(vp_LePointeur->)+1)
							vp_LePointeur->{Size of array:C274(vp_LePointeur->)}:=$tl_FicheIDTemp{$vl_bcle}
						End for 
					End if 
				End if 
				
			Else 
				$tl_FicheNuits{$ii}:=$vl_Jours
				vL_NbFichesRupture:=vL_NbFichesRupture+1
				If (Size of array:C274($tl_FicheIDTemp)>0)
					For ($vl_bcle; 1; Size of array:C274($tl_FicheIDTemp))
						INSERT IN ARRAY:C227(tl_HGRupture; Size of array:C274(tl_HGRupture)+1)
						tl_HGRupture{Size of array:C274(tl_HGRupture)}:=$tl_FicheIDTemp{$vl_bcle}
					End for 
				End if 
			End if 
			
		End if 
	End for 
	
	For ($jj; 1; vl_TrancheLigneEtatCivil)
		vl_TrancheCol1:=vl_TrancheCol1+tl_TrancheCol1{$jj}
		vl_TrancheCol2:=vl_TrancheCol2+tl_TrancheCol2{$jj}
		vl_TrancheCol3:=vl_TrancheCol3+tl_TrancheCol3{$jj}
		vl_TrancheCol4:=vl_TrancheCol4+tl_TrancheCol4{$jj}
		vl_TrancheCol5:=vl_TrancheCol5+tl_TrancheCol5{$jj}
		vl_TrancheCol6:=vl_TrancheCol6+tl_TrancheCol6{$jj}
		vl_TrancheCol7:=vl_TrancheCol7+tl_TrancheCol7{$jj}
		vl_TrancheCol8:=vl_TrancheCol8+tl_TrancheCol8{$jj}
		vl_TrancheCol9:=vl_TrancheCol9+tl_TrancheCol9{$jj}
		vl_TrancheCol10:=vl_TrancheCol10+tl_TrancheCol10{$jj}
		vl_TrancheCol11:=vl_TrancheCol11+tl_TrancheCol11{$jj}
		vl_TrancheCol12:=vl_TrancheCol12+tl_TrancheCol12{$jj}
	End for 
	If (Application type:C494#4D Server:K5:6)
		4D_Progression_Close($L_ref)
	End if 
	
	P_StatTranche("TRT"; 0; 0)
	
	If (Size of array:C274(tl_HGRupture)>0)
		vt_ColRéf_LibelléRupture:="Personnes avec rupture de prise en charge : "+String:C10(vL_NbFichesRupture)
	Else 
		vt_ColRéf_LibelléRupture:=""
	End if 
Else 
	REDUCE SELECTION:C351([HeberGement:5]; 0)
End if 
// CLOSE WINDOW



OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol1"; tl_TrancheCol1)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol2"; tl_TrancheCol2)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol3"; tl_TrancheCol3)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol4"; tl_TrancheCol4)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol5"; tl_TrancheCol5)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol6"; tl_TrancheCol6)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol7"; tl_TrancheCol7)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol8"; tl_TrancheCol8)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol9"; tl_TrancheCol9)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol10"; tl_TrancheCol10)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol11"; tl_TrancheCol11)
OB SET ARRAY:C1227($O_Objet; "tl_TrancheCol12"; tl_TrancheCol12)
OB SET ARRAY:C1227($O_Objet; "tl_HGRupture"; tl_HGRupture)
OB SET:C1220($O_Objet; "vl_TrancheCol1"; vl_TrancheCol1)
OB SET:C1220($O_Objet; "vl_TrancheCol2"; vl_TrancheCol2)
OB SET:C1220($O_Objet; "vl_TrancheCol3"; vl_TrancheCol3)
OB SET:C1220($O_Objet; "vl_TrancheCol4"; vl_TrancheCol4)
OB SET:C1220($O_Objet; "vl_TrancheCol5"; vl_TrancheCol5)
OB SET:C1220($O_Objet; "vl_TrancheCol6"; vl_TrancheCol6)
OB SET:C1220($O_Objet; "vl_TrancheCol7"; vl_TrancheCol7)
OB SET:C1220($O_Objet; "vl_TrancheCol8"; vl_TrancheCol8)
OB SET:C1220($O_Objet; "vl_TrancheCol9"; vl_TrancheCol9)
OB SET:C1220($O_Objet; "vl_TrancheCol10"; vl_TrancheCol10)
OB SET:C1220($O_Objet; "vl_TrancheCol11"; vl_TrancheCol11)
OB SET:C1220($O_Objet; "vl_TrancheCol12"; vl_TrancheCol12)
OB SET:C1220($O_Objet; "vt_ColRéf_LibelléRupture"; vt_ColRéf_LibelléRupture)
OB SET:C1220($O_Objet; "vL_NbFichesRupture"; vL_NbFichesRupture)
OB SET:C1220($O_Objet; "vl_TrancheLigneEtatCivil"; vl_TrancheLigneEtatCivil)


$P_Objet->:=OB Copy:C1225($O_Objet)