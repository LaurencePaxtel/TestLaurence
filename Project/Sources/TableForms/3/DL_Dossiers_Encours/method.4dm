// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/03/20, 03:30:14
// ----------------------------------------------------
// Method: [DiaLogues].DL_Dossiers_Encours
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $i; $pos : Integer

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var DOS_Nom_1; DOS_Numero_1; DOS_Nom_2; DOS_Numero_2; DOS_Nom_3; DOS_Numero_3; DOS_Nom_4; DOS_Numero_4; DOS_Nom_5; DOS_Numero_5; \
			DOS_Nom_6; DOS_Numero_6; DOS_Nom_7; DOS_Numero_7; DOS_Nom_8; DOS_Numero_8; DOS_Nom_9; DOS_Numero_9; DOS_Nom_10; \
			DOS_Numero_10 : Text
		var DOS_Jours_Rappel_1; DOS_Jours_Rappel_2; DOS_Jours_Rappel_3; DOS_Jours_Rappel_4; DOS_Jours_Rappel_5; DOS_Jours_Rappel_6; \
			DOS_Jours_Rappel_7; DOS_Jours_Rappel_8; DOS_Jours_Rappel_9; DOS_Jours_Rappel_10 : Integer
		var DOS_Date_Du_1; DOS_Date_Au_1; DOS_Date_Du_2; DOS_Date_Au_2; DOS_Date_Du_3; DOS_Date_Au_3; DOS_Date_Du_4; DOS_Date_Au_4; \
			DOS_Date_Du_5; DOS_Date_Au_5; DOS_Date_Du_6; DOS_Date_Au_6; DOS_Date_Du_7; DOS_Date_Au_7; DOS_Date_Du_8; DOS_Date_Au_8; \
			DOS_Date_Du_9; DOS_Date_Au_9; DOS_Date_Du_10; DOS_Date_Au_10 : Date
		
		ARRAY TEXT:C222(tb_dos_noms_1; 0)
		ARRAY TEXT:C222(tb_jours_rappel_1; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_2; 0)
		ARRAY TEXT:C222(tb_jours_rappel_2; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_3; 0)
		ARRAY TEXT:C222(tb_jours_rappel_3; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_4; 0)
		ARRAY TEXT:C222(tb_jours_rappel_4; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_5; 0)
		ARRAY TEXT:C222(tb_jours_rappel_5; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_6; 0)
		ARRAY TEXT:C222(tb_jours_rappel_6; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_7; 0)
		ARRAY TEXT:C222(tb_jours_rappel_7; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_8; 0)
		ARRAY TEXT:C222(tb_jours_rappel_8; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_9; 0)
		ARRAY TEXT:C222(tb_jours_rappel_9; 0)
		
		ARRAY TEXT:C222(tb_dos_noms_10; 0)
		ARRAY TEXT:C222(tb_jours_rappel_10; 0)
		
		READ ONLY:C145([Dossiers_Encours:102])
		
		START TRANSACTION:C239
		
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_1)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_2)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_3)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_4)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_5)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_6)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_7)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_8)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_9)
		COPY ARRAY:C226(<>ta_DossiersEncours; tb_dos_noms_10)
		
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_1)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_2)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_3)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_4)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_5)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_6)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_7)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_8)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_9)
		COPY ARRAY:C226(<>ta_DOS_Jours_Rappel; tb_jours_rappel_10)
		
		For ($i; 1; 10)
			QUERY:C277([Dossiers_Encours:102]; [Dossiers_Encours:102]DOS_HB_ReferenceID:2=DOS_HB_ReferenceID; *)
			QUERY:C277([Dossiers_Encours:102];  & ; [Dossiers_Encours:102]DOS_ID:10=$i)
			MultiSoc_Filter(->[Dossiers_Encours:102])
			
			If (Records in selection:C76([Dossiers_Encours:102])=1)
				
				// Modifié par : Scanu Rémy (03/05/2023)
				// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
				EXECUTE FORMULA:C63("DOS_Numero_"+String:C10($i)+":=[Dossiers_Encours]DOS_Numero")
				EXECUTE FORMULA:C63("DOS_Date_Du_"+String:C10($i)+":=[Dossiers_Encours]DOS_Date_Du")
				EXECUTE FORMULA:C63("DOS_Date_Au_"+String:C10($i)+":=[Dossiers_Encours]DOS_Date_Au")
				
				$pos:=Find in array:C230(<>ta_DossiersEncours; [Dossiers_Encours:102]DOS_Nom:3)
				
				If ($pos>0)
					EXECUTE FORMULA:C63("tb_dos_noms_"+String:C10($i)+":="+String:C10($pos))
					EXECUTE FORMULA:C63("DOS_Nom_"+String:C10($i)+":=<>ta_DossiersEncours{"+String:C10($pos)+"}")
				End if 
				
				$pos:=Find in array:C230(<>ta_DOS_Jours_Rappel; String:C10([Dossiers_Encours:102]DOS_Rappel_Jours:7))
				
				// Modifié par : Scanu Rémy (11/07/2023)
				If ($pos>0)
					EXECUTE FORMULA:C63("tb_jours_rappel_"+String:C10($i)+":="+String:C10($pos))
					EXECUTE FORMULA:C63("DOS_Jours_Rappel_"+String:C10($i)+":=Num(<>ta_DOS_Jours_Rappel{"+String:C10($pos)+"})")
				End if 
				
			End if 
			
		End for 
		
End case 