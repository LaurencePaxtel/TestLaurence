//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LaSelection
//{          Lundi 8 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($vb_OK; $vb_OKAction)
C_LONGINT:C283($ii; $kk; $mm)
ARRAY TEXT:C222($ta_Conso_Document; 0)
Case of 
	: (<>ve_ConsoRegion_Mode=0)  //Mode de consolidation régionale inactivé
		$vb_OK:=False:C215
	: (<>ve_ConsoRegion_Mode=1)  //Mode de consolidation régionale de type 115 : export
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4=vd_DateRéelle)
		MultiSoc_Filter(->[HeberGement:5])
		
		$vb_OK:=(Records in selection:C76([HeberGement:5])>0)
		If ($vb_OK=False:C215)
			$vb_OKAction:=F_Report_FullDuplexMessage3(vb_SurServeur; "NO"; "Consolidation régionale 115 : aucune fiche"; "Pas de consolidation")
		End if 
		
	: (<>ve_ConsoRegion_Mode=2)  //Serveur régionale : import
		ARRAY TEXT:C222(tt_Conso_DocumentDos; 0)
		ARRAY TEXT:C222(ta_Conso_Document; 0)
		If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
			For ($ii; 1; Size of array:C274(<>tt_T_CheminsRegionaux))
				
				DOCUMENT LIST:C474(<>tt_T_CheminsRegionaux{$ii}; $ta_Conso_Document)
				If (Size of array:C274($ta_Conso_Document)>0)
					
					//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT          
					vl_ii:=1
					vl_ij:=Size of array:C274($ta_Conso_Document)
					Repeat 
						//•(x1) Longueur 25 caractères
						If (Substring:C12($ta_Conso_Document{vl_ii}; Length:C16($ta_Conso_Document{vl_ii})-3; 4)=".TXT")
							$vb_OK:=(Length:C16($ta_Conso_Document{vl_ii})=29)
						Else 
							$vb_OK:=(Length:C16($ta_Conso_Document{vl_ii})=25)
						End if 
						//•(x2) Année               
						If ($vb_OK)
							$vb_OK:=(Num:C11($ta_Conso_Document{vl_ii}[[4]])>=0) & (Num:C11($ta_Conso_Document{vl_ii}[[4]])<=9)
							$vb_OK:=$vb_OK & ((Num:C11(Substring:C12($ta_Conso_Document{vl_ii}; 4; 2))>0) & (Num:C11(Substring:C12($ta_Conso_Document{vl_ii}; 4; 2))<=99))
						End if 
						//•(x3) Mois               
						If ($vb_OK)
							$vb_OK:=((Num:C11(Substring:C12($ta_Conso_Document{vl_ii}; 6; 2))>0) & (Num:C11(Substring:C12($ta_Conso_Document{vl_ii}; 6; 2))<=12))
						End if 
						//•(x4) Jour              
						If ($vb_OK)
							$vb_OK:=((Num:C11(Substring:C12($ta_Conso_Document{vl_ii}; 8; 2))>0) & (Num:C11(Substring:C12($ta_Conso_Document{vl_ii}; 8; 2))<=31))
						End if 
						//•(x5) h          
						If ($vb_OK)
							$vb_OK:=($ta_Conso_Document{vl_ii}[[12]]="h")
						End if 
						//•(x6) Jour   ou Nuit                 
						If ($vb_OK)
							$vb_OK:=(($ta_Conso_Document{vl_ii}[[15]]="J") | ($ta_Conso_Document{vl_ii}[[15]]="N"))
						End if 
						//•(x7) Homme   ou Femme             
						If ($vb_OK)
							$vb_OK:=(($ta_Conso_Document{vl_ii}[[22]]="H") | ($ta_Conso_Document{vl_ii}[[22]]="F"))
						End if 
						
						If ($vb_OK)
							vl_ii:=vl_ii+1
						Else 
							DELETE FROM ARRAY:C228($ta_Conso_Document; vl_ii; 1)
						End if 
						$vb_OK:=(vl_ii>Size of array:C274($ta_Conso_Document))
					Until ($vb_OK)
					If (Size of array:C274($ta_Conso_Document)>0)
						$kk:=Size of array:C274(ta_Conso_Document)+1
						INSERT IN ARRAY:C227(ta_Conso_Document; $kk; Size of array:C274($ta_Conso_Document))
						INSERT IN ARRAY:C227(tt_Conso_DocumentDos; $kk; Size of array:C274($ta_Conso_Document))
						For ($mm; $kk; Size of array:C274(ta_Conso_Document))
							ta_Conso_Document{$mm}:=$ta_Conso_Document{$mm-$kk+1}
							tt_Conso_DocumentDos{$mm}:=<>tt_T_CheminsRegionaux{$ii}
						End for 
					End if 
				End if 
			End for 
			
			$vb_OK:=(Size of array:C274(ta_Conso_Document)>0)
		Else 
			$vb_OK:=False:C215
		End if 
		
		
End case 
$0:=$vb_OK