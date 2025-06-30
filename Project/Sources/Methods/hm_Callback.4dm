//%attributes = {}
// Method hm_Callback  
// 

// #20170605-3

C_LONGINT:C283($0; $L_MyError)

C_LONGINT:C283($0; $1; $2; $3; $6; $7; $8; $vl_area; $vl_event; $vl_appointment; $vl_time1; $vl_time2; $vl_userref; $vl_windowref)
C_DATE:C307($vd_date1; $vd_date2)
C_TIME:C306($vu_time1; $vu_time2)
C_BOOLEAN:C305($B_ganztag)

$vl_area:=$1
$vl_event:=$2
$vl_appointment:=$3
$vd_date1:=$4
$vd_date2:=$5
$vl_time1:=$6
$vl_time2:=$7
$B_ganztag:=($8=1)
$vl_userref:=$9

$vu_time1:=?00:00:00?+$vl_time1
$vu_time2:=?00:00:00?+$vl_time2

C_TEXT:C284($T_Text_erreur)
C_LONGINT:C283($L_Erreur)

C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible)
Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible)

C_TEXT:C284($T_Permanencier)
C_LONGINT:C283($L_ID_Permanencier)
If ($P_Permanenciers_nom->#0)
	$L_ID_Permanencier:=$P_Permanenciers_pk_invisible->{$P_Permanenciers_nom->}
	$T_Permanencier:=$P_Permanenciers_nom->{$P_Permanenciers_nom->}
End if 

C_TEXT:C284($T_Current_user)
$T_Current_user:=Current user:C182
C_BOOLEAN:C305($B_PermaIsCurrent_user)
$B_PermaIsCurrent_user:=($T_Permanencier=$T_Current_user)

C_POINTER:C301($P_LB)
hm_Get_Pointer_LB_usagers(->$P_LB)

Case of 
	: ($vl_event=hmCal_Error)
		
		ALERT:C41("Erreur: "+String:C10($vl_appointment))  // code erreur
		
	: ($vl_event=hmCal_UpdateAppointments)
		
		hm_Display_selection($vl_area; $vd_date1; $vd_date2)
		$L_MyError:=0
		
	: ($vl_event=hmCal_TryDragAppointment) | ($vl_event=hmCal_TryResizeAppointment) | ($vl_event=hmCal_TryNewAppointment)
		
		$L_MyError:=0
		
	: ($vl_event=hmCal_DragAppointment) | ($vl_event=hmCal_ResizeAppointment) | ($vl_event=hmCal_NewAppointment) | ($vl_event=hmCal_DeleteAppointment) | ($vl_event=hmCal_Drop) | ($vl_event=hmCal_DoubleClickApp)
		
		C_LONGINT:C283($L_DroitAjouter; $L_DroitModifier; $L_DroitElargi)
		hm_Cal_Droits("get"; ->$L_DroitAjouter; ->$L_DroitModifier; ->$L_DroitElargi)
		
		C_BOOLEAN:C305($B_Droit_modif; $B_Droit_ajout)
		$B_Droit_modif:=($L_DroitElargi=1) | (($L_DroitModifier=1) & $B_PermaIsCurrent_user)
		$B_Droit_ajout:=($L_DroitElargi=1) | (($L_DroitAjouter=1) & $B_PermaIsCurrent_user)
		
		C_POINTER:C301($P_hmSource)
		C_LONGINT:C283($L_Index; $L_Process)
		
		$P_hmSource:=->$L_Index
		
		hmCal_DRAG AND DROP PROPERTIES($vl_area; $P_hmSource; $L_Index; $L_Process)  // #20170924-1
		
		// Cette partie crée ou modifie un enregistrement
		READ WRITE:C146([APPOINTMENTS:73])
		Case of 
			: ($vl_event=hmCal_NewAppointment) | ($vl_event=hmCal_DoubleClickApp) | (($vl_event=hmCal_Drop) & ($vl_appointment=0))
				
				// cette partie ouvre une fenêtre pour modifier l'enregistrement
				
				
				$L_Erreur:=-1  // si new interdit
				Case of 
					: ($vl_event=hmCal_NewAppointment) | ($vl_event=hmCal_Drop)
						
						//$L_New:=New list
						//APPEND TO LIST($L_New;"Vert";65344)
						//APPEND TO LIST($L_New;"Bleu";33023)
						//APPEND TO LIST($L_New;"Rouge";16711680)
						//APPEND TO LIST($L_New;"Violet";7105727)
						
						C_LONGINT:C283($L_Index)
						$L_Index_permanencier:=$P_Permanenciers_nom->
						
						If ($B_Droit_ajout) & ($L_Index_permanencier>=1)
							
							C_TIME:C306($H_Time1; $H_Time2)
							If ($vl_event=hmCal_Drop)
								$H_Time1:=?00:00:00?+$vl_time1
								$H_Time2:=?00:00:00?+($vl_time1+7200)
							Else 
								$H_Time1:=?00:00:00?+$vl_time1
								$H_Time2:=?00:00:00?+$vl_time2
							End if 
							
							CREATE RECORD:C68([APPOINTMENTS:73])
							MultiSoc_Init_Structure(->[APPOINTMENTS:73])
							[APPOINTMENTS:73]Date1:4:=$vd_date1
							[APPOINTMENTS:73]Time1:5:=$H_Time1
							[APPOINTMENTS:73]Date2:6:=$vd_date2
							[APPOINTMENTS:73]Time2:7:=$H_Time2
							[APPOINTMENTS:73]AllDay:9:=$B_ganztag
							[APPOINTMENTS:73]UserID:10:=$P_Permanenciers_pk_invisible->{$L_Index_permanencier}
							[APPOINTMENTS:73]Statut:13:=1
							[APPOINTMENTS:73]TypeRDV:14:=1
							[APPOINTMENTS:73]Subject:2:="Sanstitre"
							[APPOINTMENTS:73]CreePar:15:=$T_Current_user
							SAVE RECORD:C53([APPOINTMENTS:73])
							
							reu_Toogle_Participation($P_Usagers_pk->{$L_Index}; [APPOINTMENTS:73]ID:1)
							
							$L_MyError:=[APPOINTMENTS:73]ID:1
							
							$L_Erreur:=1  // pour ouvrir la fenetre
						End if 
						
						
					: ($vl_event=hmCal_DoubleClickApp)
						
						$L_Erreur:=hm_Query_appointment($vl_appointment; ->$T_Text_erreur)  // si le double clic est interdit on sera bloqué plus bas
					Else 
						TRACE:C157
				End case 
				
				If (($B_Droit_modif) | ($B_Droit_ajout)) & ($L_Erreur=1)
					
					$vl_windowref:=Open form window:C675([APPOINTMENTS:73]; "entree"; Form fenêtre standard:K39:10; Centrée horizontalement:K39:1; En haut:K39:5; *)
					MODIFY RECORD:C57([APPOINTMENTS:73]; *)
					If (OK=1)
						SAVE RECORD:C53([APPOINTMENTS:73])
						
						$L_MyError:=1
					Else 
						If ($vl_event=hmCal_NewAppointment)
							If ($B_Droit_ajout)
								DELETE RECORD:C58([APPOINTMENTS:73])
							End if 
						End if 
					End if 
					hmCal_UPDATE APPOINTMENTS($vl_area)
				End if 
				
				
			: ($vl_event=hmCal_DragAppointment) | ($vl_event=hmCal_ResizeAppointment) | ($vl_event=hmCal_DeleteAppointment) | ($vl_event=hmCal_Drop)
				
				// Cette partie modifie un enregistrement en tache de fond  sans interface
				$L_Erreur:=hm_Query_appointment($vl_appointment; ->$T_Text_erreur)
				If ($L_Erreur=1) | ($vl_event=hmCal_Drop)  // id rdv sera 0 si on dépose hors rdv
					
					Case of 
						: ($vl_event=hmCal_DragAppointment) | ($vl_event=hmCal_ResizeAppointment)
							
							If ($B_Droit_modif=False:C215)
								
								ALERT:C41("Vous ne pouvez modifier que vos rendez-vous")
								$L_DroitModifier:=0
							End if 
							
							If ($B_Droit_modif)
								
								$L_MyError:=0
								
								[APPOINTMENTS:73]Date1:4:=$vd_date1
								[APPOINTMENTS:73]Time1:5:=?00:00:00?+$vl_time1
								[APPOINTMENTS:73]Date2:6:=$vd_date2
								[APPOINTMENTS:73]Time2:7:=?00:00:00?+$vl_time2
								[APPOINTMENTS:73]AllDay:9:=$B_ganztag
								[APPOINTMENTS:73]UserID:10:=$vl_userref
								SAVE RECORD:C53([APPOINTMENTS:73])
								
							Else 
								$L_MyError:=-1
							End if 
							
						: ($vl_event=hmCal_Drop)
							
							If ($B_Droit_modif=False:C215)
								
								ALERT:C41("Vous ne pouvez modifier que vos rendez-vous")
								
							End if 
							
							If ($B_Droit_modif)
								
								C_TEXT:C284($T_Name1; $T_Name2)
								C_LONGINT:C283($L_Field; $L_Table)
								RESOLVE POINTER:C394($P_hmSource; $T_Name1; $L_Table; $L_Field)
								RESOLVE POINTER:C394($P_LB; $T_Name2; $L_Table; $L_Field)
								
								// #20170616-1 : contournement d'un bug en compilé
								$T_Name1:=Replace string:C233($T_Name1; "$"; "")
								$T_Name2:=Replace string:C233($T_Name2; "$"; "")
								
								Case of 
									: ($L_Process#Current process:C322)
										$L_MyError:=-1
									: ($T_Name1#$T_Name2)
										$L_MyError:=-2
									Else 
										
										Case of 
											: ($vl_appointment=0)
												$L_MyError:=-3
											: ($vd_date1=!00-00-00!)
												$L_MyError:=-4
											: ($vd_date2=!00-00-00!)
												$L_MyError:=-5
											: ($vl_time1=0)
												$L_MyError:=-6
											: ($vl_time2=0)
												$L_MyError:=-7
											Else 
												// Si on dépose sur un rendez-vous valide
												//$L_Erreur:=hm_Query_appointment ($vl_appointment;->$T_Text_erreur)
												
												reu_Toogle_Participation($P_Usagers_pk->{$L_Index}; $vl_appointment)
												
												$L_MyError:=1
										End case 
										
								End case 
								hmCal_UPDATE APPOINTMENTS($vl_area)
								
							End if 
							
						: ($vl_event=hmCal_DeleteAppointment)
							
							If ($L_DroitModifier=1)
								
								If ($L_ID_Permanencier#[APPOINTMENTS:73]UserID:10)
									ALERT:C41("Vous ne pouvez supprimer que vos rendez-vous")
									$L_DroitModifier:=0
								End if 
								
								If ($L_DroitModifier=1)
									
									$L_MyError:=0
									
									CONFIRM:C162("Supprimer ?")
									If (OK=1)
										DELETE SELECTION:C66([APPOINTMENTS:73])
										$L_MyError:=0
									Else 
										$L_MyError:=-1
									End if 
									
								Else 
									$L_MyError:=-1
								End if 
							End if 
							
						Else 
							TRACE:C157
					End case 
				Else 
					$L_MyError:=-999999
				End if 
				
			Else 
				TRACE:C157
		End case 
		UNLOAD RECORD:C212([APPOINTMENTS:73])
		READ ONLY:C145([APPOINTMENTS:73])
		
	: ($vl_event=hmCal_ClickAppointment)
		
		//reu_Lire_Participants ($vl_appointment)
		//reu_reveal_usagers 
		
		
	: ($vl_event=hmCal_DoubleClickArea)
		
	: ($vl_event=hmCal_ClickArea)
		
End case 

$0:=$L_MyError
