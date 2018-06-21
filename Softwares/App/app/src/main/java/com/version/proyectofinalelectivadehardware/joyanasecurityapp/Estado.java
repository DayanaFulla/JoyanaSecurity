package com.version.proyectofinalelectivadehardware.joyanasecurityapp;

import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;

import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.version.proyectofinalelectivadehardware.joyanasecurityapp.Utilities.User;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by DAYANA on 8/4/2018.
 */

public class Estado extends Fragment implements View.OnClickListener{
    private ImageButton desactivado;
    private ImageButton activado;
    private TextView tvicontrasena;
    private EditText txtContrasena;
    private Button btnConfirmar;
    private boolean IsActive;
    private String IdAlarma;
    private String Contraseña;
    private int password;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_estado, container, false);
        desactivado=(ImageButton) rootView.findViewById(R.id.btn_desactivado);
        tvicontrasena=rootView.findViewById(R.id.tv_icontrasena);
        txtContrasena=rootView.findViewById(R.id.txt_Contrasena);
        btnConfirmar=rootView.findViewById(R.id.btn_Confirmar);
        activado=(ImageButton) rootView.findViewById(R.id.btn_activado);
        btnConfirmar.setOnClickListener(this);
        desactivado.setOnClickListener(this);
        activado.setOnClickListener(this);

        GetAlarma(true);

        return rootView;
    }

    public void GetAlarma(final boolean withShowOpt){
        String url = "http://192.168.43.172/JoyanaSecurityServices/api/alarma/GetAlarmaByUsuarioId/"+ User.getInstance().getUserIdLogin();

        RequestQueue requestQueue = Volley.newRequestQueue(getContext());

        JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(
                url,
                null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            IsActive = response.getBoolean("IsActive");
                            IdAlarma = response.getString("IdAlarma");
                            Contraseña = response.getString("Contrasena");

                            if (withShowOpt){
                                desactivado.setVisibility(View.GONE);
                                activado.setVisibility(View.GONE);
                                tvicontrasena.setVisibility(View.GONE);
                                txtContrasena.setVisibility(View.GONE);
                                btnConfirmar.setVisibility(View.GONE);
                                if(IsActive){
                                    activado.setVisibility(View.VISIBLE);
                                }else{
                                    desactivado.setVisibility(View.VISIBLE);
                                }
                            }

                        } catch (Exception q){
                            Toast.makeText(getContext(), q.getMessage(), Toast.LENGTH_LONG).show();
                        }

                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Toast.makeText(getContext(), error.toString(), Toast.LENGTH_LONG).show();
                    }
                }
        );
        requestQueue.add(jsonObjectRequest);
    }

    public void HiddenStates(){
        desactivado.setVisibility(View.GONE);
        activado.setVisibility(View.GONE);
        tvicontrasena.setVisibility(View.VISIBLE);
        txtContrasena.setVisibility(View.VISIBLE);
        btnConfirmar.setVisibility(View.VISIBLE);
    }

    @Override
    public void onClick(View view) {
        if(view.getId()==R.id.btn_activado){
            HiddenStates();
        }
        if (view.getId()==R.id.btn_Confirmar){
            String currentPass = txtContrasena.getText().toString().trim();

            if (currentPass.isEmpty()){
                txtContrasena.setError("Debe Ingresar la Contraseña");
                return;
            }

            GetAlarma(false);
            Toast.makeText(getContext(), Contraseña, Toast.LENGTH_SHORT).show();
            if (!currentPass.equals(Contraseña)){
                txtContrasena.setError("Contraseña Incorrecta");
                Toast.makeText(getContext(), "Contraseña Incorrecta", Toast.LENGTH_SHORT).show();
                return;
            } else {

                UpdateState();
            }

        }
        if(view.getId()==R.id.btn_desactivado){
            HiddenStates();
        }


    }

    private  void UpdateState(){
        String url = "http://192.168.43.172/JoyanaSecurityServices/api/alarma/ActivarAlarma/"+IdAlarma;

        RequestQueue requestQueue = Volley.newRequestQueue(getContext());

        StringRequest stringRequest = new StringRequest(
                url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        if (response.contains("ok")){
                                Toast.makeText(getContext(), "El Estado de la alarma a cambiado", Toast.LENGTH_LONG).show();
                                IsActive = !IsActive;
                                txtContrasena.setText("");
                                desactivado.setVisibility(View.GONE);
                                activado.setVisibility(View.GONE);
                                tvicontrasena.setVisibility(View.GONE);
                                txtContrasena.setVisibility(View.GONE);
                                btnConfirmar.setVisibility(View.GONE);
                                if(IsActive){
                                    activado.setVisibility(View.VISIBLE);
                                }else{
                                    desactivado.setVisibility(View.VISIBLE);
                                }
                        } else {
                            Toast.makeText(getContext(), "No se pudo Actualizar la alarma", Toast.LENGTH_LONG).show();
                        }
                    }
                },

                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        if (error.networkResponse.statusCode == 404){
                            Toast.makeText(getContext(), "Alarma no encontrada", Toast.LENGTH_LONG).show();
                        }
                        else {
                            Toast.makeText(getContext(), "Error: " + error.getMessage(), Toast.LENGTH_LONG).show();
                        }
                    }
                });

        requestQueue.add(stringRequest);
    }

    @Override
    public void onResume() {
        super.onResume();

        GetAlarma(true);


    }
}
