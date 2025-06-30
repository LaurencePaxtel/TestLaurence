//%attributes = {}
// Method MIG_Populate_IDs  


// On ajoute les 71 Champs ID dans un tableau de pointeurs
// Pour pouvoir numéroter chaque enregistrements
//C_LONGINT($L_Erreur)
//ARRAY POINTER($rP_Field_ID;0)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[ActionSociale]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Adresses]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[APpels]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Assocs]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[CentresLits]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DePart]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DiaLogues]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Dossier_SIAO]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierInfirmie]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierInfirmie_DI_DependTypes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierInfirmie_DI_IndicesTypes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierInfirmie_DI_PathoTypes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierMedical]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierPsycho]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierPsycho_DY_AnteTypes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierPsycho_DY_EtatPsyTypes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierPsycho_DY_NA]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierSante]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierSante_DE_Examens]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierSocial]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierSocial_DS_EnfantsNom]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[DossierSocial_EL_ReferentList]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[FicheMedicaleOl]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[GIP]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[GrouPe]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[GroupeHeberges]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[HeBerge]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[HeBerge_Servi]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[HeberGement]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[HebergementLie]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[INtervenants]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[IntervenantsGroupes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[IntervenantsProfils]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[ItemGroupe]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[LeMedical]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[LesCentres]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[LeSignaletique]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[LesLogs]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[LesRubriques]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[LesTranches]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Maraude]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Maraude_MR_PathologieListe]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Maraude_MR_ReferentList]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Maraude_MR_SuiviMedicalList]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Medicale]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[MedicalPlus]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[MemO]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Messagerie]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[MessagerieVSM]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Objets]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Objets_Planification]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[PreSentation]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[PresentationData]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Prolongation]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Rapport]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[ReferenceUnique]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[RenseiGnements]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[ShowAutreS]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SIAO]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SIAO_Divers]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SIAO_Personnes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SIAO_SiteAccueil]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SIAO_SiteReference]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SIAO_Situations]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[SOciete]ID)  // 
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[Sommes]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[TableFusions]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[TAbles]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[TablesDemande]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[TrancheAge]ID)
//$L_Erreur:=Handle_PK (1;->$rP_Field_ID;->[TypesTables]ID)


//C_LONGINT($i)
//For ($i;1;Size of array($rP_Field_ID))

//C_POINTER($P_Field;$P_Table;)
//$P_Field:=$rP_Field_ID{$i}
//$P_Table:=Table(Table($P_Field))


//READ WRITE($P_Table->)
//ALL RECORDS($P_Table->)

//  // Le tableau qui contient les futurs IDs
//ARRAY LONGINT($rL_Sel;0)
//LONGINT ARRAY FROM SELECTION($P_Table->;$rL_Sel)

//For ($j;1;Size of array($rL_Sel))
//GOTO RECORD($P_Table->;$rL_Sel{$j})
//  //For ($j;1;Size of array($rL_Sel))
//  //$rL_Sel{$j}:=$j
//  //End for 
//$P_Field->:=$j
//SAVE RECORD($P_Table->)
//  // Report du tableau des IDs dans le champ ID
//End for 

//READ ONLY($P_Table->)
//End for 