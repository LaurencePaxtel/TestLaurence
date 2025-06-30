//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementDécoupageCALC
//{
//{          Jeudi 31 décembre 2009 à 12:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii; $jj; $kk; $Position)
C_DATE:C307($vd_Date; $vd_Debut; $vd_Fin)
C_POINTER:C301(vp_Pointeur; vp_Pointeur2; vp_Pointeur3)

$vd_Date:=!00-00-00!
$vb_OK:=($1>1980)
$vb_OK:=$vb_OK & ($1<2080)
If ($vb_OK)
	$vd_Date:=Date:C102("01/01/"+String:C10(vl_Annee; "0000"))
	For ($ii; 1; 12)
		i_MessageSeul("Recherche : "+String:C10($ii; "00")+"/12")
		//••• La sélection du mois
		$vd_Debut:=Add to date:C393($vd_Date; 0; $ii-1; 0)
		$vd_Fin:=Add to date:C393($vd_Date; 0; $ii; -1)
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=$vd_Debut; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$vd_Fin; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)
		MultiSoc_Filter(->[HeberGement:5])
		//Centre 
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_LC_ID:61; ->tl_xCentre; ->te_xCentre)
		
		CREATE SET:C116([HeberGement:5]; "E_Perimetre")
		
		//•• Nuitées totales Nombre
		vp_Pointeur:=Get pointer:C304("vl_ColN1_"+String:C10($ii))
		vp_Pointeur->:=Records in selection:C76([HeberGement:5])
		
		//•• Nuitées totales Fiches
		vp_Pointeur2:=Get pointer:C304("tl_ColRéf_"+String:C10($ii)+"_1")
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; vp_Pointeur2->)
		
		//Etat civil  
		P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_EtatCivil:20; ->ta_CritEtCiv; ->te_CritEtCiv)
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamChef:103=True:C214)
		
		ARRAY TEXT:C222(ta_ColFamClé; 0)
		ARRAY BOOLEAN:C223(tb_ColFamClé; 0)
		
		If (Records in selection:C76([HeberGement:5])>0)
			
			//•••on obtient les fiches dont on retient les clés de lien      
			DISTINCT VALUES:C339([HeberGement:5]HG_FamClé:104; ta_ColFamClé)
			ARRAY BOOLEAN:C223(tb_ColFamClé; Size of array:C274(ta_ColFamClé))
			
			//•• FAMILLES totales Nombre
			vp_Pointeur:=Get pointer:C304("vl_ColF1_"+String:C10($ii))
			vp_Pointeur->:=Size of array:C274(ta_ColFamClé)
			
			//•• FAMILLES totales Personnes #
			vp_Pointeur:=Get pointer:C304("vl_ColF1_P_"+String:C10($ii))
			vp_Pointeur->:=0
			
			//•• FAMILLES totales Codes
			vp_Pointeur:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii)+"_2")
			COPY ARRAY:C226(ta_ColFamClé; vp_Pointeur->)
			
			//•• FAMILLES totales Nombre Nuitées totales Fiches
			vp_Pointeur:=Get pointer:C304("tl_ColRéf_"+String:C10($ii)+"_2")
			ARRAY LONGINT:C221(vp_Pointeur->; 0)
			
			If (Size of array:C274(ta_ColFamClé)>0)
				QUERY WITH ARRAY:C644([HeberGement:5]HG_FamClé:104; ta_ColFamClé)
				CREATE SET:C116([HeberGement:5]; "E_LesFamilles")
				INTERSECTION:C121("E_Perimetre"; "E_LesFamilles"; "E_LesFamilles")
				If (Records in set:C195("E_LesFamilles")>0)
					USE SET:C118("E_LesFamilles")
					SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; vp_Pointeur->)
					DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
					vp_Pointeur:=Get pointer:C304("vl_ColF1_P_"+String:C10($ii))
					vp_Pointeur->:=Size of array:C274($tl_Temp)
				End if 
				CLEAR SET:C117("E_LesFamilles")
			End if 
			
			//••• Cette famille n'a t elle que des enfant de moins de 3 ans
			If (Size of array:C274(ta_ColFamClé)>0)
				For ($jj; 1; Size of array:C274(ta_ColFamClé))
					P_HébergementDécoupageFamille($vd_Debut; $jj)
				End for 
				//••• on supprime les familles n'ayant pas que des enfant de moins de 3 Ans
				$jj:=1
				$vb_OK:=False:C215
				Repeat 
					If (tb_ColFamClé{$jj}=False:C215)
						DELETE FROM ARRAY:C228(ta_ColFamClé; $jj; 1)
						DELETE FROM ARRAY:C228(tb_ColFamClé; $jj; 1)
					Else 
						$jj:=$jj+1
					End if 
					$vb_OK:=($jj>Size of array:C274(tb_ColFamClé))
				Until ($vb_OK)
			End if 
		End if 
		
		//•• FAMILLES -3ans Nombre
		vp_Pointeur:=Get pointer:C304("vl_ColF2_"+String:C10($ii))
		vp_Pointeur->:=Size of array:C274(ta_ColFamClé)
		
		//•• FAMILLES -3ans Codes
		vp_Pointeur:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii)+"_3")
		COPY ARRAY:C226(ta_ColFamClé; vp_Pointeur->)
		
		//•• FAMILLES -3ans Personnes #
		vp_Pointeur:=Get pointer:C304("vl_ColF2_P_"+String:C10($ii))
		vp_Pointeur->:=0
		
		//•• FAMILLES -3ans Nuitées totales Fiches
		vp_Pointeur:=Get pointer:C304("tl_ColRéf_"+String:C10($ii)+"_3")
		ARRAY LONGINT:C221(vp_Pointeur->; 0)
		
		If (Size of array:C274(ta_ColFamClé)>0)
			QUERY WITH ARRAY:C644([HeberGement:5]HG_FamClé:104; ta_ColFamClé)
			CREATE SET:C116([HeberGement:5]; "E_LesFamilles")
			INTERSECTION:C121("E_Perimetre"; "E_LesFamilles"; "E_LesFamilles")
			If (Records in set:C195("E_LesFamilles")>0)
				USE SET:C118("E_LesFamilles")
				SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; vp_Pointeur->)
				
				DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
				vp_Pointeur:=Get pointer:C304("vl_ColF2_P_"+String:C10($ii))
				vp_Pointeur->:=Size of array:C274($tl_Temp)
			End if 
			CLEAR SET:C117("E_LesFamilles")
		End if 
		
		//On calcul ici les nouveaux arrivants
		If ($ii=1)  //Ce sont lesmêmes données que pour la famille -3 ans
			vp_Pointeur:=Get pointer:C304("vl_ColF2_"+String:C10($ii))
			vp_Pointeur2:=Get pointer:C304("vl_ColF3_"+String:C10($ii))
			vp_Pointeur2->:=vp_Pointeur->
			
			vp_Pointeur:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii)+"_3")
			vp_Pointeur2:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii)+"_4")
			COPY ARRAY:C226(vp_Pointeur->; vp_Pointeur2->)
			
			//•• FAMILLES -3ans Personnes #
			vp_Pointeur:=Get pointer:C304("vl_ColF2_P_"+String:C10($ii))
			vp_Pointeur2:=Get pointer:C304("vl_ColF3_P_"+String:C10($ii))
			vp_Pointeur2->:=vp_Pointeur->
			
			//•• FAMILLES -3ans Nuitées totales Fiches
			vp_Pointeur:=Get pointer:C304("tl_ColRéf_"+String:C10($ii)+"_3")
			vp_Pointeur2:=Get pointer:C304("tl_ColRéf_"+String:C10($ii)+"_4")
			COPY ARRAY:C226(vp_Pointeur->; vp_Pointeur2->)
		Else 
			//On compare les codes des familles Mois précédent et actuel
			//On copie dans les nouveaux du mois les familles du mois
			//on supprime par comparaison ceux qui était déja ici
			vp_Pointeur:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii)+"_4")
			vp_Pointeur2:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii)+"_3")
			COPY ARRAY:C226(vp_Pointeur2->; vp_Pointeur->)
			
			vp_Pointeur2:=Get pointer:C304("ta_ColRéfFam_"+String:C10($ii-1)+"_3")
			If (Size of array:C274(vp_Pointeur->)>0)
				$kk:=1
				Repeat 
					$Position:=Find in array:C230(vp_Pointeur2->; vp_Pointeur->{$kk})
					If ($Position>0)
						DELETE FROM ARRAY:C228(vp_Pointeur->; $kk; 1)
					Else 
						$kk:=$kk+1
					End if 
				Until ($kk>Size of array:C274(vp_Pointeur->))
			End if 
			
			vp_Pointeur2:=Get pointer:C304("vl_ColF3_"+String:C10($ii))
			vp_Pointeur2->:=Size of array:C274(vp_Pointeur->)
			
			vp_Pointeur2:=Get pointer:C304("vl_ColF3_P_"+String:C10($ii))
			vp_Pointeur2->:=0
			
			vp_Pointeur2:=Get pointer:C304("tl_ColRéf_"+String:C10($ii)+"_4")
			ARRAY LONGINT:C221(vp_Pointeur2->; 0)
			
			If (Size of array:C274(vp_Pointeur->)>0)
				QUERY WITH ARRAY:C644([HeberGement:5]HG_FamClé:104; vp_Pointeur->)
				CREATE SET:C116([HeberGement:5]; "E_LesFamilles")
				INTERSECTION:C121("E_Perimetre"; "E_LesFamilles"; "E_LesFamilles")
				If (Records in set:C195("E_LesFamilles")>0)
					USE SET:C118("E_LesFamilles")
					SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; vp_Pointeur2->)
					
					DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
					vp_Pointeur2:=Get pointer:C304("vl_ColF3_P_"+String:C10($ii))
					vp_Pointeur2->:=Size of array:C274($tl_Temp)
				End if 
				CLEAR SET:C117("E_LesFamilles")
			End if 
		End if 
	End for 
End if 