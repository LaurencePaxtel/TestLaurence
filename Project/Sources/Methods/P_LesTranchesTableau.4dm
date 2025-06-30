//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($ii)

ARRAY TEXT:C222(<>ta_LesTranches; $1)
ARRAY INTEGER:C220(<>te_LesTranches; $1)
For ($ii; 1; Size of array:C274(<>ta_LesTranches))
	<>ta_LesTranches{$ii}:=Field:C253($2; $ii+2)->
	<>te_LesTranches{$ii}:=Field:C253($2; $ii+14)->
End for 