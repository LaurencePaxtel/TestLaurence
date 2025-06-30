//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Item_Maraude
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_OK)

C_POINTER:C301(vp_ptr1; vp_ptr2; vp_Sel; vp_It; vp_Nb; vp_Nb_P; vp_Tot; vp_Tot_P)

$vb_OK:=True:C214

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
			ARRAY TEXT:C222(ta_it1; 0)
			
			ARRAY INTEGER:C220(te_Sel1; 0)
			
			ARRAY LONGINT:C221(tl_Nb1; 0)
			ARRAY LONGINT:C221(tl_Nb1_1; 0)
			
			vl_Tot1:=0
		: ($1=2)
			ARRAY TEXT:C222(ta_it2; 0)
			
			ARRAY INTEGER:C220(te_Sel2; 0)
			
			ARRAY LONGINT:C221(tl_Nb2; 0)
			ARRAY LONGINT:C221(tl_Nb2_2; 0)
			
			vl_Tot2:=0
		: ($1=3)
			ARRAY TEXT:C222(ta_it3; 0)
			
			ARRAY INTEGER:C220(te_Sel3; 0)
			
			ARRAY LONGINT:C221(tl_Nb3; 0)
			ARRAY LONGINT:C221(tl_Nb3_3; 0)
			
			vl_Tot3:=0
		: ($1=4)
			ARRAY TEXT:C222(ta_it4; 0)
			
			ARRAY INTEGER:C220(te_Sel4; 0)
			
			ARRAY LONGINT:C221(tl_Nb4; 0)
			ARRAY LONGINT:C221(tl_Nb4_4; 0)
			
			vl_Tot4:=0
	End case 
	
	$va_Rb:=vp_ptr1->{$2}
	
	Case of 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{4})  //"No EMA")
			$ij:=Size of array:C274(<>ta_EMA)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_EMA{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{1})  //"Conseiller")
			$ij:=Size of array:C274(<>ta_InAsSoc)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_InAsSoc{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{2})  //"Opérateur")
			$ij:=Size of array:C274(<>ta_InOpér)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_InOpér{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{3})  //"Chef de bord")
			$ij:=Size of array:C274(<>ta_ChB)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_ChB{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{17})  //"Etat Civil")
			$ij:=Size of array:C274(<>ta_TBEtCiv)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBEtCiv{$ii}
			End for 
			
		: ($va_Rb="Age")
			INSERT IN ARRAY:C227(vp_It->; 1; 9)
			
			vp_It->{1}:="de 0 jusqu' à 3"
			vp_It->{2}:="plus de 3 et moins de 18"
			vp_It->{3}:="plus de 18 jusqu'à 24"
			vp_It->{4}:="plus de 24 jusqu'à 29"
			vp_It->{5}:="plus de 29 jusqu'à 39"
			vp_It->{6}:="plus de 39 jusqu'à 49"
			vp_It->{7}:="plus de 49 jusqu'à 59"
			vp_It->{8}:="plus de 59 jusqu'à 69"
			vp_It->{9}:="plus de 69"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{22})  //"Lieu de naissance")
			$ij:=Size of array:C274(<>ta_TBLieuNé)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBLieuNé{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7})  //"Signalement")
			$ij:=Size of array:C274(<>ta_MRsg)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRsg{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{9})  //"Emplacement")
			$ij:=Size of array:C274(<>ta_TBPorte)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBPorte{$ii}
			End for 
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{11})  //"Arrondissement CP")
			$ij:=Size of array:C274(<>ta_TBArr)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBArr{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{12})  //"Heure debut de la rencontre")
			INSERT IN ARRAY:C227(vp_It->; 1; 24)
			
			For ($ii; 1; 24)
				vp_It->{$ii}:=String:C10($ii-1)
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{13})  //"Heure fin de la rencontre")
			INSERT IN ARRAY:C227(vp_It->; 1; 24)
			
			For ($ii; 1; 24)
				vp_It->{$ii}:=String:C10($ii-1)
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{15})  //"Duré de la rencontre en minutes")
			//•••••••••
			INSERT IN ARRAY:C227(vp_It->; 1; 10)
			
			vp_It->{1}:="0 à 5 mn"  //5      
			vp_It->{2}:="5 à 10 mn"  //6 -10      
			vp_It->{3}:="10 à 15 mn"  //11-15   
			vp_It->{4}:="15 à 30 mn"  //16-30
			vp_It->{5}:="30 à 45 mn"  //31-45
			vp_It->{6}:="45 à 60 mn"  //46-60
			vp_It->{7}:="60 à 90 mn"  //61-90
			vp_It->{8}:="90 à 120 mn"  //91-120
			vp_It->{9}:="120 à 150 mn"  //121-150
			vp_It->{10}:="+ de 150 mn"  //+150
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{14})  //"Demande")
			$ij:=Size of array:C274(<>ta_MRDem)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRDem{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{16})  //"Motif refus prise encharge")
			
			// Modified by: Kevin HASSAL (09/08/2019)
			// Correction du bug pour afficher les bonnes valeurs :Quartier
			$ij:=Size of array:C274(<>ta_MRqua)  //Size of array(<>ta_MRrefu)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRqua{$ii}  //<>ta_MRrefu{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{23})  //"Etat général")
			$ij:=Size of array:C274(<>ta_MReGé)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MReGé{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{24})  //"Etat cutané")
			$ij:=Size of array:C274(<>ta_MReCu)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MReCu{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{25})  //"Relation")
			$ij:=Size of array:C274(<>ta_MRrel)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRrel{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{26})  //"Langue 1")
			$ij:=Size of array:C274(<>ta_Lgs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_Lgs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{27})  //"Langue 2")
			$ij:=Size of array:C274(<>ta_Lgs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_Lgs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{28})  //"Langue 3")
			$ij:=Size of array:C274(<>ta_Lgs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_Lgs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{32})  //"Orientation médicale")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{33})  //"Orientation médicale 1")
			$ij:=Size of array:C274(<>ta_OrMd)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_OrMd{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{29})  //"Orientation sociale")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{30})  //"Orientation sociale 1")
			$ij:=Size of array:C274(<>ta_OrSc)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_OrSc{$ii}
			End for 
			
		: ($va_Rb="Genre")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Féminin"
			vp_It->{2}:="Masculin"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{6})  //"Y a t-il une fiche sociale")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{35})  //"Prise en charge EMA")
			$ij:=Size of array:C274(<>ta_MRPch)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRPch{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{37})  //"Dernier lieu d'hébergement")
			$ij:=Size of array:C274(<>ta_DerLH)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_DerLH{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{36})  //"Motif refus prise encharge sociale")
			$ij:=Size of array:C274(<>ta_MRrefu)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRrefu{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{40})  //"Quel mode")
			$ij:=Size of array:C274(<>ta_Qmod)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_Qmod{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{42})  //"Temps d'errance")
			$ij:=Size of array:C274(<>ta_TBTpsErr)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBTpsErr{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{43})  //"Personne chez qui aller")
			$ij:=Size of array:C274(<>ta_MRQui)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRQui{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44})  //"Compagnie actuelle")
			$ij:=Size of array:C274(<>ta_CpAct)
			$ij:=Size of array:C274(<>ta_DScomp)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_DScomp{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{47})  //"Question couverture sociale")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48})  //"Couverture sociale 1")
			$ij:=Size of array:C274(<>ta_MRcs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRcs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{50})  //"Couverture sociale 2")
			$ij:=Size of array:C274(<>ta_MRcs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRcs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{52})  //"Couverture sociale 3")
			$ij:=Size of array:C274(<>ta_MRcs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRcs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{59})  //"Question ressouces")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{60})  //"Ressources 1")
			$ij:=Size of array:C274(<>ta_MRrs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRrs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{62})  //"Ressources 2")
			$ij:=Size of array:C274(<>ta_MRrs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRrs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{64})  //"Ressources 3")
			$ij:=Size of array:C274(<>ta_MRrs)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRrs{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{55})  //"Question papiers d'identité")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56})  //"Papiers d'identité")
			$ij:=Size of array:C274(<>ta_TBPIdté)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_TBPIdté{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{67})  //"Question régime")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68})  //"Régime")
			$ij:=Size of array:C274(<>ta_MRrg)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRrg{$ii}
			End for 
			
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{71})  //"Question suivi social")
			INSERT IN ARRAY:C227(vp_It->; 1; 2)
			vp_It->{1}:="Oui"
			vp_It->{2}:="Non"
		: ($va_Rb=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72})  //"Suivi social")
			$ij:=Size of array:C274(<>ta_MRss)
			INSERT IN ARRAY:C227(vp_It->; 1; $ij)
			
			For ($ii; 1; $ij)
				vp_It->{$ii}:=<>ta_MRss{$ii}
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