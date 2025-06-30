//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportPasse2
//{
//{          Lundi 29 mars 2004 à 15:07:10
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)  // #20170628-2 Ce paramètre est passé en cascade aux sous méthodes, à ce jour il vaut ici toujours 1. Je ne sais pas à quoi sert ce paramètre

C_LONGINT:C283($hg_referenceid_origine; $ii; $L_Toujours1)
C_BOOLEAN:C305($B_Dummy)

C_BOOLEAN:C305(<>is_rattrapage)


// Pansement 

$L_Toujours1:=$4

READ WRITE:C146([HeberGement:5])
LOAD RECORD:C52([HeberGement:5])

$hg_referenceid_origine:=[HeberGement:5]HG_ReferenceID:1

DUPLICATE RECORD:C225([HeberGement:5])
[HeberGement:5]HG_Facture:172:=False:C215

$B_Dummy:=F_VariablesTransite(4; 2; False:C215; $1; $2; $3; $L_Toujours1)

[HeberGement:5]HG_Signalement:12:="*Report"

$ii:=Size of array:C274(tl_RATTRAPE_Réf_HG)+1
INSERT IN ARRAY:C227(tl_RATTRAPE_Réf_HG; $ii)

tl_RATTRAPE_Réf_HG{$ii}:=$hg_referenceid_origine

[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010

// Modified by: Kevin HASSAL (30-03-2019)
// Mise à jour de la référence unique et numéro de fiche
[HeberGement:5]HG_ReferenceID:1:=Uut_Numerote(->[HeberGement:5])
[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche(Choose:C955([HeberGement:5]HG_Nuit:2; "N"; "J"); [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4); ref_soc_active)
[HeberGement:5]HG_Origine_ID:175:=$hg_referenceid_origine

// Modifié par : Scanu Rémy (18/02/2022)
[HeberGement:5]HG_Age:23:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_Date:4)

// Modified by: Kevin HASSAL (06/06/2020)
// Les reports manuels
If (<>is_rattrapage)
	APPEND TO ARRAY:C911(tb_hg_fr_referenceid; [HeberGement:5]HG_ReferenceID:1)
End if 

SAVE RECORD:C53([HeberGement:5])

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=tl_RATTRAPE_Réf_HG{$ii})

UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])