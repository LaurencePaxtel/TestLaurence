//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Prestation_Transfert
//{          Vendredi 29 avril 2011 à 15:45
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215
C_POINTER:C301($1)  //Pointeur sur le tableau
C_BOOLEAN:C305($2)  //vb_Serveur : Serveur ou sur le poste
C_TEXT:C284($3)  //Titre de l'action

//•(1) Est ce une base CHRS  et avec des prestations à exporter
$vb_OK:=<>vb_T_ModeCHRS & <>vb_T_Prestations
If ($vb_OK)
	$vb_OK:=F_FicheSurDisque($1; $2; $3; (<>vt_T_CheminRépServeur*Num:C11($2))+(<>vt_T_CheminRép*Num:C11($2=False:C215)); <>va_Rép_TransPresta; "Export des prestations en cours …"; 1)
End if 