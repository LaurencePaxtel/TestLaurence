//%attributes = {}
//{==================================================}
//{          Méthode : DATA_Export_All
//{          Mardi 03/10/2019 à 09:15
//{          Modifiée :
//{          Développeur : Kevin HASSAL
//{==================================================}

//READ ONLY(*)
//C_TIME($ref_doc;$heure_debut;$heure_fin)
//C_TEXT($vt_Chemin)
//C_LONGINT($ii;$jj;$kk;$nb_fiches)
//C_BOOLEAN($vb_OK)

//ARRAY TEXT($tb_tables_names;0)
//ARRAY POINTER($tb_tables;0)
//ARRAY TEXT($tb_champs_id;0)

//INSERT IN ARRAY($tb_tables;1;1)
//$tb_tables{1}:=->[Factures]
//INSERT IN ARRAY($tb_tables_names;1;1)
//$tb_tables_names{1}:="Factures"
//INSERT IN ARRAY($tb_champs_id;1;1)
//$tb_champs_id{1}:="UID"



//C_TEXT($fichier_encodage)

//CONFIRM("Vous êtes entrain d'exporter les données")

//If (OK=1)

//  //{= $fichier_encodage:=DATA_ENCODAGE_EXPORT 
//$vt_Chemin:=Select folder("Selectionner le dossier d'export .")

//  //USE CHARACTER SET("uft-8";0)

//  //{= UTILISER FILTRE($vt_Chemin+"\EXPORT_ENCODAGE.4FI")

//If (OK=1)

//$heure_debut:=Current time
//$nb_tables:=Size of array($tb_tables_names)

//  //i_Message("Export des données en cours…")

//For ($ii;1;$nb_tables)


//ALL RECORDS($tb_tables{$ii}->)


//$nb_fiches:=Records in selection($tb_tables{$ii}->)



//If ($nb_fiches>0)


//$ref_doc:=Create document($vt_Chemin+$tb_tables_names{$ii})



//If (OK=1)

//  //{==================================================}
//  //{ export des noms des champs                                                    
//  //{==================================================}

//SEND PACKET($ref_doc;$tb_tables_names{$ii}+Char(13))
//SEND PACKET($ref_doc;$tb_champs_id{$ii}+Char(13))
//SEND PACKET($ref_doc;String($nb_fiches)+Char(13))

//C_LONGINT($p)

//For ($p;1;Get last field number($tb_tables{$ii}))
//GET FIELD PROPERTIES(Table($tb_tables{$ii});$p;$type;$long;$index)


//$data:=Field name(Table($tb_tables{$ii});$p)
//  //{   $data:=Remplacer chaine($data;"é";"e")
//  //{ $data:=Remplacer chaine($data;"à";"a")

//If ($p=1)
//SEND PACKET($ref_doc;$data)
//Else 
//SEND PACKET($ref_doc;";"+$data)
//End if 


//End for 

//SEND PACKET($ref_doc;Char(13))

//  //{==================================================}

//$jj:=0

//FIRST RECORD($tb_tables{$ii}->)
//Repeat 
//$jj:=$jj+1
//  //i_MessageSeul("Export : "+Chaine($ii)+"/"+Chaine($nb_tables)+"  -  "+$tb_tables_names{$ii}+" : "+Chaine($jj)+"/"+Chaine($nb_fiches))

//DATA_Export_Table ($ref_doc;$tb_tables{$ii})

//NEXT RECORD($tb_tables{$ii}->)
//Until (End selection($tb_tables{$ii}->))

//SEND PACKET($ref_doc;"FIN_EPORT_ALL"+Char(13))
//CLOSE DOCUMENT($ref_doc)


//End if 

//End if 
//End for 

//  //FERMER FENETRE

//$heure_fin:=Current time
//ALERT("Export terminé :  "+String($heure_debut;HH MM)+" - "+String($heure_fin;HH MM)+" > "+String($heure_fin-$heure_debut;HH MM))

//End if 
//End if 
