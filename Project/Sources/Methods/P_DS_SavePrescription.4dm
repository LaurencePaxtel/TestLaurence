//%attributes = {}
C_LONGINT:C283($1)

Case of 
	: ($1=0)
		vd_DSP_Date1:=!00-00-00!
		va_DSP_Lib1:=""
		vd_DSP_DateA1:=!00-00-00!
		va_DSP_Ma1:=""
		va_DSP_Mi1:=""
		va_DSP_So1:=""
		va_DSP_Nu1:=""
		
		vd_DSP_Date2:=!00-00-00!
		va_DSP_Lib2:=""
		vd_DSP_DateA2:=!00-00-00!
		va_DSP_Ma2:=""
		va_DSP_Mi2:=""
		va_DSP_So2:=""
		va_DSP_Nu2:=""
		
		vd_DSP_Date3:=!00-00-00!
		va_DSP_Lib3:=""
		vd_DSP_DateA3:=!00-00-00!
		va_DSP_Ma3:=""
		va_DSP_Mi3:=""
		va_DSP_So3:=""
		va_DSP_Nu3:=""
		
		vd_DSP_Date4:=!00-00-00!
		va_DSP_Lib4:=""
		vd_DSP_DateA4:=!00-00-00!
		va_DSP_Ma4:=""
		va_DSP_Mi4:=""
		va_DSP_So4:=""
		va_DSP_Nu4:=""
		
		vd_DSP_Date5:=!00-00-00!
		va_DSP_Lib5:=""
		vd_DSP_DateA5:=!00-00-00!
		va_DSP_Ma5:=""
		va_DSP_Mi5:=""
		va_DSP_So5:=""
		va_DSP_Nu5:=""
		
		vd_DSP_Date6:=!00-00-00!
		va_DSP_Lib6:=""
		vd_DSP_DateA6:=!00-00-00!
		va_DSP_Ma6:=""
		va_DSP_Mi6:=""
		va_DSP_So6:=""
		va_DSP_Nu6:=""
		
		vd_DSP_Date7:=!00-00-00!
		va_DSP_Lib7:=""
		vd_DSP_DateA7:=!00-00-00!
		va_DSP_Ma7:=""
		va_DSP_Mi7:=""
		va_DSP_So7:=""
		va_DSP_Nu7:=""
		
		vd_DSP_Date8:=!00-00-00!
		va_DSP_Lib8:=""
		vd_DSP_DateA8:=!00-00-00!
		va_DSP_Ma8:=""
		va_DSP_Mi8:=""
		va_DSP_So8:=""
		va_DSP_Nu8:=""
		
		vd_DSP_Date9:=!00-00-00!
		va_DSP_Lib9:=""
		vd_DSP_DateA9:=!00-00-00!
		va_DSP_Ma9:=""
		va_DSP_Mi9:=""
		va_DSP_So9:=""
		va_DSP_Nu9:=""
		
		vd_DSP_Date10:=!00-00-00!
		va_DSP_Lib10:=""
		vd_DSP_DateA10:=!00-00-00!
		va_DSP_Ma10:=""
		va_DSP_Mi10:=""
		va_DSP_So10:=""
		va_DSP_Nu10:=""
		
		vd_DSP_Date11:=!00-00-00!
		va_DSP_Lib11:=""
		vd_DSP_DateA11:=!00-00-00!
		va_DSP_Ma11:=""
		va_DSP_Mi11:=""
		va_DSP_So11:=""
		va_DSP_Nu11:=""
		
		vd_DSP_Date12:=!00-00-00!
		va_DSP_Lib12:=""
		vd_DSP_DateA12:=!00-00-00!
		va_DSP_Ma12:=""
		va_DSP_Mi12:=""
		va_DSP_So12:=""
		va_DSP_Nu12:=""
		
		
		va_DSP_LibPoids:=""
		va_DSP_LibTA:=""
		va_DSP_LibPoul:=""
		va_DSP_LibTemp:=""
		va_DSP_LibHGT:=""
	: ($1=1)
		[DossierSante:33]DE_Prescription:123:=""
		
		[DossierSante:33]DE_Prescription:123:=String:C10(vd_DSP_Date1; 7)+<>va_Tab+va_DSP_Lib1+<>va_Tab+String:C10(vd_DSP_DateA1; 7)+<>va_Tab+va_DSP_Ma1+<>va_Tab+va_DSP_Mi1+<>va_Tab+va_DSP_So1+<>va_Tab+va_DSP_Nu1+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date2; 7)+<>va_Tab+va_DSP_Lib2+<>va_Tab+String:C10(vd_DSP_DateA2; 7)+<>va_Tab+va_DSP_Ma2+<>va_Tab+va_DSP_Mi2+<>va_Tab+va_DSP_So2+<>va_Tab+va_DSP_Nu2+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date3; 7)+<>va_Tab+va_DSP_Lib3+<>va_Tab+String:C10(vd_DSP_DateA3; 7)+<>va_Tab+va_DSP_Ma3+<>va_Tab+va_DSP_Mi3+<>va_Tab+va_DSP_So3+<>va_Tab+va_DSP_Nu3+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date4; 7)+<>va_Tab+va_DSP_Lib4+<>va_Tab+String:C10(vd_DSP_DateA4; 7)+<>va_Tab+va_DSP_Ma4+<>va_Tab+va_DSP_Mi4+<>va_Tab+va_DSP_So4+<>va_Tab+va_DSP_Nu4+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date5; 7)+<>va_Tab+va_DSP_Lib5+<>va_Tab+String:C10(vd_DSP_DateA5; 7)+<>va_Tab+va_DSP_Ma5+<>va_Tab+va_DSP_Mi5+<>va_Tab+va_DSP_So5+<>va_Tab+va_DSP_Nu5+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date6; 7)+<>va_Tab+va_DSP_Lib6+<>va_Tab+String:C10(vd_DSP_DateA6; 7)+<>va_Tab+va_DSP_Ma6+<>va_Tab+va_DSP_Mi6+<>va_Tab+va_DSP_So6+<>va_Tab+va_DSP_Nu6+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date7; 7)+<>va_Tab+va_DSP_Lib7+<>va_Tab+String:C10(vd_DSP_DateA7; 7)+<>va_Tab+va_DSP_Ma7+<>va_Tab+va_DSP_Mi7+<>va_Tab+va_DSP_So7+<>va_Tab+va_DSP_Nu7+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date8; 7)+<>va_Tab+va_DSP_Lib8+<>va_Tab+String:C10(vd_DSP_DateA8; 7)+<>va_Tab+va_DSP_Ma8+<>va_Tab+va_DSP_Mi8+<>va_Tab+va_DSP_So8+<>va_Tab+va_DSP_Nu8+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date9; 7)+<>va_Tab+va_DSP_Lib9+<>va_Tab+String:C10(vd_DSP_DateA9; 7)+<>va_Tab+va_DSP_Ma9+<>va_Tab+va_DSP_Mi9+<>va_Tab+va_DSP_So9+<>va_Tab+va_DSP_Nu9+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date10; 7)+<>va_Tab+va_DSP_Lib10+<>va_Tab+String:C10(vd_DSP_DateA10; 7)+<>va_Tab+va_DSP_Ma10+<>va_Tab+va_DSP_Mi10+<>va_Tab+va_DSP_So10+<>va_Tab+va_DSP_Nu10+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date11; 7)+<>va_Tab+va_DSP_Lib11+<>va_Tab+String:C10(vd_DSP_DateA11; 7)+<>va_Tab+va_DSP_Ma11+<>va_Tab+va_DSP_Mi11+<>va_Tab+va_DSP_So11+<>va_Tab+va_DSP_Nu11+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+String:C10(vd_DSP_Date12; 7)+<>va_Tab+va_DSP_Lib12+<>va_Tab+String:C10(vd_DSP_DateA12; 7)+<>va_Tab+va_DSP_Ma12+<>va_Tab+va_DSP_Mi12+<>va_Tab+va_DSP_So12+<>va_Tab+va_DSP_Nu12+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+va_DSP_LibPoids+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+va_DSP_LibTA+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+va_DSP_LibPoul+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+va_DSP_LibTemp+<>va_CR
		[DossierSante:33]DE_Prescription:123:=[DossierSante:33]DE_Prescription:123+va_DSP_LibHGT+<>va_CR
	: ($1=2)
		
		If ([DossierSante:33]DE_Prescription:123>"")
			C_TEXT:C284(vt_memoNote)
			
			vt_memoNote:=[DossierSante:33]DE_Prescription:123
			
			vd_DSP_Date1:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib1:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA1:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma1:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi1:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So1:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu1:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date2:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib2:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA2:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma2:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi2:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So2:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu2:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date3:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib3:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA3:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma3:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi3:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So3:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu3:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date4:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib4:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA4:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma4:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi4:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So4:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu4:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date5:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib5:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA5:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma5:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi5:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So5:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu5:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date6:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib6:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA6:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma6:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi6:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So6:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu6:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date7:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib7:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA7:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma7:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi7:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So7:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu7:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date8:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib8:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA8:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma8:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi8:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So8:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu8:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date9:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib9:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA9:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma9:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi9:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So9:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu9:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date10:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib10:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA10:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma10:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi10:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So10:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu10:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date11:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib11:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA11:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma11:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi11:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So11:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu11:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			vd_DSP_Date12:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Lib12:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			vd_DSP_DateA12:=Date:C102(Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1))
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Ma12:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Mi12:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_So12:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_Tab; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_Tab; vt_memoNote)+1)
			va_DSP_Nu12:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			
			va_DSP_LibPoids:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			va_DSP_LibTA:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			va_DSP_LibPoul:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			va_DSP_LibTemp:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
			vt_memoNote:=Substring:C12(vt_memoNote; Position:C15(<>va_CR; vt_memoNote)+1)
			va_DSP_LibHGT:=Substring:C12(vt_memoNote; 1; Position:C15(<>va_CR; vt_memoNote)-1)
		Else 
			vd_DSP_Date1:=!00-00-00!
			va_DSP_Lib1:=""
			vd_DSP_DateA1:=!00-00-00!
			va_DSP_Ma1:=""
			va_DSP_Mi1:=""
			va_DSP_So1:=""
			va_DSP_Nu1:=""
			
			vd_DSP_Date2:=!00-00-00!
			va_DSP_Lib2:=""
			vd_DSP_DateA2:=!00-00-00!
			va_DSP_Ma2:=""
			va_DSP_Mi2:=""
			va_DSP_So2:=""
			va_DSP_Nu2:=""
			
			vd_DSP_Date3:=!00-00-00!
			va_DSP_Lib3:=""
			vd_DSP_DateA3:=!00-00-00!
			va_DSP_Ma3:=""
			va_DSP_Mi3:=""
			va_DSP_So3:=""
			va_DSP_Nu3:=""
			
			vd_DSP_Date4:=!00-00-00!
			va_DSP_Lib4:=""
			vd_DSP_DateA4:=!00-00-00!
			va_DSP_Ma4:=""
			va_DSP_Mi4:=""
			va_DSP_So4:=""
			va_DSP_Nu4:=""
			
			vd_DSP_Date5:=!00-00-00!
			va_DSP_Lib5:=""
			vd_DSP_DateA5:=!00-00-00!
			va_DSP_Ma5:=""
			va_DSP_Mi5:=""
			va_DSP_So5:=""
			va_DSP_Nu5:=""
			
			vd_DSP_Date6:=!00-00-00!
			va_DSP_Lib6:=""
			vd_DSP_DateA6:=!00-00-00!
			va_DSP_Ma6:=""
			va_DSP_Mi6:=""
			va_DSP_So6:=""
			va_DSP_Nu6:=""
			
			vd_DSP_Date7:=!00-00-00!
			va_DSP_Lib7:=""
			vd_DSP_DateA7:=!00-00-00!
			va_DSP_Ma7:=""
			va_DSP_Mi7:=""
			va_DSP_So7:=""
			va_DSP_Nu7:=""
			
			vd_DSP_Date8:=!00-00-00!
			va_DSP_Lib8:=""
			vd_DSP_DateA8:=!00-00-00!
			va_DSP_Ma8:=""
			va_DSP_Mi8:=""
			va_DSP_So8:=""
			va_DSP_Nu8:=""
			
			vd_DSP_Date9:=!00-00-00!
			va_DSP_Lib9:=""
			vd_DSP_DateA9:=!00-00-00!
			va_DSP_Ma9:=""
			va_DSP_Mi9:=""
			va_DSP_So9:=""
			va_DSP_Nu9:=""
			
			vd_DSP_Date10:=!00-00-00!
			va_DSP_Lib10:=""
			vd_DSP_DateA10:=!00-00-00!
			va_DSP_Ma10:=""
			va_DSP_Mi10:=""
			va_DSP_So10:=""
			va_DSP_Nu10:=""
			
			
			vd_DSP_Date11:=!00-00-00!
			va_DSP_Lib11:=""
			vd_DSP_DateA11:=!00-00-00!
			va_DSP_Ma11:=""
			va_DSP_Mi11:=""
			va_DSP_So11:=""
			va_DSP_Nu11:=""
			
			vd_DSP_Date12:=!00-00-00!
			va_DSP_Lib12:=""
			vd_DSP_DateA12:=!00-00-00!
			va_DSP_Ma12:=""
			va_DSP_Mi12:=""
			va_DSP_So12:=""
			va_DSP_Nu12:=""
			
			
			va_DSP_LibPoids:=""
			va_DSP_LibTA:=""
			va_DSP_LibPoul:=""
			va_DSP_LibTemp:=""
			va_DSP_LibHGT:=""
		End if 
		
End case 