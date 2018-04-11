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
    [RoutePrefix("api/alarma")]
    public class AlarmaController : ApiController
    {
        //POST api/values        

        [HttpGet]
        [Route("ActivarAlarma/{idAlarma}")]
        public HttpResponseMessage ActivarAlarma(string idAlarma)
        {
            HttpResponseMessage msg = null;
            Alarma obj = AlarmaBRL.GetAlarmaById(Int32.Parse(idAlarma));
            
            if (obj == null)
            {
                msg = Request.CreateResponse(HttpStatusCode.NotFound, "No se ha encontrado la Alarma para desactivarla");
                return msg;
            }

            obj.IsActive = !obj.IsActive;

            AlarmaBRL.UpdateAlarma(obj);

            msg = Request.CreateResponse<bool>(HttpStatusCode.OK, true);

            return msg;
        }

        [HttpGet]
        [Route("GetAlarmaById/{idAlarma}")]
        public HttpResponseMessage GetAlarmaByCodigo(string idAlarma)
        {
            HttpResponseMessage msg = null;

            Alarma obj = AlarmaBRL.GetAlarmaById(Int32.Parse(idAlarma));

            if (obj == null)
            {
                msg = Request.CreateResponse(HttpStatusCode.NotFound, "Codigo de alarma invalido");
                return msg;
            }

            msg = Request.CreateResponse<Alarma>(HttpStatusCode.OK, obj);
            return msg;
        }
    }
}
