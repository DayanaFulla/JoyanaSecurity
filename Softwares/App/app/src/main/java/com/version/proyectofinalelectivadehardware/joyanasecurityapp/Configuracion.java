package com.version.proyectofinalelectivadehardware.joyanasecurityapp;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

/**
 * Created by DAYANA on 8/4/2018.
 */

public class Configuracion extends Fragment {

    private EditText txtCurrentPassword;
    private Button btnCambiarPass;
    private LinearLayout contenedor;

    @Override
    public View onCreateView(LayoutInflater inflater, final ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_configuracion, container, false);
        txtCurrentPassword = rootView.findViewById(R.id.txtCurrentPassw);
        btnCambiarPass = rootView.findViewById(R.id.CambiarPassButton);
        contenedor = rootView.findViewById(R.id.CurrentPassPanel);

        btnCambiarPass.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                contenedor.setVisibility(container.INVISIBLE);
                txtCurrentPassword.setCursorVisible(false);
            }
        });

        return rootView;
    }

    public void Cambiar (View view){

    }
}
