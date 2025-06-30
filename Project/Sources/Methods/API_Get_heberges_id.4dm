//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 28/06/18, 15:17:59
// ----------------------------------------------------
// Méthode : API_Get_heberges_id
// Description
// Cette méthode permet de la recherche par refId
// #SYNTAX: $L_Erreur:=API_Get_heberges_id ($O_Data;->$O_Output) 
//
// Paramètres
//     $0 Long            : error code. 1 = OK 
//     $7 Object          : objet avec les para de la requête
//     $7 Pointer         : pointeur sur objet de retour
// ----------------------------------------------------

C_LONGINT:C283($0; $L_MyErreur)
C_TEXT:C284($T_Param)

C_OBJECT:C1216($1; $O_Data)
$O_Data:=$1
C_POINTER:C301($2; $P_Output)
$P_Output:=$2

$L_MyErreur:=MAXLONG:K35:2
Case of 
	: (Not:C34(OB Is defined:C1231($O_Data; "refId")))
		
	Else 
		
		$L_MyErreur:=1
		
		$T_Property:="refId"
		$P_Field:=->[HeBerge:4]HB_ReferenceID:1
		$T_Param:=OB Get:C1224($O_Data; $T_Property; Est un texte:K8:3)
		
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$T_Param)
		MultiSoc_Filter(->[HeBerge:4])
		
		
		$L_Trouve:=Records in selection:C76([HeBerge:4])
		
		ARRAY OBJECT:C1221($rO_Compte_hebergement; $L_Trouve)
		ARRAY OBJECT:C1221($rO_Selection; 0)
		
		If ($L_Trouve>=1)
			//REDUCE SELECTION([HeBerge];5)
			$T_JSON:=Selection to JSON:C1234([HeBerge:4]; SelectionJson_template(->[HeBerge:4]))
			JSON PARSE ARRAY:C1219($T_JSON; $rO_Selection)
			
			ARRAY LONGINT:C221($rL_ReferenceID; 0)
			ARRAY TEXT:C222($rT_Cle; 0)
			ARRAY TEXT:C222($rT_Clefamille; 0)
			SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $rL_ReferenceID; [HeBerge:4]HB_Clé:2; $rT_Cle; [HeBerge:4]HB_CléFam:47; $rT_Clefamille)
			
			C_LONGINT:C283($L_Pos)
			$L_Pos:=Find in array:C230($rL_ReferenceID; 0)
			If ($L_Pos>-1)
				$L_MyErreur:=-1
				$L_Pos:=Find in array:C230($rT_Cle; "")
				If ($L_Pos>-1)
					$L_MyErreur:=-2
				End if 
			End if 
			
			C_LONGINT:C283($L_Count)
			SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Count)
			For ($i; 1; $L_Trouve)
				QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$rL_ReferenceID{$i})  // vers variable !!
				MultiSoc_Filter(->[HeberGement:5])
				OB SET:C1220($rO_Compte_hebergement{$i}; "cle"; $rT_Cle{$i}; "count_fiches"; $L_Count; "clefamille"; $rT_Clefamille{$i})
			End for 
			SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
			
		End if 
		
		
		C_TEXT:C284($T_Message)
		Case of 
			: ($L_MyErreur=-1)
				$T_Message:="Des [HeBerge]HB_ReferenceID à 0 ont été trouvées"
			: ($L_MyErreur=-2)
				$T_Message:="Des clé [HeBerge]HB_Clé vides ont été trouvées"
			Else 
				$T_Message:="OK"
		End case 
		
		OB SET ARRAY:C1227($P_Output->; "heberges"; $rO_Selection)
		OB SET ARRAY:C1227($P_Output->; "count_fiches"; $rO_Compte_hebergement)
		OB SET:C1220($P_Output->; "message"; $T_Message)
		
		
		UNLOAD RECORD:C212([HeBerge:4])
		
End case 

$0:=$L_MyErreur

