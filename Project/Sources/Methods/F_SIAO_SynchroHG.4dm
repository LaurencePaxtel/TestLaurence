//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_SIAO_SynchroHG
//{          Mardi 22 février 2011 à 11:50
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($vl_Fenetre)
Case of 
	: ($1=1)
		ARRAY TEXT:C222(ta_SIAOSync_Titre; 11)
		ARRAY TEXT:C222(ta_SIAOSync_Valeur; 11)
		
		ta_SIAOSync_Titre{1}:="Nationalité"
		ta_SIAOSync_Titre{2}:="Papier administratif"
		ta_SIAOSync_Titre{3}:="Cas spécifique"
		ta_SIAOSync_Titre{4}:="Couverture sociale 1"
		ta_SIAOSync_Titre{5}:="Couverture sociale 2"
		ta_SIAOSync_Titre{6}:="Couverture sociale 2"
		ta_SIAOSync_Titre{7}:="Situation professionnelle"
		ta_SIAOSync_Titre{8}:="Ressources 1"
		ta_SIAOSync_Titre{9}:="Ressources 2"
		ta_SIAOSync_Titre{10}:="Ressources 3"
		ta_SIAOSync_Titre{11}:="Logement ou hébergement actuel"
		//  ta_SIAOSync_Titre{12}:="Motif de la demande"
		
		For ($ii; 1; 11)
			ta_SIAOSync_Valeur{$ii}:=""
		End for 
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$2)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <)
			FIRST RECORD:C50([HeberGement:5])
			ta_SIAOSync_Valeur{1}:=[HeberGement:5]HG_Nationalité:25
			ta_SIAOSync_Valeur{2}:=[HeberGement:5]HG_PiècesIdté1:31
			ta_SIAOSync_Valeur{3}:=[HeberGement:5]HG_FamCasSpéc:111
			ta_SIAOSync_Valeur{4}:=[HeberGement:5]HG_CouvSocial1:53
			ta_SIAOSync_Valeur{5}:=[HeberGement:5]HG_CouvSocial2:54
			ta_SIAOSync_Valeur{6}:=[HeberGement:5]HG_CouvSocial3:55
			ta_SIAOSync_Valeur{7}:=[HeberGement:5]HG_SituProfess:36
			ta_SIAOSync_Valeur{8}:=[HeberGement:5]HG_Ressources1:45
			ta_SIAOSync_Valeur{9}:=[HeberGement:5]HG_Ressources2:46
			ta_SIAOSync_Valeur{10}:=[HeberGement:5]HG_Ressources3:47
			ta_SIAOSync_Valeur{11}:=[HeberGement:5]HG_CentreNom:62
			// ta_SIAOSync_Valeur{12}:=[HeberGement]HG_Métro  `motif de la demande
			
		End if 
		If ($3)
			$vl_Fenetre:=i_FenêtreNo(507; 399; 5; "Actualiser à partir du dernier hébergement"; 4; "")
			DIALOG:C40([DePart:1]; "DL_SIAO_Synchro")
			CLOSE WINDOW:C154($vl_Fenetre)
			$0:=(OK=1)
		Else 
			$0:=True:C214
		End if 
		
	: ($1=2)
		If (ta_SIAOSync_Valeur{1}>"")
			va_SP_Nationalite:=ta_SIAOSync_Valeur{1}
			$vb_OK:=F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Nationalite:23); ->va_SP_Nationalite; ta_SP_Nom)
		End if 
		
		
		If (ta_SIAOSync_Valeur{2}>"")
			va_SP_Papier:=ta_SIAOSync_Valeur{2}
			$vb_OK:=F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_Carte_d_identite_no:26); ->va_SP_Papier; ta_SP_Nom)
		End if 
		
		If (ta_SIAOSync_Valeur{3}>"")
			va_SP_CasSpecific:=ta_SIAOSync_Valeur{3}
			$vb_OK:=F_SIAO_Var_SP(10; vl_SP_Reference; Field:C253(->[SIAO_Personnes:51]Sp_CasSpecific:38); ->va_SP_CasSpecific; ta_SP_Nom)
		End if 
		
		If (ta_SIAOSync_Valeur{4}>"")
			va_Ss_CS_Intitule1:=ta_SIAOSync_Valeur{4}
			$vb_OK:=F_SIAO_Var_SsCS(10; vl_Ss_CS_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_CS_Intitule1; ta_SP_Nom)
		End if 
		
		If (ta_SIAOSync_Valeur{5}>"")
			va_Ss_CS_Intitule2:=ta_SIAOSync_Valeur{5}
			$vb_OK:=F_SIAO_Var_SsCS(10; vl_Ss_CS_Reference2; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_CS_Intitule2; ta_SP_Nom)
		End if 
		If (ta_SIAOSync_Valeur{6}>"")
			va_Ss_CS_Intitule3:=ta_SIAOSync_Valeur{6}
			$vb_OK:=F_SIAO_Var_SsCS(10; vl_Ss_CS_Reference3; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_CS_Intitule3; ta_SP_Nom)
		End if 
		
		If (ta_SIAOSync_Valeur{7}>"")
			va_Ss_SPa_Intitule1:=ta_SIAOSync_Valeur{7}
			$vb_OK:=F_SIAO_Var_SsSP(10; vl_Ss_SPa_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_SPa_Intitule1; ta_SP_Nom)
		End if 
		
		If (ta_SIAOSync_Valeur{8}>"")
			va_Ss_RS_Intitule1:=ta_SIAOSync_Valeur{8}
			$vb_OK:=F_SIAO_Var_SsRS(10; vl_Ss_RS_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_RS_Intitule1; ta_SP_Nom)
		End if 
		If (ta_SIAOSync_Valeur{9}>"")
			va_Ss_RS_Intitule2:=ta_SIAOSync_Valeur{9}
			$vb_OK:=F_SIAO_Var_SsRS(10; vl_Ss_RS_Reference2; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_RS_Intitule2; ta_SP_Nom)
		End if 
		
		If (ta_SIAOSync_Valeur{10}>"")
			va_Ss_RS_Intitule3:=ta_SIAOSync_Valeur{10}
			$vb_OK:=F_SIAO_Var_SsRS(10; vl_Ss_RS_Reference3; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_RS_Intitule3; ta_SP_Nom)
		End if 
		
		
		If (ta_SIAOSync_Valeur{11}>"")
			va_Ss_LGa_Intitule1:=ta_SIAOSync_Valeur{11}
			$vb_OK:=F_SIAO_Var_SsLG(10; vl_Ss_LGa_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_LGa_Intitule1; ta_SP_Nom)
			
		End if 
		If (7=8)
			If (ta_SIAOSync_Valeur{12}>"")
				va_Ss_LGb_Intitule1:=ta_SIAOSync_Valeur{12}  //motif de la demande
				$vb_OK:=F_SIAO_Var_SsLG(10; vl_Ss_LGb_Reference1; Field:C253(->[SIAO_Situations:52]Ss_Intitule:9); ->va_Ss_LGb_Intitule1; ta_SP_Nom)
			End if 
		End if 
		
		
End case 

