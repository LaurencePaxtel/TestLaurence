// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13/03/20, 08:18:34
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementVeille_b.btn_liste_presents
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_LONGINT:C283($size; $i; lp_total_rows)
		
		QUERY:C277([Structures:79]; [Structures:79]STRC_Initiales:2=<>ref_soc_active)
		QUERY:C277([SOciete:18]; [SOciete:18]ID:94=[Structures:79]STRC_Societe_ID:6)
		
		strc_logo:=[Structures:79]STRC_Logo:5
		txt_strc_nom:=[SOciete:18]SO_Libel01:3
		txt_strc_nom_suite:=[SOciete:18]SO_Libel02:4
		txt_strc_adresse:=[SOciete:18]SO_Libel03:5
		txt_strc_tel:=""
		txt_strc_fax:=""
		
		txt_piece_titre:="Agenda des présents du "+String:C10([DiaLogues:3]DL_Date:2)+" au "+String:C10([DiaLogues:3]DL_Date2:8)
		
		$size:=Records in selection:C76([HeberGement:5])
		
		//ARRAY LONGINT(tb_lp_hg_referenceid;0)
		//ARRAY DATE(tb_lp_hg_date;0)
		
		ARRAY TEXT:C222(tb_lp_lundi; 0)
		ARRAY TEXT:C222(tb_lp_mardi; 0)
		ARRAY TEXT:C222(tb_lp_mercredi; 0)
		ARRAY TEXT:C222(tb_lp_jeudi; 0)
		ARRAY TEXT:C222(tb_lp_vendredi; 0)
		ARRAY TEXT:C222(tb_lp_samedi; 0)
		ARRAY TEXT:C222(tb_lp_dimanche; 0)
		
		$i:=0
		
		
		FIRST RECORD:C50([HeberGement:5])
		
		While (Not:C34(End selection:C36([HeberGement:5])))
			
			Case of 
				: (Day number:C114([HeberGement:5]HG_Date:4)=1)
					
					APPEND TO ARRAY:C911(tb_lp_dimanche; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
				: (Day number:C114([HeberGement:5]HG_Date:4)=2)
					
					APPEND TO ARRAY:C911(tb_lp_lundi; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
				: (Day number:C114([HeberGement:5]HG_Date:4)=3)
					
					APPEND TO ARRAY:C911(tb_lp_mardi; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
				: (Day number:C114([HeberGement:5]HG_Date:4)=4)
					
					APPEND TO ARRAY:C911(tb_lp_mercredi; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
				: (Day number:C114([HeberGement:5]HG_Date:4)=5)
					
					APPEND TO ARRAY:C911(tb_lp_jeudi; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
				: (Day number:C114([HeberGement:5]HG_Date:4)=6)
					
					APPEND TO ARRAY:C911(tb_lp_vendredi; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
				: (Day number:C114([HeberGement:5]HG_Date:4)=7)
					
					APPEND TO ARRAY:C911(tb_lp_samedi; [HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22)
					
			End case 
			
			NEXT RECORD:C51([HeberGement:5])
		End while 
		
		SORT ARRAY:C229(tb_lp_dimanche; >)
		SORT ARRAY:C229(tb_lp_lundi; >)
		SORT ARRAY:C229(tb_lp_mardi; >)
		SORT ARRAY:C229(tb_lp_mercredi; >)
		SORT ARRAY:C229(tb_lp_jeudi; >)
		SORT ARRAY:C229(tb_lp_vendredi; >)
		SORT ARRAY:C229(tb_lp_samedi; >)
		
		
		ARRAY LONGINT:C221($tb_sizes; 0)
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_dimanche))
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_lundi))
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_mardi))
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_mercredi))
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_jeudi))
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_vendredi))
		APPEND TO ARRAY:C911($tb_sizes; Size of array:C274(tb_lp_samedi))
		
		SORT ARRAY:C229($tb_sizes; <)
		
		lp_total_rows:=$tb_sizes{1}
		
		C_TEXT:C284(txt_dimanche_total; txt_lundi_total; txt_mardi_total; txt_mercredi_total; txt_jeudi_total; txt_vendredi_total; txt_samedi_total)
		
		txt_dimanche_total:=String:C10(Size of array:C274(tb_lp_dimanche))
		txt_lundi_total:=String:C10(Size of array:C274(tb_lp_lundi))
		txt_mardi_total:=String:C10(Size of array:C274(tb_lp_mardi))
		txt_mercredi_total:=String:C10(Size of array:C274(tb_lp_mercredi))
		txt_jeudi_total:=String:C10(Size of array:C274(tb_lp_jeudi))
		txt_vendredi_total:=String:C10(Size of array:C274(tb_lp_vendredi))
		txt_samedi_total:=String:C10(Size of array:C274(tb_lp_samedi))
		
		If ([DiaLogues:3]DL_Date2:8-[DiaLogues:3]DL_Date:2=6)
			
			For ($i; 0; 6)
				
				$date_current:=Add to date:C393([DiaLogues:3]DL_Date:2; 0; 0; $i)
				
				$day_number:=Day number:C114($date_current)
				
				Case of 
					: ($day_number=1)
						txt_dimanche_date:=String:C10($date_current)
						
					: ($day_number=2)
						txt_lundi_date:=String:C10($date_current)
						
					: ($day_number=3)
						txt_mardi_date:=String:C10($date_current)
						
					: ($day_number=4)
						txt_mercredi_date:=String:C10($date_current)
						
					: ($day_number=5)
						txt_jeudi_date:=String:C10($date_current)
						
					: ($day_number=6)
						txt_vendredi_date:=String:C10($date_current)
						
					: ($day_number=7)
						txt_samedi_date:=String:C10($date_current)
				End case 
				
			End for 
			
			$file_name:=Replace string:C233(txt_piece_titre; " "; "_")+".pdf"
			$file_name:=Replace string:C233($file_name; "/"; "-")
			
			SET PRINT OPTION:C733(Option nom document à imprimer:K47:10; $file_name)
			
			Print_Liste_Presents(->[HeberGement:5]; "Liste_presents"; 2; 2; False:C215)
			
		Else 
			ALERT:C41("Veuillez sélectionner une semaine")
		End if 
		
		
		
		
End case 