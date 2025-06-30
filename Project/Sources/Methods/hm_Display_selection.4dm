//%attributes = {}
// Method hm_Display_selection affiche la sélection d'enregsitrements dans la zone hmCal 
// 
// #SYNTAX: $L_Erreur:=hm_Display_selection 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK

// #DATE CREATION: 08/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_LONGINT:C283($0)

C_LONGINT:C283($1; $L_Zone)
$L_Zone:=$1
C_DATE:C307($2; $D_Date1)
$D_Date1:=$2
C_DATE:C307($3; $D_Date2)
$D_Date2:=$3

C_LONGINT:C283($L_MyError)
$L_MyError:=1

// Détecter :
// la zone affichée
// le type de requête : rdv du permanencier ou rdv de l'usager

C_POINTER:C301($P_Current)
$P_Current:=OBJECT Get pointer:C1124(Objet courant:K67:2)



C_POINTER:C301($P_LB)
hm_Get_Pointer_LB_usagers(->$P_LB)

C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible)
Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible)

C_LONGINT:C283($L_Index_permanencier)
$L_Index_permanencier:=$P_Permanenciers_nom->

$P_RAZ:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "button_raz")

C_LONGINT:C283($L_View)
$L_View:=hmCal_Get View($L_Zone)
Case of 
	: ($L_View=hmCal_DayView) | ($L_View=hmCal_MultiDayView) | ($L_View=hmCal_MonthView)
		
		// on veut surtout savoir si on a cliqué sur la lb usager
		
		If ($P_Current=$P_Permanenciers_nom) | ($P_Current=$P_Usagers_cle) | ($P_Current=$P_Usagers_nom) | ($P_Current=$P_Usagers_pk) | ($L_Index_permanencier#0) | ($P_Current=$P_RAZ)
			
			C_LONGINT:C283($L_Index_permanencier; $L_ID)
			If ($P_Current=$P_Usagers_cle) | ($P_Current=$P_Usagers_nom) | ($P_Current=$P_Usagers_pk)
				
				// rendez-vous de l'usager
				
				$L_ID:=0
				$L_Index_permanencier:=Find in array:C230($P_LB->; True:C214)
				If ($L_Index_permanencier>-1)
					$L_ID:=$P_Usagers_pk->{$L_Index_permanencier}
				End if 
				
				QUERY:C277([APPOINTMENTS:73]; [APPOINT_REUNION:74]Ref_Heberge:3=$L_ID; *)
				QUERY:C277([APPOINTMENTS:73];  & ; [APPOINTMENTS:73]Date1:4>=$D_Date1; *)
				QUERY:C277([APPOINTMENTS:73];  & ; [APPOINTMENTS:73]Date2:6<=$D_Date2)
				MultiSoc_Filter(->[APPOINTMENTS:73])
			Else 
				
				// rendez-vous du permanencier
				
				$L_Index_permanencier:=$P_Permanenciers_nom->
				If ($L_Index_permanencier#0)
					
					$L_ID:=$P_Permanenciers_pk_invisible->{$L_Index_permanencier}
					
					QUERY:C277([APPOINTMENTS:73]; [APPOINTMENTS:73]UserID:10=$L_ID; *)
					QUERY:C277([APPOINTMENTS:73];  & ; [APPOINTMENTS:73]Date1:4>=$D_Date1; *)
					QUERY:C277([APPOINTMENTS:73];  & ; [APPOINTMENTS:73]Date2:6<=$D_Date2)
					MultiSoc_Filter(->[APPOINTMENTS:73])
					
				Else 
					REDUCE SELECTION:C351([APPOINTMENTS:73]; 0)
				End if 
			End if 
		Else 
			
		End if 
		
	: ($L_View=hmCal_UserView) | ($L_View=hmCal_UserMultiDayView)
		
		QUERY BY FORMULA:C48([APPOINTMENTS:73]; ([APPOINTMENTS:73]Date1:4>=$D_Date1) & ([APPOINTMENTS:73]Date2:6<=$D_Date2))
		
	Else 
		ASSERT:C1129(False:C215; "Ce type de calendrier n'est pas pris en charge")
End case 



ARRAY LONGINT:C221($rL_ID; 0)
ARRAY TEXT:C222($rT_Titre; 0)
ARRAY TEXT:C222($rT_Body; 0)
ARRAY DATE:C224($rD_Date1; 0)
ARRAY LONGINT:C221($rL_Time1; 0)
ARRAY DATE:C224($rD_Date2; 0)
ARRAY LONGINT:C221($rL_Time2; 0)
ARRAY BOOLEAN:C223($rB_AllDay; 0)
ARRAY LONGINT:C221($rL_UserID; 0)
ARRAY TEXT:C222($rT_HelpTip; 0)
ARRAY BOOLEAN:C223($rB_ReminderIcon; 0)
ARRAY BOOLEAN:C223($rB_Locked; 0)
ARRAY INTEGER:C220($rI_Statut; 0)

//SELECTION TO ARRAY([APPOINTMENTS]ID;$rL_ID;[APPOINTMENTS]Subject;$rT_Titre;[APPOINTMENTS]Body;$rT_Body;[APPOINTMENTS]Date1;$rD_Date1;[APPOINTMENTS]Time1;$rL_Time1;[APPOINTMENTS]Date2;$rD_Date2;[APPOINTMENTS]Time2;$rL_Time2;[APPOINTMENTS]AllDay;$rB_All\
Day;[APPOINTMENTS]UserID;$rL_UserID;[APPOINTMENTS]Tiptext;$rT_HelpTip;[APPOINTMENTS]Reminder;$rB_ReminderIcon;[APPOINTMENTS]Lock;$rB_Locked;[APPOINTMENTS]Statut;$rI_Statut)\

C_LONGINT:C283($i)
For ($i; 1; Records in selection:C76([APPOINTMENTS:73]))
	
	APPEND TO ARRAY:C911($rL_ID; [APPOINTMENTS:73]ID:1)
	APPEND TO ARRAY:C911($rT_Titre; [APPOINTMENTS:73]Subject:2)
	APPEND TO ARRAY:C911($rD_Date1; [APPOINTMENTS:73]Date1:4)
	APPEND TO ARRAY:C911($rL_Time1; [APPOINTMENTS:73]Time1:5)
	APPEND TO ARRAY:C911($rD_Date2; [APPOINTMENTS:73]Date2:6)
	APPEND TO ARRAY:C911($rL_Time2; [APPOINTMENTS:73]Time2:7)
	APPEND TO ARRAY:C911($rB_AllDay; [APPOINTMENTS:73]AllDay:9)
	APPEND TO ARRAY:C911($rL_UserID; [APPOINTMENTS:73]UserID:10)
	APPEND TO ARRAY:C911($rT_HelpTip; [APPOINTMENTS:73]Tiptext:8)
	APPEND TO ARRAY:C911($rB_ReminderIcon; [APPOINTMENTS:73]Reminder:11)
	APPEND TO ARRAY:C911($rB_Locked; [APPOINTMENTS:73]Lock:12)
	APPEND TO ARRAY:C911($rI_Statut; [APPOINTMENTS:73]Statut:13)
	
	// construction du corps du rdv
	RELATE ONE:C42([APPOINTMENTS:73]UserID:10)  // avoir le permanencier
	RELATE MANY:C262([APPOINTMENTS:73]ID:1)  // avoir les usagers
	
	
	// permanencier
	C_TEXT:C284($T_Permanencier)
	$T_Permanencier:=[INtervenants:10]IN_NomPrénom:8
	
	
	// Usager
	ARRAY LONGINT:C221($rL_ID_Usager; 0)
	SELECTION TO ARRAY:C260([APPOINT_REUNION:74]Ref_Heberge:3; $rL_ID_Usager)
	QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $rL_ID_Usager)
	
	
	C_TEXT:C284($T_Usager)
	$T_Usager:=Choose:C955(Records in selection:C76([HeBerge:4])=0; "Aucun usager\r"; "")
	
	C_LONGINT:C283($j)
	For ($j; 1; Records in selection:C76([HeBerge:4]))
		
		C_TEXT:C284($T_Tel)
		$T_Tel:=Choose:C955(Length:C16([HeBerge:4]HB_Telephone:66)>0; "\rTel. "+[HeBerge:4]HB_Telephone:66; "")
		$T_Usager:=$T_Usager+[HeBerge:4]HB_Nom:3+" "+Uppercase:C13(Substring:C12([HeBerge:4]HB_Prénom:4; 1; 1))+$T_Tel+"\r"
		
		NEXT RECORD:C51([HeBerge:4])
	End for 
	
	// résumé
	C_TEXT:C284($T_Resume)
	$T_Resume:=""
	If (Length:C16([APPOINTMENTS:73]Body:3)>0)
		$T_Resume:="\rRésumé:\r"+[APPOINTMENTS:73]Body:3
	End if 
	
	C_TEXT:C284($T_TypeRDV)
	$T_TypeRDV:=4DLISTE_Decode_itemref(L_ListeTypeRDV; [APPOINTMENTS:73]TypeRDV:14)
	
	// le contenu varie selon le type de calendrier
	C_TEXT:C284($T_Body)
	$T_Body:=""
	If ($P_Current=$P_Permanenciers_nom) | ($L_Index_permanencier#0) | ($P_Current=$P_Usagers_cle) | ($P_Current=$P_Usagers_pk) | ($P_Current=$P_Usagers_nom)
		
		
		C_BOOLEAN:C305($B_Source_LB)
		$B_Source_LB:=($P_Current=$P_Usagers_cle) | ($P_Current=$P_Usagers_pk) | ($P_Current=$P_Usagers_nom)
		// $B_Source_LB : vrai, on veut connaitre les rdv de l'usager et avec qui
		
		Case of 
			: ($L_View=hmCal_DayView) | ($L_View=hmCal_MultiDayView) | ($L_View=hmCal_MonthView)
				
				Case of 
					: ($L_View=hmCal_DayView)
						
						If ($B_Source_LB)
							$T_Body:=$T_Permanencier+"\r"+$T_TypeRDV
						Else 
							$T_Body:=$T_Usager
							$T_Body:=$T_Body+"\r"+$T_TypeRDV+"\r"+$T_Resume
						End if 
						
					: ($L_View=hmCal_MultiDayView)
						
						If ($B_Source_LB)
							$T_Body:=$T_Permanencier+"\r"+$T_TypeRDV
						Else 
							$T_Body:=$T_Usager
							$T_Body:=$T_Body+"\r"+$T_TypeRDV+"\r"+$T_Resume
						End if 
						
					: ($L_View=hmCal_MonthView)
						
						If ($B_Source_LB)
							$T_Body:=$T_Permanencier+" "+$T_TypeRDV
						Else 
							$T_Body:=$T_Usager+" "+$T_TypeRDV
						End if 
					Else 
						TRACE:C157
				End case 
				
		End case 
	Else 
		
	End if 
	
	APPEND TO ARRAY:C911($rT_Body; $T_Body)
	NEXT RECORD:C51([APPOINTMENTS:73])
End for 





C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($rL_ID))
	
	If ($L_MyError=1)
		
		// Couleur de l'entête
		C_LONGINT:C283($L_Statut)
		$L_Statut:=$rI_Statut{$i}
		Case of 
			: ($L_Statut=1)
				$L_Color:=65344
			: ($L_Statut=2)
				$L_Color:=33023
			: ($L_Statut=3)
				$L_Color:=16711680
			: ($L_Statut=4)
				$L_Color:=7105727
			Else 
				$L_Color:=20000
		End case 
		
		C_LONGINT:C283($L_Red; $L_Green; $L_Blue)
		$L_Red:=(($L_Color & 0x00FF0000) >> 16) << 8
		$L_Green:=(($L_Color & 0xFF00) >> 8) << 8
		$L_Blue:=($L_Color & 0x00FF) << 8
		hmCal_SET COLOR NEW($L_Zone; hmCal_clr_AppNewBackground; 0; 0; $L_Red; $L_Green; $L_Blue; 100)
		// fin couleur
		
		Case of 
			: (hmCal_Add Appointment($L_Zone; $rL_ID{$i}; $rT_Titre{$i}; $rT_Body{$i}; Num:C11($rB_AllDay{$i}); $rD_Date1{$i}; $rL_Time1{$i}; $rD_Date2{$i}; $rL_Time2{$i}; $rL_UserID{$i})#0)
				$L_MyError:=-1
			: (hmCal_Set App Property($L_Zone; $rL_ID{$i}; hmCal_aprop_Tiptext; 0; $rT_HelpTip{$i}; !00-00-00!)#0)
				$L_MyError:=-2
			: (hmCal_Set App Property($L_Zone; $rL_ID{$i}; hmCal_aprop_Icon; 0; ""; !00-00-00!)#0)
				$L_MyError:=-3
			: (hmCal_Set App Property($L_Zone; $rL_ID{$i}; hmCal_aprop_Lock; Num:C11($rB_Locked{$i}); ""; !00-00-00!)#0)
				$L_MyError:=-4
			Else 
				$L_MyError:=1
		End case 
		ASSERT:C1129($L_MyError=1; "problème pour recrééer les rendez-vous")
	End if 
End for 


$0:=$L_MyError

// EOM