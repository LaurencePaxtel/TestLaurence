//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergéCréer
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)

C_TEXT:C284($UneClé)
C_LONGINT:C283($vl_NbFiches)
C_DATE:C307($vd_Date)
C_POINTER:C301($P_Nom; $P_Prenom; $P_NeeLe; $P_Telephone)

C_TEXT:C284(<>va_TDT_Typ; <>va_TDT_Nom; <>va_TDT_Pré; <>va_TDT_Nat; <>va_TDT_Clé; <>va_TDT_Titr)
C_LONGINT:C283(<>ve_TDT_NbFL)
C_BOOLEAN:C305(<>vb_TDT_Genr)
C_DATE:C307(<>vd_TDT_NéLe)

$P_Nom:=$1
$P_Prenom:=$2
$P_NeeLe:=$3
$P_Telephone:=$4

ASSERT:C1129((Is nil pointer:C315($P_Telephone)=False:C215); "le pointeur téléphone est nil")

$vd_Date:=Current date:C33
$UneClé:=Uut_HébergéClé($P_Nom; $P_Prenom; $P_NeeLe)  // 23/1/17 je remplace les $1, $2, $3 dans toute la méthode

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$UneClé)
MultiSoc_Filter(->[HeBerge:4])

$vl_NbFiches:=Records in selection:C76([HeBerge:4])

Case of 
	: ($vl_NbFiches>1)
		StrAlerte(11; $UneClé)
	: ($vl_NbFiches=0)
		READ WRITE:C146([HeBerge:4])
		
		CREATE RECORD:C68([HeBerge:4])
		MultiSoc_Init_Structure(->[HeBerge:4])
		
		[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
		[HeBerge:4]HB_Clé:2:=$UneClé
		[HeBerge:4]HB_Nom:3:=$P_Nom->
		[HeBerge:4]HB_Prénom:4:=$P_Prenom->
		[HeBerge:4]HB_DateNéLe:5:=$P_NeeLe->
		[HeBerge:4]HB_Telephone:66:=$P_Telephone->  // ajouté 20/01/2017
		[HeBerge:4]HG_Genre:39:=(Num:C11(x_IDTG_2)=1)
		[HeBerge:4]HB_FicheCrééele:46:=$vd_Date
		
		// Modifié par : Scanu Rémy (27/02/2023)
		// On ne repose pas la question si on est dans le cas d'une duplication de fiche
		If (Bool:C1537(Form:C1466.dupliquerFiche)=False:C215)
			CONFIRM:C162("La fiche créée est-elle chef de famille ?"; "Oui"; "Non")
			
			If (OK=1)
				[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
			End if 
			
		End if 
		
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		
		SAVE RECORD:C53([HeBerge:4])
		
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
		
		<>va_TDT_Typ:=va_IDT_Typ1
		<>va_TDT_Nom:=$P_Nom->
		<>va_TDT_Pré:=$P_Prenom->
		<>vd_TDT_NéLe:=$P_NeeLe->
		<>vb_TDT_Genr:=(x_IDTG_2=1)
		<>va_TDT_Nat:=va_IDT_Nat
		<>va_TDT_Clé:=$UneClé
		<>va_TDT_Titr:=va_IDT_Titr
		<>ve_TDT_NbFL:=ve_IDT_NbFL
		
		vb_NewEtC:=True:C214
		vb_Valider:=True:C214
	: ($vl_NbFiches=1)
		vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=vl_RéfU_HBB)
		MultiSoc_Filter(->[HeberGement:5])
		
		If (Records in selection:C76([HeberGement:5])>0)
			
			If (vl_IDT_Old=0)
				StrAlerte(13; $UneClé)
			Else 
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
				
				If ([HeberGement:5]HG_Date:4=$vd_Date)
					
					If (i_Confirmer("Attention cette personne a déjà une fiche ce jour !"))
						<>va_TDT_Typ:=va_IDT_Typ1
						<>va_TDT_Nom:=$P_Nom->
						<>va_TDT_Pré:=$P_Prenom->
						<>vd_TDT_NéLe:=$P_NeeLe->
						<>vb_TDT_Genr:=(x_IDTG_2=1)
						<>va_TDT_Nat:=va_IDT_Nat
						<>va_TDT_Clé:=$UneClé
						<>va_TDT_Titr:=va_IDT_Titr
						<>ve_TDT_NbFL:=ve_IDT_NbFL
						
						vb_NewEtC:=True:C214
						vb_Valider:=True:C214
					End if 
					
				Else 
					<>va_TDT_Typ:=va_IDT_Typ1
					<>va_TDT_Nom:=$P_Nom->
					<>va_TDT_Pré:=$P_Prenom->
					<>vd_TDT_NéLe:=$P_NeeLe->
					<>vb_TDT_Genr:=(x_IDTG_2=1)
					<>va_TDT_Nat:=va_IDT_Nat
					<>va_TDT_Clé:=$UneClé
					<>va_TDT_Titr:=va_IDT_Titr
					<>ve_TDT_NbFL:=ve_IDT_NbFL
					
					vb_NewEtC:=True:C214
					vb_Valider:=True:C214
				End if 
				
			End if 
			
		Else 
			StrAlerte(11; [HeBerge:4]HB_Clé:2)
			
			<>va_TDT_Typ:=va_IDT_Typ1
			<>va_TDT_Nom:=$P_Nom->
			<>va_TDT_Pré:=$P_Prenom->
			<>vd_TDT_NéLe:=$P_NeeLe->
			<>vb_TDT_Genr:=(x_IDTG_2=1)
			<>va_TDT_Nat:=va_IDT_Nat
			<>va_TDT_Clé:=$UneClé
			<>va_TDT_Titr:=va_IDT_Titr
			<>ve_TDT_NbFL:=ve_IDT_NbFL
			
			x_IDTG_1:=Num:C11([HeBerge:4]HG_Genre:39=False:C215)
			x_IDTG_2:=Num:C11([HeBerge:4]HG_Genre:39=True:C214)
			
			vb_NewEtC:=True:C214
			vb_Valider:=True:C214
		End if 
		
End case 