function FDP_Login(){
  document.getElementById('method').value='POST';
  document.getElementById('login').action='password-reset';
  document.getElementById('login').submit(); 
  return false;
}

function FDP_Password_Reset(){
  document.getElementById('method').value='POST';
  document.getElementById('password_reset').submit();
  return false;
}