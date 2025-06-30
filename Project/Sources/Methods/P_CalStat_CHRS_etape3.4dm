//%attributes = {"executedOnServer":true}
// Method P_CalStat_CHRS_etape3  
C_POINTER:C301($1)

C_LONGINT:C283($kk; $pipi; $pos; $oo; $pos_el)
C_BOOLEAN:C305($vb_OK; $ajouter_b)
C_POINTER:C301($P_Objet)
C_OBJECT:C1216($O_Objet)

$P_Objet:=$1
$O_Objet:=OB Copy:C1225($P_Objet->)

MultiSoc_Init_On_Server(Count parameters:C259; $2)

ARRAY TEXT:C222(<>ta_TBEtCiv; 0)

ARRAY TEXT:C222(ta_ET_EtcivGroupe; 0)
ARRAY TEXT:C222(ta_ET_EtcivLienGroupe; 0)
ARRAY TEXT:C222(ta_ET_EtcivLienOrigine; 0)

ARRAY TEXT:C222(ta_LC_Centre; 0)
ARRAY TEXT:C222(ta_LC_CentreLien; 0)
ARRAY TEXT:C222(ta_LC_Presta; 0)
ARRAY TEXT:C222(ta_LC_PrestaLien; 0)

ARRAY TEXT:C222(ta_xGroupe; 0)
ARRAY TEXT:C222(ta_xTBPIdté; 0)
ARRAY TEXT:C222(ta_xTBSglt; 0)

ARRAY INTEGER:C220(te_xGroupe; 0)

ARRAY LONGINT:C221(tl_ET_Dem; 0)
ARRAY LONGINT:C221(tl_ET_Dis; 0)
ARRAY LONGINT:C221(tl_LC_Centre; 0)
ARRAY LONGINT:C221(tl_LC_CentreLien; 0)
ARRAY LONGINT:C221(tl_LC_Presta; 0)
ARRAY LONGINT:C221(tl_LC_PrestaLien; 0)
ARRAY LONGINT:C221(tl_LC_PrestaNb; 0)
ARRAY LONGINT:C221(tl_LC_Total; 0)
ARRAY LONGINT:C221(tl_xNbIdtéJ; 0)
ARRAY LONGINT:C221(tl_xNbIdtéJC; 0)
ARRAY LONGINT:C221(tl_xNbIdtéN; 0)
ARRAY LONGINT:C221(tl_xNbIdtéT; 0)
ARRAY LONGINT:C221(tl_xNbSgltJ; 0)
ARRAY LONGINT:C221(tl_xNbSgltJC; 0)
ARRAY LONGINT:C221(tl_xNbSgltN; 0)
ARRAY LONGINT:C221(tl_xNbSgltT; 0)

<>vb_StopEven:=OB Get:C1224($O_Objet; "<>vb_StopEven"; Est un booléen:K8:9)

E_HG_Presta:=OB Get:C1224($O_Objet; "E_HG_Presta"; Est un numérique:K8:4)

vb_CentreRegroupé:=OB Get:C1224($O_Objet; "vb_CentreRegroupé"; Est un booléen:K8:9)
vb_EtCivRegroupé:=OB Get:C1224($O_Objet; "vb_EtCivRegroupé"; Est un booléen:K8:9)
vb_PrestaRegroupé:=OB Get:C1224($O_Objet; "vb_PrestaRegroupé"; Est un booléen:K8:9)

vd_Date1:=OB Get:C1224($O_Objet; "vd_Date1"; Est une date:K8:7)

// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
vd_Date2:=OB Get:C1224($O_Objet; "vd_Date2"; Est une date:K8:7)

vl_ET_Dem:=OB Get:C1224($O_Objet; "vl_ET_Dem"; Est un entier long:K8:6)
vl_ET_Dis:=OB Get:C1224($O_Objet; "vl_ET_Dis"; Est un entier long:K8:6)

vl_HG_Appels:=OB Get:C1224($O_Objet; "vl_HG_Appels"; Est un entier long:K8:6)
vl_HG_AppelsJour:=OB Get:C1224($O_Objet; "vl_HG_AppelsJour"; Est un entier long:K8:6)
vl_HG_AppelsJourClo:=OB Get:C1224($O_Objet; "vl_HG_AppelsJourClo"; Est un entier long:K8:6)

