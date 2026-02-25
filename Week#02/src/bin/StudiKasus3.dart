// Validasi Data Pengguna
void main() {  
  String username = 'budi123';  
  String password = 'pass123';  
  int umur = 17;    
  bool isUsernameValid = username.length >= 6;  
  bool isPasswordValid = password.length >= 6;  
  bool isAdult = umur >= 18;    
  bool canRegister = isUsernameValid && isPasswordValid;  
  bool canAccessAdultContent = canRegister && isAdult;    
  print('Dapat mendaftar: $canRegister');  
  print('Dapat mengakses konten: $canAccessAdultContent');
}
