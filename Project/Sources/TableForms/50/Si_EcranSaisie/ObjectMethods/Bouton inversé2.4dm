//•• Accuei
QUERY:C277([SIAO_SiteReference:54]; [SIAO_SiteReference:54]Sa_RéférenceID:1=[SIAO:50]Si_Origine_SiteReference_ID:15)
MultiSoc_Filter(->[SIAO_SiteReference:54])
If (Records in selection:C76([SIAO_SiteReference:54])=1)
	[SIAO:50]Si_Origine_SiteReference:14:=[SIAO_SiteReference:54]Sa_ReferenceNom:6
End if 