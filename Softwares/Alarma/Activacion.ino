void InitActivacion (){   
  if (ValidatingPassword()){
    if (isActive){
      lcd.setCursor(5, 0);      
      lcd.print("ALARMA");
      lcd.setCursor(3, 1);
      lcd.print("DESACTIVADA");  
      isActive = !isActive;
      options[0] = "A: Activar";
      sound = false;
      digitalWrite(pinBuzzer, LOW);
    } else {
      lcd.setCursor(5, 0);      
      lcd.print("ALARMA");
      lcd.setCursor(4, 1);
      lcd.print("ACTIVADA");
      isActive = !isActive;
      options[0] = "A: Desactivar";
    }          
    delay(2000); 
  }
               
        
}