vl_LC_PrestaNb:=OB Get:C1224($O_Objet; "vl_LC_PrestaNb"; Est un entier long:K8:6)
vl_LC_Total:=OB Get:C1224($O_Objet; "vl_LC_Total"; Est un entier long:K8:6)

vl_Tab1:=OB Get:C1224($O_Objet; "vl_Tab1"; Est un entier long:K8:6)
vl_Tab2:=OB Get:C1224($O_Objet; "vl_Tab2"; Est un entier long:K8:6)
vl_Tab3:=OB Get:C1224($O_Objet; "vl_Tab3"; Est un entier long:K8:6)
vl_Tab4:=OB Get:C1224($O_Objet; "vl_Tab4"; Est un entier long:K8:6)
vl_Tab5:=OB Get:C1224($O_Objet; "vl_Tab5"; Est un entier long:K8:6)

vl_xNbIdtéJ:=OB Get:C1224($O_Objet; "vl_xNbIdtéJ"; Est un entier long:K8:6)
vl_xNbIdtéJC:=OB Get:C1224($O_Objet; "vl_xNbIdtéJC"; Est un entier long:K8:6)
vl_xNbIdtéN:=OB Get:C1224($O_Objet; "vl_xNbIdtéN"; Est un entier long:K8:6)
vl_xNbIdtéT:=OB Get:C1224($O_Objet; "vl_xNbIdtéT"; Est un entier long:K8:6)
vl_xNbSgltJ:=OB Get:C1224($O_Objet; "vl_xNbSgltJ"; Est un entier long:K8:6)
vl_xNbSgltJC:=OB Get:C1224($O_Objet; "vl_xNbSgltJC"; Est un entier long:K8:6)
vl_xNbSgltN:=OB Get:C1224($O_Objet; "vl_xNbSgltN"; Est un entier long:K8:6)
vl_xNbSgltT:=OB Get:C1224($O_Objet; "vl_xNbSgltT"; Est un entier long:K8:6)

OB GET ARRAY:C1229($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)

OB GET ARRAY:C1229($O_Objet; "ta_ET_EtcivGroupe"; ta_ET_EtcivGroupe)
OB GET ARRAY:C1229($O_Objet; "ta_ET_EtcivLienGroupe"; ta_ET_EtcivLienGroupe)
OB GET ARRAY:C1229($O_Objet; "ta_ET_EtcivLienOrigine"; ta_ET_EtcivLienOrigine)

OB GET ARRAY:C1229($O_Objet; "ta_LC_Centre"; ta_LC_Centre)
OB GET ARRAY:C1229($O_Objet; "ta_LC_CentreLien"; ta_LC_CentreLien)
OB GET ARRAY:C1229($O_Objet; "ta_LC_Presta"; ta_LC_Presta)
OB GET ARRAY:C1229($O_Objet; "ta_LC_PrestaLien"; ta_LC_PrestaLien)

OB GET ARRAY:C1229($O_Objet; "ta_xGroupe"; ta_xGroupe)
OB GET ARRAY:C1229($O_Objet; "ta_xTBPIdté"; ta_xTBPIdté)
OB GET ARRAY:C1229($O_Objet; "ta_xTBSglt"; ta_xTBSglt)
OB GET ARRAY:C1229($O_Objet; "te_xGroupe"; te_xGroupe)

OB GET ARRAY:C1229($O_Objet; "tl_ET_Dem"; tl_ET_Dem)
OB GET ARRAY:C1229($O_Objet; "tl_ET_Dis"; tl_ET_Dis)

OB GET ARRAY:C1229($O_Objet; "tl_LC_Centre"; tl_LC_Centre)
OB GET ARRAY:C1229($O_Objet; "tl_LC_CentreLien"; tl_LC_CentreLien)
OB GET ARRAY:C1229($O_Objet; "tl_LC_Presta"; tl_LC_Presta)
OB GET ARRAY:C1229($O_Objet; "tl_LC_PrestaLien"; tl_LC_PrestaLien)
OB GET ARRAY:C1229($O_Objet; "tl_LC_PrestaNb"; tl_LC_PrestaNb)
OB GET ARRAY:C1229($O_Objet; "tl_LC_Total"; tl_LC_Total)

OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéJ"; tl_xNbIdtéJ)
OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéJC"; tl_xNbIdtéJC)
OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéN"; tl_xNbIdtéN)
OB GET ARRAY:C1229($O_Objet; "tl_xNbIdtéT"; tl_xNbIdtéT)
OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltJ"; tl_xNbSgltJ)
OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltJC"; tl_xNbSgltJC)
OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltN"; tl_xNbSgltN)
OB GET ARRAY:C1229($O_Objet; "tl_xNbSgltT"; tl_xNbSgltT)

If (<>vb_StopEven=False:C215)
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HG_Total")
	CREATE EMPTY SET:C140([HeberGement:5]; "E_HG_Jour")
	
	// La date
	// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
	If (vd_Date1>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1)
		
		If (vd_Date2>!00-00-00!)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date2)
		End if 
		
	End if 
	
	If (vd_Date1=!00-00-00!) & (vd_Date2>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date2)
	End if 
	
	// Modifié par : Scanu Rémy (05/10/2023)
	If (Bool:C1537($O_Objet.avecInconnu)=False:C215)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nom:21#"X0@"; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21#"Z0@")
	End if 
	
	Case of 
		: (Bool:C1537($O_Objet.hebergement)=True:C214) & (Bool:C1537($O_Objet.prestation)=True:C214)
		: (Bool:C1537($O_Objet.hebergement)=True:C214) & (Bool:C1537($O_Objet.prestation)=False:C215)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
		: (Bool:C1537($O_Objet.hebergement)=False:C215) & (Bool:C1537($O_Objet.prestation)=True:C214)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
	End case 
	
	//CHERCHER([HeberGement];[HeberGement]HG_Date=vd_Date1)
	MultiSoc_Filter(->[HeberGement:5])
	
	vl_HG_Appels:=Records in selection:C76([HeberGement:5])
	
	If (vl_HG_Appels>0)
		CREATE SET:C116([HeberGement:5]; "E_HG_Total")
	End if 
	
	// La journée
	// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
	If (vd_Date1>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1)
		
		If (vd_Date2>!00-00-00!)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date2)
		End if 
		
	End if 
	
	If (vd_Date1=!00-00-00!) & (vd_Date2>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date2)
	End if 
	
	//CHERCHER([HeberGement];[HeberGement]HG_Date=vd_Date1;*)
	//CHERCHER([HeberGement]; & ;[HeberGement]HG_Nuit=Faux)
	
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
	MultiSoc_Filter(->[HeberGement:5])
	
	vl_HG_AppelsJour:=Records in selection:C76([HeberGement:5])
	
	If (vl_HG_AppelsJour>0)
		CREATE SET:C116([HeberGement:5]; "E_HG_Jour")
	End if 
	
	// La journée clôturée
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214)
	vl_HG_AppelsJourClo:=Records in selection:C76([HeberGement:5])
	
	// La nuit ou les prestations
	// Modifié par : Scanu Rémy - remy@connect-io.fr (30/06/2021)
	If (vd_Date1>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_Date1)
		
		If (vd_Date2>!00-00-00!)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date2)
		End if 
		
	End if 
	
	If (vd_Date1=!00-00-00!) & (vd_Date2>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4<=vd_Date2)
	End if 
	
	//CHERCHER([HeberGement];[HeberGement]HG_Date=vd_Date1;*)
	//CHERCHER([HeberGement]; & ;[HeberGement]HG_Nuit=Vrai)
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
	MultiSoc_Filter(->[HeberGement:5])
	
	E_HG_Presta:=Records in selection:C76([HeberGement:5])
	
	USE SET:C118("E_HG_Total")
	
	If (Size of array:C274(ta_xGroupe)>0)
		
		For ($kk; 1; Size of array:C274(ta_xGroupe))
			
			If (te_xGroupe{$kk}=1)
				$oo:=$oo+1
			End if 
			
		End for 
		
		Case of 
			: ($oo=0)
			: ($oo>=Size of array:C274(ta_xGroupe))
			: ($oo<Size of array:C274(ta_xGroupe))
				$vb_OK:=True:C214
				
				If (Records in selection:C76([HeberGement:5])>0)
					
					For ($kk; 1; Size of array:C274(ta_xGroupe))
						
						If (te_xGroupe{$kk}=1)
							
							If ($pipi=0)
								$pipi:=1
								
								If (ta_xGroupe{$kk}="115")
									QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102=""; *)
									QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102="115"; *)
								Else 
									QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102=ta_xGroupe{$kk}; *)
								End if 
								
							Else 
								
								If (ta_xGroupe{$kk}="115")
									QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102=""; *)
									QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102="115"; *)
								Else 
									QUERY SELECTION:C341([HeberGement:5];  | ; [HeberGement:5]HG_FamGroupe:102=ta_xGroupe{$kk}; *)
								End if 
								
							End if 
							
						End if 
						
					End for 
					
					QUERY SELECTION:C341([HeberGement:5])
					MultiSoc_Filter(->[HeberGement:5])
				End if 
				
				CREATE SET:C116([HeberGement:5]; "E_HG_Total")
		End case 
		
	End if 
	
