#include <Keypad.h>
#include <Wire.h> 
#include "RTClib.h" 
// Declaramos un RTC DS3231
RTC_DS3231 rtc;
#include <LiquidCrystal_I2C.h>

// Set the LCD address to 0x27 for a 16 chars and 2 line display
LiquidCrystal_I2C lcd(0x27, 16, 2);

const byte ROWS = 4; //four rows
const byte COLS = 4; //four columns

//define the cymbols on the buttons of the keypads
char hexaKeys[ROWS][COLS] = {
  {'1','2','3','A'},
  {'4','5','6','B'},
  {'7','8','9','C'},
  {'*','0','#','D'}
};
byte rowPins[ROWS] = {9, 8, 7, 6}; //connect to the row pinouts of the keypad
byte colPins[COLS] = {5, 4, 3, 2}; //connect to the column pinouts of the keypad

//initialize an instance of class NewKeypad
Keypad customKeypad = Keypad( makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS); 

//PINES AND OTHERS
const int pinBuzzer = 13;
const int pinPIR = 10;
const int pinMagnetic1 = 11;
const int pinMagnetic2 = 12;
char key;

//VARIABLES DE FUNCIONAMIENTO
boolean showTime = true;
String options[3] = {"A: Activar", "B: Cambiar Contr", "C: Ver Reporte"};
int contOpt = 0;
String currentTime = "";
const long intervalOption = 3000;
long previusMillOpt = 0;

boolean isActive = false;
boolean sound = false;
String PASSWORD = "123454321";
String lastAlarm = "NO HAY DATOS";
const long intervalBuzzer  = 500;
long previousMillBuzzer = 0;

String estado;
String contrasena;

void setup() {
  if (! rtc.begin()) {
    //Serial.println("No hay un módulo RTC");
    while (1);
  }    
  if (rtc.lostPower()) {
    rtc.adjust(DateTime(2018, 06, 19, 11, 01, 0));    
  }
  
  Serial.begin(9600);
  pinMode(pinBuzzer, OUTPUT);
  pinMode(pinPIR, INPUT);
  pinMode(pinMagnetic1, INPUT_PULLUP);
  pinMode(pinMagnetic2, INPUT_PULLUP);
  
  lcd.begin();    

  lcd.setCursor(0,1);
  lcd.print("                ");
      
  lcd.setCursor(0,1);
  lcd.print(options[contOpt]);

  contOpt++;
}

void loop() {
  key = customKeypad.getKey();
  unsigned long currentMillis = millis();   
  
  DateTime now = rtc.now();
  currentTime = "";
  currentTime = currentTime + " " + now.day() + "/" + now.month() + " "+ now.hour() + ":" + now.minute() + ":" + now.second() + " ";

  if (showTime){
    lcd.setCursor(0,0);
    lcd.print(currentTime);

    if ((currentMillis - previusMillOpt) > intervalOption){
      previusMillOpt = currentMillis;
      lcd.setCursor(0,1);
      lcd.print("                ");
      
      lcd.setCursor(0,1);
      lcd.print(options[contOpt]);
  
      contOpt++;
      if (contOpt >= 3){
        contOpt = 0;      
      }  
    }
  }

  if (key != NO_KEY){    
    if (key == 'A') {
      InitActivacion();
    } else if (key == 'B'){
      changePassword();
    } else if (key == 'C'){
      lcd.clear();
      lcd.setCursor(1, 0);      
      lcd.print("ULTIMA ALERTA:");
      lcd.setCursor(1, 1);
      lcd.print(lastAlarm);  
      delay(6000);
      lcd.clear();
    }
  }   

  if (isActive){
    if (digitalRead(pinPIR) == HIGH || digitalRead(pinMagnetic1) == HIGH || digitalRead(pinMagnetic2) == HIGH){
      if (!sound){
        lastAlarm = currentTime;
      }      
      sound = true;
    } 
  }

  if (sound == true){
    analogWrite(pinBuzzer,128);    
    if (currentMillis - previousMillBuzzer >= intervalBuzzer){
      digitalWrite(pinBuzzer, LOW); //deja de emitir
      previousMillBuzzer = currentMillis;        
    } 
  }  

  if(Serial.available() > 0 ){
     estado = Serial.readStringUntil(';');
     contrasena = Serial.readString();          

     PASSWORD = contrasena;
     if (estado == "t"){
        options[0] = "A: Desactivar";    
        isActive = true;    
     } else if (estado == "f"){
        isActive = false;
        sound = false;
        options[0] = "A: Activar";    
        digitalWrite(pinBuzzer, LOW);        
     }     
  }  
}

