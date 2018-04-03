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
        [HttpGet]
        [Route("GetUserByEmail/{email}")]
        public HttpResponseMessage GetUserByEmail(string email)
        {
            HttpResponseMessage msg = null;
            Usuario obj = UsuarioBRL.GetUsuarioByEmail(email);

            if (obj == null)
            {
                msg = Request.CreateResponse(HttpStatusCode.NotFound, "Usuario no encontrado");
                return msg;
            }

            msg = Request.CreateResponse<Usuario>(HttpStatusCode.OK, obj);

            return msg;
        }

    }
}