End if 

If (<>vb_StopEven=False:C215)
	USE SET:C118("E_HG_Total")
	
	If (Records in selection:C76([HeberGement:5])>0)
		FIRST RECORD:C50([HeberGement:5])
		
		Repeat 
			
			If (vl_Tab1>0)  //Etat cicil
				
				If ([HeberGement:5]HG_Nuit:2=True:C214)
					$vb_OK:=True:C214
				Else 
					$vb_OK:=F_Calc_CHRS("BonCentre")
				End if 
				
				If ($vb_OK)
					
					If (vb_EtCivRegroupé)
						$pos:=Find in array:C230(ta_ET_EtcivLienOrigine; [HeberGement:5]HG_EtatCivil:20)
						
						If ($pos>0)
							$pos:=Find in array:C230(ta_ET_EtcivGroupe; ta_ET_EtcivLienGroupe{$pos})
						End if 
						
					Else 
						$pos:=Find in array:C230(<>ta_TBEtCiv; [HeberGement:5]HG_EtatCivil:20)
					End if 
					
					If ($Pos>0)
						tl_ET_Dem{$pos}:=tl_ET_Dem{$pos}+1
						vl_ET_Dem:=vl_ET_Dem+1
						
						If ([HeberGement:5]HG_Cloturée:67=True:C214)
							tl_ET_Dis{$pos}:=tl_ET_Dis{$pos}+1
							vl_ET_Dis:=vl_ET_Dis+1
						End if 
						
					End if 
					
				End if 
				
				//Fin de si 
				
			End if 
			
			If (vl_Tab2>0)  //Hébergements centres
				
				If ([HeberGement:5]HG_Nuit:2=False:C215)
					
					If ([HeberGement:5]HG_Cloturée:67=True:C214)
						
						If (vb_CentreRegroupé)
							$pos:=Find in array:C230(tl_LC_CentreLien; [HeberGement:5]HG_LC_ID:61)
							
							If ($pos>0)
								$pos:=Find in array:C230(ta_LC_Centre; ta_LC_CentreLien{$pos})
							End if 
							
						Else 
							$pos:=Find in array:C230(tl_LC_Centre; [HeberGement:5]HG_LC_ID:61)
						End if 
						
						If ($pos>0)
							
							// Modifié par : Scanu Rémy (27/09/2023) et Re-modifié par : Scanu Rémy (10/10/2023)
							If (vb_CentreRegroupé)
								$ajouter_b:=True:C214
							Else 
								$pos_el:=Find in array:C230(ta_xGroupe; ta_LC_Centre{$pos})
								
								If ($pos_el>0)
									$ajouter_b:=(te_xGroupe{$pos_el}=1)
								End if 
								
							End if 
							
						End if 
						
						If ($ajouter_b=True:C214)
							tl_LC_Total{$pos}:=tl_LC_Total{$pos}+1
							vl_LC_Total:=vl_LC_Total+1
						End if 
						
					End if 
					
				End if 
				
			End if 
			
			If (vl_Tab3>0)  //Prestations
				
				If ([HeberGement:5]HG_Nuit:2=True:C214)
					
					If (vb_PrestaRegroupé)
						$pos:=Find in array:C230(tl_LC_PrestaLien; [HeberGement:5]HG_LC_ID:61)
						
						If ($pos>0)
							$pos:=Find in array:C230(ta_LC_Presta; ta_LC_PrestaLien{$pos})
						End if 
						
					Else 
						$pos:=Find in array:C230(tl_LC_Presta; [HeberGement:5]HG_LC_ID:61)
					End if 
					
					If ($pos>0)
						tl_LC_PrestaNb{$pos}:=tl_LC_PrestaNb{$pos}+1
						vl_LC_PrestaNb:=vl_LC_PrestaNb+1
					End if 
					
				End if 
				
			End if 
			
			If (vl_Tab4>0)  //Signalement
				$pos:=Find in array:C230(ta_xTBSglt; [HeberGement:5]HG_Signalement:12)
				
				If ($Pos>0)
					tl_xNbSgltT{$pos}:=tl_xNbSgltT{$pos}+1
					vl_xNbSgltT:=vl_xNbSgltT+1
					
					If ([HeberGement:5]HG_Nuit:2)
						tl_xNbSgltN{$pos}:=tl_xNbSgltN{$pos}+1
						vl_xNbSgltN:=vl_xNbSgltN+1
					Else 
						tl_xNbSgltJ{$pos}:=tl_xNbSgltJ{$pos}+1
						vl_xNbSgltJ:=vl_xNbSgltJ+1
						
						If ([HeberGement:5]HG_Cloturée:67)
							tl_xNbSgltJC{$pos}:=tl_xNbSgltJC{$pos}+1
							vl_xNbSgltJC:=vl_xNbSgltJC+1
						End if 
						
					End if 
					
				End if 
				
			End if 
			
			If (vl_Tab5>0)  //Pièce d'identité
				$pos:=Find in array:C230(ta_xTBPIdté; [HeberGement:5]HG_PiècesIdté1:31)
				
				If ($Pos>0)
					tl_xNbIdtéT{$pos}:=tl_xNbIdtéT{$pos}+1
					vl_xNbIdtéT:=vl_xNbIdtéT+1
					
					If ([HeberGement:5]HG_Nuit:2)
						tl_xNbIdtéN{$pos}:=tl_xNbIdtéN{$pos}+1
						vl_xNbIdtéN:=vl_xNbIdtéN+1
					Else 
						tl_xNbIdtéJ{$pos}:=tl_xNbIdtéJ{$pos}+1
						vl_xNbIdtéJ:=vl_xNbIdtéJ+1
						
						If ([HeberGement:5]HG_Cloturée:67)
							tl_xNbIdtéJC{$pos}:=tl_xNbIdtéJC{$pos}+1
							vl_xNbIdtéJC:=vl_xNbIdtéJC+1
						End if 
						
					End if 
					
				End if 
				
			End if 
			
			CLEAR VARIABLE:C89($ajouter_b)
			
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]) | (<>vb_StopEven=True:C214))
		
	End if 
	
