import processing.serial.*;
import http.requests.*;

Serial port;

JSONObject json;

void setup(){
  size(600, 600);  
    
  port = new Serial(this, "COM46", 9600);   
  /*
  PostRequest post = new PostRequest("http://localhost/JoyanaSecurityServices/api/alarma/Config");  
  post.addData("IdAlarma", "2");
  post.addData("Contrasena", "87873");  
  post.send();
  println("Reponse Content: " + post.getContent());
  println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));
  */
  
}

void draw(){
  GetRequest get = new GetRequest("http://localhost/JoyanaSecurityServices/api/alarma/GetAlarmaByUsuarioId/4");
  get.send();
  
  //println("Reponse Content: " + get.getContent());
  json = parseJSONObject(get.getContent());
  
  boolean state = json.getBoolean("IsActive");
  String password = json.getString("Contrasena");
  String data = "";
  if (state){        
    data += "t;";
  } else {    
    data += "f;";
  }
  
  data += password;  
  
  port.write(data);
    
  
  println(state); 
  delay(2000);
}

void serialEvent(Serial port){ 
  //String accion = port.readStringUntil(';');
  String dato = "";
  if (port.available() > 0) {
    dato = port.readString();
  }
  
  //if (accion != null){        
    //accion = trim(accion);
    //println("accion: " + accion);
    if (dato != null){
      dato = trim(dato);
      println("accion: " + dato);  
    }    
  //}
}  
