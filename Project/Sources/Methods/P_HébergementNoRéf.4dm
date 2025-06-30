//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementNoRéf
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
[HeberGement:5]HG_ReferenceID:1:=vl_RéfU_HG
[HeberGement:5]HG_HB_ID:19:=vl_RéfU_HBB
[HeberGement:5]HG_NbFicheLiée:79:=ve_IDT_NbFL
[HeberGement:5]HG_YaFicheLiée:78:=(ve_IDT_NbFL>0)
[HeberGement:5]HG_Réservation:91:=False:C215
[HeberGement:5]HG_NuitenCours:92:=1
[HeberGement:5]HG_NuitTOTAL:93:=1
[HeberGement:5]HG_Reporté:94:=""
[HeberGement:5]HG_NuitReste:95:=0


[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
