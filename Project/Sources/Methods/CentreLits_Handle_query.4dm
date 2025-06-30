//%attributes = {}
// Method CentreLits_Handle_query  
// 
// 
// #SYNTAX: $L_Erreur:=CentreLits_Handle_query("Selecteur") 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 27/01/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_TEXT:C284($T_JourNuit; $T_Selecteur; $T_Cle)
C_LONGINT:C283($i; $L_Erreur)
C_BOOLEAN:C305($B_Dummy)
C_POINTER:C301($P_CheckBox; $P_Subform)

ARRAY LONGINT:C221($rL_Selection; 0)

$0:=1
$T_Selecteur:=$1

Case of 
	: ($T_Selecteur="chercher")
		
		// Modifié par : Scanu Rémy (20/10/2022)
		If (Length:C16(va_CtrLib)=2) & (outilsCheckCharacterIsNumber(Substring:C12(va_CtrLib; 1; 1))=True:C214) & (outilsCheckCharacterIsNumber(Substring:C12(va_CtrLib; 2; 1))=True:C214)
			$B_Dummy:=F_HebergementCible(2; <>vb_T_ModeCHRS; va_CasRecherche; False:C215; va_CtrLib; 0)
		Else 
			$B_Dummy:=F_HebergementCible(2; <>vb_T_ModeCHRS; va_CasRecherche; False:C215; "@"+va_CtrLib; 0)
		End if 
		
		// checkbox >0 ajouté 24/1/17
		// je retire /laisse de la sélection les centres à zéro
		$P_CheckBox:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "checkbox_sup0")
		
		If ($P_CheckBox->=1)
			LONGINT ARRAY FROM SELECTION:C647([LesCentres:9]; $rL_Selection)
			
			$T_JourNuit:=("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))+("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))
			
			For ($i; Size of array:C274($rL_Selection); 1; -1)
				GOTO RECORD:C242([LesCentres:9]; $rL_Selection{$i})
				
				// #Fix20170517-1
				$T_Cle:=Uut_NumeroteLitsType(vd_DateRecherche; $T_JourNuit)+Uut_NumeroteLitsID([LesCentres:9]LC_RéférenceID:1)
				
				QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateTypeIDLC:10=$T_Cle)
				MultiSoc_Filter(->[CentresLits:16])
				
				If ([CentresLits:16]CL_Restant:7=0)
					DELETE FROM ARRAY:C228($rL_Selection; $i)
				End if 
				
			End for 
			
			CREATE SELECTION FROM ARRAY:C640([LesCentres:9]; $rL_Selection)
		End if 
		
		$L_Erreur:=CentreLits_Handle_query("tri_niveau")
	: ($T_Selecteur="tri_lieu")
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Lieu:5; >; *)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	: ($T_Selecteur="tri_niveau")
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	: ($T_Selecteur="tri_nom")
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	: ($T_Selecteur="nouvelle_date")
		$P_Subform:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "Sous-formulaire1")
		
		REDRAW:C174($P_Subform->)
	Else 
		ASSERT:C1129(False:C215; "Mauvais sélecteur")
End case 

UNLOAD RECORD:C212([LesCentres:9])