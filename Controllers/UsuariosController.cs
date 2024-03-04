using EcommerceNicolas.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace EcommerceNicolas.Controllers
{
    public class UsuariosController : Controller
    {
        // GET: Usuarios
        public ActionResult Login()
        {
            //ViewBag.Message = "Login de Usuarios.";

            Usuario usuario = new Usuario();

            return View(usuario);
        }


        [Authorize]
        public ActionResult MisDatos()
        {
            Usuario usuario = new Usuario();

            string sRet = "";
            DataTable dt = new DataTable();
            sRet = Models.Usuario.ObtenerUsuario(int.Parse(Session["ID"].ToString()), ref dt);

            if (sRet != "")
            {
                ViewBag.Message = "Error al obtener el usuario: " + sRet;

            }


            if (dt.Rows.Count == 1)
            {
                usuario.Id = int.Parse(dt.Rows[0]["id"].ToString());
                usuario.Email = (dt.Rows[0]["email"].ToString());
                usuario.Nombre = (dt.Rows[0]["Nombre"].ToString());
                usuario.Apellido = (dt.Rows[0]["Apellido"].ToString());
                usuario.Clave = (dt.Rows[0]["Clave"].ToString());
            }

            return View(usuario);
        }


        [HttpPost]
        public ActionResult ModificarDatosUsuario(Models.Usuario model)
        {


            if (ModelState.IsValid)
            {


                string sRet = "";
                DataTable dt = new DataTable();

                sRet = Models.Usuario.ModificarUsuario(int.Parse(Session["ID"].ToString()), model.Nombre, model.Apellido, model.Clave);

                if (sRet != "")
                {
                    ViewBag.Message = "Error en el login - " + sRet;
                    return Redirect("~/Usuarios/MisDatos");
                }
                else
                {
                    return Redirect("~/Home/Index");
                }



            }
            else
            {
                return Redirect("~/Home/Index");
            }






        }


        [HttpPost]
        public ActionResult InsertarDatosUsuario(Models.Usuario model)
        {


            if (ModelState.IsValid)
            {


                string sRet = "";
                DataTable dt = new DataTable();

                sRet = Models.Usuario.InsertarUsuario(model.Email, model.Nombre, model.Apellido, model.Clave);

                if (sRet != "")
                {
                    ViewBag.Message = "Error en el insert - " + sRet;
                    return Redirect("~/Home/Index");
                }
                else
                {
                    return Redirect("~/Usuarios/Login");
                }



            }
            else
            {
                return Redirect("~/Home/Index");
            }






        }


        public ActionResult Registro()
        {
            Usuario usuario = new Usuario();
            return View(usuario);
        }



        [HttpPost]
        public ActionResult LoginForm(Models.Usuario model)
        {


            if (ModelState.IsValid)
            {


                string sRet = "";
                DataTable dt = new DataTable();

                sRet = Models.Usuario.LoginUsuario(model.Email.ToString().Trim(), model.Clave.ToString().Trim(), ref dt);

                if (sRet != "")
                {
                    ViewBag.AlertMessage = "Error en el login - " + sRet;
                    ViewBag.Message = "Error en el login - " + sRet;
                    return View("Login", model);
                }


                if (dt.Rows.Count == 1)
                {
                    var authenticationTicket = new FormsAuthenticationTicket(
                1, // Versión de la cookie de autenticación
                model.Email, // Nombre del usuario (puedes dejarlo en blanco si lo configurarás después)
                DateTime.Now, // Fecha y hora de inicio de la cookie de autenticación
                DateTime.Now.AddMinutes(30), // Fecha y hora de expiración de la cookie de autenticación
                false // Si la cookie persiste en el disco después de cerrar el navegador (false en este ejemplo)
                , "roles, custom data" // Datos adicionales del usuario (roles, información personalizada, etc.)
            );

                    // Encriptar la cookie de autenticación
                    string encryptedTicket = FormsAuthentication.Encrypt(authenticationTicket);

                    // Crear una cookie de autenticación y agregarla a la respuesta
                    var authenticationCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                    HttpContext.Response.Cookies.Add(authenticationCookie);

                    Session["ID"] = dt.Rows[0]["id"];
                    Session["NOMBRE"] = dt.Rows[0]["nombre"];
                    Session["APELLIDO"] = dt.Rows[0]["apellido"];
                    //Session["PERFIL"] = dt.Rows[0]["perfil"];
                    //Session["PERFIL_ID"] = dt.Rows[0]["perfil_id"];

                    //PASO SIGUIENTE INSTANCIAR EL OBJETO USUARIO/CUENTA, LLENARLO Y ESE OBJETO GUARDARLO EN SESSION


                    return Redirect("~/Home/Index");
                }
                else
                {
                    ViewBag.AlertMessage = "Error en el login";
                    ViewBag.Message = "Error en el login";
                    return View("Login", model);
                }




            }
            else
            {
                return View("Login", model);
            }





        }


        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();

            return Redirect("~/Home/Index");
        }



    }
}