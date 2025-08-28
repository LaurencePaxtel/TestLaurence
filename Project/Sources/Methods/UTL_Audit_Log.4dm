//%attributes = {}
// ----------------------------------------------------
// Method: UTL_Audit_Log
// Insert a row into AuditLog table
// ----------------------------------------------------

C_TEXT($1;$3;$4;$5;$6;$user;$role;$now)
C_LONGINT($2)

$user:=UTL_Get_Intervenant_Courant
$role:=UTL_Get_Role_Intervenant
$now:=UTL_ISO_Now

$log:=ds.AuditLog.new()
$log.AL_DateTime:=$now
$log.AL_User:=$user
$log.AL_Role:=$role
$log.AL_Table:=$1
$log.AL_RecordID:=$2
$log.AL_Action:=$3
$log.AL_Field:=$4
$log.AL_OldValue:=$5
$log.AL_NewValue:=$6
$log.save()
