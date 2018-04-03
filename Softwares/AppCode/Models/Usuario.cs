using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCode.Models
{
    public class Usuario
    {
        private int _idusuario;
        private string _nombrecompleto;
        private string _email;
        private string _password;
        private string _telefono;
        private string _direccion;

        public Usuario() { }

        public string Direccion
        {
            get { return _direccion; }
            set { _direccion = value; }
        }


        public string Telefono
        {
            get { return _telefono; }
            set { _telefono = value; }
        }


        public string Password
        {
            get { return _password; }
            set { _password = value; }
        }


        public string Email
        {
            get { return _email; }
            set { _email = value; }
        }


        public string NombreCompleto
        {
            get { return _nombrecompleto; }
            set { _nombrecompleto = value; }
        }


        public int IdUsuario
        {
            get { return _idusuario; }
            set { _idusuario = value; }
        }

    }
}
