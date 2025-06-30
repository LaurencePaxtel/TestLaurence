//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_StatFlux
//{
//{          Jeudi 21 avril 2011 à 18:13:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

i_Message("Recherche…")
vp_LePointeur:=Get pointer:C304($3+String:C10($1->))
QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; vp_LePointeur->)
P_HébergementVeilleSort(2)
vt_ColRéf_Libellé:=$2+" : "+String:C10(Records in selection:C76([HeberGement:5]))+" fiche(s)"+"  pour  "+ta_TrancheColEtatCivil{$1->}
CLOSE WINDOW:C154