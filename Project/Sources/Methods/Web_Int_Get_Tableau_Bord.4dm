//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 27/10/18, 01:47:42
// ----------------------------------------------------
// Méthode : Web_Int_Get_Tableau_Bord
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($T_Message; $T_JSON; $T_Zone; $T_Action; $T_Token; $T_NbPersonne; $T_NbMenage)
C_LONGINT:C283($i; $L_Default_Date_inside_objects)
C_BOOLEAN:C305($B_Thats_My_JSON; $B_Connected)
C_OBJECT:C1216($O_Output; $O_Variables_web; $O_Request; $O_Data; $O_User_output)

ARRAY TEXT:C222($rT_names; 0)
ARRAY TEXT:C222($rT_values; 0)

ARRAY OBJECT:C1221($rO_Selection; 0)

WEB GET VARIABLES:C683($rT_names; $rT_values)  //variable get et post

$O_Output:=New object:C1471
$O_Variables_web:=New object:C1471

For ($i; 1; Size of array:C274($rT_names))
	OB SET:C1220($O_Variables_web; $rT_names{$i}; $rT_values{$i})
End for 

$B_Thats_My_JSON:=OB Is defined:C1231($O_Variables_web; "json")

If ($B_Thats_My_JSON)
	$B_Connected:=True:C214
	
	$T_JSON:=OB Get:C1224($O_Variables_web; "json"; Est un texte:K8:3)
	$O_Request:=JSON Parse:C1218($T_JSON)
	
	$T_Zone:=OB Get:C1224($O_Request; "zone"; Est un texte:K8:3)
	$T_Action:=OB Get:C1224($O_Request; "action"; Est un texte:K8:3)
	$O_Data:=OB Get:C1224($O_Request; "data"; Est un objet:K8:27)
	
	$T_Token:=OB Get:C1224($O_Request; "token"; Est un texte:K8:3)
End if 

$L_Default_Date_inside_objects:=Get database parameter:C643(Dates dans les objets:K37:73)
SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

$O_User_output:=New object:C1471

$L_Erreur:=API_Get_hebergement_veille($O_Data; ->$O_User_output)

$B_Connected:=True:C214
$T_Message:=OB Get:C1224($O_User_output; "message"; Est un texte:K8:3)

$T_NbPersonne:=OB Get:C1224($O_User_output; "nbPersonne"; Est un texte:K8:3)
$T_NbMenage:=OB Get:C1224($O_User_output; "nbMenage"; Est un texte:K8:3)

OB GET ARRAY:C1229($O_User_output; "hebergement_veille"; $rO_Selection)
OB SET ARRAY:C1227($O_Output; "hebergement_veille"; $rO_Selection)

OB SET:C1220($O_Output; "connected"; $B_Connected)
OB SET:C1220($O_Output; "message"; $T_Message; "error_code"; $L_Erreur)

OB SET:C1220($O_Output; "nbPersonne"; $T_NbPersonne)
OB SET:C1220($O_Output; "nbMenage"; $T_NbMenage)

$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; $L_Default_Date_inside_objects)