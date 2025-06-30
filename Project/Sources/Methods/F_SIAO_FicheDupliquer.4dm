//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Fonction : F_SIAO_FicheDupliquer
//{
//{          Lundi 28 février 2011 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
$0:=True:C214

C_LONGINT:C283($ii; $jj; $vl_Ref_SIAO; $vl_Ref_PERS; $vl_Ref_PERSOLD)
C_LONGINT:C283($vl_RefNo_PERS; $vl_RefNo_ADR; $vl_RefNo_SIT)
ARRAY LONGINT:C221($tl_Ref_PERS; 0)
ARRAY LONGINT:C221($tl_Ref_SIT; 0)

i_Message("Duplication en cours…")


If ($2=1)
	[SIAO:50]Si_Fermeture:46:=Current date:C33
	SAVE RECORD:C53([SIAO:50])
End if 

DUPLICATE RECORD:C225([SIAO:50])
[SIAO:50]Si_RéférenceID:1:=Uut_Numerote(->[SIAO:50])
$vl_Ref_SIAO:=[SIAO:50]Si_RéférenceID:1
[SIAO:50]Si_Demande_Date:2:=Current date:C33
[SIAO:50]Si_Demande_Numero:3:=F_Site(<>va_T_Site)+F_SIAO_Numero([SIAO:50]Si_Demande_Date:2)
[SIAO:50]Si_Fermeture:46:=!00-00-00!

[SIAO:50]Si_DemandeAnnulee:29:=False:C215
[SIAO:50]Si_DemandeAnnulee_Date:30:=!00-00-00!
[SIAO:50]Si_DemandeAnnulee_Heure:31:=?00:00:00?
[SIAO:50]Si_DemandeAnnulee_Par:32:=""

[SIAO:50]Si_Etat_Type:41:=""
[SIAO:50]Si_Etat_Date:42:=!00-00-00!

[SIAO:50]Si_Demande_fichecreeepar:6:=Current user:C182


SAVE RECORD:C53([SIAO:50])


QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=$1)
MultiSoc_Filter(->[SIAO_Personnes:51])
If (Records in selection:C76([SIAO_Personnes:51])>0)
	SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_RéférenceID:1; $tl_Ref_PERS)
	READ WRITE:C146([SIAO_Personnes:51])
	READ WRITE:C146([Adresses:53])
	READ WRITE:C146([SIAO_Situations:52])
	//•1 - Personnes
	$vl_RefNo_PERS:=Uut_NumerotePlus(->[SIAO_Personnes:51]; Size of array:C274($tl_Ref_PERS))
	For ($ii; 1; Size of array:C274($tl_Ref_PERS))
		//•1A - Personnes
		
		i_MessageSeul("Duplication en cours : "+String:C10($ii)+"/"+String:C10(Size of array:C274($tl_Ref_PERS)))
		
		
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_RéférenceID:1=$tl_Ref_PERS{$ii})
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])=1)
			
			Repeat 
				LOAD RECORD:C52([SIAO_Personnes:51])
			Until (Not:C34(Locked:C147([SIAO_Personnes:51])))
			DUPLICATE RECORD:C225([SIAO_Personnes:51])
			$vl_Ref_PERSOLD:=[SIAO_Personnes:51]Sp_RéférenceID:1
			[SIAO_Personnes:51]Sp_RéférenceID:1:=$vl_RefNo_PERS
			$vl_RefNo_PERS:=$vl_RefNo_PERS+1
			$vl_Ref_PERS:=[SIAO_Personnes:51]Sp_RéférenceID:1
			[SIAO_Personnes:51]Sp_SIAO_ID:2:=$vl_Ref_SIAO
			SAVE RECORD:C53([SIAO_Personnes:51])
			UNLOAD RECORD:C212([SIAO_Personnes:51])
			
			
			//•2 - ADRESSE
			$vl_RefNo_ADR:=Uut_NumerotePlus(->[Adresses:53]; 2)
			
			//•2A - ADRESSE :   HEB
			QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=$1; *)
			MultiSoc_Filter(->[Adresses:53])
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_SIAO_Personne_ID:4=$vl_Ref_PERSOLD; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5="HEB")
			MultiSoc_Filter(->[Adresses:53])
			If (Records in selection:C76([Adresses:53])=1)
				Repeat 
					LOAD RECORD:C52([Adresses:53])
				Until (Not:C34(Locked:C147([Adresses:53])))
				DUPLICATE RECORD:C225([Adresses:53])
				[Adresses:53]AD_RéférenceID:1:=$vl_RefNo_ADR
				$vl_RefNo_ADR:=$vl_RefNo_ADR+1
				[Adresses:53]AD_SIAO_ID:3:=$vl_Ref_SIAO
				[Adresses:53]AD_SIAO_Personne_ID:4:=$vl_Ref_PERS
				SAVE RECORD:C53([Adresses:53])
				UNLOAD RECORD:C212([Adresses:53])
			End if 
			
			//•2B - ADRESSE :   DOM
			QUERY:C277([Adresses:53]; [Adresses:53]AD_SIAO_ID:3=$1; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_SIAO_Personne_ID:4=$vl_Ref_PERSOLD; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_Categorie:5="DOM")
			MultiSoc_Filter(->[Adresses:53])
			If (Records in selection:C76([Adresses:53])=1)
				Repeat 
					LOAD RECORD:C52([Adresses:53])
				Until (Not:C34(Locked:C147([Adresses:53])))
				DUPLICATE RECORD:C225([Adresses:53])
				[Adresses:53]AD_RéférenceID:1:=$vl_RefNo_ADR
				[Adresses:53]AD_SIAO_ID:3:=$vl_Ref_SIAO
				[Adresses:53]AD_SIAO_Personne_ID:4:=$vl_Ref_PERS
				SAVE RECORD:C53([Adresses:53])
				UNLOAD RECORD:C212([Adresses:53])
			End if 
			
			//•3 - SITUATIONS
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=$vl_Ref_PERSOLD)
			MultiSoc_Filter(->[SIAO_Situations:52])
			If (Records in selection:C76([SIAO_Situations:52])>0)
				SELECTION TO ARRAY:C260([SIAO_Situations:52]Ss_RéférenceID:1; $tl_Ref_SIT)
				$vl_RefNo_SIT:=Uut_NumerotePlus(->[SIAO_Situations:52]; Size of array:C274($tl_Ref_SIT))
				For ($jj; 1; Size of array:C274($tl_Ref_SIT))
					i_MessageSeul("Duplication en cours : "+String:C10($ii)+"/"+String:C10(Size of array:C274($tl_Ref_PERS))+" - situations : "+String:C10($jj)+"/"+String:C10(Size of array:C274($tl_Ref_SIT)))
					
					QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_RéférenceID:1=$tl_Ref_SIT{$jj})
					MultiSoc_Filter(->[SIAO_Situations:52])
					If (Records in selection:C76([SIAO_Situations:52])=1)
						Repeat 
							LOAD RECORD:C52([SIAO_Situations:52])
						Until (Not:C34(Locked:C147([SIAO_Situations:52])))
						DUPLICATE RECORD:C225([SIAO_Situations:52])
						[SIAO_Situations:52]Ss_SIAO_ID:2:=$vl_RefNo_SIT
						$vl_RefNo_SIT:=$vl_RefNo_SIT+1
						[SIAO_Situations:52]Ss_SIAO_ID:2:=$vl_Ref_SIAO
						[SIAO_Situations:52]Ss_SIAO_Personne_ID:3:=$vl_Ref_PERS
						SAVE RECORD:C53([SIAO_Situations:52])
						UNLOAD RECORD:C212([SIAO_Situations:52])
						
					End if 
				End for 
			End if 
		End if 
	End for 
	
	
	UNLOAD RECORD:C212([SIAO_Personnes:51])
	UNLOAD RECORD:C212([Adresses:53])
	UNLOAD RECORD:C212([SIAO_Situations:52])
	READ ONLY:C145([SIAO_Personnes:51])
	READ ONLY:C145([Adresses:53])
	READ ONLY:C145([SIAO_Situations:52])
	
End if 

CLOSE WINDOW:C154