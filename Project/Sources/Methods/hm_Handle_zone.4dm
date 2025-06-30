//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 17/11/21, 12:27:18
// ----------------------------------------------------
// Méthode : hm_Handle_zone
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($T_Selecteur)
C_LONGINT:C283($L_Error; $L_Zone; $L_ZoneMini; $L_Style)
C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible)

ARRAY TEXT:C222($rT_Jours; 7)
ARRAY TEXT:C222($rT_Mois; 12)
ARRAY TEXT:C222($rT_Local_permanencier_nom; 0)

ARRAY LONGINT:C221($rT_Local_permanencier_pk; 0)

$T_Selecteur:=$1

Case of 
	: ($T_Selecteur="test")
		$L_Zone:=hm_Get_Zoneref("hmCal")
		$L_ZoneMini:=hm_Get_Zoneref("hmCalmini")
		
		hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_ShowResources; 1)
	: ($T_Selecteur="libre")
		hmCal_SET AREA PROPERTY($P_Zone->; hmCal_prop_ColumnLines; 1)  // pas compris
		hmCal_SET AREA PROPERTY($P_Zone->; hmCal_prop_ShowHeader; 1)
		hmCal_SET AREA PROPERTY($P_Zone->; hmCal_prop_GridHourLine; 30)
	: ($T_Selecteur="register")
		
		If (Is Windows:C1573)
			$L_Error:=hmCal_Register("o7-ABZZ2BAGQAAAAIyANPBoKAAmADLAFwAIVAK6FUr")
		End if 
		
	: ($T_Selecteur="init_@") | ($T_Selecteur="do_@")
		$L_Zone:=hm_Get_Zoneref("hmCal")
		$L_ZoneMini:=hm_Get_Zoneref("hmCalmini")
		
		Case of 
			: ($T_Selecteur="init_@")
				
				Case of 
					: ($T_Selecteur="init_commun_@")  // commun au deux zones
						
						Case of 
							: ($T_Selecteur="@mois")
								$rT_Mois{1}:="Jan."
								$rT_Mois{2}:="Fév."
								$rT_Mois{3}:="Mar."
								$rT_Mois{4}:="Avr."
								$rT_Mois{5}:="Mai"
								$rT_Mois{6}:="Jui."
								$rT_Mois{7}:="Juil."
								$rT_Mois{8}:="Aou."
								$rT_Mois{9}:="Sep."
								$rT_Mois{10}:="Oct."
								$rT_Mois{11}:="Nov."
								$rT_Mois{12}:="Déc."
								
								hmCal_SET MONTH NAMES($L_Zone; $rT_Mois)
								hmCal_mini_SET MONTH NAMES($L_ZoneMini; $rT_Mois)
							: ($T_Selecteur="@jours")
								$rT_Jours{1}:="Lun"
								$rT_Jours{2}:="Mar"
								$rT_Jours{3}:="Mer"
								$rT_Jours{4}:="Jeu"
								$rT_Jours{5}:="Ven"
								$rT_Jours{6}:="Sam"
								$rT_Jours{7}:="Dim"
								
								hmCal_SET WEEKDAY NAMES($L_Zone; $rT_Jours)
								hmCal_mini_SET WEEKDAY NAMES($L_ZoneMini; $rT_Jours)
						End case 
						
					: ($T_Selecteur="@callback_set")
						hmCal_INSTALL CALLBACK($L_Zone; "hm_Callback")
					: ($T_Selecteur="@callback_get")
						ALERT:C41("Nom de la méthode callback: "+hmCal_Get Callback($L_Zone))
					: ($T_Selecteur="@fontstyle")
						$L_Error:=hmCal_Add Stylesheet($L_Zone; 1; "Segoe UI"; 9; Normal:K14:1)
						$L_Error:=hmCal_Apply Stylesheet($L_Zone; 1; 3; 0)
					: ($T_Selecteur="@CurrentTimeIndicator")
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_CurrentTimeIndicator; 1)
						hmCal_SET WORKING HOURS($L_Zone; ?07:00:00?+0; ?22:00:00?+0)
					: ($T_Selecteur="@style_mini")
						
						If (Shift down:C543=False:C215)
							$L_Style:=hmCal_mini_style_classic
						Else 
							$L_Style:=hmCal_mini_style_modern
						End if 
						
						hmCal_mini_SET STYLE($L_ZoneMini; $L_Style)
					: ($T_Selecteur="@display_weeknumber")
						hmCal_mini_DISPLAY WEEK NUMBER($L_ZoneMini; 1)
					: ($T_Selecteur="@nombre_minical")
						hmCal_mini_SET MONTHS($L_ZoneMini; 3)  // nombre de mini cal affichés
					: ($T_Selecteur="@users_@")
						Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible)
						
						Case of 
							: ($T_Selecteur="@add")  // on ajoute les utilisateurs
								//%W-518.1
								COPY ARRAY:C226($P_Permanenciers_nom->; $rT_Local_permanencier_nom)
								COPY ARRAY:C226($P_Permanenciers_pk_invisible->; $rT_Local_permanencier_pk)
								//%W+518.1
								
								C_LONGINT:C283($L_Size_pk; $L_size_nom)
								$L_Size_pk:=Size of array:C274($rT_Local_permanencier_pk)
								$L_size_nom:=Size of array:C274($rT_Local_permanencier_nom)
								
								ASSERT:C1129($L_Size_pk=$L_size_nom; "les tableaux n'ont pas la même taille")
								
								C_LONGINT:C283($i)
								For ($i; 1; $L_size_nom)
									
									C_LONGINT:C283($L_ID)
									$L_ID:=$rT_Local_permanencier_pk{$i}
									C_TEXT:C284($T_Nom)
									$T_Nom:=$rT_Local_permanencier_nom{$i}
									$L_Errocalr:=hmCal_Add User($L_Zone; $L_ID; $T_Nom)
								End for 
								
							: ($T_Selecteur="@users/page")  // le nombre d'utilisateurs par page dans la "Vue permanenciers jour" / hmCal_UserView
								hmCal_SET USERS PER PAGE($L_Zone; 4)
							Else 
								TRACE:C157
						End case 
						
					: ($T_Selecteur="@options")
						hmCal_START ON MONDAY($L_Zone; 1)
						hmCal_mini_START ON MONDAY($L_ZoneMini; 1)
						
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_AllowDragNew; 0)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_OneLineCaption; 0)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_MultiDayArea; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_AllowDragNew; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_Overlapping; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_ScrollAutoHide; 0)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_DisplayTime; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_FreezeView_V; 0)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_ShowMonthHeader; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_IndicateOutsideApp; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_SwitchUser; 1)  // glisser un rendez-vous d'un permanencier à l'autre
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_GhostApppointment; 1)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_TimelineFullHours; 0)
						hmCal_SET AREA PROPERTY($L_Zone; hmCal_prop_SelectionThickness; 10)
						
						hmCal_SET EVENT STATE($L_Zone; hmCal_TryDragAppointment; 0)
						hmCal_SET EVENT STATE($L_Zone; hmCal_TryResizeAppointment; 0)
						hmCal_SET EVENT STATE($L_Zone; hmCal_TryNewAppointment; 0)
						
					Else 
						TRACE:C157
				End case 
				
			: ($T_Selecteur="do_@")
				
				Case of 
					: ($T_Selecteur="@UpdateZone")
						hmCal_UPDATE APPOINTMENTS($L_Zone)
						
					: ($T_Selecteur="@Calmini+1") | ($T_Selecteur="@Calmini-1")  // On fait défiler les mini calendrier
						
						C_LONGINT:C283($L_Month)
						$L_Month:=Num:C11($T_Selecteur)
						
						C_DATE:C307($D_Start)
						$D_Start:=hmCal_mini_Get Start Date($L_ZoneMini)
						$D_Start:=Add to date:C393($D_Start; 0; $L_Month; 0)
						hmCal_mini_SET START DATE($L_ZoneMini; $D_Start)
						
					: ($T_Selecteur="@pasteboard")  // On met une image de la zone dans le presse-papiers
						C_PICTURE:C286($G_Picture)
						$G_Picture:=hmCal_Area To Picture($L_Zone; 1; 0; 0)
						SET PICTURE TO PASTEBOARD:C521($G_Picture)
						BEEP:C151
					Else 
						TRACE:C157
				End case 
				
			Else 
				TRACE:C157
		End case 
		
End case 