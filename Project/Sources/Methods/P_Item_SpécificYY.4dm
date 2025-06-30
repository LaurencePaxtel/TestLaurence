//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Item_Spécific
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=True:C214
C_POINTER:C301(vp_ptr1)
C_POINTER:C301(vp_ptr2)
C_POINTER:C301(vp_Sel)
C_POINTER:C301(vp_It)
C_POINTER:C301(vp_Nb)
C_POINTER:C301(vp_Nb_P)
C_POINTER:C301(vp_Tot)
C_POINTER:C301(vp_Tot_P)


C_LONGINT:C283($ii)

vp_ptr1:=Get pointer:C304("ta_Rub"+String:C10($1))
vp_Sel:=Get pointer:C304("te_Sel"+String:C10($1))
vp_It:=Get pointer:C304("ta_it"+String:C10($1))
vp_Nb:=Get pointer:C304("tl_Nb"+String:C10($1))
vp_Tot:=Get pointer:C304("vl_Tot"+String:C10($1))

vp_Nb_P:=Get pointer:C304("tl_Nb"+String:C10($1)+"_"+String:C10($1))
vp_Tot_P:=Get pointer:C304("vl_Tot"+String:C10($1)+"_"+String:C10($1))

For ($ii; 1; 4)
	vp_ptr2:=Get pointer:C304("ta_Rub"+String:C10($ii))
	If ($ii#$1)
		If (vp_ptr2->{0}=vp_ptr1->{vp_ptr1->})
			$vb_OK:=False:C215
		End if 
	End if 
End for 


If ($vb_OK)
	Case of 
		: ($1=1)
			ARRAY INTEGER:C220(te_Sel1; 0)
			ARRAY TEXT:C222(ta_it1; 0)
			ARRAY LONGINT:C221(tl_Nb1; 0)
			ARRAY LONGINT:C221(tl_Nb1_1; 0)
			vl_Tot1:=0
		: ($1=2)
			ARRAY INTEGER:C220(te_Sel2; 0)
			ARRAY TEXT:C222(ta_it2; 0)
			ARRAY LONGINT:C221(tl_Nb2; 0)
			ARRAY LONGINT:C221(tl_Nb2_2; 0)
			vl_Tot2:=0
		: ($1=3)
			ARRAY INTEGER:C220(te_Sel3; 0)
			ARRAY TEXT:C222(ta_it3; 0)
			ARRAY LONGINT:C221(tl_Nb3; 0)
			ARRAY LONGINT:C221(tl_Nb3_3; 0)
			vl_Tot3:=0
		: ($1=4)
			ARRAY INTEGER:C220(te_Sel4; 0)
			ARRAY TEXT:C222(ta_it4; 0)
			ARRAY LONGINT:C221(tl_Nb4; 0)
			ARRAY LONGINT:C221(tl_Nb4_4; 0)
			vl_Tot4:=0
	End case 
	$va_Rb:=vp_ptr1->{$2}
	Case of 
		: ($va_Rb="HeureAppel")
			INSERT IN ARRAY:C227(vp_It->; 1; 24)
			For ($ii; 1; 24)
				vp_It->{$ii}:=String:C10($ii-1)
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{19})  //"Maraude")
			$ij:=Size of array:C274(<>ta_TBMaraud)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBMaraud{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5})  //"Signalement")
			$ij:=Size of array:C274(<>ta_TBSglt)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBSglt{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7})  //"Code Postal")
			$ij:=Size of array:C274(<>ta_TBArr)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBArr{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8})  //"Gare")
			$ij:=Size of array:C274(<>ta_TBGare)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBGare{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9})  //"Métro")
			$ij:=Size of array:C274(<>ta_TBMetro)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBMetro{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{10})  //"Emplacement")
			$ij:=Size of array:C274(<>ta_TBPorte)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBPorte{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40})  //"Etat Civil")
			$ij:=Size of array:C274(<>ta_TBEtCiv)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBEtCiv{$ii}
			End for 
		: ($va_Rb="Age")
			If (7=8)
				INSERT IN ARRAY:C227(vp_It->; 1; 9)
				vp_It->{1}:="de 0 jusqu' à  3"
				vp_It->{2}:="plus de 3 et moins de  18"
				vp_It->{3}:="plus de 18 jusqu' à 24"
				vp_It->{4}:="plus de 24 jusqu' à 29"
				vp_It->{5}:="plus de 29 jusqu' à 39"
				vp_It->{6}:="plus de 39 jusqu' à 49"
				vp_It->{7}:="plus de 49 jusqu' à 59"
				vp_It->{8}:="plus de 59 jusqu' à 69"
				vp_It->{9}:="plus de 69"
			Else 
				INSERT IN ARRAY:C227(vp_It->; 1; Size of array:C274(<>ta_TrancheAge))
				For ($ii; 1; Size of array:C274(<>ta_TrancheAge))
					vp_It->{$ii}:=<>ta_TrancheAge{$ii}
				End for 
			End if 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12})  //"Nationalité")
			$ij:=Size of array:C274(<>ta_TBNatio)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBNatio{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11})  //"Lien de parenté")
			$ij:=Size of array:C274(<>ta_TBLien)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBLien{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13})  //"Situation de Famille")
			$ij:=Size of array:C274(<>ta_TBSitFam)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBSitFam{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25})  //"Pièces Idté 1")
			$ij:=Size of array:C274(<>ta_TBPIdté)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBPIdté{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26})  //"Pièces Idté 2")
			$ij:=Size of array:C274(<>ta_TBPIdté2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBPIdté2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27})  //"Pièces Idté 3")
			$ij:=Size of array:C274(<>ta_TBPIdté3)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBPIdté3{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14})  //"Temps d'errance")
			$ij:=Size of array:C274(<>ta_TBTpsErr)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBTpsErr{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15})  //"Dernier hébergement")
			$ij:=Size of array:C274(<>ta_TBDerHéb)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBDerHéb{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16})  //"Situation professionnelle")
			$ij:=Size of array:C274(<>ta_TBSitPro)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBSitPro{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17})  //"Dernier emploi")
			$ij:=Size of array:C274(<>ta_TBDerJob)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBDerJob{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18})  //"Duré sans emploi")
			$ij:=Size of array:C274(<>ta_TBDurJob)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBDurJob{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28})  //"Rupture majeure 1")
			$ij:=Size of array:C274(<>ta_TBRupMaj)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBRupMaj{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29})  //"Rupture majeure 2")
			$ij:=Size of array:C274(<>ta_TBRupMaj2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBRupMaj2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30})  //"Rupture majeure 3")
			$ij:=Size of array:C274(<>ta_TBRupMaj3)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBRupMaj3{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41})  //"Niveau d'étude")
			$ij:=Size of array:C274(<>ta_TBNivEtu)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBNivEtu{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31})  //"Ressources 1")
			$ij:=Size of array:C274(<>ta_TBResAct)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBResAct{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32})  //"Ressources 2")
			$ij:=Size of array:C274(<>ta_TBResAct2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBResAct2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33})  //"Ressources 3")
			$ij:=Size of array:C274(<>ta_TBResAct3)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBResAct3{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34})  //"Suivi social 1")
			$ij:=Size of array:C274(<>ta_TBSuiSoc)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBSuiSoc{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{35})  //"Suivi social 2")
			$ij:=Size of array:C274(<>ta_TBSuiSoc2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBSuiSoc2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{36})  //"Suivi social 3")
			$ij:=Size of array:C274(<>ta_TBSuiSoc3)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBSuiSoc3{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37})  //"Couverture sociale 1")
			$ij:=Size of array:C274(<>ta_TBCouSoc)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBCouSoc{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{38})  //"Couverture sociale 2")
			$ij:=Size of array:C274(<>ta_TBCouSoc2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBCouSoc2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{39})  //"Couverture sociale 3")
			$ij:=Size of array:C274(<>ta_TBCouSoc3)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBCouSoc3{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{42})  //"Lit médicalisé")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Médicalisé"
			vp_It->{2}:="Non médicalisé"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48})  //"Orientation 1")
			$ij:=Size of array:C274(<>ta_TBOr1)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBOr1{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49})  //"Orientation 2")
			$ij:=Size of array:C274(<>ta_TBOr2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBOr2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50})  //"Autre solution")
			$ij:=Size of array:C274(<>ta_AtS)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_AtS{$ii}
			End for 
		: ($va_Rb="Genre")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Féminin"
			vp_It->{2}:="Masculin"
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{43})  //"Status")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Non"
			vp_It->{2}:="Oui"
			
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62})  //"Famille groupe")
			$ij:=Size of array:C274(<>ta_FMGrp)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMGrp{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{63})  //"Famille responsable")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Non"
			vp_It->{2}:="Oui"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{65})  //"Famille composition")
			$ij:=Size of array:C274(<>ta_FMComp)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMComp{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{78})  //"Famille distri 1")
			$ij:=Size of array:C274(<>ta_FMDis1)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMDis1{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{79})  //"Famille distri 2")
			$ij:=Size of array:C274(<>ta_FMDis2)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMDis2{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{80})  //"Famille distri 3")
			$ij:=Size of array:C274(<>ta_FMDis3)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMDis3{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{81})  //"Famille distri 4")
			$ij:=Size of array:C274(<>ta_FMDis4)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMDis4{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{82})  //"Famille distri 5")
			$ij:=Size of array:C274(<>ta_FMDis5)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMDis5{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{83})  //"Famille cas spécif")
			$ij:=Size of array:C274(<>ta_FMCaS)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_FMCaS{$ii}
			End for 
	End case 
	
	$ii:=Size of array:C274(vp_It->)
	If ($ii>0)
		INSERT IN ARRAY:C227(vp_Sel->; 1; $ii)
		INSERT IN ARRAY:C227(vp_Nb->; 1; $ii)
		INSERT IN ARRAY:C227(vp_Nb_P->; 1; $ii)
	End if 
	vp_Tot->:=0
	vp_Tot_P->:=0
End if 
$0:=$vb_OK