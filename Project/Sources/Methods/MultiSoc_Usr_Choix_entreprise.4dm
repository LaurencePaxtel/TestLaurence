//%attributes = {}
// ----------------------------------------------------
// Développeur (OS) : Kevin HASSAL
// Date et heure : 30/08/18, 02:30:26
// ----------------------------------------------------
// Méthode : MultiSoc_Usr_Choix_entreprise
// Description
// 
//
// Paramètres
// ----------------------------------------------------
<>ref_soc_active:=Liste_initiale_entreprise{Liste_entreprise}
Use (Storage:C1525)
	Storage:C1525.societeDetail:=New shared object:C1526
End use 

Use (Storage:C1525.societeDetail)
	Storage:C1525.societeDetail.Ref_Structure:=Liste_initiale_entreprise{Liste_entreprise}
End use 

ref_soc_active:=Liste_initiale_entreprise{Liste_entreprise}

<>user_nom_entreprise:=Liste_entreprise{Liste_entreprise}
<>user_uid_entreprise:=Liste_ref_entreprise{Liste_entreprise}
<>info_structure_user:="Structure : "+<>user_nom_entreprise+" / Utilisateur : "+Current user:C182

READ ONLY:C145([Structures:79])
QUERY:C277([Structures:79]; [Structures:79]UID:1=<>user_uid_entreprise)

If (Records in selection:C76([Structures:79])=1)
	<>strc_logoClient:=[Structures:79]STRC_Logo:5
	<>ID_Societe_Active:=[Structures:79]STRC_Societe_ID:6
End if 

If (<>ref_soc_active="")
	ALERT:C41("Erreur! "+Char:C90(13)+Char:C90(13)+"Veuillez consulter le service informatique.")
	QUIT 4D:C291
Else 
	ACCEPT:C269
End if 