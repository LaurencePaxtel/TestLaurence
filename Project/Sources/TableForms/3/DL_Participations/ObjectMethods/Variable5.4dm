C_OBJECT:C1216($table_o; $autreTable_o)
C_COLLECTION:C1488($collection_c)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ARRAY TEXT:C222(enumList_at; 0)
		
		$table_o:=ds:C1482.TypesTables.query("TT_Libellé = :1"; "Nb personnes ménage")
		
		$autreTable_o:=outilsOrdaSearch($table_o; "TT_RéférenceID"; "TAbles"; "TB_TT_ID")
		outilsOrdaSearchByRefStctre(->$autreTable_o)
		
		$collection_c:=$autreTable_o.orderBy("TB_Code asc").toCollection()
		COLLECTION TO ARRAY:C1562($collection_c; enumList_at; "TB_Texte")
		
		If (Size of array:C274(enumList_at)=0)
			ALERT:C41("L'énumération « Nb personnes ménage » doit être créée")
			APPEND TO ARRAY:C911(enumList_at; "0")
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		
		If (enumList_at>0)
			enumList_at{0}:=enumList_at{enumList_at}
			Form:C1466.personneMenage:=Num:C11(enumList_at{0})
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 