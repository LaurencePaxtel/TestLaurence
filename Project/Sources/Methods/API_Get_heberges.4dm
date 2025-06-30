//%attributes = {}
// Method API_Get_heberges retourne une selection d'heberges 
// 
// 
// #SYNTAX: $L_Erreur:=API_Get_heberges ($O_Data;->$O_Output) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK 
//     $7 Object          : objet avec les para de la requête
//     $7 Pointer         : pointeur sur objet de retour

// #DATE CREATION: 16/02/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_LONGINT:C283($0; $L_MyErreur)

C_OBJECT:C1216($1; $O_Data)
$O_Data:=$1
C_POINTER:C301($2; $P_Output)
$P_Output:=$2

$L_MyErreur:=MAXLONG:K35:2
Case of 
	: (Not:C34(OB Is defined:C1231($O_Data; "nom")))
	: (Not:C34(OB Is defined:C1231($O_Data; "prenom")))
	: (Not:C34(OB Is defined:C1231($O_Data; "date")))
	: (Not:C34(OB Is defined:C1231($O_Data; "telephone")))
	Else 
		
		$L_MyErreur:=1
		
		ARRAY TEXT:C222($rT_Nom; 0)
		ARRAY TEXT:C222($rT_Prenom; 0)
		ARRAY TEXT:C222($rT_Date; 0)
		ARRAY TEXT:C222($rT_Telephone; 0)
		
		ALL RECORDS:C47([HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		For ($i; 1; 4)
			
			C_POINTER:C301($P_Array)
			Case of 
				: ($i=1)
					$T_Property:="nom"
					$P_Array:=->$rT_Nom
					$P_Field:=->[HeBerge:4]HB_Nom:3
				: ($i=2)
					$T_Property:="prenom"
					$P_Array:=->$rT_Prenom
					$P_Field:=->[HeBerge:4]HB_Prénom:4
				: ($i=3)
					$T_Property:="date"
					$P_Array:=->$rT_Date
					$P_Field:=->[HeBerge:4]HB_DateNéLe:5
				: ($i=4)
					$T_Property:="telephone"
					$P_Array:=->$rT_Telephone
					$P_Field:=->[HeBerge:4]HB_Telephone:66
				Else 
					//TRACE
			End case 
			
			$T_Param:=OB Get:C1224($O_Data; $T_Property; Est un texte:K8:3)
			4DCAR_Split_String($P_Array; ","; $T_Param)
			
			If (Size of array:C274($P_Array->)>=1)
				
				If ($P_Array->{1}#"")
					GET FIELD PROPERTIES:C258($P_Field; $L_FieldType)
					Case of 
						: ($L_FieldType=Est une date:K8:7)
							
							ARRAY DATE:C224($rD_Date; 0)
							Cast($P_Array; ->$rD_Date)
							$P_Array:=->$rD_Date
						Else 
							// Pas besoin de changer le contenu du tableau
					End case 
					QUERY SELECTION WITH ARRAY:C1050($P_Field->; $P_Array->)
				End if 
			End if 
		End for 
		
		// on a une sélection de centres
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

// EOM
