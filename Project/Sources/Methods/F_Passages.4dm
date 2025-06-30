//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_Passages
//{
//{          Lundi 14 décembre 2009 à 15:35:00
//{          Modifiée : 28/10/2010
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_TEXT:C284($position_t; $servicePrevious_t)
C_LONGINT:C283($ii)

Case of 
	: ($1=0)  // Initialisation des variables
		C_LONGINT:C283(vl_Pas_Position)
		C_BOOLEAN:C305(vb_Pas_Départ)
		C_DATE:C307(vd_Pas_Date)
		
		// Modifié par : Scanu Rémy (02/05/2023)
		// Ajout d'un tableau pour le service
		ARRAY TEXT:C222(service_at; 0)
		ARRAY TEXT:C222(tt_PasS_Service; 0)
		
		ARRAY INTEGER:C220(tl_Pas_Nuit; 0)
		ARRAY INTEGER:C220(tl_Pas_NuitT; 0)
		
		ARRAY LONGINT:C221(tl_Pas_Réf; 0)
		
		// Modifié par : Scanu Rémy (03/08/2022)
		// Ajout d'un tableau pour savoir pour chaque période à quel bien il correspond
		ARRAY LONGINT:C221(tl_Pas_LCID; 0)
		ARRAY LONGINT:C221(tl_PasS_LCID; 0)
		
		ARRAY LONGINT:C221(tl_PasS_Séjour; 0)
		ARRAY LONGINT:C221(tl_PasS_NbNuits; 0)
		
		ARRAY DATE:C224(td_Pas_Date; 0)
		ARRAY DATE:C224(td_PasS_Date1; 0)
		ARRAY DATE:C224(td_PasS_Date2; 0)
		
		ARRAY BOOLEAN:C223(tb_Pas_Nuit; 0)
		ARRAY BOOLEAN:C223(tb_Pas_Cloture; 0)
	: ($1=1)  // Recherche des données pour les traiter et les afficher dans le formulaire [DiaLogues]DL_Passages
		F_Passages(0; 0)
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215)
		MultiSoc_Filter(->[HeberGement:5])
		
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; >; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; >)
		
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Pas_Réf; [HeberGement:5]HG_LC_ID:61; tl_Pas_LCID; [HeberGement:5]HG_Date:4; td_Pas_Date; [HeberGement:5]HG_Nuit:2; tb_Pas_Nuit; [HeberGement:5]HG_Cloturée:67; tb_Pas_Cloture; [HeberGement:5]HG_NuitenCours:92; \
			tl_Pas_Nuit; [HeberGement:5]HG_NuitTOTAL:93; tl_Pas_NuitT; [HeberGement:5]HG_FamGroupe:102; service_at)
		
		F_Passages(2; 0)
		
		If (Size of array:C274(td_Pas_Date)>0) & (Count parameters:C259=2)
			$position_t:="center"
			outilsCreateWindowsForm("DL_Passages"; ->$position_t; Null:C1517; ->[DiaLogues:3])
		End if 
		
		If (Count parameters:C259=2)
			QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
			
			var $modeCHRS_b : Boolean
			If (Session:C1714.storage.societe.ModeCHRS#Null:C1517)
				$modeCHRS_b:=Session:C1714.storage.societe.ModeCHRS
			Else 
				$modeCHRS_b:=Storage:C1525.societeDetail.ModeCHRS
			End if 
			If ($modeCHRS_b)
				
				If (wSansFiltre=1)
					var $plateForm_t : Text
					$plateForm_t:=(Session:C1714.storage.intervenant.Plateforme#Null:C1517) ? Session:C1714.storage.intervenant.Plateforme : Storage:C1525.intervenantsDetail.UserPlateforme
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12($plateForm_t; 1; 4)+"@"))
				End if 
				
			End if 
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
			
			FIRST RECORD:C50([HeberGement:5])
			PREVIOUS RECORD:C110([HeberGement:5])
			
			vl_Nb_HG_F:=Records in selection:C76([HeberGement:5])
		End if 
		
	: ($1=2)  // Remplissage des tableaux utilisés dans le formulaire [DiaLogues]DL_Passages
		vl_Pas_Nombres:=0
		vl_Pas_NombresNuits:=0
		vl_Pas_Position:=1
		
		vb_Pas_Départ:=False:C215
		
		If (Size of array:C274(td_Pas_Date)>0)
			vd_Pas_Date:=td_Pas_Date{1}
			
			// Modifié par : Scanu Rémy (02/05/2023)
			$servicePrevious_t:=service_at{1}
		Else 
			vd_Pas_Date:=!00-00-00!
		End if 
		
		F_Passages(3; vl_Pas_Position)
		
		tl_PasS_Séjour{vl_Pas_Position}:=vl_Pas_Position
		
		td_PasS_Date1{vl_Pas_Position}:=vd_Pas_Date
		td_PasS_Date2{vl_Pas_Position}:=vd_Pas_Date
		
		// Modifié par : Scanu Rémy (03/08/2022) et Re-modifié par Scanu Rémy (12/03/2023)
		If (Size of array:C274(tl_Pas_LCID)>0)
			tl_PasS_LCID{vl_Pas_Position}:=tl_Pas_LCID{1}
		End if 
		
		If (Size of array:C274(service_at)>0)
			tt_PasS_Service{vl_Pas_Position}:=service_at{1}
		End if 
		
		tl_PasS_NbNuits{vl_Pas_Position}:=0
		vl_Pas_HGNombres:=Size of array:C274(td_Pas_Date)
		
		For ($ii; 1; Size of array:C274(td_Pas_Date))
			
			// Modifié par : Scanu Rémy (02/05/2023)
			If (vd_Pas_Date=td_Pas_Date{$ii}) & (service_at{$ii}=$servicePrevious_t)  // Si le séjour suit le séjour précédent et qu'il est dans le même service, on met à jour la ligne
				vd_Pas_Date:=Add to date:C393(vd_Pas_Date; 0; 0; 1)
				
				tl_PasS_NbNuits{vl_Pas_Position}:=tl_PasS_NbNuits{vl_Pas_Position}+1
				vl_Pas_NombresNuits:=vl_Pas_NombresNuits+1
				
				td_PasS_Date2{vl_Pas_Position}:=td_Pas_Date{$ii}
				
				// Modifié par : Scanu Rémy (03/08/2022)
				tl_PasS_LCID{vl_Pas_Position}:=tl_Pas_LCID{$ii}
			Else 
				vd_Pas_Date:=td_Pas_Date{$ii}
				vl_Pas_Position:=vl_Pas_Position+1
				
				F_Passages(3; vl_Pas_Position)
				
				tl_PasS_Séjour{vl_Pas_Position}:=vl_Pas_Position
				
				td_PasS_Date1{vl_Pas_Position}:=vd_Pas_Date
				td_PasS_Date2{vl_Pas_Position}:=vd_Pas_Date
				
				tl_PasS_NbNuits{vl_Pas_Position}:=1
				vl_Pas_NombresNuits:=vl_Pas_NombresNuits+1
				
				vd_Pas_Date:=Add to date:C393(vd_Pas_Date; 0; 0; 1)
			End if 
			
			// Modifié par : Scanu Rémy (03/05/2023)
			tt_PasS_Service{vl_Pas_Position}:=service_at{$ii}
			$servicePrevious_t:=service_at{$ii}
		End for 
		
		vl_Pas_Nombres:=Size of array:C274(tl_PasS_Séjour)
	: ($1=3)
		INSERT IN ARRAY:C227(tl_PasS_Séjour; $2)
		
		INSERT IN ARRAY:C227(td_PasS_Date1; $2)
		INSERT IN ARRAY:C227(td_PasS_Date2; $2)
		
		INSERT IN ARRAY:C227(tl_PasS_NbNuits; $2)
		
		// Modifié par : Scanu Rémy (03/08/2022)
		INSERT IN ARRAY:C227(tl_PasS_LCID; $2)
		
		// Modifié par : Scanu Rémy (03/05/2023)
		INSERT IN ARRAY:C227(tt_PasS_Service; $2)
End case 