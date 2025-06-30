//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VarConso_Liste
//{
//{          Mardi 17 février 2009 à 13:35:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $kk; $mm)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1=0)
		C_LONGINT:C283(vl_ConsoB_DocumentLignes)
		C_TEXT:C284(va_ConsoB_Document)
		C_LONGINT:C283(vl_ConsoB_DocumentLignes)
		
		C_TEXT:C284(vt_ConsoB_Chemin)
		C_TEXT:C284(vt_ConsoB_CheminDossier)
		C_TEXT:C284(vt_ConsoB_Dossier)
		C_TEXT:C284(vt_ConsoB_Document)
		C_TEXT:C284(vt_ConsoB_Titre)
		
		C_TEXT:C284(vt_ConsoB_Buffer)
		
	: ($1=1)
		vl_ConsoB_DocumentLignes:=0
		va_ConsoB_Document:=""
		ARRAY TEXT:C222(ta_Conso_Document; 0)
		vt_ConsoB_Chemin:=""
		vt_ConsoB_CheminDossier:=""
		vt_ConsoB_Dossier:=""
		
		
	: ($1=2)
		
	: ($1=3)
		vt_ConsoB_Chemin:=""
		vt_ConsoB_CheminDossier:=""
		vt_ConsoB_Dossier:=""
		
	: ($1=4)
		t_ConsoB_Document:=""
		vt_ConsoB_Titre:=""
		
		
	: ($1=5)
		
		P_VarConso_Regional(1)
		//•(3) Les répertoires de consolidation régionales sur les 115 existent-ils    
		$vb_OK:=False:C215
		$kk:=0
		$mm:=0
		ARRAY BOOLEAN:C223($tb_T_CheminsRegionaux; Size of array:C274(<>tt_T_CheminsRegionaux))
		If (Size of array:C274(<>tt_T_CheminsRegionaux)>0)
			For ($ii; 1; Size of array:C274(<>tt_T_CheminsRegionaux))
				vb_Conso:=F_Report_FullDuplexDossier(11; <>tt_T_CheminsRegionaux{$ii})
				If (vb_Conso=False:C215)
					$kk:=$kk+1
					$tb_T_CheminsRegionaux{$ii}:=False:C215
				Else 
					$mm:=$mm+1
					$tb_T_CheminsRegionaux{$ii}:=True:C214
				End if 
			End for 
			$vb_OK:=($mm>0)
		Else 
			$vb_OK:=False:C215
			ALERT:C41("Aucun répertoire régional !")
		End if 
		If ($vb_OK)
			For ($ii; 1; Size of array:C274($tb_T_CheminsRegionaux))
				ARRAY TEXT:C222($ta_Conso_Document; 0)
				If ($tb_T_CheminsRegionaux{$ii}=True:C214)
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
					End if 
					
					If (Size of array:C274($ta_Conso_Document)>0)
						$kk:=Size of array:C274(ta_Conso_Document)+1
						$mm:=Size of array:C274($ta_Conso_Document)
						INSERT IN ARRAY:C227(ta_Conso_Document; $kk; $mm)
						For ($ii; $kk; Size of array:C274(ta_Conso_Document))
							ta_Conso_Document{$ii}:=$ta_Conso_Document{$ii-$kk+1}
						End for 
					End if 
				End if 
			End for 
		End if 
		vl_Conso_DocumentLignes:=Size of array:C274(ta_Conso_Document)
		va_ConsoB_Document:=String:C10(vl_Conso_DocumentLignes)+" fiche"+("s"*Num:C11(vl_Conso_DocumentLignes>1))+" trouvée"+("s"*Num:C11(vl_Conso_DocumentLignes>1))+" le "+String:C10(Current date:C33; Système date court:K1:1)+" à "+String:C10(Current time:C178; h mn:K7:2)
		
End case 

