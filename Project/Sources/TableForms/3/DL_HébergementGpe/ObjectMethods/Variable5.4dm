//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script va_IDT_Nom  
//{
//{          Lundi 28 Juillet 1997 à 16:54:03
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

$ev:=Form event code:C388

Case of 
	: ($ev=Sur chargement:K2:1)
		va_FrappeClavier:=""
	: ($ev=Sur après frappe clavier:K2:26) & (Storage:C1525.societeDetail.rechercheUsagerManuel=True:C214)
		va_FrappeClavier:=Get edited text:C655
		
		If (va_FrappeClavier="")
			REDUCE SELECTION:C351([HeBerge:4]; 0)
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_FrappeClavier+"@"))
			MultiSoc_Filter(->[HeBerge:4])
		End if 
		
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vL_Nb_HG_F:=0
		
		P_HébergementNotesBt(0)
		
		If (wresMulti=0)
			OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		End if 
		
		//============================================//
		// Modified by: Kevin HASSAL (26/09/2019)
		// Le code ci-dessous a été ajouté pour
		// sélectionner le premier et affichier les
		// fiches d'hébergement du premier hebergé
		// de la liste
		//============================================//
		If ([HeBerge:4]HB_ReferenceID:1>0)
			va_NNN:=F_AfficheCléHébergé
			
			Rec_Hébergements1(->vL_Nb_HG_F)
			P_HébergementNotesBt(1)
			
			OBJECT SET ENABLED:C1123(b_ValHBnew; True:C214)
			
			// Modified by: Kevin HASSAL (06/07/2020)
			// Pour la gestion des participations
			If ([HeBerge:4]HB_FAC_Mode_Facturation:80="Participations")
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; False:C215)
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
				OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
			End if 
			
		Else 
			REDUCE SELECTION:C351([HeberGement:5]; 0)
			
			vL_Nb_HG_F:=0
			va_NNN:=""
			P_HébergementNotesBt(0)
			
			OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
			OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
			OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
		End if 
		
	: ($ev=Sur données modifiées:K2:15)
		
		If (Length:C16(va_IDT_Nom)>30)
			ALERT:C41("La longueur du nom ne peut pas dépasser 30 caractères !")
			va_IDT_Nom:=Substring:C12(va_IDT_Nom; 1; 30)
		Else 
			
			If (Substring:C12(va_IDT_Nom; 1; 1)=" ")
				
				While (Substring:C12(va_IDT_Nom; 1; 1)=" ")
					va_IDT_Nom:=Substring:C12(va_IDT_Nom; 2)
				End while 
				
			End if 
			
			va_IDT_Nom:=Uppercase:C13(va_IDT_Nom)
			
			If (va_IDT_Nom>"")
				
				Repeat 
					
					If (Character code:C91(va_IDT_Nom[[1]])<=32)
						va_IDT_Nom:=Substring:C12(va_IDT_Nom; 2)
					End if 
					
				Until (Character code:C91(va_IDT_Nom[[1]])>32)
				
			End if 
			
			va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
			va_FrappeClavier:=va_IDT_Nom
		End if 
		
End case 