//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : Prolongation_FicheIncluse 
//{
//{          Vendredi 17 septembre 2004 à 15:23:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1)

Case of 
	: ($1=1)
		READ WRITE:C146([Prolongation:38])
		
		FORM SET INPUT:C55([Prolongation:38]; "PR_EcranSaisie")
		$vl_Fenetre:=i_FenêtreNo(650; 326; 4; "Prolongation : nouveau"; 4; "")
		ADD RECORD:C56([Prolongation:38])  //lpc 08122017 ascenceur
		CLOSE WINDOW:C154($vl_Fenetre)
		READ ONLY:C145([Prolongation:38])
		
		QUERY:C277([Prolongation:38]; [Prolongation:38]PR_GPHB_Référence:5=[GrouPe:36]GP_ReferenceID:1)
		MultiSoc_Filter(->[Prolongation:38])
		ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
		FIRST RECORD:C50([Prolongation:38])
		vL_Nb_PR:=Records in selection:C76([Prolongation:38])
		
	: ($1=2)
		If ([Prolongation:38]PR_RéférenceID:1>0)
			READ WRITE:C146([Prolongation:38])
			If (i_NonVerrou(->[Prolongation:38]))
				FORM SET INPUT:C55([Prolongation:38]; "PR_EcranSaisie")
				$vl_Fenetre:=i_FenêtreNo(650; 326; 4; "Prolongation : modifier"; 4; "")
				MODIFY RECORD:C57([Prolongation:38]; *)
				CLOSE WINDOW:C154($vl_Fenetre)
				UNLOAD RECORD:C212([Prolongation:38])
			End if 
			READ ONLY:C145([Prolongation:38])
			
			REDRAW:C174([Prolongation:38])
		Else 
			ALERT:C41("Veuillez sélectionner une prolongation !")
		End if 
		
	: ($1=3)
		If ([Prolongation:38]PR_RéférenceID:1>0)
			If ([Prolongation:38]PR_ProlongationEffectuée:11)
				ALERT:C41("La prolongation déjà utilisée dans le cycle des reports ne peut être supprimée !")
			Else 
				If (i_Confirmer("Supprimer la prolongation du : "+String:C10([Prolongation:38]PR_RésaDateDébut:6)))
					CREATE SET:C116([Prolongation:38]; "$E_temp")
					READ WRITE:C146([Prolongation:38])
					If (i_NonVerrou(->[Prolongation:38]))
						DELETE RECORD:C58([Prolongation:38])
						UNLOAD RECORD:C212([Prolongation:38])
					End if 
					READ ONLY:C145([Prolongation:38])
					USE SET:C118("$E_temp")
					CLEAR SET:C117("$E_temp")
					ORDER BY:C49([Prolongation:38]; [Prolongation:38]PR_RésaDateDébut:6; <)
					FIRST RECORD:C50([Prolongation:38])
					vL_Nb_PR:=Records in selection:C76([Prolongation:38])
				End if 
			End if 
		Else 
			ALERT:C41("Veuillez sélectionner une prolongation !")
		End if 
End case 