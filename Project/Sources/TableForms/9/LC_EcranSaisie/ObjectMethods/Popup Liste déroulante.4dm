var $index_el : Integer

var $structure_e : cs:C1710.StructuresEntity
var $factureExport_e : cs:C1710.FactureExportEntity

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		outilsOrdaSearchSimple("Structures"; "UID"; <>user_uid_entreprise; ->$structure_e; "first")
		
		OBJECT Get pointer:C1124(Objet courant:K67:2)->:=New object:C1471()
		OBJECT Get pointer:C1124(Objet courant:K67:2)->values:=$structure_e.AllFactureExport.toCollection().extract("sectionCodeThird")
		
		If ([LesCentres:9]factureExportID:100="")
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=-1
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:="Choix du « Code section Tiers »"
		Else 
			outilsOrdaSearchSimple("FactureExport"; "ID"; [LesCentres:9]factureExportID:100; ->$factureExport_e; "first")
			$index_el:=OBJECT Get pointer:C1124(Objet courant:K67:2)->values.indexOf($factureExport_e.sectionCodeThird)
			
			OBJECT Get pointer:C1124(Objet courant:K67:2)->index:=$index_el
			OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue:=$factureExport_e.sectionCodeThird
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		outilsOrdaSearchSimple("FactureExport"; "sectionCodeThird"; OBJECT Get pointer:C1124(Objet courant:K67:2)->currentValue; ->$factureExport_e; "first")
		[LesCentres:9]factureExportID:100:=$factureExport_e.ID
End case 