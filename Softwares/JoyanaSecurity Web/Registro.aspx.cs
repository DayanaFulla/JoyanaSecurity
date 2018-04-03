using AppCode.BRL;
using AppCode.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Registrar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        
    }

    protected void btnGuardar_Click(object sender, EventArgs e)
    {
        //USUARIO
        string US_nombreCompleto = txtNombreComp.Text.Trim();
        string US_telefono = txtTelefono.Text.Trim();
        string US_email = txtEmail.Text.Trim();
        string US_contraseña = txtPassword.Text.Trim();
        string US_reContraseña = txtRePassword.Text.Trim();
        string US_direccion = txtDescripcion.Text.Trim();

        if (string.IsNullOrEmpty(US_nombreCompleto))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Nombre Completo no debe estar vacío')", true);            
            return;                
        }

        if (string.IsNullOrEmpty(US_telefono))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Teléfono no debe estar vacío')", true);           
            return;
        }

        if (string.IsNullOrEmpty(US_email))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Email no debe estar vacío')", true);            
            return;
        }

        if (string.IsNullOrEmpty(US_contraseña))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Contraseña no debe estar vacío')", true);            
            return;
        }

        if (!US_reContraseña.Equals(US_contraseña))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Las contraseñas no coinciden')", true);            
            return;
        }

        if (string.IsNullOrEmpty(US_direccion))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Dirección no debe estar vacío')", true);            
            return;
        }
         
        //ALARMA
        string AL_ContraseñaAct = txtAlarmPass.Text.Trim();
        string AL_ReContraseñaAct = txtReAlarmPass.Text.Trim();

        if (string.IsNullOrEmpty(AL_ContraseñaAct))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('El campo Contraseña de Activación no debe estar vacío')", true);
            return;
        }

        if (!AL_ReContraseñaAct.Equals(AL_ContraseñaAct))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Las Contraseñas de Activación no coinciden')", true);
            return;
        }

        string AL_latitud = latitudHidden.Value;
        string AL_longitud = longitudHidden.Value;

        if (string.IsNullOrEmpty(AL_latitud) || string.IsNullOrEmpty(AL_longitud))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error de Red, Asegurese de que el equipo tenga Conexión a INTERNET')", true);
            return;
        }

        //REGISTRANDO USUARIO

        Usuario objUser = new Usuario()
        {
            NombreCompleto = US_nombreCompleto,
            Telefono = US_telefono,
            Email = US_email,
            Password = US_contraseña,
            Direccion = US_direccion,            
        };

        int idUsuario = UsuarioBRL.InsertUser(objUser);

        Alarma objAlarma = new Alarma()
        {
            IdUsuario = idUsuario,
            Contraseña = AL_ContraseñaAct,
            Latitud = AL_latitud,
            Longitud = AL_longitud,
            IsActive = false,
        };

        int idAlarma = AlarmaBRL.InsertAlarma(objAlarma);
    
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Usuario y Alarma Registrado Exitosamente!!!')", true);

        Response.Redirect("~/Registro.aspx");
    }
}