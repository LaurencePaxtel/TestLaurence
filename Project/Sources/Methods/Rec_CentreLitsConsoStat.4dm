//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure:  Rec_CentreLitsConsoStat
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_DATE:C307($1)
C_BOOLEAN:C305($vb_OK)

CREATE EMPTY SET:C140([HeberGement:5]; "$E_HéberGement")

$vb_OK:=(($1>!00-00-00!) & (Records in selection:C76([CentresLits:16])>0))
If ($vb_OK)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=$1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
	MultiSoc_Filter(->[HeberGement:5])
	CREATE SET:C116([HeberGement:5]; "$E_HéberGement")
	$vb_OK:=(Records in selection:C76([HeberGement:5])>0)
End if 

vl_Et_EF:=0
vl_Et_HS:=0
vl_Et_FS:=0
vl_Et_HC:=0

vl_Et_FF:=0
vl_Et_FMono:=0

If ($vb_OK)
	READ WRITE:C146([CentresLits:16])
	FIRST RECORD:C50([CentresLits:16])
	Repeat 
		[CentresLits:16]CL_NbPersonnes:18:=0
		[CentresLits:16]CL_NbPersonnesNouvelles:19:=0
		[CentresLits:16]CL_NbFamilles:20:=0
		[CentresLits:16]CL_NbAdultes:21:=0
		[CentresLits:16]CL_NbEnfants:22:=0
		USE SET:C118("$E_HéberGement")
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=[CentresLits:16]CL_LC_ID:2)
		$TailleTab:=Records in selection:C76([HeberGement:5])
		If ($TailleTab>0)
			[CentresLits:16]CL_NbPersonnes:18:=$TailleTab
			SELECTION TO ARRAY:C260([HeberGement:5]HG_LC_ID:61; $tl_IDLC; [HeberGement:5]HG_Signalement:12; $ta_Signalement; [HeberGement:5]HG_EtatCivil:20; $ta_EtCv; [HeberGement:5]HG_Age:23; $tl_Age)
			For ($ii; 1; $TailleTab)
				If ($ta_Signalement{$ii}="*Usager premier appel")
					[CentresLits:16]CL_NbPersonnesNouvelles:19:=[CentresLits:16]CL_NbPersonnesNouvelles:19+1
				End if 
				If ($tl_Age{$ii}>=18)
					[CentresLits:16]CL_NbAdultes:21:=[CentresLits:16]CL_NbAdultes:21+1
				Else 
					[CentresLits:16]CL_NbEnfants:22:=[CentresLits:16]CL_NbEnfants:22+1
					vl_Et_EF:=vl_Et_EF+1
				End if 
				If (($ta_EtCv{$ii}="Homme en coup@") | ($ta_EtCv{$ii}="H Famille@") | ($ta_EtCv{$ii}="Homme avec@") | ($ta_EtCv{$ii}="Femme avec@"))
					
					
					[CentresLits:16]CL_NbFamilles:20:=[CentresLits:16]CL_NbFamilles:20+1
				End if 
				//Par civilité regroupées
				Case of 
					: ($ta_EtCv{$ii}="Homme seul@")
						vl_Et_HS:=vl_Et_HS+1
					: ($ta_EtCv{$ii}="Femme seule@")
						vl_Et_FS:=vl_Et_FS+1
					: ($ta_EtCv{$ii}="Homme en coup@")
						vl_Et_HC:=vl_Et_HC+1
					: ($ta_EtCv{$ii}="H Famille@")
						vl_Et_FF:=vl_Et_FF+1
					: (($ta_EtCv{$ii}="Homme avec@") | ($ta_EtCv{$ii}="Femme avec@"))
						vl_Et_FMono:=vl_Et_FMono+1
				End case 
			End for 
		End if 
		SAVE RECORD:C53([CentresLits:16])
		UNLOAD RECORD:C212([CentresLits:16])
		NEXT RECORD:C51([CentresLits:16])
	Until (End selection:C36([CentresLits:16]))
End if 