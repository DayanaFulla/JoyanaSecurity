using AppCode.DAL.ReporteDSTableAdapters;
using AppCode.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static AppCode.DAL.ReporteDS;

namespace AppCode.BRL
{
    public class ReporteBRL
    {
        public static int InsertReport(Reporte obj)
        {
            int? idReporte = 0; 
            ReporteTableAdapter adapter = new ReporteTableAdapter();
            adapter.Insert(obj.FechaActivacion, obj.IdAlarma, ref idReporte);

            if (idReporte == 0)
            {
                throw new ArgumentException("Error al insertar un nuevo reporte");
            }
            return idReporte.Value;
        }

        public List<Reporte> GetLastReportsByAlarmaId(int idAlarma)
        {
            ReporteTableAdapter adapter = new ReporteTableAdapter();
            ReporteDataTable table = adapter.GetLastReportsByAlarmaId(idAlarma);

            List<Reporte> listReports = new List<Reporte>();
            Reporte objTemp;
            foreach (var row in table)
            {
                objTemp = new Reporte()
                {
                    IdReporte = row.idReporte,
                    FechaActivacion = row.fechaActivacion,
                    IdAlarma = row.idAlarma
                };

                listReports.Add(objTemp);
            }

            return listReports;
        }
    }
}
