//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_FluxEnCours
//{
//{          Jeudi 21 avril 2011 à 14:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================} 
C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)
C_POINTER:C301($P_Flux)  // en remplacement du pointeur process vptr_Flux
C_LONGINT:C283($ii; $jj; $kk; $vl_TrancheLigne)
C_BOOLEAN:C305($vb_Entree; $vb_Sortie)
C_DATE:C307($vd_DatePecedente)

C_LONGINT:C283($vl_RéfHB; $vl_Jours; $vl_Nuits; $vl_Position1)
C_TEXT:C284($va_EtCivil)
C_TEXT:C284($va_EtCv)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_TrancheColTotal; vl_TrancheColEtatCivil; vl_TrancheLigneEtatCivil; vl_TrancheDiffTotal)
		vl_TrancheLigneEtatCivil:=4
		C_LONGINT:C283(ve_TrancheCasNew)
		ve_TrancheCasNew:=0
		
		
		ARRAY TEXT:C222(ta_MoisColEtatCivil; vl_MoisLigneEtatCivil)
		ta_MoisColEtatCivil{1}:="Homme seul"  //(HS)
		ta_MoisColEtatCivil{2}:="Femme seule"  //(FS)
		ta_MoisColEtatCivil{3}:="Couples"  //(HC-FC)
		ta_MoisColEtatCivil{4}:="Familles"  //(HF-HE-FF-FE FP-HP)
		
		
		
		ARRAY TEXT:C222(ta_TrancheColEtatCivil; vl_TrancheLigneEtatCivil)
		
		//  COPIER TABLEAU(◊ta_TBEtCiv;ta_TrancheColEtatCivil)
		//  vl_TrancheLigneEtatCivil:=Taille tableau(ta_TrancheColEtatCivil)
		
		
		ta_TrancheColEtatCivil{1}:="Homme seul"  //(HS)
		ta_TrancheColEtatCivil{2}:="Femme seule"  //(FS)
		ta_TrancheColEtatCivil{3}:="Couples"  //(HC-FC)
		ta_TrancheColEtatCivil{4}:="Familles"  //(HF-HE-FF-FE FP-HP)
		
		ARRAY LONGINT:C221(tl_FluxFirst; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_FluxFirstP; vl_TrancheLigneEtatCivil)
		
		ARRAY LONGINT:C221(tl_FluxIn; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_FluxInP; vl_TrancheLigneEtatCivil)
		
		ARRAY LONGINT:C221(tl_FluxOut; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_FluxOutP; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_FluxOutN; vl_TrancheLigneEtatCivil)
		
		ARRAY LONGINT:C221(tl_FluxLast; vl_TrancheLigneEtatCivil)
		ARRAY LONGINT:C221(tl_FluxLastP; vl_TrancheLigneEtatCivil)
		
		C_LONGINT:C283(vl_FluxFirst; vl_FluxFirstP)
		C_LONGINT:C283(vl_FluxIn; vl_FluxInP)
		C_LONGINT:C283(vl_FluxOut; vl_FluxOutP; vl_FluxOutN)
		C_LONGINT:C283(vl_FluxLast; vl_FluxLastP)
		
		
		ARRAY LONGINT:C221(tl_FluxFirst_1; 0)
		ARRAY LONGINT:C221(tl_FluxFirst_2; 0)
		ARRAY LONGINT:C221(tl_FluxFirst_3; 0)
		ARRAY LONGINT:C221(tl_FluxFirst_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxFirstP_1; 0)
		ARRAY LONGINT:C221(tl_FluxFirstP_2; 0)
		ARRAY LONGINT:C221(tl_FluxFirstP_3; 0)
		ARRAY LONGINT:C221(tl_FluxFirstP_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxIn_1; 0)
		ARRAY LONGINT:C221(tl_FluxIn_2; 0)
		ARRAY LONGINT:C221(tl_FluxIn_3; 0)
		ARRAY LONGINT:C221(tl_FluxIn_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxInP_1; 0)
		ARRAY LONGINT:C221(tl_FluxInP_2; 0)
		ARRAY LONGINT:C221(tl_FluxInP_3; 0)
		ARRAY LONGINT:C221(tl_FluxInP_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxOut_1; 0)
		ARRAY LONGINT:C221(tl_FluxOut_2; 0)
		ARRAY LONGINT:C221(tl_FluxOut_3; 0)
		ARRAY LONGINT:C221(tl_FluxOut_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxOutP_1; 0)
		ARRAY LONGINT:C221(tl_FluxOutP_2; 0)
		ARRAY LONGINT:C221(tl_FluxOutP_3; 0)
		ARRAY LONGINT:C221(tl_FluxOutP_4; 0)
		
		
		ARRAY LONGINT:C221(tl_FluxOutN_1; 0)
		ARRAY LONGINT:C221(tl_FluxOutN_2; 0)
		ARRAY LONGINT:C221(tl_FluxOutN_3; 0)
		ARRAY LONGINT:C221(tl_FluxOutN_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxLast_1; 0)
		ARRAY LONGINT:C221(tl_FluxLast_2; 0)
		ARRAY LONGINT:C221(tl_FluxLast_3; 0)
		ARRAY LONGINT:C221(tl_FluxLast_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxLastP_1; 0)
		ARRAY LONGINT:C221(tl_FluxLastP_2; 0)
		ARRAY LONGINT:C221(tl_FluxLastP_3; 0)
		ARRAY LONGINT:C221(tl_FluxLastP_4; 0)
		
	: ($1=2)
		For ($ii; 1; vl_TrancheLigneEtatCivil)
			tl_FluxFirst{$ii}:=0
			tl_FluxFirstP{$ii}:=0
			tl_FluxIn{$ii}:=0
			tl_FluxInP{$ii}:=0
			tl_FluxOut{$ii}:=0
			tl_FluxOutP{$ii}:=0
			tl_FluxOutN{$ii}:=0
			tl_FluxLast{$ii}:=0
			tl_FluxLastP{$ii}:=0
		End for 
		vl_FluxFirst:=0
		vl_FluxFirstP:=0
		vl_FluxIn:=0
		vl_FluxInP:=0
		vl_FluxOut:=0
		vl_FluxOutP:=0
		vl_FluxOutN:=0
		vl_FluxLast:=0
		vl_FluxLastP:=0
		
		vt_ColRéf_Libellé:=""
		vt_ColRéf_LibelléRupture:=""
		
		ARRAY LONGINT:C221(tl_FluxFirst_1; 0)
		ARRAY LONGINT:C221(tl_FluxFirst_2; 0)
		ARRAY LONGINT:C221(tl_FluxFirst_3; 0)
		ARRAY LONGINT:C221(tl_FluxFirst_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxFirstP_1; 0)
		ARRAY LONGINT:C221(tl_FluxFirstP_2; 0)
		ARRAY LONGINT:C221(tl_FluxFirstP_3; 0)
		ARRAY LONGINT:C221(tl_FluxFirstP_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxIn_1; 0)
		ARRAY LONGINT:C221(tl_FluxIn_2; 0)
		ARRAY LONGINT:C221(tl_FluxIn_3; 0)
		ARRAY LONGINT:C221(tl_FluxIn_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxInP_1; 0)
		ARRAY LONGINT:C221(tl_FluxInP_2; 0)
		ARRAY LONGINT:C221(tl_FluxInP_3; 0)
		ARRAY LONGINT:C221(tl_FluxInP_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxOut_1; 0)
		ARRAY LONGINT:C221(tl_FluxOut_2; 0)
		ARRAY LONGINT:C221(tl_FluxOut_3; 0)
		ARRAY LONGINT:C221(tl_FluxOut_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxOutP_1; 0)
		ARRAY LONGINT:C221(tl_FluxOutP_2; 0)
		ARRAY LONGINT:C221(tl_FluxOutP_3; 0)
		ARRAY LONGINT:C221(tl_FluxOutP_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxOutN_1; 0)
		ARRAY LONGINT:C221(tl_FluxOutN_2; 0)
		ARRAY LONGINT:C221(tl_FluxOutN_3; 0)
		ARRAY LONGINT:C221(tl_FluxOutN_4; 0)
		
		
		ARRAY LONGINT:C221(tl_FluxLast_1; 0)
		ARRAY LONGINT:C221(tl_FluxLast_2; 0)
		ARRAY LONGINT:C221(tl_FluxLast_3; 0)
		ARRAY LONGINT:C221(tl_FluxLast_4; 0)
		
		ARRAY LONGINT:C221(tl_FluxLastP_1; 0)
		ARRAY LONGINT:C221(tl_FluxLastP_2; 0)
		ARRAY LONGINT:C221(tl_FluxLastP_3; 0)
		ARRAY LONGINT:C221(tl_FluxLastP_4; 0)
		
	: ($1=5)
		// i_Message ("RAZ…")
		
		C_BOOLEAN:C305($B_Dummy)
		$B_Dummy:=P_FluxEnCours(2)
		
		// i_MessageSeul ("Recherche…")
		
		
		If (Application type:C494#4D Server:K5:6)
			D_Date:=[DiaLogues:3]DL_Date:2
			D_Date2:=[DiaLogues:3]DL_Date2:8
		End if 
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=D_Date; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=D_Date2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		
		MultiSoc_Filter(->[HeberGement:5])
		
		//Centre 9/5/2012
		
		C_LONGINT:C283($vl_Fiches)
		$vl_Fiches:=Records in selection:C76([HeberGement:5])
		If ($vl_Fiches>0)
			P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_xCentre; ->te_xCentre)
		End if 
		$vl_Fiches:=Records in selection:C76([HeberGement:5])
		
		
		//i_MessageSeul ("Tri…")
		If ($vl_Fiches>0)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HB_ID:19; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >)
			//FIRST RECORD([HeberGement])
			$vl_RéfHB:=[HeberGement:5]HG_HB_ID:19
			$va_EtCivil:=[HeberGement:5]HG_EtatCivil:20
			$vd_DatePecedente:=[HeberGement:5]HG_Date:4
			$vl_Jours:=0
			$vl_Nuits:=0
			$kk:=0
			$vb_Entree:=False:C215
			$vb_Sortie:=False:C215
			
			
			If (Application type:C494#4D Server:K5:6)
				C_LONGINT:C283($L_ref)
				$L_ref:=4D_Progression_Open("")
				
			End if 
			Repeat 
				
				$kk:=$kk+1
				// i_MessageSeul ("Calcul : "+String($vl_Fiches)+"/"+String($kk))
				
				If (Application type:C494#4D Server:K5:6)
					If ((($kk%30)=0))
						
						// la propriete STOP
						// on ne la met pas ou on met -1
						// 1 l'utilisateur a cliqué STOP
						// 2 est la valeur au demarrage
						
						C_OBJECT:C1216($O_Progression)
						OB SET:C1220($O_Progression; \
							"progress ref"; $L_ref; \
							"progress titel"; "Supervision des flux"; \
							"progress message"; "Calcul... "+String:C10($kk)+"/"+String:C10($vl_Fiches); \
							"progress compteur"; $kk; \
							"progress max"; $vl_Fiches; \
							"progress stop"; -1\
							)
						4D_Progression_Send(->$O_Progression)
					End if 
				End if 
				
				
				
				$vb_Entree:=False:C215
				$vb_Sortie:=False:C215
				
				If ($vl_RéfHB=[HeberGement:5]HG_HB_ID:19)
					$vl_Nuits:=$vl_Nuits+1
				Else 
					$vl_Nuits:=1
				End if 
				
				
				Case of 
					: ([HeberGement:5]HG_Date:4=D_Date) & ([HeberGement:5]HG_NuitenCours:92=1)
						$vb_Entree:=True:C214
						$vl_Jours:=1
					: ([HeberGement:5]HG_Date:4=D_Date)
						$vb_Entree:=True:C214
						$vl_Jours:=1
					: ([HeberGement:5]HG_NuitenCours:92=1) & ($vl_RéfHB=[HeberGement:5]HG_HB_ID:19) & (Add to date:C393($vd_DatePecedente; 0; 0; 1)<[HeberGement:5]HG_Date:4)
						$vb_Entree:=True:C214
						$vl_Jours:=1
						$vd_DatePecedente:=[HeberGement:5]HG_Date:4
						
					: ([HeberGement:5]HG_NuitenCours:92=1) & ($vl_RéfHB#[HeberGement:5]HG_HB_ID:19)
						$vb_Entree:=True:C214
						$vl_Jours:=1
					Else 
						$vl_Jours:=$vl_Jours+1
				End case 
				
				If ($vl_RéfHB=[HeberGement:5]HG_HB_ID:19)
				Else 
					$vl_Jours:=1
					$vl_RéfHB:=[HeberGement:5]HG_HB_ID:19
					$va_EtCivil:=[HeberGement:5]HG_EtatCivil:20
				End if 
				
				
				
				If ([HeberGement:5]HG_NuitenCours:92=[HeberGement:5]HG_NuitTOTAL:93)
					If (End selection:C36([HeberGement:5]))
						$vb_Sortie:=True:C214
					Else 
						NEXT RECORD:C51([HeberGement:5])
						If (Add to date:C393($vd_DatePecedente; 0; 0; 1)=[HeberGement:5]HG_Date:4)
						Else 
							$vb_Sortie:=True:C214
						End if 
						PREVIOUS RECORD:C110([HeberGement:5])
					End if 
				End if 
				
				
				$vd_DatePecedente:=[HeberGement:5]HG_Date:4
				
				$va_EtCv:=""
				$vl_Position1:=Position:C15("("; $va_EtCivil)
				If ($vl_Position1>0)
					$vl_Position1:=$vl_Position1+1
					$va_EtCv:=Substring:C12($va_EtCivil; $vl_Position1; 2)
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
				
				C_LONGINT:C283($Pos)
				If ($vl_TrancheLigne>0)
					
					//1 er jour
					If ([HeberGement:5]HG_Date:4=D_Date)  //••• LE PREMIER JOUR  •••
						
						tl_FluxFirst{$vl_TrancheLigne}:=tl_FluxFirst{$vl_TrancheLigne}+1
						
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxFirst_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxFirst_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxFirst_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxFirst_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxFirst_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Size of array:C274($P_Flux->)+1
						INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
						$P_Flux->{$Pos}:=[HeberGement:5]HG_ReferenceID:1
						
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxFirstP_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxFirstP_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxFirstP_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxFirstP_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxFirstP_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Find in array:C230($P_Flux->; [HeberGement:5]HG_HB_ID:19)
						If ($Pos<=0)
							$Pos:=Size of array:C274($P_Flux->)+1
							INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
							$P_Flux->{$Pos}:=[HeberGement:5]HG_HB_ID:19
						End if 
						
					End if 
					
					
					If ($vb_Entree)  //••• LES ENTREES  •••
						
						//••Nombre      
						tl_FluxIn{$vl_TrancheLigne}:=tl_FluxIn{$vl_TrancheLigne}+1
						
						//••Lien de la fiche
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxIn_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxIn_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxIn_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxIn_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxIn_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Size of array:C274($P_Flux->)+1
						INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
						$P_Flux->{$Pos}:=[HeberGement:5]HG_ReferenceID:1
						
						
						//••Lien de la personne unique
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxInP_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxInP_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxInP_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxInP_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxInP_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Find in array:C230($P_Flux->; [HeberGement:5]HG_HB_ID:19)
						If ($Pos<=0)
							$Pos:=Size of array:C274($P_Flux->)+1
							INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
							$P_Flux->{$Pos}:=[HeberGement:5]HG_HB_ID:19
						End if 
					End if 
					
					
					If ($vb_Sortie)  //••• LES SORTIES  •••
						
						//••Nombre                  
						tl_FluxOut{$vl_TrancheLigne}:=tl_FluxOut{$vl_TrancheLigne}+1
						
						//••Lien de la fiche
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxOut_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxOut_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxOut_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxOut_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxOut_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Size of array:C274($P_Flux->)+1
						INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
						$P_Flux->{$Pos}:=[HeberGement:5]HG_ReferenceID:1
						
						
						//••Le total des nuitées
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxOutN_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxOutN_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxOutN_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxOutN_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxOutN_4
							Else 
								TRACE:C157
						End case 
						If (Size of array:C274($P_Flux->)=0)
							INSERT IN ARRAY:C227($P_Flux->; 1; 1)
						End if 
						$P_Flux->{1}:=$P_Flux->{1}+$vl_Nuits
						$vl_Nuits:=0
						
						
						//••Lien de la personne unique
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxOutP_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxOutP_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxOutP_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxOutP_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxOutP_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Find in array:C230($P_Flux->; [HeberGement:5]HG_HB_ID:19)
						If ($Pos<=0)
							$Pos:=Size of array:C274($P_Flux->)+1
							INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
							$P_Flux->{$Pos}:=[HeberGement:5]HG_HB_ID:19
						End if 
					End if 
					
					
					If ([HeberGement:5]HG_Date:4=D_Date2)  //••• LE DERNIER JOUR  •••
						
						//••Nombre            
						tl_FluxLast{$vl_TrancheLigne}:=tl_FluxLast{$vl_TrancheLigne}+1
						
						//••Lien de la fiche
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxLast_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxLast_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxLast_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxLast_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxLast_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Size of array:C274($P_Flux->)+1
						INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
						$P_Flux->{$Pos}:=[HeberGement:5]HG_ReferenceID:1
						
						
						//••Lien de la personne unique
						// remplacement get pointer 17/2/17
						// $P_Flux:=Get pointer("tl_FluxLastP_"+String($vl_TrancheLigne))
						Case of 
							: ($vl_TrancheLigne=1)
								$P_Flux:=->tl_FluxLastP_1
							: ($vl_TrancheLigne=2)
								$P_Flux:=->tl_FluxLastP_2
							: ($vl_TrancheLigne=3)
								$P_Flux:=->tl_FluxLastP_3
							: ($vl_TrancheLigne=4)
								$P_Flux:=->tl_FluxLastP_4
							Else 
								TRACE:C157
						End case 
						$Pos:=Find in array:C230($P_Flux->; [HeberGement:5]HG_HB_ID:19)
						If ($Pos<=0)
							$Pos:=Size of array:C274($P_Flux->)+1
							INSERT IN ARRAY:C227($P_Flux->; $Pos; 1)
							$P_Flux->{$Pos}:=[HeberGement:5]HG_HB_ID:19
						End if 
						
					End if 
				End if   //FIN  Si ($vl_TrancheLigne>0)
				
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
			
			If (Application type:C494#4D Server:K5:6)
				4D_Progression_Close($L_ref)
			End if 
			
			tl_FluxFirstP{1}:=Size of array:C274(tl_FluxFirstP_1)
			tl_FluxFirstP{2}:=Size of array:C274(tl_FluxFirstP_2)
			tl_FluxFirstP{3}:=Size of array:C274(tl_FluxFirstP_3)
			tl_FluxFirstP{4}:=Size of array:C274(tl_FluxFirstP_4)
			
			tl_FluxInP{1}:=Size of array:C274(tl_FluxInP_1)
			tl_FluxInP{2}:=Size of array:C274(tl_FluxInP_2)
			tl_FluxInP{3}:=Size of array:C274(tl_FluxInP_3)
			tl_FluxInP{4}:=Size of array:C274(tl_FluxInP_3)
			
			tl_FluxOutP{1}:=Size of array:C274(tl_FluxOutP_1)
			tl_FluxOutP{2}:=Size of array:C274(tl_FluxOutP_2)
			tl_FluxOutP{3}:=Size of array:C274(tl_FluxOutP_3)
			tl_FluxOutP{4}:=Size of array:C274(tl_FluxOutP_4)
			
			If (Size of array:C274(tl_FluxOutN_1)>0)
				tl_FluxOutN{1}:=tl_FluxOutN_1{1}
			End if 
			If (Size of array:C274(tl_FluxOutN_2)>0)
				tl_FluxOutN{2}:=tl_FluxOutN_2{1}
			End if 
			If (Size of array:C274(tl_FluxOutN_3)>0)
				tl_FluxOutN{3}:=tl_FluxOutN_3{1}
			End if 
			If (Size of array:C274(tl_FluxOutN_4)>0)
				tl_FluxOutN{4}:=tl_FluxOutN_4{1}
			End if 
			
			
			tl_FluxLastP{1}:=Size of array:C274(tl_FluxLastP_1)
			tl_FluxLastP{2}:=Size of array:C274(tl_FluxLastP_2)
			tl_FluxLastP{3}:=Size of array:C274(tl_FluxLastP_3)
			tl_FluxLastP{4}:=Size of array:C274(tl_FluxLastP_4)
			
			
			For ($jj; 1; vl_TrancheLigneEtatCivil)
				vl_FluxFirst:=vl_FluxFirst+tl_FluxFirst{$jj}
				vl_FluxFirstP:=vl_FluxFirstP+tl_FluxFirstP{$jj}
				
				vl_FluxIn:=vl_FluxIn+tl_FluxIn{$jj}
				vl_FluxInP:=vl_FluxInP+tl_FluxInP{$jj}
				
				vl_FluxOut:=vl_FluxOut+tl_FluxOut{$jj}
				vl_FluxOutP:=vl_FluxOutP+tl_FluxOutP{$jj}
				vl_FluxOutN:=vl_FluxOutN+tl_FluxOutN{$jj}
				
				vl_FluxLast:=vl_FluxLast+tl_FluxLast{$jj}
				vl_FluxLastP:=vl_FluxLastP+tl_FluxLastP{$jj}
				
			End for 
			
			REDUCE SELECTION:C351([HeberGement:5]; 0)
			
			
		End if 
		//CLOSE WINDOW
		
End case 