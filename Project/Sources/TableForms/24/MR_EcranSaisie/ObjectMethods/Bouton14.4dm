
//_o_DELETE SUBRECORD([Maraude]MR_PathologieListe)
//_o_ALL SUBRECORDS([Maraude]MR_PathologieListe)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		// Migration
		
		
		
		C_OBJECT:C1216($O_Object)
		OB SET:C1220($O_Object; "table"; ->[Maraude_MR_PathologieListe:62])  // On travaille sur un numéro de table
		OB SET:C1220($O_Object; "subform"; "lb_maraude_patho")  // le nom d'objet du sous formulaire inclus
		OB SET:C1220($O_Object; "displayed_field"; ->[Maraude_MR_PathologieListe:62]Catégorie:1)  // le nom du champ lors de la confirmation
		
		
		START TRANSACTION:C239
		
		C_TEXT:C284($T_Message)
		C_LONGINT:C283($L_Erreur)
		$L_Erreur:=4DREC_Sublist_del_inList($O_Object; ->$T_Message)
		
		4DTRANSACTION_Close($L_Erreur=1)
		
		
End case 