//%attributes = {"shared":true}
#DECLARE($vt_MethodName : Text; $vb_ExecuteOnServer : Boolean)
var $vl_ServerProcess : Integer
If(Bool:C1537($vb_ExecuteOnServer))
$vl_ServerProcess:=Execute on server:C373($vt_MethodName; 0)
Else
EXECUTE METHOD:C1007($vt_MethodName)
End if
