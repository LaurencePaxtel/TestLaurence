//%attributes = {}
// Method Planning export gère l'export d'une sélection de rdv du planning APPOINTMENT
// La selection se fait sur :
//    - Permanencier
//    - Usager
//    - Date
//
// La méthode exporte en fonction du sélecteur :
//  - un objet
//  - une variable texte pour un tableur excel
//
// #SYNTAX: $L_Erreur:=Planning export(selecteur;O_Param) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Object          : les propriétés en input et en output

// #DATE CREATION: 28/02/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// #20180306-1

C_LONGINT:C283($0; $L_MyError)
C_TEXT:C284($1; $T_Selecteur)
$T_Selecteur:=$1
If (Count parameters:C259=2)
	C_OBJECT:C1216($2; $O_Param)
	$O_Param:=$2
End if 

$L_MyError:=1
Case of 
	: ($T_Selecteur="object")
		
		ARRAY OBJECT:C1221($rO_Output; 0)
		
		Case of 
			: (OB Is defined:C1231($O_Param; "permanenciers")=False:C215)
				$L_MyError:=-1
			: (OB Is defined:C1231($O_Param; "heberges")=False:C215)
				$L_MyError:=-2
			: (OB Is defined:C1231($O_Param; "date_start")=False:C215)
				$L_MyError:=-3
			: (OB Is defined:C1231($O_Param; "date_end")=False:C215)
				$L_MyError:=-4
			: (OB Is defined:C1231($O_Param; "filtre")=False:C215)
				$L_MyError:=-5
			Else 
				C_DATE:C307($D_Date_start; $D_Date_end)
				$D_Date_start:=!00-00-00!
				$D_Date_end:=!00-00-00!
				
				C_LONGINT:C283($L_Filtre)
				$L_Filtre:=0
				
				ARRAY LONGINT:C221($rL_Permanenciers_ID; 0)
				ARRAY LONGINT:C221($rL_Heberges_ID; 0)
				
				OB GET ARRAY:C1229($O_Param; "permanenciers"; $rL_Permanenciers_ID)
				OB GET ARRAY:C1229($O_Param; "heberges"; $rL_Heberges_ID)
				$D_Date_start:=OB Get:C1224($O_Param; "date_start"; Est une date:K8:7)
				$D_Date_end:=OB Get:C1224($O_Param; "date_end"; Est une date:K8:7)
				$L_Filtre:=OB Get:C1224($O_Param; "filtre"; Est un entier long:K8:6)
				
				C_LONGINT:C283($L_Null)
				$L_Null:=Find in array:C230($rL_Permanenciers_ID; 0)
				Case of 
					: ($L_Null>0)
						$L_MyError:=-10
					: ($D_Date_start>$D_Date_end)
						$L_MyError:=-9
					: ($L_Filtre<=0) | ($L_Filtre>4)
						$L_MyError:=-6
					Else 
						// 1 - Les RDV d'un permancier entre deux dates
						// 2 - Les RDV d'un usager entre deux dates
						// 3 - Les RDV d'usagers avec un permanenciers entre deux dates
						// 4 - Les RDV de tout le monde entre deux dates
						
						QUERY:C277([APPOINTMENTS:73]; [APPOINTMENTS:73]Date1:4>=$D_Date_start; *)
						QUERY:C277([APPOINTMENTS:73];  & ; [APPOINTMENTS:73]Date2:6<=$D_Date_end)
						MultiSoc_Filter(->[APPOINTMENTS:73])
						CREATE SET:C116([APPOINTMENTS:73]; "$appointement_date")
						
						If ($L_Filtre=1) | ($L_Filtre=3)
							// On veut les RDV de 1 ou N permanenciers
							QUERY WITH ARRAY:C644([INtervenants:10]ID:16; $rL_Permanenciers_ID)
							RELATE MANY SELECTION:C340([APPOINTMENTS:73]UserID:10)  // ça donne des [APPOINTMENTS]
							CREATE SET:C116([APPOINTMENTS:73]; "$appointement_permanenciers")
						End if 
						
						If ($L_Filtre=2) | ($L_Filtre=3)
							// On veut les RDV de 1 ou N heberges
							QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $rL_Heberges_ID)
							RELATE MANY SELECTION:C340([APPOINT_REUNION:74]Ref_Heberge:3)  // ça donne des [APPOINT_REUNION]
							RELATE ONE SELECTION:C349([APPOINT_REUNION:74]; [APPOINTMENTS:73])  // ça donne des [APPOINTMENTS]
							CREATE SET:C116([APPOINTMENTS:73]; "$appointement_heberges")
						End if 
						
						
						Case of 
							: ($L_Filtre=1)
								
								// On veut les RDV de 1 ou N permanenciers
								INTERSECTION:C121("$appointement_date"; "$appointement_permanenciers"; "$appointment")
								
							: ($L_Filtre=2)
								
								// On veut les RDV de 1 ou N heberges
								INTERSECTION:C121("$appointement_date"; "$appointement_heberges"; "$appointment")
								
							: ($L_Filtre=3)
								
								INTERSECTION:C121("$appointement_date"; "$appointement_permanenciers"; "$appointment1")
								INTERSECTION:C121("$appointement_date"; "$appointement_heberges"; "$appointment2")
								INTERSECTION:C121("$appointment1"; "$appointment2"; "$appointment")
								
							: ($L_Filtre=4)
								
								COPY SET:C600("$appointement_date"; "$appointment")
								
							Else 
								TRACE:C157
						End case 
						
						USE SET:C118("$appointment")
						
						CLEAR SET:C117("$appointment")
						CLEAR SET:C117("$appointement_date")
						CLEAR SET:C117("$appointement_permanenciers")
						CLEAR SET:C117("$appointement_heberges")
						CLEAR SET:C117("$appointment1")
						CLEAR SET:C117("$appointment2")
						CLEAR SET:C117("$appointement_heberges")
						CLEAR SET:C117("$appointement_permanenciers")
						
						ORDER BY:C49([APPOINTMENTS:73]; [APPOINTMENTS:73]Date1:4; >; [APPOINTMENTS:73]Time1:5; >)
						
						C_LONGINT:C283($i)
						$i:=0
						ARRAY OBJECT:C1221($rO_Output; Records in selection:C76([APPOINTMENTS:73]))
						While (Not:C34(End selection:C36([APPOINTMENTS:73])))
							
							RELATE ONE:C42([APPOINTMENTS:73]UserID:10)
							RELATE MANY:C262([APPOINTMENTS:73]ID:1)
							RELATE ONE SELECTION:C349([APPOINT_REUNION:74]; [HeBerge:4])
							
							ARRAY TEXT:C222($rT_Heberge_cle; 0)
							SELECTION TO ARRAY:C260([HeBerge:4]HB_Clé:2; $rT_Heberge_cle)
							
							$i:=$i+1
							OB SET:C1220($rO_Output{$i}; "rdv_type"; 4DLISTE_Decode_itemref(L_ListeTypeRDV; [APPOINTMENTS:73]TypeRDV:14))
							OB SET:C1220($rO_Output{$i}; "rdv_resultat"; 4DLISTE_Decode_itemref(L_Liste_resultat; [APPOINTMENTS:73]Statut:13))
							OB SET:C1220($rO_Output{$i}; "date_start"; [APPOINTMENTS:73]Date1:4)
							OB SET:C1220($rO_Output{$i}; "time_start"; [APPOINTMENTS:73]Time1:5)
							OB SET:C1220($rO_Output{$i}; "date_end"; [APPOINTMENTS:73]Date2:6)
							OB SET:C1220($rO_Output{$i}; "time_end"; [APPOINTMENTS:73]Time2:7)
							OB SET:C1220($rO_Output{$i}; "permanencier"; [INtervenants:10]IN_NomPrénom:8)
							OB SET:C1220($rO_Output{$i}; "rdv_id"; [APPOINTMENTS:73]ID:1)
							OB SET:C1220($rO_Output{$i}; "rdv_subject"; [APPOINTMENTS:73]Subject:2)
							OB SET ARRAY:C1227($rO_Output{$i}; "heberges"; $rT_Heberge_cle)
							
							NEXT RECORD:C51([APPOINTMENTS:73])
						End while 
				End case 
		End case 
		
		OB SET ARRAY:C1227($O_Param; "output"; $rO_Output)
		
		
	: ($T_Selecteur="txt")
		
		// Les rdv sont exportés dans un format tableur
		
		If (OB Is defined:C1231($O_Param; "output")=False:C215)
			$L_MyError:=-7
		Else 
			
			ARRAY OBJECT:C1221($rO_Output; 0)
			OB GET ARRAY:C1229($O_Param; "output"; $rO_Output)
			C_LONGINT:C283($L_Size)
			$L_Size:=Size of array:C274($rO_Output)
			
			ARRAY TEXT:C222($rT_Output_TXT; 1)
			$rT_Output_TXT{1}:=\
				"ID RDV"+"\t"\
				+"Clé hébergé"+"\t"\
				+"Permanencier"+"\t"\
				+"Date début"+"\t"\
				+"Heure début"+"\t"\
				+"Date fin"+"\t"\
				+"Heure fin"+"\t"\
				+"Type"+"\t"\
				+"Résultat"+"\t"\
				+"Sujet"
			
			C_LONGINT:C283($i; $j)
			For ($i; 1; $L_Size)
				
				ARRAY TEXT:C222($rT_Heberge_cle; 0)
				OB GET ARRAY:C1229($rO_Output{$i}; "heberges"; $rT_Heberge_cle)
				
				If (Size of array:C274($rT_Heberge_cle)=0)
					APPEND TO ARRAY:C911($rT_Heberge_cle; "")  // si un permanencier n'a pas d'usager
				End if 
				
				For ($j; 1; Size of array:C274($rT_Heberge_cle))
					
					C_TEXT:C284($T_Permanencier)
					$T_Permanencier:=OB Get:C1224($rO_Output{$i}; "permanencier"; Est un texte:K8:3)
					
					C_TIME:C306($H_Time_Start; $H_Time_End)
					C_DATE:C307($D_Date_start; $D_Date_end)
					C_TEXT:C284($T_Type; $T_Resultat; $T_RDV_Subject)
					C_LONGINT:C283($L_ID)
					$D_Date_start:=OB Get:C1224($rO_Output{$i}; "date_start"; Est une date:K8:7)
					$D_Date_end:=OB Get:C1224($rO_Output{$i}; "date_end"; Est une date:K8:7)
					$H_Time_Start:=OB Get:C1224($rO_Output{$i}; "time_start"; Est une heure:K8:8)
					$H_Time_End:=OB Get:C1224($rO_Output{$i}; "time_end"; Est une heure:K8:8)
					$T_Type:=OB Get:C1224($rO_Output{$i}; "rdv_type"; Est un texte:K8:3)
					$T_Resultat:=OB Get:C1224($rO_Output{$i}; "rdv_resultat"; Est un texte:K8:3)
					$L_ID:=OB Get:C1224($rO_Output{$i}; "rdv_id"; Est un entier long:K8:6)
					$T_RDV_Subject:=OB Get:C1224($rO_Output{$i}; "rdv_subject"; Est un texte:K8:3)
					
					APPEND TO ARRAY:C911($rT_Output_TXT; \
						String:C10($L_ID)+"\t"\
						+$rT_Heberge_cle{$j}+"\t"\
						+$T_Permanencier+"\t"\
						+String:C10($D_Date_start)+"\t"\
						+String:C10($H_Time_Start)+"\t"\
						+String:C10($D_Date_start)+"\t"\
						+String:C10($H_Time_End)+"\t"\
						+$T_Type+"\t"\
						+$T_Resultat+"\t"\
						+$T_RDV_Subject)
				End for 
			End for 
			
			C_TEXT:C284($T_TXT)
			$T_TXT:=""
			For ($i; 1; Size of array:C274($rT_Output_TXT))
				$T_TXT:=$T_TXT+$rT_Output_TXT{$i}+"\r"
			End for 
			OB SET:C1220($O_Param; "output"; $T_TXT)
		End if 
		
		
	: ($T_Selecteur="debogage")  // Ce sélecteur ne doit être appelé que pour des tests
		
		
		C_DATE:C307($D_Date1; $D_Date2)
		$D_Date1:=!2017-09-01!
		$D_Date2:=Current date:C33
		C_LONGINT:C283($L_Filtre)
		$L_Filtre:=4
		
		ARRAY LONGINT:C221($rL_Permanenciers_ID; 0)
		ARRAY LONGINT:C221($rL_Heberges_ID; 0)
		
		C_OBJECT:C1216($O_Param)
		$O_Param:=New object:C1471("filtre"; $L_Filtre; "date_start"; $D_Date1; "date_end"; $D_Date2; "permanenciers"; $rL_Permanenciers_ID; "heberges"; $rL_Heberges_ID)
		$L_Erreur:=Planning export("object"; $O_Param)
		$L_Erreur:=Planning export("TXT"; $O_Param)
		
		$H_Doc:=Create document:C266("")
		If (OK=1)
			C_TEXT:C284($T_TXT)
			$T_TXT:=OB Get:C1224($O_Param; "output"; Est un texte:K8:3)
			SEND PACKET:C103($H_Doc; $T_TXT)
			CLOSE DOCUMENT:C267($H_Doc)
		End if 
	Else 
		$L_MyError:=-8
