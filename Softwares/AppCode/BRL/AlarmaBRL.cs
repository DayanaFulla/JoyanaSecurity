using AppCode.DAL.AlarmaDSTableAdapters;
using AppCode.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static AppCode.DAL.AlarmaDS;

namespace AppCode.BRL
{
    public class AlarmaBRL
    {
        public static int InsertAlarma(Alarma obj)
        {
            if (obj == null)
            {
                throw new ArgumentException("El obj Alarma no debe ser nulo");
            }
            int? idAlarma = 0;
            AlarmaTableAdapter adapter = new AlarmaTableAdapter();
            adapter.Insert(obj.Contraseña, obj.Latitud, obj.Longitud, obj.IsActive, obj.IdUsuario, ref idAlarma);

            if (idAlarma == 0)
            {
                throw new ArgumentException("Error al insertar una nueva alarma");
            }

            return idAlarma.Value;
        }

        public static void UpdateAlarma(Alarma obj)
        {
            
            AlarmaTableAdapter adapter = new AlarmaTableAdapter();
            adapter.Update(obj.Contraseña, obj.Latitud, obj.Longitud, obj.IsActive, obj.IdAlarma); 
        }

        public static Alarma GetAlarmaByIdUsuario(int idUsuario)
        {
            AlarmaTableAdapter adapter = new AlarmaTableAdapter();
            AlarmaDataTable table = adapter.GetAlarmaByUsuarioId(idUsuario);

            if (table.Rows.Count == 0)
            {
                return null;
            }

            AlarmaRow row = table[0];
            Alarma obj = new Alarma()
            {
                IdAlarma = row.idAlarma,                
                Contraseña = row.contraseña,
                Latitud = row.latitud,
                Longitud = row.longitud,
                IsActive = row.isActive,
                IdUsuario = row.idUsuario
            };

            return obj;

        }

        public static Alarma GetAlarmaById(int idAlarma)
        {
            AlarmaTableAdapter adapter = new AlarmaTableAdapter();
            AlarmaDataTable table = adapter.GetAlarmaById(idAlarma);

            if (table.Rows.Count == 0)
            {
                return null;
            }

            AlarmaRow row = table[0];
            Alarma obj = new Alarma()
            {
                IdAlarma = row.idAlarma,                
                Contraseña = row.contraseña,
                Latitud = row.latitud,
                Longitud = row.longitud,
                IsActive = row.isActive,
                IdUsuario = row.idUsuario
            };

            return obj;
        }
        
    }
}
