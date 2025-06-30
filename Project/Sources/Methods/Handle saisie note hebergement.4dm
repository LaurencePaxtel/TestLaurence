//%attributes = {}
// Method Handle saisie note hebergement gère l'interface de saisie des note hebergement
// 
// #SYNTAX: Handle saisie note hebergement(selecteur) 
// #PARAMETERS:
//     $1 Text            : selecteur

// #DATE CREATION: 21/12/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_TEXT:C284($1)

C_TEXT:C284($T_Selecteur; $T_Item; $T_Timestamp; $T_Etoiles; $T_texte)
C_LONGINT:C283($L_Pos1; $L_Pos2; $L_Page; $L_Item; $L_Note_LG_MAX; $L_Length)
C_POINTER:C301($P_Note_lg; $P_Field)

$T_Selecteur:=$1
$L_Page:=FORM Get current page:C276

GET LIST ITEM:C378(*; "objet_onglet"; *; $L_Item; $T_Item)
$L_Note_LG_MAX:=vl_Note_LG_MAX

$P_Note_lg:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Lgnote_lg")

// Modifié par : Kevin HASSAL (05/12/2018)
// Ajout de la note FVV
Case of 
	: ($L_Page=1)
		$P_Field:=->[HeBerge:4]Notes:6
	: ($L_Page=2)
		$P_Field:=->[HeBerge:4]HB_Notes2:50
	: ($L_Page=3)
		$P_Field:=->[HeBerge:4]HB_Notes3:54
	: ($L_Page=4)
		$P_Field:=->[HeBerge:4]HB_notes4:64
	: ($L_Page=5)
		$P_Field:=->[HeBerge:4]HB_NotesTrans:53
	: ($L_Page=6)
		$P_Field:=->[HeBerge:4]HB_Maraude:41
	: ($L_Page=7)
		$P_Field:=->[HeBerge:4]HB_Maraude2:51
	: ($L_Page=8)
		$P_Field:=->[HeBerge:4]HB_photo:63
	: ($L_Page=9)
		$P_Field:=->[HeBerge:4]HB_Note_FVV:69
	: ($L_Page=10)
		$P_Field:=->[HeBerge:4]HB_Note_Comptable:75
	: ($L_Page=11)
		$P_Field:=->[HeBerge:4]HB_Adresse_Facturation:76
	: ($L_Page=12)
		// Modifié par : Scanu Rémy (13/07/2022)
		$P_Field:=->[HeBerge:4]NotesArchive:81
End case 

Case of 
	: ($T_Selecteur="edit")
		Handle saisie note hebergement("longueur")
	: ($T_Selecteur="timestamp")
		$T_Timestamp:=String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+" - "+<>va_CR
		GET HIGHLIGHT:C209($P_Field->; $L_Pos1; $L_Pos2)
		
		$P_Field->:=Insert string:C231($P_Field->; $T_Timestamp; $L_Pos2)
		$L_Pos2:=$L_Pos2+Length:C16($T_Timestamp)  // #Fix20170424-1
		HIGHLIGHT TEXT:C210($P_Field->; $L_Pos2; $L_Pos2)
		
		Handle saisie note hebergement("longueur")
	: ($T_Selecteur="tab")
		
		If ($L_Page#$L_Item)
			FORM GOTO PAGE:C247($L_Item)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "Lgnote_"; $L_Item#8)
		
		SET TIMER:C645(-1)
	: ($T_Selecteur="trait")
		GET HIGHLIGHT:C209($P_Field->; $L_Pos1; $L_Pos2)
		$T_Etoiles:="\r"+("*"*<>vl_NbEtoilesTrait)+"\r"
		
		$P_Field->:=Insert string:C231($P_Field->; $T_Etoiles; $L_Pos1)
		HIGHLIGHT TEXT:C210($P_Field->; $L_Pos2; $L_Pos2)
		
		Handle saisie note hebergement("longueur")
	: ($T_Selecteur="longueur")
		
		If (Type:C295($P_Field->)#Est une image:K8:10)
			
			If (Form event code:C388=Sur après modification:K2:43)
				$T_texte:=Get edited text:C655
			Else 
				$T_texte:=$P_Field->
			End if 
			
			$L_Length:=Length:C16($T_texte)
			$P_Note_lg->:=$L_Length  // on affiche la longueur dans la variable
			
			OBJECT SET VISIBLE:C603(*; "Lgnote_TropPage"; ($L_Length>$L_Note_LG_MAX))
		End if 
		
	: ($T_Selecteur="curseur_fin")
		
		If (Type:C295($P_Field->)#Est une image:K8:10)
			$L_Pos2:=Length:C16($P_Field->)+1
			HIGHLIGHT TEXT:C210($P_Field->; $L_Pos2; $L_Pos2)
		End if 
		
End case 