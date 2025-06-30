//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          P_HébergementMembreAdd b_Gpe
//{
//{          Mardi 9 mars 2004 à 10:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//1 il est SP  : REFUS
//2 il est sélectionné et le groupe est sélectionné`
//3 si le groupe n'est pas le même
//   -   on est le jour et il a déja un groupe de jour
//   -   on est la nuit et il a déja un groupe de nuit
//   -   REFUS
//4 si le groupe nest le même et il est déja dans le groupe 
//   -   on se positionne sur le membre 
//5 Si l'on peut l'affecter à ce groupe
//   -   Comme la résa multiple
//   -   F_HébergementCtrlCréation
//   -   si ok on 
//6 Affecter l'etat civil
C_TEXT:C284($jourNuit_t)
C_LONGINT:C283($vl_Gp_RéfHB; $vl_Gp_RéfGP; $ii; $Pos)
C_BOOLEAN:C305($vb_OK; $vb_Gp_RéfNuit)

outilsHebergeLoadRecord

LOAD RECORD:C52([GrouPe:36])  // #Fix20170424-3
LOAD RECORD:C52([HeBerge:4])  // #Fix20170424-3

$vb_OK:=True:C214

$vl_Gp_RéfHB:=[HeBerge:4]HB_ReferenceID:1
$vl_Gp_RéfGP:=[GrouPe:36]GP_ReferenceID:1
$vb_Gp_RéfNuit:=[GrouPe:36]GP_Nuit:5

If ($vl_Gp_RéfHB>0)
	
	If ($vl_Gp_RéfGP>0)
		
		If (Size of array:C274(<>tl_GpHBID)>0)  // Est-il lié à ce groupe ?
			$Pos:=Find in array:C230(<>tl_GpHBID; $vl_Gp_RéfHB)
			
			If ($Pos>0)
				ALERT:C41("Ce demandeur est déjà lié à ce groupe !")
				P_Tab_GP(1; $Pos)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		If ($vb_OK)
			$vb_OK:=False:C215
			
			If ([HeBerge:4]HB_Status:18)
				ALERT:C41([HeBerge:4]HB_Clé:2+" est Personna non grata !!!")
			Else 
				$vb_OK:=True:C214
				
				Case of 
					: ([GrouPe:36]GP_Famille:6)  // Calcul du Nb membres permis
						
						If (Size of array:C274(<>ta_GpClé)>=<>vl_GpeMaxNbFam)
							ALERT:C41("Le nombre de membres est limité à "+String:C10(<>vl_GpeMaxNbFam)+"  !")
							$vb_OK:=False:C215
						End if 
						
					: (Size of array:C274(<>ta_GpClé)>=<>vl_GpeMaxNbStd)
						ALERT:C41("Le nombre de membres est limité à "+String:C10(<>vl_GpeMaxNbStd)+"  !")
						$vb_OK:=False:C215
				End case 
				
				If ($vb_OK)
					QUERY:C277([GroupeHeberges:37]; [GroupeHeberges:37]GH_HB_Référence:3=$vl_Gp_RéfHB)
					MultiSoc_Filter(->[GroupeHeberges:37])
					
					$vb_OK:=False:C215
					$ii:=Records in selection:C76([GroupeHeberges:37])
					
					Case of 
						: ($ii=0)
							$vb_OK:=True:C214
						: ($ii=1)
							If ([GroupeHeberges:37]GH_GP_Référence:2#$vl_Gp_RéfGP)
								QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=[GroupeHeberges:37]GH_GP_Référence:2)
								MultiSoc_Filter(->[GrouPe:36])
								
								If (Records in selection:C76([GrouPe:36])=1)
									
									If ([GrouPe:36]GP_Nuit:5=$vb_Gp_RéfNuit)
										ALERT:C41([HeBerge:4]HB_Clé:2+" est  déjà rataché à un groupe "+("Nuit"*Num:C11([GrouPe:36]GP_Nuit:5=True:C214))+("Jour"*Num:C11([GrouPe:36]GP_Nuit:5=False:C215))+" !")
									Else 
										$vb_OK:=True:C214
									End if 
									
								End if 
								
							End if 
							
						: ($ii>1)
							ALERT:C41([HeBerge:4]HB_Clé:2+" est rataché à un groupe Jour et un groupe Nuit !")
					End case 
					
				End if 
				
			End if 
			
		End if 
		
		If ($vb_OK)
			QUERY:C277([GrouPe:36]; [GrouPe:36]GP_ReferenceID:1=$vl_Gp_RéfGP)
			MultiSoc_Filter(->[GrouPe:36])
			
			$vb_OK:=False:C215
			
			// Modifié par : Scanu Rémy (30/06/2022)
			$jourNuit_t:=va_JourNuit
			
			If ($jourNuit_t="JN")
				$jourNuit_t:=Choose:C955([GrouPe:36]GP_Nuit:5=True:C214; "N"; "J")
			End if 
			
			If (F_HébergementCtrlCréation($jourNuit_t))
				Tab_PopIn1p("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
				
				If (va_IDT_Typ1>"")
					READ WRITE:C146([GroupeHeberges:37])
					
					CREATE RECORD:C68([GroupeHeberges:37])
					MultiSoc_Init_Structure(->[GroupeHeberges:37])
					[GroupeHeberges:37]GH_ReferenceID:1:=Uut_Numerote(->[GroupeHeberges:37])
					[GroupeHeberges:37]GH_GP_Référence:2:=$vl_Gp_RéfGP
					[GroupeHeberges:37]GH_HB_Référence:3:=$vl_Gp_RéfHB
					[GroupeHeberges:37]GH_HB_Clé:4:=[HeBerge:4]HB_Clé:2
					[GroupeHeberges:37]GH_EtatCivil:5:=va_IDT_Typ1
					[GroupeHeberges:37]GH_Ordre:6:=Size of array:C274(<>ta_GpClé)+1
					
					va_IDT_Typ1:=""
					SAVE RECORD:C53([GroupeHeberges:37])
					
					P_Tab_GP(5; 0)
					UNLOAD RECORD:C212([GroupeHeberges:37])
					READ ONLY:C145([GroupeHeberges:37])
				End if   //Si (va_IDT_Typ1>"")
				
				vL_Nb_GP:=Records in selection:C76([GrouPe:36])
				
				If (vL_Nb_GP>0)
					ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
					FIRST RECORD:C50([GrouPe:36])
					
					POST CLICK:C466(20; 390)
					
					If ([GrouPe:36]GP_ReferenceID:1>0)
						P_Tab_GP(4; 0)
						P_Tab_GP(12; $ii)
					Else 
						P_Tab_GP(0; 0)
					End if 
					
				Else 
					P_Tab_GP(0; 0)
				End if 
				
			End if   //  Si (F_HébergementCtrlCréation (va_JourNuit))    
			
		End if 
		
	Else 
		ALERT:C41("Veuillez sélectionner un groupe !")
	End if 
	
Else 
	ALERT:C41("Veuillez sélectionner un demandeur !")
End if 