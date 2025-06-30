//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergementCtrlGroupe
//{
//{          Vendredi 27 Février 2004 à 16:03
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($0; $vb_Nuit)
C_TEXT:C284($1)
C_LONGINT:C283($2)


vb_PasseR:=True:C214
vl_NbHéberGements:=0
QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=<>tl_GpHBID{$2})
MultiSoc_Filter(->[HeBerge:4])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=<>tl_GpHBID{$2})
MultiSoc_Filter(->[HeberGement:5])
vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
If (vl_NbHéberGements>0)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
	FIRST RECORD:C50([HeberGement:5])
	If ([HeBerge:4]HB_Status:18)
		vb_PasseR:=False:C215
		P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
		
		<>ta_GpEtat{$2}:="Persona non grata"
		<>te_GpEtat{$2}:=-1
		
	Else 
		$vb_Nuit:=($1="N")
		If ([HeberGement:5]HG_Date:4=Current date:C33(*))
			If ([HeberGement:5]HG_Nuit:2=$vb_Nuit)
				StrAlerte(15; "")
				vb_PasseR:=False:C215
				<>ta_GpEtat{$2}:="Déja hébergement de nuit"
				<>te_GpEtat{$2}:=-1
			Else 
				If (i_Confirmer("Attention cette personne a déja une fiche d'hébergement .  "+"Confirmez-vous la création d'une fiche ? "))
					$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
					$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
					If ($kk>0)
						If (i_Confirmer("Attention voir SP !"))
							<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
							vl_IDT_Old:=1
							P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
							<>ta_GpEtat{$2}:="Déja hébergement de jour"
							<>te_GpEtat{$2}:=1
						Else 
							vb_PasseR:=False:C215
							<>ta_GpEtat{$2}:="Déja hébergement de jour"
							<>te_GpEtat{$2}:=1
						End if 
					End if 
				Else 
					vb_PasseR:=False:C215
				End if 
			End if 
		Else 
			$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
			$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
			If ($kk>0)
				If (i_Confirmer("Attention voir SP !"))
					<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
					vl_IDT_Old:=1
					P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
				Else 
					vb_PasseR:=False:C215
				End if 
			End if 
		End if 
	End if 
Else 
	If ([HeBerge:4]HB_Status:18)
		vb_PasseR:=False:C215
		
		<>ta_GpEtat{$2}:="Persona non grata"
		<>te_GpEtat{$2}:=-1
		
	Else 
		$kk:=Num:C11([HeBerge:4]HB_Cas1:7)+Num:C11([HeBerge:4]HB_Cas2:8)+Num:C11([HeBerge:4]HB_Cas3:9)+Num:C11([HeBerge:4]HB_Cas4:10)+Num:C11([HeBerge:4]HB_Cas5:11)
		$kk:=$kk+Num:C11([HeBerge:4]HB_Cas6:12)+Num:C11([HeBerge:4]HB_Cas7:13)+Num:C11([HeBerge:4]HB_Cas8:14)+Num:C11([HeBerge:4]HB_Cas9:15)+Num:C11([HeBerge:4]HB_Cas10:16)
		If ($kk>0)
			If (i_Confirmer("Attention voir SP !"))
				<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
				vl_IDT_Old:=1
				P_VoirStatutSP([HeBerge:4]HB_ReferenceID:1)
				
				<>ta_GpEtat{$2}:="Voir SP"
				<>te_GpEtat{$2}:=1
			Else 
				vb_PasseR:=False:C215
			End if 
		End if 
	End if 
End if 
$0:=vb_PasseR