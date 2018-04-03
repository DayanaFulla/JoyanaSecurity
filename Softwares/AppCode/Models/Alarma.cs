using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCode.Models
{
    public class Alarma
    {
        private int _idalarma;
        private string _contraseña;
        private string _latitud;
        private string _longitud;
        private bool _isactive;
        private int _idusuario;

        public Alarma()
        {

        }

        public bool IsActive
        {
            get { return _isactive; }
            set { _isactive = value; }
        }

        public int IdUsuario
        {
            get { return _idusuario; }
            set { _idusuario = value; }
        }


        public string Longitud
        {
            get { return _longitud; }
            set { _longitud = value; }
        }

        public string Latitud
        {
            get { return _latitud; }
            set { _latitud = value; }
        }

        public string Contraseña
        {
            get { return _contraseña; }
            set { _contraseña = value; }
        }

        public int IdAlarma
        {
            get { return _idalarma; }
            set { _idalarma = value; }
        }

    }
}
