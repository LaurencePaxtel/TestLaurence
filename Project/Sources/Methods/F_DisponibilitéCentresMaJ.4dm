//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction:  F_DisponibilitéCentresMaJ
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée : 18 mars 2008 à 15:13:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_DATE:C307($1)  // Date
C_LONGINT:C283($2)  // Afficher ou pas de message

C_TEXT:C284($va_Temp)
C_LONGINT:C283($ii; $vl_Position; $vl_RestantVeille)
C_BOOLEAN:C305($vb_OK)
C_DATE:C307($D_Date_reelle)

// Les disponibilitées du jour
ARRAY TEXT:C222($ta_LCD_DateTypeIDLC; 0)
ARRAY LONGINT:C221($tl_LCD_RestantsVeille; 0)

// Les disponibilitées de la veille
ARRAY TEXT:C222($ta_LCD2_DateTypeIDLC; 0)

ARRAY INTEGER:C220($te_LCD2_Restant; 0)
ARRAY INTEGER:C220($te_LCD2_Remplace; 0)
ARRAY LONGINT:C221($tl_LCD2_Excuse; 0)

$D_Date_reelle:=$1

If ($2=1)
	i_Message("Mise à jour en cours  phase 1...")
End if 

// Recherche des disponibilitées du jour
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=$D_Date_reelle)
MultiSoc_Filter(->[CentresLits:16])

// 04/11/2008
QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)
QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin)
// Fin 04/11/2008

If (Records in selection:C76([CentresLits:16])>0)
	SELECTION TO ARRAY:C260([CentresLits:16]CL_DateTypeIDLC:10; $ta_LCD_DateTypeIDLC; [CentresLits:16]CL_RestantsVeille:16; $tl_LCD_RestantsVeille)
End if 

// Recherche des disponibilitées de la veille ayant des restants
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=($D_Date_reelle-1))
MultiSoc_Filter(->[CentresLits:16])

QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_LC_ID:2>=<>vl_T_CentreCodeDebut; *)  //4/11/2008
QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_LC_ID:2<=<>vl_T_CentreCodeFin; *)  //Fin 4/11/2008
QUERY SELECTION:C341([CentresLits:16];  & ; [CentresLits:16]CL_Restant:7>0)

If (Records in selection:C76([CentresLits:16])>0)
	SELECTION TO ARRAY:C260([CentresLits:16]CL_DateTypeIDLC:10; $ta_LCD2_DateTypeIDLC; [CentresLits:16]CL_Restant:7; $te_LCD2_Restant; [CentresLits:16]CL_Excusés:14; $tl_LCD2_Excuse; [CentresLits:16]CL_Remplacants:28; $te_LCD2_Remplace)
End if 

// Y a t-il des données aujourd'hui et hier ?
$vb_OK:=((Size of array:C274($ta_LCD_DateTypeIDLC)>0) & (Size of array:C274($ta_LCD2_DateTypeIDLC)>0))

If ($vb_OK)  // S'il y a des données aujourd'hui et hier
	
	For ($ii; 1; Size of array:C274($ta_LCD_DateTypeIDLC))
		// Constituer la clé de recherche Centrelit    
		$va_Temp:=String:C10(Year of:C25($D_Date_reelle-1); "0000")+String:C10(Month of:C24($D_Date_reelle-1); "00")+String:C10(Day of:C23($D_Date_reelle-1); "00")+Substring:C12($ta_LCD_DateTypeIDLC{$ii}; 9)
		
		// Recherche dans le tableau de la veille si il ya un centre identique
		$vl_Position:=Find in array:C230($ta_LCD2_DateTypeIDLC; $va_Temp)
		
		If ($vl_Position>0)
			$vl_RestantVeille:=$te_LCD2_Restant{$vl_Position}
			
			If ($vl_RestantVeille<0)
				$vl_RestantVeille:=0
			End if 
			
		End if 
		
		$tl_LCD_RestantsVeille{$ii}:=$vl_RestantVeille
		CLEAR VARIABLE:C89($vl_RestantVeille)
	End for 
	
End if 

If ($2=1)
	CLOSE WINDOW:C154
End if 

//Si il y a des données aujourd'hui et hier
If ($vb_OK)
	
	If ($2=1)
		i_Message("Mise à jour en cours phase 2 et fin...")
	End if 
	
	READ WRITE:C146([CentresLits:16])
	
	For ($ii; 1; Size of array:C274($ta_LCD_DateTypeIDLC))
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateTypeIDLC:10=$ta_LCD_DateTypeIDLC{$ii})
		MultiSoc_Filter(->[CentresLits:16])
		
		If (Records in selection:C76([CentresLits:16])=1)
			P_DisponibilitéCréer(2; ""; $D_Date_reelle; $tl_LCD_RestantsVeille{$ii}; 0; 0; 0; 0)
		End if 
		
	End for 
	
	READ ONLY:C145([CentresLits:16])
	
	If ($2=1)
		CLOSE WINDOW:C154
	End if 
	
End if 