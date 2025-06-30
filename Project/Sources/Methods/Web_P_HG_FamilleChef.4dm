//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementGpeAsile
//{
//{          Mardi 22 février 2005 à 11:47:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_TEXT:C284($structure_t)
C_BOOLEAN:C305($vb_OK; $group_b)

$vb_OK:=[HeberGement:5]HG_FamChef:103  //15/2/2010
$vb_OK:=True:C214  //15/2/2010


If ($1=1)
	
	If ([HeberGement:5]HG_FamChef:103)
		
		If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
			$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
		Else 
			$structure_t:=Storage:C1525.societeDetail.Ref_Structure
		End if 
		
		If ([HeberGement:5]HG_FamClé:104="")
			va_LeNoFAM:=""
			
			READ WRITE:C146([HeBerge:4])
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
			
			MultiSoc_Filter(->[HeBerge:4])
			
			If (Records in selection:C76([HeBerge:4])>1)
				REDUCE SELECTION:C351([HeBerge:4]; 1)
			End if 
			
			If (Records in selection:C76([HeBerge:4])=1)
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (06/10/2021)
				// Si on a importé une fiche hébergée et que les 3 premières lettres ne sont pas celles de la structure sur lequel je suis en train de travailler alors on reset
				If (Value type:C1509(w_visiteur)#Est une variable indéfinie:K8:13) && (w_visiteur#Null:C1517)
					$group_b:=outilsManagePrivilege(1; "RemiseZeroNumerotation"; w_userUID)
				Else 
					$group_b:=(Session:C1714.storage.intervenant.Privileges.query("nom IS :1"; "RemiseZeroNumerotation").length=1)
				End if 
				
				If ([HeBerge:4]HB_CléFam:47>"") & ($group_b=False:C215) & (Substring:C12([HeBerge:4]HB_CléFam:47; 0; 3)=$structure_t)
					va_LeNoFAM:=[HeBerge:4]HB_CléFam:47
				Else 
					
					Repeat 
						LOAD RECORD:C52([HeBerge:4])
					Until (Not:C34(Locked:C147([HeBerge:4])))
					
					If (Not:C34(Locked:C147([HeBerge:4])))
						[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
						[HeBerge:4]HB_CléFam:47:=web_F_LienDeFamille("Nouveau")
						
						SAVE RECORD:C53([HeBerge:4])
						va_LeNoFAM:=[HeBerge:4]HB_CléFam:47
					End if 
					
				End if 
				
			End if 
			
			UNLOAD RECORD:C212([HeBerge:4])
			READ ONLY:C145([HeBerge:4])
			
			[HeberGement:5]HG_FamClé:104:=va_LeNoFAM
		End if 
		
	End if 
	
End if 