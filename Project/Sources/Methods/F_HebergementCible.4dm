//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_HebergementCible
//{
//{          Jeudi 10 janvier 2008 à 14:13
//{          Modifiée : 7 octobre 2008 à 10:43
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)  //Origine de l'appel
C_BOOLEAN:C305($2)  //CHRS ou 115
C_TEXT:C284($3)  //Jour ou nuit OU P_RESTATION ou H_ÉBERGEMENT
C_BOOLEAN:C305($4)  //Fiche clôturée
C_TEXT:C284($5)
C_LONGINT:C283($6)

C_TEXT:C284($T_Cas_JourNuit_PrestaHeberge; $T_GroupeRecherche; $va_Temp)
C_LONGINT:C283($L_Appel_origine)
C_BOOLEAN:C305($B_EstCHRS; $B_FicheCloturee)

$L_Appel_origine:=$1
$B_EstCHRS:=$2
$T_Cas_JourNuit_PrestaHeberge:=$3
$B_FicheCloturee:=$4
$T_GroupeRecherche:=$5

Case of 
	: ($L_Appel_origine=0)
		
		If ($B_FicheCloturee=False:C215)
			
			If ($6=1)
				va_HGGP_CentreNom:=""
				va_HGGP_CentreARR:=""
				
				vl_HGGP_LC_ID:=0
				
				vb_HGGP_Médicalisé:=False:C215
				
				$0:=True:C214
			Else 
				[HeberGement:5]HG_CentreNom:62:=""
				[HeberGement:5]HG_CentreARR:63:=""
				
				[HeberGement:5]HG_LC_ID:61:=0
				
				[HeberGement:5]HG_Médicalisé:56:=False:C215
			End if 
			
		End if 
		
	: ($L_Appel_origine=1)
		
		If ($B_FicheCloturee=False:C215)
			
			// Est-ce un hébergement ou une prestation
			If ($B_EstCHRS) & ($T_Cas_JourNuit_PrestaHeberge="N")  // Ici = CHRS et Nuit donc c'est une prestation
				$va_Temp:="P"
			Else 
				$va_Temp:="H"
			End if 
			
			If (F_HebergementPrestation($va_Temp; <>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; !00-00-00!; $T_GroupeRecherche))
				
				If ($6=1)
					va_HGGP_CentreNom:=va_RH_Typ1
					va_HGGP_CentreARR:=va_RH_Typ2
					vl_HGGP_LC_ID:=vl_RH_RéfID
					vb_HGGP_Médicalisé:=vb_RH_Médic
					
					$0:=True:C214
				Else 
					[HeberGement:5]HG_CentreNom:62:=va_RH_Typ1
					[HeberGement:5]HG_CentreARR:63:=va_RH_Typ2
					[HeberGement:5]HG_LC_ID:61:=vl_RH_RéfID
					[HeberGement:5]HG_Médicalisé:56:=vb_RH_Médic
				End if 
				
			End if 
			
		End if 
		
	: ($L_Appel_origine=2)
		
		Case of 
			: ($T_Cas_JourNuit_PrestaHeberge="P")
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)  //3/2/2009
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)  //3/2/2009 
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Plateforme:56=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"); *)
				
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=True:C214)
				
				// Modifié par : Scanu Rémy (24/05/2022)
				If ($T_GroupeRecherche>"")
					QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Nom:4=F_Joker("D+F+"; $T_GroupeRecherche); *)  //6/3/2012
					QUERY SELECTION:C341([LesCentres:9];  | ; [LesCentres:9]LC_Lieu:5="@"+$T_GroupeRecherche+"@")
				End if 
				
				// Modifié par : Scanu Rémy (03/02/2023)
				QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Fermé:53=False:C215)
				
				MultiSoc_Filter(->[LesCentres:9])
			: ($T_Cas_JourNuit_PrestaHeberge="H")
				
				// Modifié 24/1/17
				// En Mode 115 et en CHRS on ne montre plus les centres fermés
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)
				
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215; *)
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Fermé:53=False:C215)
				
				// Modifié par : Scanu Rémy (24/05/2022)
				Case of 
					: ($B_EstCHRS)
						
						If ($T_GroupeRecherche>"")
							QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Nom:4=F_Joker("D+F+"; $T_GroupeRecherche); *)  //6/3/2012
							QUERY SELECTION:C341([LesCentres:9];  | ; [LesCentres:9]LC_Lieu:5=Replace string:C233("@"+$T_GroupeRecherche+"@"; Char:C90(Arobase:K15:46)+Char:C90(Arobase:K15:46); ""))
						End if 
						
						If (<>va_Trans_CentrePlateforme>"")
							QUERY SELECTION:C341([LesCentres:9];  & ; [LesCentres:9]LC_Nom:4=("@"+<>va_Trans_CentrePlateforme+"@"))
						End if 
						
					: ($T_GroupeRecherche>"")
						QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Nom:4=F_Joker("D+F+"; $T_GroupeRecherche); *)  //6/3/2012
						QUERY SELECTION:C341([LesCentres:9];  | ; [LesCentres:9]LC_Lieu:5=Replace string:C233("@"+$T_GroupeRecherche+"@"; Char:C90(Arobase:K15:46)+Char:C90(Arobase:K15:46); ""))
				End case 
				
				MultiSoc_Filter(->[LesCentres:9])
		End case 
		
	: ($L_Appel_origine=3)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)  //3/2/2009
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)  //3/2/2009
		
		If ($B_EstCHRS)
			
			If ($T_GroupeRecherche>"")
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Plateforme:56=($T_GroupeRecherche+"@"); *)
			End if 
			
			If (<>va_Trans_CentrePlateforme>"")
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Nom:4=F_Joker("D+F+"; <>va_Trans_CentrePlateforme); *)  //6/3/2012
			End if 
			
		Else 
			
			If ($T_GroupeRecherche>"")
				QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Plateforme:56=($T_GroupeRecherche+"@"); *)
			End if 
			
		End if 
		
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Prestation:55=False:C215; *)
		QUERY:C277([LesCentres:9];  & ; [LesCentres:9]LC_Fermé:53=False:C215)
		
		MultiSoc_Filter(->[LesCentres:9])
	Else 
		TRACE:C157
End case 