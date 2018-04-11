package com.version.proyectofinalelectivadehardware.joyanasecurityapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

public class Login extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
    }

    public void Ingresar(View view){
        Toast.makeText(this, "Usted se ha loggeado", Toast.LENGTH_LONG).show();




    }
}
