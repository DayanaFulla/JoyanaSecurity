using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppCode.Models
{
    public class Reporte
    {
        private int _idreporte;
        private string _fechaactivacion;
        private int _idalarma;

        public Reporte()
        {

        }


        public int IdAlarma
        {
            get { return _idalarma; }
            set { _idalarma = value; }
        }

        
        public string FechaActivacion
        {
            get { return _fechaactivacion; }
            set { _fechaactivacion = value; }
        }


        public int IdReporte
        {
            get { return _idreporte; }
            set { _idreporte = value; }
        }

    }
}
