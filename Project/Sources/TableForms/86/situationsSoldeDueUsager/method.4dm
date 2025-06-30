var $index_i : Integer
var $destinataireID_c; $facture_c; $autreFacture_c : Collection

var $heberge_es : cs:C1710.HeBergeSelection
var $facture_e : cs:C1710.FacturesEntity
var $facture_es; $autreFacture_es : cs:C1710.FacturesSelection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		Form:C1466.loadAll:=False:C215
		Form:C1466.notification_cs:=cuToolGetClass("Notification").new()
		
		Form:C1466.dateDu:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33)))
		Form:C1466.dateAu:=Date:C102("31/12/"+String:C10(Year of:C25(Current date:C33)))
		
		POST OUTSIDE CALL:C329(Current process:C322)
	: (Form event code:C388=Sur appel extérieur:K2:11)
		$facture_es:=ds:C1482.Factures.query("FAC_Type_Piece = :1"; Choose:C955(Num:C11(Form:C1466.appel)=1; "HG"; "P"))
		outilsOrdaSearchByRefStctre(->$facture_es)
		
		If (Date:C102(Form:C1466.dateDu)#!00-00-00!) & (Form:C1466.loadAll=True:C214)
			$facture_es:=$facture_es.query("FAC_Date_Piece >= :1"; Form:C1466.dateDu)
		End if 
		
		If (Date:C102(Form:C1466.dateAu)#!00-00-00!) & (Form:C1466.loadAll=True:C214)
			$facture_es:=$facture_es.query("FAC_Date_Piece <= :1"; Form:C1466.dateAu)
		End if 
		
		If (String:C10(Form:C1466.nom)#"")
			$facture_es:=$facture_es.query("FAC_Destinataire_Nom = :1"; "@"+Form:C1466.nom+"@")
		End if 
		
		$facture_c:=$facture_es.toCollection().orderBy("FAC_Destinataire_Nom asc, FAC_Date_Piece asc, FAC_No_Piece asc")
		$destinataireID_c:=$facture_c.distinct("FAC_Destinataire_ID")
		
		$autreFacture_c:=New collection:C1472
		
		For each ($facture_e; $facture_c)
			$index_i:=$destinataireID_c.indexOf($facture_e.FAC_Destinataire_ID)
			
			If ($index_i#-1)
				$heberge_es:=ds:C1482.HeBerge.query("HB_ReferenceID is :1"; $facture_e.FAC_Origine_ID)
				
				If ($heberge_es.length>0)
					$facture_e.nomUsager:=$heberge_es[0].HB_Nom+" "+$heberge_es[0].HB_Prénom
				Else 
					$facture_e.nomUsager:=""
				End if 
				
				$autreFacture_es:=ds:C1482.Factures.query("FAC_Destinataire_ID = :1 AND FAC_Type_Piece = :2"; $facture_e.FAC_Destinataire_ID; Choose:C955(Num:C11(Form:C1466.appel)=1; "HG"; "P"))
				
				If (Date:C102(Form:C1466.dateDu)#!00-00-00!) & (Form:C1466.loadAll=True:C214)
					$autreFacture_es:=$autreFacture_es.query("FAC_Date_Piece >= :1"; Form:C1466.dateDu)
				End if 
				
				If (Date:C102(Form:C1466.dateAu)#!00-00-00!) & (Form:C1466.loadAll=True:C214)
					$autreFacture_es:=$autreFacture_es.query("FAC_Date_Piece <= :1"; Form:C1466.dateAu)
				End if 
				
				$facture_e.soldeDue:=$autreFacture_es.sum("FAC_Solde_Du_cal")
				$autreFacture_c.push($facture_e)
				
				If (statut_at{statut_at}#"") & (statut_at{statut_at}#"Tous") & (statut_at{statut_at}#"Sélectionner une statut de facture")
					
					If ((statut_at{statut_at}="Soldée") & ($facture_e.soldeDue#0)) | ((statut_at{statut_at}="Non Soldée") & ($facture_e.soldeDue=0))
						$autreFacture_c.remove($autreFacture_c.length-1)
					End if 
					
				End if 
				
				$destinataireID_c.remove($index_i)
			End if 
			
		End for each 
		
		Form:C1466.situations:=$autreFacture_c.orderBy("FAC_Destinataire_Nom asc, FAC_Date_Piece asc, FAC_No_Piece asc")
		
		If (Form:C1466.loadAll=False:C215)
			Form:C1466.loadAll:=True:C214
			
			POST OUTSIDE CALL:C329(Current process:C322)
		End if 
		
End case 