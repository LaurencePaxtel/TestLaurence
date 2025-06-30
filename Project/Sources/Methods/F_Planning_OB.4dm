//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_Planning_OP 
//{
//{          Mercredi 12 janvier 2011 à 12:06:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($ii; $kk)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)
		ARRAY LONGINT:C221(tl_LesObjets_ID; 0)
		ARRAY TEXT:C222(ta_LesObjets; 0)
		ARRAY TEXT:C222(ta_LesObjetsCourt; 0)
		ARRAY LONGINT:C221(tl_LesObjets_NbPL; 0)
		
		ARRAY LONGINT:C221(th_LesObjets_Debut_1; 0)
		ARRAY LONGINT:C221(th_LesObjets_Fin_1; 0)
		
		ARRAY LONGINT:C221(th_LesObjets_Debut_2; 0)
		ARRAY LONGINT:C221(th_LesObjets_Fin_2; 0)
		
		ARRAY LONGINT:C221(th_LesObjets_Debut_3; 0)
		ARRAY LONGINT:C221(th_LesObjets_Fin_3; 0)
		
		ARRAY LONGINT:C221(th_LesObjets_Debut_4; 0)
		ARRAY LONGINT:C221(th_LesObjets_Fin_4; 0)
		
		ARRAY LONGINT:C221(th_LesObjets_Debut_5; 0)
		ARRAY LONGINT:C221(th_LesObjets_Fin_5; 0)
		
		ARRAY LONGINT:C221(th_LesObjets_Debut_6; 0)
		ARRAY LONGINT:C221(th_LesObjets_Fin_6; 0)
		
	: ($1=1)
		//Synchro
		$ii:=0
		ta_LesObjets:=0
		vl_MachineLe_ID:=0
		va_MachineLib:=""
		va_MachineLibAbrev:=""
		
		If (Size of array:C274(ta_LesObjets)>4)
			If ($2=0)
				$ii:=Find in array:C230(tl_LesObjets_ID; tl_LesObjets_ID{0})
				If ($ii>0)
					ta_LesObjets:=$ii
				End if 
			Else 
				$ii:=Find in array:C230(tl_LesObjets_ID; $2)
				If ($ii>0)
					ta_LesObjets:=$ii
				End if 
			End if 
		End if 
		If ($ii>0)
			tl_LesObjets_ID{0}:=tl_LesObjets_ID{ta_LesObjets}
			vl_MachineLe_ID:=tl_LesObjets_ID{ta_LesObjets}
			va_MachineLib:=ta_LesObjets{ta_LesObjets}
			va_MachineLibAbrev:=ta_LesObjetsCourt{ta_LesObjets}
		Else 
			tl_LesObjets_ID{0}:=0
		End if 
		
	: ($1=2)
		ALL RECORDS:C47([Objets:56])
		MultiSoc_Filter(->[Objets:56])
		ORDER BY:C49([Objets:56]; [Objets:56]OB_Nom:2; >)
		SELECTION TO ARRAY:C260([Objets:56]OB_RéférenceID:1; tl_LesObjets_ID; [Objets:56]OB_Nom:2; ta_LesObjets; [Objets:56]OB_NomCourt:3; ta_LesObjetsCourt; [Objets:56]OB_NbParJour:5; tl_LesObjets_NbPL; [Objets:56]OB_HeureDébut_1:6; th_LesObjets_Debut_1; [Objets:56]OB_HeureFin_1:7; th_LesObjets_Fin_1; [Objets:56]OB_HeureDébut_2:8; th_LesObjets_Debut_2; [Objets:56]OB_HeureFin_2:9; th_LesObjets_Fin_2; [Objets:56]OB_HeureDébut_3:10; th_LesObjets_Debut_3; [Objets:56]OB_HeureFin_3:11; th_LesObjets_Fin_3; [Objets:56]OB_HeureDébut_4:12; th_LesObjets_Debut_4; [Objets:56]OB_HeureFin_4:13; th_LesObjets_Fin_4; [Objets:56]OB_HeureDébut_5:14; th_LesObjets_Debut_5; [Objets:56]OB_HeureFin_5:15; th_LesObjets_Fin_5; [Objets:56]OB_HeureDébut_6:16; th_LesObjets_Debut_6; [Objets:56]OB_HeureFin_6:17; th_LesObjets_Fin_6)
		
		$vb_OK:=User in group:C338(Current user:C182; <>Groupe_PlanObjet)
		$vb_OK:=$vb_OK | User in group:C338(Current user:C182; <>Groupe_DEVELOP)
		If ($vb_OK)
			If (Size of array:C274(tl_LesObjets_ID)>0)
				$ii:=Size of array:C274(tl_LesObjets_ID)+1
				INSERT IN ARRAY:C227(tl_LesObjets_ID; $ii; 4)
				INSERT IN ARRAY:C227(ta_LesObjets; $ii; 4)
				INSERT IN ARRAY:C227(ta_LesObjetsCourt; $ii; 4)
				
				INSERT IN ARRAY:C227(tl_LesObjets_NbPL; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_1; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_1; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_2; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_2; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_3; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_3; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_4; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_4; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_5; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_5; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_6; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_6; $ii; 4)
				
				tl_LesObjets_ID{$ii}:=0
				ta_LesObjets{$ii}:="-"
				tl_LesObjets_NbPL{$ii}:=0
				$ii:=$ii+1
				tl_LesObjets_ID{$ii}:=-1
				ta_LesObjets{$ii}:="Ajouter un objet"
				tl_LesObjets_NbPL{$ii}:=0
				$ii:=$ii+1
				tl_LesObjets_ID{$ii}:=-2
				ta_LesObjets{$ii}:="Modifier  l'objet courant"
				tl_LesObjets_NbPL{$ii}:=0
				$ii:=$ii+1
				tl_LesObjets_ID{$ii}:=-3
				ta_LesObjets{$ii}:="Supprimer l'objet courant"
				tl_LesObjets_NbPL{$ii}:=0
				
			Else 
				$ii:=Size of array:C274(tl_LesObjets_ID)+1
				INSERT IN ARRAY:C227(tl_LesObjets_ID; $ii; 1)
				INSERT IN ARRAY:C227(ta_LesObjets; $ii; 1)
				INSERT IN ARRAY:C227(ta_LesObjetsCourt; $ii; 1)
				INSERT IN ARRAY:C227(tl_LesObjets_NbPL; $ii; 1)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_1; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_1; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_2; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_2; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_3; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_3; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_4; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_4; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_5; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_5; $ii; 4)
				
				INSERT IN ARRAY:C227(th_LesObjets_Debut_6; $ii; 4)
				INSERT IN ARRAY:C227(th_LesObjets_Fin_6; $ii; 4)
				tl_LesObjets_ID{$ii}:=-1
				ta_LesObjets{$ii}:="Ajouter un objet"
				tl_LesObjets_NbPL{$ii}:=0
			End if 
		End if 
		
	: ($1=3)  //Ajouter
		If ($2=0)
			$vb_OK:=F_Planning_OB(1; 0)  //Synchro
		Else 
			$vb_OK:=F_Planning_OB(2; 0)  //Chargement des objets
			$vb_OK:=F_Planning_OB(1; $2)  //Synchro
			$vb_OK:=F_Planning_OB(6; ta_LesObjets)
			P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
		End if 
		
		
		
		
	: ($1=4)  //Modifier
		If ($2=0)
			$vb_OK:=F_Planning_OB(1; 0)  //Synchro
		Else 
			$vb_OK:=F_Planning_OB(2; 0)  //Chargement des objets   
			$vb_OK:=F_Planning_OB(1; $2)  //Synchro
			$vb_OK:=F_Planning_OB(6; ta_LesObjets)
			P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
		End if 
		
		
		
	: ($1=5)  //Supprimer
		If ($2=0)
			$vb_OK:=F_Planning_OB(1; 0)  //Synchro
		Else 
			$vb_OK:=F_Planning_OB(2; 0)  //Chargement des objets       
			If (Size of array:C274(ta_LesObjets)>4)
				$vb_OK:=F_Planning_OB(1; tl_LesObjets_ID{1})  //Synchro        
			Else 
				$vb_OK:=F_Planning_OB(1; 0)  //Synchro        
			End if 
			$vb_OK:=F_Planning_OB(6; ta_LesObjets)
			P_Planing_Charger(vd_DateJour; tl_LesObjets_ID{ta_LesObjets}; 1)
		End if 
		
		
		
	: ($1=6)
		va_Plage_1:=""
		va_Plage_2:=""
		va_Plage_3:=""
		va_Plage_4:=""
		va_Plage_5:=""
		va_Plage_6:=""
		
		
		For ($ii; 1; 6)
			For ($kk; 1; 7)
				vp_UnPointeur:=Get pointer:C304("b_Sel_H_"+String:C10($ii)+"_"+String:C10($kk))
				OBJECT SET ENABLED:C1123(vp_UnPointeur->; False:C215)
			End for 
		End for 
		
		OBJECT SET VISIBLE:C603(*; "Masque_@"; True:C214)
		
		If (tl_LesObjets_NbPL{$2}>0)
			For ($ii; 1; tl_LesObjets_NbPL{$2})
				For ($kk; 1; 7)
					vp_UnPointeur:=Get pointer:C304("b_Sel_H_"+String:C10($ii)+"_"+String:C10($kk))
					OBJECT SET ENABLED:C1123(vp_UnPointeur->; True:C214)
				End for 
				OBJECT SET VISIBLE:C603(*; "Masque_"+String:C10($ii); False:C215)
				
				Case of 
					: ($ii=1)
						vh_PlageD_1:=th_LesObjets_Debut_1{$2}+?00:00:00?
						vh_PlageF_1:=th_LesObjets_Fin_1{$2}+?00:00:00?
						va_Plage_1:="P"+String:C10($ii)+" : "+String:C10(vh_PlageD_1; 2)+" - "+String:C10(vh_PlageF_1; 2)
						
					: ($ii=2)
						vh_PlageD_2:=th_LesObjets_Debut_2{$2}+?00:00:00?
						vh_PlageF_2:=th_LesObjets_Fin_2{$2}+?00:00:00?
						va_Plage_2:="P"+String:C10($ii)+" : "+String:C10(vh_PlageD_2; 2)+" - "+String:C10(vh_PlageF_2; 2)
						
					: ($ii=3)
						vh_PlageD_3:=th_LesObjets_Debut_3{$2}+?00:00:00?
						vh_PlageF_3:=th_LesObjets_Fin_3{$2}+?00:00:00?
						va_Plage_3:="P"+String:C10($ii)+" : "+String:C10(vh_PlageD_3; 2)+" - "+String:C10(vh_PlageF_3; 2)
						
					: ($ii=4)
						vh_PlageD_4:=th_LesObjets_Debut_4{$2}+?00:00:00?
						vh_PlageF_4:=th_LesObjets_Fin_4{$2}+?00:00:00?
						va_Plage_4:="P"+String:C10($ii)+" : "+String:C10(vh_PlageD_4; 2)+" - "+String:C10(vh_PlageF_4; 2)
						
					: ($ii=5)
						vh_PlageD_5:=th_LesObjets_Debut_5{$2}+?00:00:00?
						vh_PlageF_5:=th_LesObjets_Fin_5{$2}+?00:00:00?
						va_Plage_5:="P"+String:C10($ii)+" : "+String:C10(vh_PlageD_5; 2)+" - "+String:C10(vh_PlageF_5; 2)
						
					: ($ii=6)
						vh_PlageD_6:=th_LesObjets_Debut_6{$2}+?00:00:00?
						vh_PlageF_6:=th_LesObjets_Fin_6{$2}+?00:00:00?
						va_Plage_6:="P"+String:C10($ii)+" : "+String:C10(vh_PlageD_6; 2)+" - "+String:C10(vh_PlageF_6; 2)
						
				End case 
			End for 
		End if 
End case 

