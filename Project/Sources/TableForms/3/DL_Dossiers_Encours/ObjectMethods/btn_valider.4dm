// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 05/03/20, 15:45:54
// ----------------------------------------------------
// Method: [DiaLogues].DL_Dossiers_Encours.btn_valider
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		READ WRITE:C146([Dossiers_Encours:102])
		
		For ($i; 1; 10)
			QUERY:C277([Dossiers_Encours:102]; [Dossiers_Encours:102]DOS_HB_ReferenceID:2=DOS_HB_ReferenceID; *)
			QUERY:C277([Dossiers_Encours:102];  & ; [Dossiers_Encours:102]DOS_ID:10=$i)
			MultiSoc_Filter(->[Dossiers_Encours:102])
			
			If (Records in selection:C76([Dossiers_Encours:102])=0)
				CREATE RECORD:C68([Dossiers_Encours:102])
				MultiSoc_Init_Structure(->[Dossiers_Encours:102])
				
				[Dossiers_Encours:102]DOS_HB_ReferenceID:2:=DOS_HB_ReferenceID
				[Dossiers_Encours:102]DOS_ID:10:=$i
			End if 
			
			// Modifié par : Scanu Rémy (03/05/2023)
			// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
			EXECUTE FORMULA:C63("[Dossiers_Encours]DOS_Nom:=DOS_Nom_"+String:C10($i))
			EXECUTE FORMULA:C63("[Dossiers_Encours]DOS_Numero:=DOS_Numero_"+String:C10($i))
			EXECUTE FORMULA:C63("[Dossiers_Encours]DOS_Date_Du:=DOS_Date_Du_"+String:C10($i))
			EXECUTE FORMULA:C63("[Dossiers_Encours]DOS_Date_Au:=DOS_Date_Au_"+String:C10($i))
			EXECUTE FORMULA:C63("[Dossiers_Encours]DOS_Rappel_Jours:=DOS_Jours_Rappel_"+String:C10($i))
			
			If (([Dossiers_Encours:102]DOS_Nom:3#"") | ([Dossiers_Encours:102]DOS_Numero:4#""))
				SAVE RECORD:C53([Dossiers_Encours:102])
			End if 
			
			UNLOAD RECORD:C212([Dossiers_Encours:102])
		End for 
		
		ACCEPT:C269
		VALIDATE TRANSACTION:C240
End case 