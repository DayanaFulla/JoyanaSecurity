using AppCode.BRL;
using AppCode.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace JoyanaSecurityServices.Controllers
{
    [RoutePrefix("api/usuario")]
    public class UsuarioController : ApiController
    {        
        [HttpPost()]
        [Route("Login")]
        public HttpResponseMessage LoginUser([FromBody] Usuario objUser)
        {
            HttpResponseMessage msg = null;
            Usuario obj = UsuarioBRL.GetUsuarioByEmail(objUser.Email);

            if (obj == null)
            {
                msg = Request.CreateResponse(HttpStatusCode.NotFound, "Usuario no encontrado");
                return msg;
            }

            if (obj.Password == objUser.Password)
            {
                msg = Request.CreateResponse<string>(HttpStatusCode.OK, obj.IdUsuario.ToString());
            }
            else
            {
                msg = Request.CreateResponse<string>(HttpStatusCode.OK, "no"); //PASSWORD INCORRED
            }

            return msg;
        }


        [HttpGet]
        [Route("GetAllUsers")]
        public HttpResponseMessage GetAllUsers()
        {
            HttpResponseMessage msg = null;

            List<Usuario> list = UsuarioBRL.GetAllUsers();

            msg = Request.CreateResponse<List<Usuario>>(HttpStatusCode.OK, list);

            return msg;
        }
    }
}
