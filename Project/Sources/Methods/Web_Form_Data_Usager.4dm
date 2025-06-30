//%attributes = {}
//  // ----------------------------------------------------
//  // Nom utilisateur (OS) : Kevin HASSAL
//  // Date et heure : 02/11/18, 02:48:16
//  // ----------------------------------------------------
//  // Méthode : Web_Form_Data_Usager
//  // Description
//  // 
//  //
//  // Paramètres
//  // ----------------------------------------------------

//TRACE
//C_OBJECT($O_Output)
//$O_Output:=New object
//C_OBJECT($O_Variables_web)
//$O_Variables_web:=New object

//ARRAY TEXT($rT_names;0)
//ARRAY TEXT($rT_values;0)

//WEB GET VARIABLES($rT_names;$rT_values)  //variable get et post

//C_LONGINT($i)
//For ($i;1;Size of array($rT_names))
//OB SET($O_Variables_web;$rT_names{$i};$rT_values{$i})
//End for 

//C_BOOLEAN($B_Thats_My_JSON)
//$B_Thats_My_JSON:=OB Is defined($O_Variables_web;"json")
//If ($B_Thats_My_JSON)

//C_BOOLEAN($B_Connected)
//$B_Connected:=True

//C_TEXT($T_JSON)
//$T_JSON:=OB Get($O_Variables_web;"json";Is text)

//C_OBJECT($O_Request)
//$O_Request:=JSON Parse($T_JSON)

//C_OBJECT($O_Data)
//C_TEXT($T_Zone;$T_Action)
//$T_Zone:=OB Get($O_Request;"zone";Is text)
//$T_Action:=OB Get($O_Request;"action";Is text)
//$O_Data:=OB Get($O_Request;"data";Is object)


//C_TEXT($T_Token)
//$T_Token:=OB Get($O_Request;"token";Is text)

//End if 

//  //================================================================================

//  //: ($T_Action="get_hebergements_cle")

//C_LONGINT($L_cle)
//$L_cle:=OB Get($O_Data;"cle";Is longint)  // cle est la cle paxtel de l'usager

//QUERY([HeberGement];[HeberGement]HG_HB_ID=$hg_hb_id;*)
//QUERY([HeberGement]; & ;[HeberGement]ID=$id)
//MultiSoc_Filter (->[HeberGement])
//TRACE
//While (Not(End selection([HeberGement])))

//NEXT RECORD([HeberGement])
//End while 

//If (Records in selection([HeberGement])=1)
//LANG_TXT_USAGER_FICHE:=LANG_TXT_USAGER_FICHE+" N° "+[HeberGement]HG_FicheNuméro
//Else 

//End if 


//  // on a une sélection de centres
//  //$T_JSON:=Selection to JSON([HeberGement];SelectionJson_template (->[HeberGement]))
//  //ARRAY OBJECT($rO_Selection;0)
//  //JSON PARSE ARRAY($T_JSON;$rO_Selection)

//  //OB SET ARRAY($O_Output;"hebergement_user";$rO_Selection)

//  //$B_Connected:=True

//UNLOAD RECORD([HeberGement])

//  //================================================================================