//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_TransFullTransfert
//{
//{          Mardi 7 octobre 2008 à 18:46
//{          Modifiée : Mardi 7 octobre 2008 à 18:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)
C_TIME:C306($h_RefDoc)
C_LONGINT:C283($ii; $jj; $vl_TransChamp; $vl_TransSTR; $vl_Sel; $vl_Position)
C_TEXT:C284($vt_RépCentre; $vt_RépCentreLu; $vt_RépDocu)
C_TEXT:C284($va_Temp)
ARRAY LONGINT:C221($tl_HG_ID; 0)
ARRAY DATE:C224($td_HG_Date; 0)
ARRAY LONGINT:C221($tl_HG_TransHeure; 0)



C_LONGINT:C283(ve_Type)
C_LONGINT:C283(vl_Long)
C_BOOLEAN:C305(vb_Index)


$h_RefDoc:=?00:00:00?


//Tester l'éxistance du répertoire
$vb_OK:=(<>vt_T_CheminRép>"")
If ($vb_OK)
	$vb_OK:=F_Répertoire(<>vt_T_CheminRép)
End if 
If ($vb_OK=False:C215)
	ALERT:C41("Veuillez vérifier le chemin d'accès du répertoire de transfert !")
End if 

If ($vb_OK)
	vd_DtJF:=Current date:C33
	vh_HrJF:=Current time:C178
	For ($ii; 1; Size of array:C274(ta_CTNom))
		$vb_OK:=False:C215
		If (tl_CTSél{$ii}=1)  //•••• Centre sélectionné
			//•••• Recherche des données du Centre sélectionné
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_CTRéf{$ii})
			MultiSoc_Filter(->[LesCentres:9])
			If (Records in selection:C76([LesCentres:9])=1)
				va_LC_Nom:=[LesCentres:9]LC_Nom:4
				va_LC_Ad1:=[LesCentres:9]LC_Adr1:24
				va_LC_Ad2:=[LesCentres:9]LC_Adr2:25
				va_LC_CP:=[LesCentres:9]LC_CP:27
				va_LC_Ville:=[LesCentres:9]LC_Ville:28
				va_LC_Tel:=[LesCentres:9]LC_Téléphone:29
				va_LC_Fax:=[LesCentres:9]LC_Télécopie2:31
				va_LC_Pers:=[LesCentres:9]LC_Responsable:32
				
				va_LC_Dossier:=[LesCentres:9]LC_Répertoire:54  //• TRES IMPORTANT : LE REPERTOIRE DU CENTRE
				//•••• Si la fiche Centre a un code Reperoire
				//•••• • Teste de l'existence du répertoire Centre
				//•••• • SINON Création du répertoire Centre
				//•••• • Teste de l'existence du répertoire Centre pour les fiches lues
				//•••• • SINON Création du répertoire Centre pour les fiches lues
				If (va_LC_Dossier>"")
					$vt_RépCentre:=F_RépertoireCréer(<>vt_T_CheminRép+va_LC_Dossier+Séparateur dossier:K24:12; 1)
					If ($vt_RépCentre>"")
						$vt_RépCentreLu:=F_RépertoireCréer(<>vt_T_CheminRép+va_LC_Dossier+Séparateur dossier:K24:12+va_LC_Dossier+" LU"+Séparateur dossier:K24:12; 1)
						$vb_OK:=True:C214
					End if 
				End if 
			End if 
		End if   //•••• FIN Centre sélectionné
		
		If ($vb_OK)
			$vb_OK:=False:C215
			$vl_Fenetre:=i_FenêtreNo(500; 20; 5; ""; 8; "")
			MESSAGE:C88("Centre : "+[LesCentres:9]LC_Nom:4+" - "+[LesCentres:9]LC_Lieu:5+" / Transfert ")
			USE SET:C118("E_Hébergé")
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=tl_CTRéf{$ii})
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_FamClé:104; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >)
			vl_NbHB:=Records in selection:C76([HeberGement:5])
			If (vl_NbHB>0)
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $tl_HG_ID; [HeberGement:5]HG_Date:4; $td_HG_Date; [HeberGement:5]HG_1_TransHeure:70; $tl_HG_TransHeure)
				
				//•Pourquoi : en fait les fiches qui n'ont pas encore été transmises
				For ($jj; 1; vl_NbHB)
					If ($tl_HG_TransHeure{$jj}=0)
						$vl_Sel:=$vl_Sel+1
						$vb_OK:=True:C214
					End if 
				End for 
				
				If ($vb_OK)
					READ WRITE:C146([HeberGement:5])
					For ($jj; 1; vl_NbHB)
						If ($tl_HG_TransHeure{$jj}=0)
							QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$tl_HG_ID{$jj})
							If (Records in selection:C76([HeberGement:5])=1)
								Repeat 
									IDLE:C311
									LOAD RECORD:C52([HeberGement:5])
								Until (Not:C34(Locked:C147([HeberGement:5])))
								
								//••• Formatage de l'heure courante
								vh_HrJF:=Current time:C178
								$va_Temp:=String:C10(vh_HrJF; h mn s:K7:1)
								$va_Temp:=Replace string:C233($va_Temp; ":"; "")
								If (Length:C16($va_Temp)>=6)
								Else 
									$va_Temp:=("0"*(6-Length:C16($va_Temp)))+$va_Temp
								End if 
								$va_Temp:=Substring:C12($va_Temp; 1; 2)+"h"+Substring:C12($va_Temp; 3; 2)
								
								//••• Titre du fichier sur disque
								//• 3 c : Code du Site
								//• 6 c : AAMMJJ
								//• 5 c : HHhMM
								//• 1 c : J(our) N(uit)
								//• 5 c : 00000 numéro de la fiche
								//• 2 c : Code Etat civil
								//• 2 c : 00 âge
								$vt_RépDocu:=<>va_T_Site+(" "*(3-Length:C16(<>va_T_Site)))
								$vt_RépDocu:=$vt_RépDocu+Substring:C12(String:C10(Year of:C25(vd_DtJF); "0000"); 3; 2)+String:C10(Month of:C24(vd_DtJF); "00")+String:C10(Day of:C23(vd_DtJF); "00")
								$vt_RépDocu:=$vt_RépDocu+$va_Temp
								$vt_RépDocu:=$vt_RépDocu+Substring:C12([HeberGement:5]HG_FicheNuméro:3; 1; 1)+Substring:C12([HeberGement:5]HG_FicheNuméro:3; 7)
								
								If (7=8)  //02/03/2012
									$vt_RépDocu:=$vt_RépDocu+" "+Substring:C12([HeberGement:5]HG_EtatCivil:20; (Length:C16([HeberGement:5]HG_EtatCivil:20)-2); 2)
								Else 
									$vl_Position:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
									If ($vl_Position>0)
										$vt_RépDocu:=$vt_RépDocu+" "+Substring:C12([HeberGement:5]HG_EtatCivil:20; ($vl_Position+1); 2)
									Else 
										$vt_RépDocu:=$vt_RépDocu+" "+"XX"
									End if 
								End if 
								
								If ([HeberGement:5]HG_Age:23>99)
									$vt_RépDocu:=$vt_RépDocu+"99"
								Else 
									$vt_RépDocu:=$vt_RépDocu+String:C10([HeberGement:5]HG_Age:23; "00")
								End if 
								
								$h_RefDoc:=Create document:C266($vt_RépCentre+$vt_RépDocu)
								If (OK=1)
									USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
									
									SEND PACKET:C103($h_RefDoc; <>va_T_Site+", Le "+String:C10(vd_DtJF; Interne date court:K1:7)+" à "+String:C10(vh_HrJF; h mn s:K7:1)+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Etat civil  :"+<>va_Tab+[HeberGement:5]HG_EtatCivil:20+<>va_CR)
									$vt_RépDocu:=""
									$va_Temp:=""
									QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
									$vt_RépDocu:=[HeBerge:4]HB_NotesTrans:53
									$va_Temp:=[HeBerge:4]HB_Clé:2
									
									SEND PACKET:C103($h_RefDoc; "Fiche n°"+<>va_Tab+[HeberGement:5]HG_FicheNuméro:3)
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Clé"+<>va_Tab+$va_Temp)
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Nom"+<>va_Tab+[HeBerge:4]HB_Nom:3)
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Prénom"+<>va_Tab+[HeBerge:4]HB_Prénom:4)
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Né(e) le"+<>va_Tab+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7))
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Age"+<>va_Tab+String:C10([HeberGement:5]HG_Age:23; "000"))
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Nuit en cours"+<>va_Tab+String:C10([HeberGement:5]HG_NuitenCours:92))
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "Nuits totales"+<>va_Tab+String:C10([HeberGement:5]HG_NuitTOTAL:93))
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; "</TD>")
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									SEND PACKET:C103($h_RefDoc; <>va_CR)
									$vt_RépDocu:=Replace string:C233($vt_RépDocu; "≤"; "-")
									$vt_RépDocu:=Replace string:C233($vt_RépDocu; Char:C90(13); "≤")
									SEND PACKET:C103($h_RefDoc; $vt_RépDocu)
									SEND PACKET:C103($h_RefDoc; "</TD>")
									
									
									SEND PACKET:C103($h_RefDoc; "Référence Hébergement"+<>va_Tab+String:C10([HeberGement:5]HG_ReferenceID:1)+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Référence Hébergé"+<>va_Tab+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Référence Centre"+<>va_Tab+String:C10([HeberGement:5]HG_LC_ID:61)+<>va_CR)
									
									SEND PACKET:C103($h_RefDoc; "Trans Hébergement"+<>va_Tab+String:C10([HeberGement:5]HG_Trans_RéférenceID:142)+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Trans Hébergé"+<>va_Tab+String:C10([HeberGement:5]HG_Trans_HB_ID:144)+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Trans Centre"+<>va_Tab+String:C10([HeberGement:5]HG_Trans_LC_ID:145)+<>va_CR)
									
									SEND PACKET:C103($h_RefDoc; "Trans DASS"+<>va_Tab+("O"*Num:C11([HeberGement:5]HG_Trans_DDASS:141))+("N"*Num:C11([HeberGement:5]HG_Trans_DDASS:141=False:C215))+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Trans Fiche n°"+<>va_Tab+[HeberGement:5]HG_Trans_FicheNuméro:143+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Trans Centre Nom"+<>va_Tab+[HeberGement:5]HG_Trans_CentreNom:146+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Trans FamClé"+<>va_Tab+[HeberGement:5]HG_Trans_FamClé:147+<>va_CR)
									SEND PACKET:C103($h_RefDoc; "Trans Plateforme"+<>va_Tab+[HeberGement:5]HG_Trans_Plateforme:148+<>va_CR)
									
									$vl_TransSTR:=8
									For ($vl_TransChamp; 1; Size of array:C274(<>te_RdsRub{$vl_TransSTR}))  //on s'appuye sur le paramètrage Asile
										If (<>tb_RdsTrans{$vl_TransSTR}{$vl_TransChamp})
											GET FIELD PROPERTIES:C258(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp}); ve_Type; vl_Long; vb_Index)
											
											Case of 
												: (ve_Type=Est un champ alpha:K8:1)
													$va_Temp:=Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->
												: (ve_Type=Est un texte:K8:3)
													$va_Temp:=""
												: (ve_Type=Est un numérique:K8:4)
													$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->)
												: (ve_Type=Est un entier:K8:5)
													$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->)
												: (ve_Type=Est un entier long:K8:6)
													$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->)
												: (ve_Type=Est une date:K8:7)
													$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->; Interne date court:K1:7)
												: (ve_Type=Est une heure:K8:8)
													$va_Temp:=String:C10(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->; h mn s:K7:1)
												: (ve_Type=Est un booléen:K8:9)
													$va_Temp:=("O"*Num:C11(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->))
													$va_Temp:=$va_Temp+("N"*Num:C11(Field:C253(<>te_RdsFic{$vl_TransSTR}{$vl_TransChamp}; <>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})->=False:C215))
												: (ve_Type=Est une image:K8:10)
													$va_Temp:=""
												: (ve_Type=Est une sous table:K8:11)
													$va_Temp:=""
												: (ve_Type=Est un BLOB:K8:12)
													$va_Temp:=""
											End case 
											SEND PACKET:C103($h_RefDoc; <>ta_RdsNomNew{$vl_TransSTR}{$vl_TransChamp}+<>va_Tab+$va_Temp+<>va_Tab+String:C10(<>te_RdsRub{$vl_TransSTR}{$vl_TransChamp})+<>va_CR)
										End if 
									End for 
									
									USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
									CLOSE DOCUMENT:C267($h_RefDoc)
									
									[HeberGement:5]HG_1_TransHeure:70:=vh_HrJF
									SAVE RECORD:C53([HeberGement:5])
									UNLOAD RECORD:C212([HeberGement:5])
								End if 
								
							End if 
						End if 
					End for 
					UNLOAD RECORD:C212([HeberGement:5])
					READ ONLY:C145([HeberGement:5])
				End if 
			End if 
		End if 
	End for 
	
	If (Size of array:C274(ta_CTNom)>0)
		Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; ta_CTNom)
	Else 
		Rec_TransFamille(2; ->[DiaLogues:3]DL_Date:2; ->Vb_JouNuit; ->Vb_Valide; 0)
	End if 
	vl_NbHB:=Records in selection:C76([HeberGement:5])
End if 