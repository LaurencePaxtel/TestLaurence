//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutDécVarTrans  
//{          Déclaration des variable superglobales suite
//{          Jeudi 3 juin 2004 à 16:14:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305(<>vb_Dupliquer)

C_DATE:C307(<>vd_VueLe)
C_TEXT:C284(<>va_Responsable; <>va_Opérateur; <>va_Assistante; <>va_EMA)

C_BOOLEAN:C305(<>vb_Enfants)
C_LONGINT:C283(<>ve_EnfantsNb)
ARRAY TEXT:C222(<>ta_EnfantNom; 0)
ARRAY TEXT:C222(<>ta_EnfantPrénom; 0)
ARRAY DATE:C224(<>td_EnfantNeLe; 0)
ARRAY INTEGER:C220(<>te_EnfantAge; 0)
ARRAY BOOLEAN:C223(<>tb_EnfantGenre; 0)
ARRAY TEXT:C222(<>ta_EnfantLieu; 0)
ARRAY TEXT:C222(<>ta_EnfantAdr1; 0)
ARRAY TEXT:C222(<>ta_EnfantAdr2; 0)
ARRAY TEXT:C222(<>ta_EnfantCP; 0)
ARRAY TEXT:C222(<>ta_EnfantVille; 0)

C_TEXT:C284(<>va_NeOu; <>va_Conjoint; <>va_Nationalité; <>va_Langue; <>va_Langue1; <>va_Langue2; <>va_Langue3; <>va_PersMajeur; <>va_EMAEnCharge; <>va_EMARefus; <>va_LastHébergt; <>va_LastHébergt1; <>va_LastHébergt2)

C_TEXT:C284(<>va_Signalt; <>va_SignaltSuite; <>va_Emplace1; <>va_Emplace2; <>va_ArrondCP; <>va_EtatCivil; <>va_Demande; <>va_EtatGénéral; <>va_EtatCutané; <>va_Relation; <>va_Hygiène; <>va_Handicap)

C_TEXT:C284(<>va_Motif; <>va_MotifDétail)

C_BOOLEAN:C305(<>vb_QuestOrMéd)
C_TEXT:C284(<>va_OrMéd1; <>va_OrMéd2)

C_BOOLEAN:C305(<>vb_QuestOrSocial)
C_TEXT:C284(<>va_OrSocial1; <>va_OrSocial2)

C_BOOLEAN:C305(<>vb_FicheSociale; <>vb_FichePsycho; <>vb_FicheInfirmiere; <>vb_FicheVerrouillée; <>vb_QuestDemHB)


C_TEXT:C284(<>va_EtatMatrimo; <>va_HébergAd1; <>va_HébergAd2; <>va_HébergAd3; <>va_Mode1; <>va_Mode2; <>va_TempsErr; <>va_Connaissance)
C_TEXT:C284(<>va_Compagnie1; <>va_Compagnie2; <>va_SSPConnu; <>va_SSPPremière; <>va_DerAdr1; <>va_DerAdr2; <>va_DerAdr3)
C_TEXT:C284(<>va_SecoursAdr1; <>va_SecoursAdr2; <>va_SecoursAdr3)

C_BOOLEAN:C305(<>vb_QuestPapier)
C_TEXT:C284(<>va_Papier1; <>va_Papier2)

C_BOOLEAN:C305(<>vb_QuestCouvSoc)
C_TEXT:C284(<>va_CouvSoc1_1; <>va_CouvSoc1_2; <>va_CouvSoc2_1; <>va_CouvSoc2_2; <>va_CouvSoc3_1; <>va_CouvSoc3_2)

C_BOOLEAN:C305(<>vb_QuestRessource)
C_TEXT:C284(<>va_Ressource1_1; <>va_Ressource1_25; <>va_Ressource2_1; <>va_Ressource2_2; <>va_Ressource3_1; <>va_Ressource3_2)

C_BOOLEAN:C305(<>vb_Référents)

//ici sous fiches référents
ARRAY TEXT:C222(<>ta_RéfCatégorie; 0)
ARRAY TEXT:C222(<>ta_RéfNom; 0)
ARRAY TEXT:C222(<>ta_RéfAdr1; 0)
ARRAY TEXT:C222(<>ta_RéfAdr2; 0)
ARRAY TEXT:C222(<>ta_RéfCP; 0)
ARRAY TEXT:C222(<>ta_RéfVille; 0)
ARRAY TEXT:C222(<>ta_RéfTél; 0)

ARRAY TEXT:C222(<>ta_SMCatégorie; 0)
ARRAY TEXT:C222(<>ta_SMCom; 0)

ARRAY TEXT:C222(<>ta_PTCatégorie; 0)
ARRAY TEXT:C222(<>ta_PTCom; 0)

C_BOOLEAN:C305(<>vb_QuestRégime)
C_TEXT:C284(<>va_Régime1; <>va_Régime2; <>va_Régime3)

C_BOOLEAN:C305(<>vb_QuestSuiviS)
C_TEXT:C284(<>va_SuiviS1; <>va_SuiviS2)

C_BOOLEAN:C305(<>vb_QuestSortie)
C_TEXT:C284(<>va_SortieCtr1; <>va_SortieCtr2)

C_BOOLEAN:C305(<>vb_Vérrouillé)
C_BOOLEAN:C305(<>vb_EnfantsScolarisés)