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
        [HttpPost]
        public IHttpActionResult PostAlarma([FromBody] Alarma obj)  //PARA ACTUALIZAR LOS DATOS DE LA ALARMA
        {
            try
            {
                if (ModelState.IsValid)
                {
                    AlarmaBRL.UpdateAlarma(obj);
                    return CreatedAtRoute("PostAlarma", new { id = obj.IdAlarma }, obj);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return BadRequest();
        }

        [HttpGet]
        [Route("ActivarAlarma/{codigo}")]
        public HttpResponseMessage ActivarAlarma(string codigo)
        {
            HttpResponseMessage msg = null;
            Alarma obj = AlarmaBRL.GetAlarmaByCodigo(codigo);
            
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
        [Route("GetAlarmaByCodigo/{codigo}")]
        public HttpResponseMessage GetAlarmaByCodigo(string codigo)
        {
            HttpResponseMessage msg = null;

            Alarma obj = AlarmaBRL.GetAlarmaByCodigo(codigo);

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
