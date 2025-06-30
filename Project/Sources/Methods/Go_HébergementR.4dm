//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Hébergement
//{
//{          Mercredi 23 mars 2001 à 16:43
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284($T_Window_titre)
C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305($vb_OK; $B_Dummy)

C_TEXT:C284(va_TransFrom; va_GPClé; va_Transfert_HBAlors; va_Transfert_Centre; va_JourNuit; va_FormatFrom)
C_BOOLEAN:C305(vb_Show)

C_TEXT:C284($formEntree_t)
C_OBJECT:C1216($position_o)

$position_o:=New object:C1471("ecartHautEcran"; Tool bar height:C1016+Menu bar height:C440+10; "ecartBasEcran"; 70)

If ($2="V") | ($2="P") | ($2="G")
	vb_Show:=False:C215
Else 
	vb_Show:=True:C214
End if 

If (vb_Show)
	Général_Hide
End if 

READ ONLY:C145(*)
SET MENU BAR:C67(1)

F_LesOrientes(-1)

V_HG_Dec(0)
V_HG_Dec(1)

$B_Dummy:=F_VariablesTransite(0; 1; False:C215)
$B_Dummy:=F_VariablesTransite(1; 1; False:C215)

$vb_OK:=F_SIAO_DansHebergement("Declarer")

V_HG_Famille(-1)

MESSAGES OFF:C175

va_JourNuit:=$1
va_FormatFrom:=$2

F_Report_FullDuplexTableau

$vb_OK:=F_Regional_RefsTableau(0)
$vb_OK:=F_Prestation_RefsTableau(0; 0)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=$3)
MultiSoc_Filter(->[HeberGement:5])

If (Records in selection:C76([HeberGement:5])=1)
	READ WRITE:C146([HeberGement:5])
	
	If (i_NonVerrou(->[HeberGement:5]))
		
		If (([HeberGement:5]HG_Nuit:2=False:C215) | (<>vb_T_ModeCHRS=False:C215)) | (<>vb_T_EcranGrand)
			$formEntree_t:="HG_EcranSaisie_B"
		Else 
			$formEntree_t:="HG_EcranSaisie"
		End if 
		
		FORM SET INPUT:C55([HeberGement:5]; $formEntree_t)
		
		P_HébergementProfil(va_JourNuit; [HeberGement:5]HG_Permanencier:9)
		$T_Window_titre:="Hébergement : "+Choose:C955(va_JourNuit="J"; "Jour"; "Nuit")
		
		// Modifié par : Scanu Rémy (21/12/2021)
		outilsCreateWindowsForm($formEntree_t; ->$position_o; Null:C1517; ->[HeberGement:5]; Null:C1517; ->$vl_Fenetre)
		SET WINDOW TITLE:C213($T_Window_titre; $vl_Fenetre)
		
		RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)
		MODIFY RECORD:C57([HeberGement:5])
		
		If (OK=1)
			SAVE RECORD:C53([HeBerge:4])
			UNLOAD RECORD:C212([HeBerge:4])
			
			If (<>vb_T_DosSIAO)
				
				If ([HeberGement:5]HG_NuitenCours:92=1)
					$vb_OK:=F_SIAO_DansHebergement("Validation")
				End if 
				
			End if 
			
			$vb_OK:=([HeberGement:5]HG_Nuit:2=False:C215)  //Modifié le 3/2/2009 avant c'était clôturé
			$vb_OK:=$vb_OK & [HeberGement:5]HG_Trans_DDASS:141
			
			If (<>vb_T_Fiches115)
				
				If (<>vb_T_ModeCHRS)
					$vb_OK:=$vb_OK & ([HeberGement:5]HG_Trans_FicheNuméro:143="")  //25/5/2011 (c'est pas une fiche 115)
				End if 
				
			End if 
			
			If ($vb_OK)
				F_Report_FullReporté(->tl_Trans_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
			End if 
			
			$vb_OK:=([HeberGement:5]HG_Nuit:2=False:C215)
			$vb_OK:=$vb_OK & [HeberGement:5]HG_Trans_DDASS:141
			
			If ($vb_OK)
				$vb_OK:=F_Regional_Refs(->tl_Regional_Réf_HG; [HeberGement:5]HG_ReferenceID:1)
			End if 
			
			$vb_OK:=([HeberGement:5]HG_Nuit:2=True:C214)  // le 29/4/2011
			$vb_OK:=$vb_OK & [HeberGement:5]HG_Trans_DDASS:141
			
			If ($vb_OK)
				$vb_OK:=F_Prestation_RefsTableau(1; [HeberGement:5]HG_ReferenceID:1)
			End if 
			
		End if 
		
		UNLOAD RECORD:C212([HeberGement:5])
		READ ONLY:C145([HeberGement:5])
		
		CLOSE WINDOW:C154($vl_Fenetre)
		POST OUTSIDE CALL:C329(<>PR_HBNotes)
		
		//•Est ce une base CHRS  et y a til des fiches reportées
		$vb_OK:=F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Tranfert ")
		$vb_OK:=F_Regional_Transfert(->tl_Regional_Réf_HG; False:C215; "Transfert régional")
		$vb_OK:=F_Prestation_Transfert(->tl_Presta_Réf_HG; False:C215; "Prestations")
		
		F_Report_FullDuplexTableau
		
		$vb_OK:=F_Regional_RefsTableau(0)
		$vb_OK:=F_Prestation_RefsTableau(0; 0)
	End if 
	
Else 
	StrAlerte(7; "' "+$3+" '")
End if 

Case of 
	: ($2="N")
		<>PR_Hébergement:=0
	: (($2="R") | ($2="G"))
		<>PR_HébergementR:=0
	: ($2="V")
		<>PR_HébergementV:=0
	: ($2="P")
		<>PR_HébergementP:=0
End case 

If (vb_Show)
	Général_Show
	POST OUTSIDE CALL:C329(<>PR_Genéral)
End if 