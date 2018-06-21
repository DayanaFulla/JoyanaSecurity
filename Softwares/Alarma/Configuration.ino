void changePassword(){
  lcd.clear();
  lcd.setCursor(3,0);
  lcd.print("CAMBIANDO");  
  lcd.setCursor(3,1);
  lcd.print("CONTRASENA...");  
  delay(4000);

  if (ValidatingPassword()){
    lcd.setCursor(0,0);
    lcd.print("NUEVA CONTRASENA");  
    String newPassword = "";
    String concatPass = "";
    int contValidator = 0;
    while(true){
      key = customKeypad.getKey();
      if (key != NO_KEY){ 
        if (key == '*'){
          lcd.clear();
          if (contValidator <= 0){            
            lcd.setCursor(0,0);
            lcd.print("ERROR: MIN. DIG.");  
            lcd.setCursor(0,1);
            lcd.print("PERMITIDOS = 0");  
            delay(2000);            
          } else {
            PASSWORD = newPassword; 
            String sendPass = "CP;hoka";
            Serial.println(sendPass);
            delay(10);
            lcd.setCursor(1,0);
            lcd.print("CLAVE GUARDADA");  
            lcd.setCursor(2,1);
            lcd.print("EXITOSAMENTE");  
          }
          delay(2000);
          lcd.clear();
          break;
          
        } else if (key != '*' && key != 'A' && key != 'B' && key != 'C' && key != 'D' && key != '#') {
          concatPass += "*";
          lcd.setCursor(0,1);
          lcd.print(concatPass);
          newPassword += key;

          contValidator++;
          if (contValidator > 10){
            lcd.clear();
            lcd.setCursor(0,0);
            lcd.print("ERROR: MAX. DIG.");  
            lcd.setCursor(0,1);
            lcd.print("PERMITIDOS = 10");  
            delay(2000);
            lcd.clear();
            break;
          }
        }
      }
      delay(100);  
    }
  }
}

boolean ValidatingPassword(){
  lcd.clear();  
  lcd.setCursor(0,0);
  lcd.print("DIGITE SU CLAVE:");  
  String digitPass = "";
  String concatPass = "";
  while (true){
    key = customKeypad.getKey();
    if (key != NO_KEY){ 
      if (key == '*'){
        if (PASSWORD == digitPass){
          lcd.clear();
          return true;
        } else {
          lcd.clear();
          lcd.setCursor(3, 0);      
          lcd.print("CONTRASENA");
          lcd.setCursor(3, 1);
          lcd.print("INCORRECTA");             
          digitPass = "";
          concatPass = "";
          delay(2000);  
          lcd.clear();
          return false;
        }
        
      } else if (key != '*' && key != 'A' && key != 'B' && key != 'C' && key != 'D' && key != '#') {
        concatPass += "*";
        lcd.setCursor(0,1);
        lcd.print(concatPass);
        digitPass += key;
      }
    }
    delay(100);
  }
}

