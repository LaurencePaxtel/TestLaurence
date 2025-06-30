//%attributes = {}
// Method reu_Toogle_Participation ajoute ou supprime un rendez-vous pour un usager 
// 
// #SYNTAX: $L_Erreur:=reu_Toogle_Participation($L_ID_Usager;$L_ID_RDV) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Long            : ID usager
//     $2 Long            : ID RDV

// #DATE CREATION: 09/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($1; $L_ID_Usager)  // ID de l'usager qui est déposé
$L_ID_Usager:=$1
C_LONGINT:C283($2; $L_ID_RDV)  // ID du RDV qui reçoit l'usager
$L_ID_RDV:=$2

C_LONGINT:C283($L_MyError)
$L_MyError:=1
C_TEXT:C284($T_Message)
$T_Message:=""

C_LONGINT:C283($L_Existe)
SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Existe)

QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$L_ID_Usager)
MultiSoc_Filter(->[HeBerge:4])
If ($L_Existe#1)
	$L_MyError:=-1
Else 
	
	QUERY:C277([APPOINTMENTS:73]; [APPOINTMENTS:73]ID:1=$L_ID_RDV)
	If ($L_Existe#1)
		$L_MyError:=-2
	Else 
		
		C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible)
		Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible)
		
		C_TEXT:C284($T_Nom)
		$T_Nom:=$P_Permanenciers_nom->{$P_Permanenciers_nom->}
		
		$L_Existe:=Num:C11((Length:C16($T_Nom)>0))
		
		If ($L_Existe=0)
			$L_MyError:=-3
		End if 
	End if 
End if 
SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)

If ($L_MyError=1)  // On a un Usager et un RDV
	
	SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Existe)
	QUERY BY FORMULA:C48([APPOINT_REUNION:74]; ([APPOINT_REUNION:74]Ref_Appointment:2=$L_ID_RDV) & ([APPOINT_REUNION:74]Ref_Heberge:3=$L_ID_Usager))
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	
	If ($L_Existe<=1)
		
		If ($L_Existe=0)
			CREATE RECORD:C68([APPOINT_REUNION:74])
			MultiSoc_Init_Structure(->[APPOINT_REUNION:74])
			[APPOINT_REUNION:74]Ref_Appointment:2:=$L_ID_RDV
			[APPOINT_REUNION:74]Ref_Heberge:3:=$L_ID_Usager
			SAVE RECORD:C53([APPOINT_REUNION:74])
			UNLOAD RECORD:C212([APPOINT_REUNION:74])
		Else 
			
			CONFIRM:C162("Cet usager est déjà inscrit à ce rendez-vous.\rQue souhaitez-vous faire ?"; "Je le maintiens sur le rendez-vous"; "Je le supprime de ce rendez-vous")
			If (OK=0)
				QUERY BY FORMULA:C48([APPOINT_REUNION:74]; ([APPOINT_REUNION:74]Ref_Appointment:2=$L_ID_RDV) & ([APPOINT_REUNION:74]Ref_Heberge:3=$L_ID_Usager))
				
				C_BOOLEAN:C305($B_RO)
				$B_RO:=4DTABLE_MakeRW(->[APPOINT_REUNION:74])
				
				C_LONGINT:C283($L_Erreur)
				$L_Erreur:=4DREC_Load_Record(->[APPOINT_REUNION:74]; ->$T_Message)
				If ($L_Erreur=1)
					DELETE SELECTION:C66([APPOINT_REUNION:74])
				Else 
					$L_MyError:=-4
				End if 
				4DTABLE_MakeRW_Restore(->[APPOINT_REUNION:74]; $B_RO)
				
				reu_Toogle_usager($L_ID_Usager)  // masquer l'usager dans la lb
			End if 
		End if 
		
	Else 
		ALERT:C41("Il y a un problème interne avec le participant "+String:C10($L_ID_Usager)+" pour le rendez-vous "+String:C10($L_ID_RDV))
	End if 
	
	
End if 

C_TEXT:C284($T_Message)
Case of 
	: ($L_MyError=-1)
		$T_Message:="Il y a un problème interne avec l'identifiant de l'usager"
	: ($L_MyError=-2)
		$T_Message:="Il y a un problème interne avec l'identifiant du rendez-vous"
	: ($L_MyError=-3)
		$T_Message:="Le permanencier n'a pas été sélectionné"
	: ($L_MyError=-4)
		$T_Message:=$T_Message
	Else 
		$T_Message:="OK"
End case 

If ($L_MyError#1)
	ALERT:C41($T_Message)
End if 

// EOM