using AppCode.DAL;
using AppCode.DAL.UsuarioDSTableAdapters;
using AppCode.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static AppCode.DAL.UsuarioDS;

namespace AppCode.BRL
{
    public class UsuarioBRL
    {
        public static int InsertUser(Usuario obj)
        {
            int? idUsuario = 0;
            if (obj == null)
            {
                throw new ArgumentException("El usuario no debe ser nulo");                
            }

            UsuarioTableAdapter adapter = new UsuarioTableAdapter();
            adapter.Insert(obj.NombreCompleto, obj.Email, obj.Password, obj.Telefono, obj.Direccion, ref idUsuario);
            if (idUsuario == 0)
            {
                throw new ArgumentException("Error al insertar un nuevo usuario");
            }

            return idUsuario.Value;
        }

        public static Usuario GetUsuarioById(int idUsuario)
        {
            UsuarioTableAdapter adapter = new UsuarioTableAdapter();
            UsuarioDataTable table = adapter.GetUsuarioById(idUsuario);

            if (table.Rows.Count == 0)
            {
                return null;
            }

            UsuarioRow row = table[0];
            Usuario obj = new Usuario()
            {
                IdUsuario = row.idUsuario,
                NombreCompleto = row.nombreCompleto,
                Email = row.email,
                Password = row.password,
                Telefono = row.telefono,
                Direccion = row.direccion
            };

            return obj;
        }

        public static Usuario GetUsuarioByEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                throw new ArgumentException("El email del usuario no debe ser nulo o vacio");
            }
            UsuarioTableAdapter adapter = new UsuarioTableAdapter();
            UsuarioDataTable table = adapter.GetUsuarioByEmail(email);

            if (table.Rows.Count == 0)
            {
                return null;
            }

            UsuarioRow row = table[0];
            Usuario obj = new Usuario()
            {
                IdUsuario= row.idUsuario,
                NombreCompleto = row.nombreCompleto,
                Email = row.email,
                Password = row.password,
                Telefono = row.telefono,
                Direccion = row.direccion
            };

            return obj;
        }
    }
}
