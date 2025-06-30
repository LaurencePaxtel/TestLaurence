//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Méthode : F_HébergementDécoupageLibellé
//{
//{          Lundi 28 décembre 2009 à 16:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)
$0:=""


C_LONGINT:C283($ii)


If ($3)  //Click pour données par mois
	If (<>vb_T_CalcTroisEnfants)  //Calcul sans utilisation des pointeurs (à cause bug en 67 sur PC)  
		vp_TroisPtrLib:=P_HébergementDécoupageLibellé(1; $1; $2)
	Else   //Calcul avec utilisation des pointeurs
		vp_TroisPtrLib:=Get pointer:C304("tl_ColRéf_"+String:C10($1)+"_"+String:C10($2))
	End if 
	If (Size of array:C274(vp_TroisPtrLib->)>0)
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; vp_TroisPtrLib->)
	Else 
		REDUCE SELECTION:C351([HeberGement:5]; 0)
	End if 
	CREATE SET:C116([HeberGement:5]; "E_LaSel")
	ve_ColMois:=$1
	ve_ColType:=$2
End if 

vL_NbFiches:=Records in selection:C76([HeberGement:5])
P_HébergementVeilleSort(2)

//Calcul sans utilisation des pointeurs (à cause bug en 67 sur PC)  
//Calcul avec utilisation des pointeurs  
Case of 
	: ($2=1)
		$0:=<>ta_LesMois{$1}+" : "
		$0:=$0+String:C10(vL_NbFiches; "### ### ##0")+" hébergement(s)"
		$0:=$0+" au total"
		ARRAY TEXT:C222(ta_ColRéfFam_Code; 0)
		DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
		$0:=$0+"  - "+String:C10(Size of array:C274($tl_Temp))+" personne(s)"
		
	: ($2=2)
		$0:=<>ta_LesMois{$1}+" : "
		$0:=$0+String:C10(vL_NbFiches; "### ### ##0")+" hébergement(s)"
		If ($3)
			If (<>vb_T_CalcTroisEnfants)
				vp_TroisPtrLib:=P_HébergementDécoupageLibellé(2; $1; $2)  //ta_ColRéfFam_$1_$2
			Else 
				vp_TroisPtrLib:=Get pointer:C304("ta_ColRéfFam_"+String:C10($1)+"_"+String:C10($2))
			End if 
			COPY ARRAY:C226(vp_TroisPtrLib->; ta_ColRéfFam_Code)
			
			$0:=$0+" pour "+String:C10(Size of array:C274(ta_ColRéfFam_Code))+" famille(s)"
			//•• FAMILLES  Personnes #
			If (<>vb_T_CalcTroisEnfants)
				vp_TroisPtrLib:=P_HébergementDécoupageLibellé(3; $1; 1)  //vl_ColF1_P_$1
			Else 
				vp_TroisPtrLib:=Get pointer:C304("vl_ColF1_P_"+String:C10($1))
			End if 
			$0:=$0+"  - "+String:C10(vp_TroisPtrLib->)+" personne(s)"
		Else 
			$0:=$0+" pour "+" la famille "+ta_ColRéfFam_Code{ta_ColRéfFam_Code}
			DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
			$0:=$0+"  - "+String:C10(Size of array:C274($tl_Temp))+" personne(s)"
		End if 
		
	: ($2=3)
		$0:=<>ta_LesMois{$1}+" : "
		$0:=$0+String:C10(vL_NbFiches; "### ### ##0")+" hébergement(s)"
		If ($3)
			If (<>vb_T_CalcTroisEnfants)
				vp_TroisPtrLib:=P_HébergementDécoupageLibellé(2; $1; $2)  //ta_ColRéfFam_$1_$2
			Else 
				vp_TroisPtrLib:=Get pointer:C304("ta_ColRéfFam_"+String:C10($1)+"_"+String:C10($2))
			End if 
			COPY ARRAY:C226(vp_TroisPtrLib->; ta_ColRéfFam_Code)
			$0:=$0+" pour les "+String:C10(Size of array:C274(ta_ColRéfFam_Code))+" famille(s) n'ayant que des enfants de moins de trois ans"
			//•• FAMILLES -3ans Personnes #
			If (<>vb_T_CalcTroisEnfants)
				vp_TroisPtrLib:=P_HébergementDécoupageLibellé(4; $1; 2)  //vl_ColF2_P_$1
			Else 
				vp_TroisPtrLib:=Get pointer:C304("vl_ColF2_P_"+String:C10($1))
			End if 
			$0:=$0+"  - "+String:C10(vp_TroisPtrLib->)+" personne(s)"
		Else 
			$0:=$0+" pour la famille "+ta_ColRéfFam_Code{ta_ColRéfFam_Code}+" n'ayant que des enfants de moins de trois ans"
			DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
			$0:=$0+"  - "+String:C10(Size of array:C274($tl_Temp))+" personne(s)"
		End if 
		
	: ($2=4)
		$0:=<>ta_LesMois{$1}+" : "
		$0:=$0+String:C10(vL_NbFiches; "### ### ##0")+" hébergement(s)"
		If ($3)
			If (<>vb_T_CalcTroisEnfants)
				vp_TroisPtrLib:=P_HébergementDécoupageLibellé(2; $1; $2)  //ta_ColRéfFam_$1_$2
			Else 
				vp_TroisPtrLib:=Get pointer:C304("ta_ColRéfFam_"+String:C10($1)+"_"+String:C10($2))
			End if 
			COPY ARRAY:C226(vp_TroisPtrLib->; ta_ColRéfFam_Code)
			$0:=$0+" pour les "+String:C10(Size of array:C274(ta_ColRéfFam_Code))+" nouvelle(s) famille(s) n'ayant que des enfants de moins de trois ans"
			//•• FAMILLES -3ans Personnes #
			If (<>vb_T_CalcTroisEnfants)
				vp_TroisPtrLib:=P_HébergementDécoupageLibellé(5; $1; 2)  //vl_ColF3_P_$1
			Else 
				vp_TroisPtrLib:=Get pointer:C304("vl_ColF3_P_"+String:C10($1))
			End if 
			$0:=$0+"  - "+String:C10(vp_TroisPtrLib->)+" personne(s)"
		Else 
			$0:=$0+" pour la nouvelle famille "+ta_ColRéfFam_Code{ta_ColRéfFam_Code}+" n'ayant que des enfants de moins de trois ans"
			DISTINCT VALUES:C339([HeberGement:5]HG_HB_ID:19; $tl_Temp)
			$0:=$0+"  - "+String:C10(Size of array:C274($tl_Temp))+" personne(s)"
		End if 
End case 

If ($3)  // ajout d'un item dans le PopUp Famille pour tout sélectionner
	If (Size of array:C274(ta_ColRéfFam_Code)>0)
		$ii:=Size of array:C274(ta_ColRéfFam_Code)+1
		INSERT IN ARRAY:C227(ta_ColRéfFam_Code; $ii; 2)
		ta_ColRéfFam_Code{$ii}:="-"
		ta_ColRéfFam_Code{$ii+1}:="Toutes"
		OBJECT SET VISIBLE:C603(*; "Famille_@"; True:C214)
		ta_ColRéfFam_Code:=Size of array:C274(ta_ColRéfFam_Code)
	Else 
		OBJECT SET VISIBLE:C603(*; "Famille_@"; False:C215)
	End if 
End if 