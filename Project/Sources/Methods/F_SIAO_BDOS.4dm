//%attributes = {}
C_LONGINT:C283($0)
$0:=0
C_TEXT:C284($1)
C_POINTER:C301(${2})
C_TEXT:C284($vt_Texte)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
Case of 
	: ($1="Jours")
		If ($2->>!00-00-00!) & ($2-><=$3->)
			$0:=$3->-$2->+1
		Else 
			$0:=0
		End if 
		
	: ($1="SIAO")
		If ($2=$3)
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2=$2->)
		Else 
			QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2>=$2->; *)
			QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Date:2<=$3->)
		End if 
		MultiSoc_Filter(->[SIAO:50])
		$0:=Records in selection:C76([SIAO:50])
		
	: ($1="Sortants")
		ARRAY LONGINT:C221(tl_LesSorties; 0)
		ARRAY LONGINT:C221(tl_LesSortiesHB; 0)
		If ($2->=$3->)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$2->; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$2->; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$3->; *)
		End if 
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		// CHERCHER([HeberGement]; & ;[HeberGement]HG_NuitTOTAL>1;*)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95=0)
		MultiSoc_Filter(->[HeberGement:5])
		$0:=Records in selection:C76([HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $4->; [HeberGement:5]HG_HB_ID:19; $5->)
			$ii:=1
			Repeat 
				QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=$5->{$ii})
				MultiSoc_Filter(->[SIAO_Personnes:51])
				If (Records in selection:C76([SIAO_Personnes:51])=0)
					DELETE FROM ARRAY:C228($4->; $ii; 1)
					DELETE FROM ARRAY:C228($5->; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
				$vb_OK:=($ii>Size of array:C274($4->))
			Until ($vb_OK)
			
		End if 
		
	: ($1="Entrants")
		ARRAY LONGINT:C221(tl_LesEntrees; 0)
		ARRAY LONGINT:C221(tl_LesEntreesHB; 0)
		If ($2->=$3->)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$2->; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$2->; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$3->; *)
		End if 
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		$0:=Records in selection:C76([HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $4->; [HeberGement:5]HG_HB_ID:19; $5->)
			$ii:=1
			Repeat 
				QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Personne_ID:3=$5->{$ii})
				MultiSoc_Filter(->[SIAO_Personnes:51])
				If (Records in selection:C76([SIAO_Personnes:51])=0)
					DELETE FROM ARRAY:C228($4->; $ii; 1)
					DELETE FROM ARRAY:C228($5->; $ii; 1)
				Else 
					$ii:=$ii+1
				End if 
				$vb_OK:=($ii>Size of array:C274($4->))
			Until ($vb_OK)
			
		End if 
		
		
	: ($1="Confirmer")
		$vt_Texte:=""
		If ($2->>0)
			$vt_Texte:=String:C10($2->; "### ### ##0")+" dossier"+("s"*Num:C11($2->>1))
		End if 
		If ($3->>0)
			If ($vt_Texte>"")
				$vt_Texte:=$vt_Texte+<>va_CR
			End if 
			$vt_Texte:=$vt_Texte+String:C10($3->; "### ### ##0")+" sortant"+("s"*Num:C11($3->>1))
		End if 
		
		If ($4->>0)
			If ($vt_Texte>"")
				$vt_Texte:=$vt_Texte+<>va_CR
			End if 
			$vt_Texte:=$vt_Texte+String:C10($4->; "### ### ##0")+" entrant"+("s"*Num:C11($4->>1))
		End if 
		
		
		$vb_OK:=i_Confirmer("Confirmez-vous l'export BDOS  : "+<>va_CR+$vt_Texte)
		If ($vb_OK)
			$vb_OK:=i_Confirmer("Confirmez-vous l'export BDOS  : "+<>va_CR+$vt_Texte+Char:C90(13)+"Seconde confirmation ?")
		End if 
		$0:=Num:C11($vb_OK)
		
	: ($1="HebergementsE")
		ARRAY LONGINT:C221(tl_LesSorties; 0)
		If ($2->=$3->)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$2->; *)
		Else 
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$2->; *)
			QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$3->; *)
		End if 
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1)
		MultiSoc_Filter(->[HeberGement:5])
		$0:=Records in selection:C76([HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; $4->)
		End if 
End case 