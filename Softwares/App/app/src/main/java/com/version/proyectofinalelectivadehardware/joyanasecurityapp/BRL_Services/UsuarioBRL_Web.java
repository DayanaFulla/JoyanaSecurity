package com.version.proyectofinalelectivadehardware.joyanasecurityapp.BRL_Services;

import com.google.gson.Gson;
import com.version.proyectofinalelectivadehardware.joyanasecurityapp.Objects.Usuario;
import com.version.proyectofinalelectivadehardware.joyanasecurityapp.httpclient.HttpConnection;
import com.version.proyectofinalelectivadehardware.joyanasecurityapp.httpclient.MethodType;
import com.version.proyectofinalelectivadehardware.joyanasecurityapp.httpclient.StandarRequestConfiguration;

import java.util.Hashtable;

/**
 * Created by DAYANA on 10/4/2018.
 */

public class UsuarioBRL_Web {

    public static String url = "192.168.43.172/JoyanaSecurityServices/api/usuario/";

    public static String DoLogin(String email){
        Hashtable<String, String> params = new Hashtable<>();
        Gson gson = new Gson();
        String jsonEmail = gson.toJson(email);

        params.put("email", jsonEmail);


        String response = HttpConnection.sendRequest(new StandarRequestConfiguration(url, MethodType.GET, params));
        return  response;
    }
}