End if 

OB SET:C1220($O_Objet; "<>vb_StopEven"; <>vb_StopEven)
OB SET:C1220($O_Objet; "E_HG_Presta"; E_HG_Presta)

OB SET:C1220($O_Objet; "vb_CentreRegroupé"; vb_CentreRegroupé)
OB SET:C1220($O_Objet; "vb_EtCivRegroupé"; vb_EtCivRegroupé)
OB SET:C1220($O_Objet; "vb_PrestaRegroupé"; vb_PrestaRegroupé)

OB SET:C1220($O_Objet; "vd_Date1"; vd_Date1)

OB SET:C1220($O_Objet; "vl_ET_Dem"; vl_ET_Dem)
OB SET:C1220($O_Objet; "vl_ET_Dis"; vl_ET_Dis)

OB SET:C1220($O_Objet; "vl_HG_Appels"; vl_HG_Appels)
OB SET:C1220($O_Objet; "vl_HG_AppelsJour"; vl_HG_AppelsJour)
OB SET:C1220($O_Objet; "vl_HG_AppelsJourClo"; vl_HG_AppelsJourClo)

OB SET:C1220($O_Objet; "vl_LC_PrestaNb"; vl_LC_PrestaNb)
OB SET:C1220($O_Objet; "vl_LC_Total"; vl_LC_Total)

