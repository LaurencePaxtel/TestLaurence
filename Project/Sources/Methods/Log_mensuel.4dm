//%attributes = {}
// ----------------------------------------------------
// Method: Log_mensuel
// Simple logging utility
// #1: Boolean - enable logging
// #2: Text - message
// #3: Text - filename
// ----------------------------------------------------
C_BOOLEAN($1)
C_TEXT($2;$3)
If ($1)
  APPEND TO DOCUMENT($3; $2+Char(Carriage return))
End if
