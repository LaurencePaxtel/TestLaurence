//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_DonneesDistri
//{
//{          Lundi 10 janvier 2011 à 11:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)

If (<>vb_T_DitribSansDecimale)
	
	If ([HeberGement:5]HG_FamDistri1M:118#0)
		$0:=[HeberGement:5]HG_FamDistri1:112+" : "+String:C10([HeberGement:5]HG_FamDistri1M:118; "### ### ##0")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri2M:119#0)
		$0:=$0+[HeberGement:5]HG_FamDistri2:113+" : "+String:C10([HeberGement:5]HG_FamDistri2M:119; "### ### ##0")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri3M:120#0)
		$0:=$0+[HeberGement:5]HG_FamDistri3:114+" : "+String:C10([HeberGement:5]HG_FamDistri3M:120; "### ### ##0")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri4M:121#0)
		$0:=$0+[HeberGement:5]HG_FamDistri4:115+" : "+String:C10([HeberGement:5]HG_FamDistri4M:121; "### ### ##0")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri5M:122#0)
		$0:=$0+[HeberGement:5]HG_FamDistri5:116+" : "+String:C10([HeberGement:5]HG_FamDistri5M:122; "### ### ##0")+<>va_CR
	End if 
	
Else 
	
	If ([HeberGement:5]HG_FamDistri1M:118#0)
		$0:=[HeberGement:5]HG_FamDistri1:112+" : "+String:C10([HeberGement:5]HG_FamDistri1M:118; "### ### ##0,00")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri2M:119#0)
		$0:=$0+[HeberGement:5]HG_FamDistri2:113+" : "+String:C10([HeberGement:5]HG_FamDistri2M:119; "### ### ##0,00")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri3M:120#0)
		$0:=$0+[HeberGement:5]HG_FamDistri3:114+" : "+String:C10([HeberGement:5]HG_FamDistri3M:120; "### ### ##0,00")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri4M:121#0)
		$0:=$0+[HeberGement:5]HG_FamDistri4:115+" : "+String:C10([HeberGement:5]HG_FamDistri4M:121; "### ### ##0,00")+<>va_CR
	End if 
	
	If ([HeberGement:5]HG_FamDistri5M:122#0)
		$0:=$0+[HeberGement:5]HG_FamDistri5:116+" : "+String:C10([HeberGement:5]HG_FamDistri5M:122; "### ### ##0,00")+<>va_CR
	End if 
	
End if 