OB SET:C1220($O_Objet; "vl_Tab1"; vl_Tab1)
OB SET:C1220($O_Objet; "vl_Tab2"; vl_Tab2)
OB SET:C1220($O_Objet; "vl_Tab3"; vl_Tab3)
OB SET:C1220($O_Objet; "vl_Tab4"; vl_Tab4)
OB SET:C1220($O_Objet; "vl_Tab5"; vl_Tab5)

OB SET:C1220($O_Objet; "vl_xNbIdtéJ"; vl_xNbIdtéJ)
OB SET:C1220($O_Objet; "vl_xNbIdtéJC"; vl_xNbIdtéJC)
OB SET:C1220($O_Objet; "vl_xNbIdtéN"; vl_xNbIdtéN)
OB SET:C1220($O_Objet; "vl_xNbIdtéT"; vl_xNbIdtéT)
OB SET:C1220($O_Objet; "vl_xNbSgltJ"; vl_xNbSgltJ)
OB SET:C1220($O_Objet; "vl_xNbSgltJC"; vl_xNbSgltJC)
OB SET:C1220($O_Objet; "vl_xNbSgltN"; vl_xNbSgltN)
OB SET:C1220($O_Objet; "vl_xNbSgltT"; vl_xNbSgltT)

OB SET ARRAY:C1227($O_Objet; "<>ta_TBEtCiv"; <>ta_TBEtCiv)

OB SET ARRAY:C1227($O_Objet; "ta_ET_EtcivGroupe"; ta_ET_EtcivGroupe)
OB SET ARRAY:C1227($O_Objet; "ta_ET_EtcivLienGroupe"; ta_ET_EtcivLienGroupe)
OB SET ARRAY:C1227($O_Objet; "ta_ET_EtcivLienOrigine"; ta_ET_EtcivLienOrigine)

OB SET ARRAY:C1227($O_Objet; "ta_LC_Centre"; ta_LC_Centre)
OB SET ARRAY:C1227($O_Objet; "ta_LC_CentreLien"; ta_LC_CentreLien)
OB SET ARRAY:C1227($O_Objet; "ta_LC_Presta"; ta_LC_Presta)
OB SET ARRAY:C1227($O_Objet; "ta_LC_PrestaLien"; ta_LC_PrestaLien)

OB SET ARRAY:C1227($O_Objet; "ta_xGroupe"; ta_xGroupe)
OB SET ARRAY:C1227($O_Objet; "ta_xTBPIdté"; ta_xTBPIdté)
OB SET ARRAY:C1227($O_Objet; "ta_xTBSglt"; ta_xTBSglt)

OB SET ARRAY:C1227($O_Objet; "te_xGroupe"; te_xGroupe)

OB SET ARRAY:C1227($O_Objet; "tl_ET_Dem"; tl_ET_Dem)
OB SET ARRAY:C1227($O_Objet; "tl_ET_Dis"; tl_ET_Dis)
OB SET ARRAY:C1227($O_Objet; "tl_LC_Centre"; tl_LC_Centre)
OB SET ARRAY:C1227($O_Objet; "tl_LC_CentreLien"; tl_LC_CentreLien)
OB SET ARRAY:C1227($O_Objet; "tl_LC_Presta"; tl_LC_Presta)
OB SET ARRAY:C1227($O_Objet; "tl_LC_PrestaLien"; tl_LC_PrestaLien)
OB SET ARRAY:C1227($O_Objet; "tl_LC_PrestaNb"; tl_LC_PrestaNb)
OB SET ARRAY:C1227($O_Objet; "tl_LC_Total"; tl_LC_Total)
OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéJ"; tl_xNbIdtéJ)
OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéJC"; tl_xNbIdtéJC)
OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéN"; tl_xNbIdtéN)
OB SET ARRAY:C1227($O_Objet; "tl_xNbIdtéT"; tl_xNbIdtéT)
OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltJ"; tl_xNbSgltJ)
OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltJC"; tl_xNbSgltJC)
OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltN"; tl_xNbSgltN)
OB SET ARRAY:C1227($O_Objet; "tl_xNbSgltT"; tl_xNbSgltT)

$P_Objet->:=OB Copy:C1225($O_Objet)