End case 

C_TEXT:C284($T_Message)
Case of 
	: ($L_MyError=-1)
		$T_Message:="La propriété permanenciers n'est pas définie"
	: ($L_MyError=-2)
		$T_Message:="La propriété heberges n'est pas définie"
	: ($L_MyError=-3)
		$T_Message:="La propriété date_start n'est pas définie"
	: ($L_MyError=-4)
		$T_Message:="La propriété date_end n'est pas définie"
	: ($L_MyError=-5)
		$T_Message:="La propriété filtre n'est pas définie"
	: ($L_MyError=-6)
		$T_Message:="La valeur du sélecteur filtre vaut "+String:C10($L_Filtre)
	: ($L_MyError=-7)
		$T_Message:="Dans l'export "+$T_Selecteur+" la propriété output n'est pas définie"
	: ($L_MyError=-8)
		$T_Message:="Dans la méthode courante le sélecteur "+$T_Selecteur+" est inconnu"
	: ($L_MyError=-9)
		$T_Message:="La date de début est supérieure à la date de fin"
	: ($L_MyError=-10)
		$T_Message:="Le permanencier n'est pas défini"
	Else 
		$T_Message:="OK"
End case 

OB SET:C1220($O_Param; "message"; $T_Message)

$0:=$L_MyError

// EOM
