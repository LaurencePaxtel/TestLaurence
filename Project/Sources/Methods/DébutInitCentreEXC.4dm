//%attributes = {}
////{==================================================}
////{ LOGICIEL : Samu Social de Paris	
////{ © DBsolutions/Paxtel
////{
////{          Procédure : DébutInitCentreEXC     Go_uCentreEXC
////{          Mardi 5 mai 2004 à 11:19:00
////{          Modifiée :
////{          Développement : GABBAY Jean-Guy
////{==================================================}

//C_ENTIER LONG($1)
//C_ENTIER LONG($vl_Réf)
//$vl_Réf:=-30

//Au cas ou 
//: ($1=0)
//<>va_CentreEXC:="N"  //Non
//<>vb_CentreEXC:=(<>va_CentreEXC="O")
//<>va_CentreEXCExc:="N"
//<>vb_CentreEXCExc:=Faux
//<>va_CentreEXCSor:="N"
//<>vb_CentreEXClits:=Faux
//<>vh_CentreEXChD:=?08:00:00?
//<>vh_CentreEXChF:=?19:59:59?

//LECTURE ÉCRITURE([DePart])
//CHERCHER([DePart]; [DePart]DP_ReferenceID=$vl_Réf)
//MultiSoc_Filter(->[DePart])
//Si (Enregistrements trouvés([DePart])=1)
//Si ([DePart]DP_Libelle="Gestion des centres : centre avec fidélisation de la chambre")
//Sinon 
//[DePart]DP_Libelle:="Gestion des centres : centre avec fidélisation de la chambre"
//STOCKER ENREGISTREMENT([DePart])
//Fin de si 
//Si ([DePart]DP_Texte>"")
//<>va_CentreEXC:=[DePart]DP_Texte[[1]]
//<>vb_CentreEXC:=(<>va_CentreEXC="O")
//<>va_CentreEXCExc:=[DePart]DP_Texte[[2]]
//<>vb_CentreEXCExc:=(<>va_CentreEXCExc="O")
//<>va_CentreEXCSor:=[DePart]DP_Texte[[3]]
//<>vb_CentreEXClits:=((<>va_CentreEXC="O") & ((<>va_CentreEXCSor="O")))
//Si (Sous chaîne([DePart]DP_Texte; 4; 8)>"")
//<>vh_CentreEXChD:=Heure(Sous chaîne([DePart]DP_Texte; 4; 8))
//Fin de si 
//Si (Sous chaîne([DePart]DP_Texte; 12; 8)>"")
//<>vh_CentreEXChF:=Heure(Sous chaîne([DePart]DP_Texte; 12; 8))
//Fin de si 

//Fin de si 
//LIBÉRER ENREGISTREMENT([DePart])
//Sinon 
//CRÉER ENREGISTREMENT([DePart])
//MultiSoc_Init_Structure(->[DePart])
//[DePart]DP_ReferenceID:=$vl_Réf
//[DePart]DP_Libelle:="Gestion des centres : centre avec fidélisation de la chambre"
//[DePart]DP_Texte:=<>va_CentreEXC+<>va_CentreEXCExc+<>va_CentreEXCSor+Chaîne(<>vh_CentreEXChD; "00:00:00")+Chaîne(<>vh_CentreEXChF; "00:00:00")
//STOCKER ENREGISTREMENT([DePart])
//LIBÉRER ENREGISTREMENT([DePart])
//Fin de si 
//LECTURE SEULEMENT([DePart])

//: ($1=1)
//LECTURE ÉCRITURE([DePart])
//CHERCHER([DePart]; [DePart]DP_ReferenceID=$vl_Réf)
//MultiSoc_Filter(->[DePart])
//Si (Enregistrements trouvés([DePart])=1)
//Repeter 
//CHARGER ENREGISTREMENT([DePart])
//Jusque (Non(Enregistrement verrouillé([DePart])))
//[DePart]DP_Texte:=<>va_CentreEXC+<>va_CentreEXCExc+<>va_CentreEXCSor+Chaîne(<>vh_CentreEXChD; "00:00:00")+Chaîne(<>vh_CentreEXChF; "00:00:00")
//STOCKER ENREGISTREMENT([DePart])
//LIBÉRER ENREGISTREMENT([DePart])
//Fin de si 
//LECTURE SEULEMENT([DePart])
//Fin de cas 