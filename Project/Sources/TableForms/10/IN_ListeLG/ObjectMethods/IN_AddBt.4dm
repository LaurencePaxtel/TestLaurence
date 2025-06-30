vb_Start:=False:C215
FORM SET INPUT:C55([INtervenants:10]; "IN_EcranSaisieLG")
FORM SET OUTPUT:C54([INtervenants:10]; "IN_ListeLG")
ADD RECORD:C56([INtervenants:10]; *)
If (OK=1)
	ADD TO SET:C119([INtervenants:10]; "E_Courant")
End if 
USE SET:C118("E_Courant")
ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)