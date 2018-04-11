package com.version.proyectofinalelectivadehardware.joyanasecurityapp.Objects;

/**
 * Created by DAYANA on 10/4/2018.
 */

public class Usuario {

    private int _idUsuario;
    private String _nombreCompleto;
    private String _email;
    private String _password;
    private String _telefono;
    private String _direccion;

    public Usuario() {
    }

    public int getIdUsuario() {
        return _idUsuario;
    }

    public void setIdUsuario(int _idUsuario) {
        this._idUsuario = _idUsuario;
    }

    public String getNombreCompleto() {
        return _nombreCompleto;
    }

    public void setNombreCompleto(String _nombreCompleto) {
        this._nombreCompleto = _nombreCompleto;
    }

    public String getEmail() {
        return _email;
    }

    public void setEmail(String _email) {
        this._email = _email;
    }

    public String getPassword() {
        return _password;
    }

    public void setPassword(String _password) {
        this._password = _password;
    }

    public String getTelefono() {
        return _telefono;
    }

    public void setTelefono(String _telefono) {
        this._telefono = _telefono;
    }

    public String getDireccion() {
        return _direccion;
    }

    public void setDireccion(String _direccion) {
        this._direccion = _direccion;
    }
}
