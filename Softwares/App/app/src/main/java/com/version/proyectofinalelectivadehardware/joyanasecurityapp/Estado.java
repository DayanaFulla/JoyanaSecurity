package com.version.proyectofinalelectivadehardware.joyanasecurityapp;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;

import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.Toast;

/**
 * Created by DAYANA on 8/4/2018.
 */

public class Estado extends Fragment implements View.OnClickListener{
    ImageButton estado;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_estado, container, false);
        estado=(ImageButton) rootView.findViewById(R.id.btn_estado);
        estado.setOnClickListener(this);
        return rootView;
    }

    public void cambiarEstado(){
        Toast.makeText(getContext(), "Su estado está cambiando", Toast.LENGTH_LONG).show();
    }


    @Override
    public void onClick(View view) {
        if(view.getId()==R.id.btn_estado){
            cambiarEstado();
        }


    }
}
