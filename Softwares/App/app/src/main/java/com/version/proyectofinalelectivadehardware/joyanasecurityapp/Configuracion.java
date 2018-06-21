package com.version.proyectofinalelectivadehardware.joyanasecurityapp;

import android.app.DownloadManager;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
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

public class Configuracion extends Fragment implements View.OnClickListener{

    private Button btnCambiarPass;
    private Button btnNewPass;

    private EditText txtCurrentPassword;
    private EditText txtNewPassword;
    private EditText txtRepitPassword;

    private int currentPassword;
    private int newPassword;
    private int repitPassword;

    private LinearLayout contenidoActual;
    private LinearLayout contenidoNuevo;

    private String IdAlarma = "";

    @Override
    public View onCreateView(LayoutInflater inflater, final ViewGroup container,
                             Bundle savedInstanceState) {
        final View rootView = inflater.inflate(R.layout.fragment_configuracion, container, false);

        contenidoActual=rootView.findViewById(R.id.ContainerActual);
        contenidoNuevo=rootView.findViewById(R.id.ContainerNew);

        txtCurrentPassword = rootView.findViewById(R.id.txtCurrentPassw);
        txtNewPassword=rootView.findViewById(R.id.txtNewPassword);
        txtRepitPassword=rootView.findViewById(R.id.txtRepitPassword);

        btnCambiarPass = rootView.findViewById(R.id.CambiarPassButton);
        btnNewPass=rootView.findViewById(R.id.NewPassButton);
        contenidoNuevo.setVisibility(View.GONE);
        btnCambiarPass.setOnClickListener(this);
        btnNewPass.setOnClickListener(this);

        return rootView;
    }

    @Override
    public void onClick(View view) {
        if (view.getId()==btnCambiarPass.getId()){
            final String currentPassword = txtCurrentPassword.getText().toString().trim();
            if (currentPassword.isEmpty()){
                txtCurrentPassword.setError("Debe ingresar su Contraseña Actual");
                return;
            }


            String url = "http://192.168.43.172/JoyanaSecurityServices/api/alarma/GetAlarmaByUsuarioId/"+ User.getInstance().getUserIdLogin();

            RequestQueue requestQueue = Volley.newRequestQueue(getContext());

            JsonObjectRequest jsonObjectRequest = new JsonObjectRequest(
                    url,
                    null,
                    new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            try {
                                String password = response.getString("Contrasena");
                                IdAlarma = response.getString("IdAlarma");
                                if (password.equals(currentPassword)){
                                    txtCurrentPassword.setText("");
                                    contenidoActual.setVisibility(View.GONE);
                                    contenidoNuevo.setVisibility(View.VISIBLE);
                                } else {
                                    txtCurrentPassword.setError("Contraseña Incorrecta");
                                    Toast.makeText(getContext(), "Contraseña Incorrecta", Toast.LENGTH_SHORT).show();
                                    return;
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
        if (view.getId()==btnNewPass.getId()) {
            final String newPassword = txtNewPassword.getText().toString().trim();
            String repitPassword = txtRepitPassword.getText().toString().trim();

            if (newPassword.isEmpty()) {
                txtNewPassword.setError("Debe ingresar Nueva Contraseña");
                return;
            }

            if (repitPassword.isEmpty()) {
                txtRepitPassword.setError("Debe repetir la contraseña ingresada");
                return;
            }

            if (newPassword.length() > 10){
                txtNewPassword.setError("La alarma debe tener menos de 10 caracteres");
                return;
            }

            if (!newPassword.equals(repitPassword)) {
                txtNewPassword.setError("Las Contraseñas no coinciden");
                txtRepitPassword.setError("Las Contraseñas no coinciden");
                return;
            }

            String url = "http://192.168.43.172/JoyanaSecurityServices/api/alarma/Config";

            RequestQueue requestQueue = Volley.newRequestQueue(getContext());

            StringRequest stringRequest = new StringRequest(
                    Request.Method.POST,
                    url,
                    new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            if (response.contains("ok")){
                                Toast.makeText(getContext(), "Alarma Actualizada Exitosamente", Toast.LENGTH_LONG).show();
                                txtNewPassword.setText("");
                                txtRepitPassword.setText("");
                                contenidoActual.setVisibility(View.VISIBLE);
                                contenidoNuevo.setVisibility(View.GONE);
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
                    }) {
                    @Override
                    protected Map<String, String> getParams() throws AuthFailureError {
                        Map<String, String> params = new HashMap<>();
                        params.put("IdAlarma", IdAlarma);
                        params.put("Contrasena", newPassword);
                        return params;
                    }

                };

            requestQueue.add(stringRequest);

            contenidoActual.setVisibility(View.VISIBLE);
            contenidoNuevo.setVisibility(View.GONE);
        }
    }
}
