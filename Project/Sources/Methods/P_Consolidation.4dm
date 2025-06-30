//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_Consolidation : Procédure pour test
//{          Mardi 10 avril 2012 à 12:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TIME:C306(vh_Réf)
C_LONGINT:C283($vl_Position)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($vt_Document; vt_TitreDocument)

C_LONGINT:C283(<>vl_Conso_Lignes)
ARRAY INTEGER:C220(<>te_Conso_Ligne; 0)
ARRAY TEXT:C222(<>tt_Conso_LeDocument; 0)
ARRAY TEXT:C222(<>ta_Conso_Titre; 0)
ARRAY TEXT:C222(<>tt_Conso_Valeur; 0)
ARRAY INTEGER:C220(<>te_Conso_Table; 0)
ARRAY INTEGER:C220(<>te_Conso_Champ; 0)
ARRAY INTEGER:C220(<>te_Conso_ChampType; 0)
ARRAY TEXT:C222(<>ta_Conso_ChampType; 0)

$vb_OK:=False:C215

vh_Réf:=Open document:C264(""; ""; Lire chemin accès:K24:6)  // BS 180516 manquait parametre
If (OK=1)
	
	
	vt_TitreDocument:=document
	
	$vt_Document:=i_NomFichier(vt_TitreDocument)
	
	
	
	If (F_Consolidation("DocuValide"; $vt_Document))
		
		If (Test path name:C476(vt_TitreDocument)=Est un document:K24:1)
			
			vh_Réf:=Open document:C264(vt_TitreDocument)
			If (OK=1)
				
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
				
				//(•Ligne de titre dans le document
				RECEIVE PACKET:C104(vh_Réf; <>vt_Buffer; <>va_CR)
				<>vt_Buffer:=Replace string:C233(<>vt_Buffer; <>va_LF; "")
				If (Substring:C12(<>vt_Buffer; 1; 7)="Infos :")
					
					$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
					//Titre
					<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
					
					$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
					//Valeur
					<>vt_Buffer:=Substring:C12(<>vt_Buffer; $vl_Position+1)
					
					$vl_Position:=Position:C15(<>va_Tab; <>vt_Buffer)
					vl_LC_Prestation:=Num:C11(Substring:C12(<>vt_Buffer; 1; $vl_Position-1))
					
					//(•Découpage du contenu du document
					$vb_OK:=F_Report_FullDuplexDecoupage(vh_Réf)
				End if 
				CLOSE DOCUMENT:C267(vh_Réf)
				USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
			End if 
		End if 
	End if 
End if 

If ($vb_OK)
	$vb_OK:=F_Consolidation("Importer"; "")
End if 

