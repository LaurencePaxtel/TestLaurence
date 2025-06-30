Class extends DataClass

Function getUniqueTags($docWritePro_es : cs:C1710.DOCWPROSelection)->$tags_c : Collection
	var $i_el : Integer
	var $tagsB_c : Collection
	
	var $docWritePro_e : cs:C1710.DOCWPROEntity
	
	ARRAY TEXT:C222($tag_at; 0)
	
	$tags_c:=New collection:C1472
	
	For each ($docWritePro_e; $docWritePro_es)
		
		If ($docWritePro_e.tag="[@")
			JSON PARSE ARRAY:C1219($docWritePro_e.tag; $tag_at)
		End if 
		
		For ($i_el; 1; Size of array:C274($tag_at))
			
			If (Length:C16($tag_at{$i_el})#32)
				$tagsB_c:=$tags_c.query("tag = :1"; $tag_at{$i_el})
				
				If ($tagsB_c.length=0)
					$tags_c.push(New object:C1471("tag"; $tag_at{$i_el}))
				End if 
				
			End if 
			
		End for 
		
		CLEAR VARIABLE:C89($tag_at)
	End for each 
	
	$tags_c:=$tags_c.orderBy(ck ascending:K85:9)
Function searchWebDocument($refStructure_t : Text)->$docwpro_es : cs:C1710.DOCWPROSelection
	var $docwpro_e : cs:C1710.DOCWPROEntity
	var $docwproB_es : cs:C1710.DOCWPROSelection
	
	ARRAY TEXT:C222($tag_at; 0)
	
	$docwpro_es:=ds:C1482.DOCWPRO.newSelection()
	$docwproB_es:=ds:C1482.DOCWPRO.query("structureRef = :1"; $refStructure_t)
	
	For each ($docwpro_e; $docwproB_es)
		JSON PARSE ARRAY:C1219($docwpro_e.tag; $tag_at)
		
		If (Find in array:C230($tag_at; "Web")#-1)
			$docwpro_es.add($docwpro_e)
		End if 
		
	End for each 
	
	$docwpro_es:=$docwpro_es.orderBy("nom asc")