package com.version.proyectofinalelectivadehardware.joyanasecurityapp;

import android.content.Intent;
import android.content.SharedPreferences;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class Login extends AppCompatActivity {

    private EditText txtPassword;
    private EditText txtEmail;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        txtPassword = findViewById(R.id.txt_Password);
        txtEmail = findViewById(R.id.txt_Email);
    }

    public void Ingresar(View view){

        final String email = txtEmail.getText().toString().trim();
        final String password = txtPassword.getText().toString().trim();

        if (email.isEmpty()){
            txtEmail.setError("Debe Ingresar un Correo Electrónico");
            return;
        }

        if (password.isEmpty()){
            txtPassword.setError("Debe Ingresar la Contraseña");
            return;
        }


        JSONObject jsonBody = new JSONObject();
        try{
            jsonBody.put("Email", email);
            jsonBody.put("Password", password);
        } catch (Exception e){
            Toast.makeText(Login.this, "Error: " + e.getMessage(), Toast.LENGTH_LONG).show();
        }

        String url = "http://192.168.43.172/JoyanaSecurityServices/api/usuario/Login";

        RequestQueue requestQueue= Volley.newRequestQueue(this);

        StringRequest stringRequest = new StringRequest(
                Request.Method.POST,
                url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        //String response is the return in the request POST http (show the web api for more information)
                        if (response.contains("no")) { //WHEN THE IdUsuario IS '0', THE PASSWORD IS INCORRED
                            Toast.makeText(Login.this, "Contraseña Incorrecta", Toast.LENGTH_SHORT).show();
                        } else { //IN OTHER CASE THE SERVER RETURN USER ID
                            //CODE FOR WRITE DATA IN SharedPreferences
                            SharedPreferences settings = getSharedPreferences("MyApp_Settings", MODE_PRIVATE);
                            SharedPreferences.Editor editor = settings.edit();
                            editor.putString("UserId", response);
                            editor.commit();

                            Intent intent = new Intent(Login.this, MainActivity.class);
                            startActivity(intent);
                        }
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        if (error.networkResponse.statusCode == 404){
                            txtEmail.setError("Email Incorrecto");
                            Toast.makeText(Login.this, "Email Incorrecto", Toast.LENGTH_LONG).show();
                        }
                        else {
                            Toast.makeText(Login.this, "Error: " + error.getMessage(), Toast.LENGTH_LONG).show();
                        }

                    }
                }) {

            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String, String> params = new HashMap<>();
                params.put("Email", email);
                params.put("Password", password);

                return params;
            }
        };

        requestQueue.add(stringRequest);


    }
}
