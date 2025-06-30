//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Calc_EtudeS1
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($Position)
C_BOOLEAN:C305($TuCompte)
i_MessageSeul("Calcul en cours …")
If (<>vb_StopEven=False:C215)
	V_Stat_Etude(1)
	vl_NbSig:=0
	vl_NbSex:=0
	vl_NbAge:=0
	vl_NbProv:=0
	vl_Nbné:=0
	vl_Nbnatio:=0
	vl_xGroupe:=0
	CREATE EMPTY SET:C140([HeBerge:4]; "E_HBCompte")
	USE SET:C118("E_encours")
	ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
	FIRST RECORD:C50([HeberGement:5])
	While ((Not:C34(End selection:C36([HeberGement:5]))) & (<>vb_StopEven=False:C215))
		$TuCompte:=False:C215
		RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)
		If (Records in selection:C76([HeBerge:4])=1)
			If (Is in set:C273("E_HBCompte"))
			Else 
				ADD TO SET:C119([HeBerge:4]; "E_HBCompte")
				$TuCompte:=True:C214
			End if 
		End if 
		
		If (sSexe=1)
			If ([HeberGement:5]HG_Genre:96=True:C214)
				<>te_NbGenre{2}:=<>te_NbGenre{2}+1
				If ($TuCompte)
					<>tl_TBGenre{2}:=<>tl_TBGenre{2}+1
				End if 
			Else 
				<>te_NbGenre{1}:=<>te_NbGenre{1}+1
				If ($TuCompte)
					<>tl_TBGenre{1}:=<>tl_TBGenre{1}+1
				End if 
			End if 
		End if 
		
		If (sAge=1)
			Case of 
					//0 à 3          
				: ([HeberGement:5]HG_Age:23<=<>te_TBAge{1})
					<>te_NbAge{1}:=<>te_NbAge{1}+1
					If ($TuCompte)
						<>tl_NbAge{1}:=<>tl_NbAge{1}+1
					End if 
					//3 -18            
				: ([HeberGement:5]HG_Age:23><>te_TBAge{1}) & ([HeberGement:5]HG_Age:23<<>te_TBAge{2})
					<>te_NbAge{2}:=<>te_NbAge{2}+1
					If ($TuCompte)
						<>tl_NbAge{2}:=<>tl_NbAge{2}+1
					End if 
					// 19-24
				: ([HeberGement:5]HG_Age:23>=<>te_TBAge{2}) & ([HeberGement:5]HG_Age:23<=<>te_TBAge{3})
					<>te_NbAge{3}:=<>te_NbAge{3}+1
					If ($TuCompte)
						<>tl_NbAge{3}:=<>tl_NbAge{3}+1
					End if 
					//25-29
				: ([HeberGement:5]HG_Age:23><>te_TBAge{3}) & ([HeberGement:5]HG_Age:23<=<>te_TBAge{4})
					<>te_NbAge{4}:=<>te_NbAge{4}+1
					If ($TuCompte)
						<>tl_NbAge{4}:=<>tl_NbAge{4}+1
					End if 
					//30-39
				: ([HeberGement:5]HG_Age:23><>te_TBAge{4}) & ([HeberGement:5]HG_Age:23<=<>te_TBAge{5})
					<>te_NbAge{5}:=<>te_NbAge{5}+1
					If ($TuCompte)
						<>tl_NbAge{5}:=<>tl_NbAge{5}+1
					End if 
					//40-49
				: ([HeberGement:5]HG_Age:23><>te_TBAge{5}) & ([HeberGement:5]HG_Age:23<=<>te_TBAge{6})
					<>te_NbAge{6}:=<>te_NbAge{6}+1
					If ($TuCompte)
						<>tl_NbAge{6}:=<>tl_NbAge{6}+1
					End if 
					//50-59
				: ([HeberGement:5]HG_Age:23><>te_TBAge{6}) & ([HeberGement:5]HG_Age:23<=<>te_TBAge{7})
					<>te_NbAge{7}:=<>te_NbAge{7}+1
					If ($TuCompte)
						<>tl_NbAge{7}:=<>tl_NbAge{7}+1
					End if 
					//60-69
				: ([HeberGement:5]HG_Age:23><>te_TBAge{7}) & ([HeberGement:5]HG_Age:23<=<>te_TBAge{8})
					<>te_NbAge{8}:=<>te_NbAge{8}+1
					If ($TuCompte)
						<>tl_NbAge{8}:=<>tl_NbAge{8}+1
					End if 
					//+70
				: ([HeberGement:5]HG_Age:23>=<>te_TBAge{9})
					<>te_NbAge{9}:=<>te_NbAge{9}+1
					If ($TuCompte)
						<>tl_NbAge{9}:=<>tl_NbAge{9}+1
					End if 
			End case 
		End if 
		
		
		If (Size of array:C274(ta_xGroupe)#0)
			If ([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115")
				$Position:=Find in array:C230(ta_xGroupe; "115")
				If ($Position#0)
					te_xxGroupe{$Position}:=te_xxGroupe{$Position}+1
					vl_xGroupe:=vl_xGroupe+1
					If ($TuCompte)
						tl_xxGroupe{$Position}:=tl_xxGroupe{$Position}+1
					End if 
				End if 
			Else 
				$Position:=Find in array:C230(ta_xGroupe; [HeberGement:5]HG_FamGroupe:102)
				If ($Position#0)
					te_xxGroupe{$Position}:=te_xxGroupe{$Position}+1
					vl_xGroupe:=vl_xGroupe+1
					If ($TuCompte)
						tl_xxGroupe{$Position}:=tl_xxGroupe{$Position}+1
					End if 
				End if 
			End if 
		End if 
		
		
		If (sNatio=1)
			$Position:=Find in array:C230(<>ta_TBNatio; [HeberGement:5]HG_Nationalité:25)
			If ($Position>0)
				<>te_NbNatio{$Position}:=<>te_NbNatio{$Position}+1
				vl_Nbnatio:=vl_Nbnatio+1
				If ($TuCompte)
					<>tl_NbNatio{$Position}:=<>tl_NbNatio{$Position}+1
				End if 
			End if 
		End if 
		
		
		If (sSignal=1)
			$Position:=Find in array:C230(<>ta_TBSglt; [HeberGement:5]HG_Signalement:12)
			If ($Position>0)
				<>te_NbSglt{$Position}:=<>te_NbSglt{$Position}+1
				vl_NbSig:=vl_NbSig+1
				If ($TuCompte)
					<>tl_NbSglt{$Position}:=<>tl_NbSglt{$Position}+1
				End if 
			End if 
		End if 
		
		If (sProv=1)
			$Position:=Find in array:C230(<>ta_TBArr; [HeberGement:5]HG_CodePostal:14)
			If ($Position>0)
				<>te_NbArr{$Position}:=<>te_NbArr{$Position}+1
				vl_NbProv:=vl_NbProv+1
				If ($TuCompte)
					<>tl_NbArr{$Position}:=<>tl_NbArr{$Position}+1
				End if 
			End if 
		End if 
		
		If (sErrance=1)
			$Position:=Find in array:C230(<>ta_TBGare; [HeberGement:5]HG_Gare:15)
			If ($Position>0)
				<>te_NbGare{$Position}:=<>te_NbGare{$Position}+1
				vl_Nbné:=vl_Nbné+1
				If ($TuCompte)
					<>tl_NbGare{$Position}:=<>tl_NbGare{$Position}+1
				End if 
			End if 
		End if 
		NEXT RECORD:C51([HeberGement:5])
	End while 
End if 