using EcommerceNicolas.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceNicolas.Controllers
{
    public class CarritoController : Controller
    {
        // GET: Carrito
        [Authorize]
        public ActionResult Index()
        {

            ViewBag.MensajeError = "";

            string sRet = "";
            List<Models.Carrito> ListaCarrito = (List<Carrito>)Carrito.ObtenerCarrito(int.Parse(Session["ID"].ToString()), ref sRet);


            return View(ListaCarrito);
        }


        [Authorize]
        [HttpPost]
        public ActionResult AgregarAlCarrito(int id_producto, int iIdUsuario, int iCantidad)
        {



            string sRet = "";
            sRet = Carrito.AgregarAlCarrito(id_producto, iIdUsuario, iCantidad);


            if (sRet == "")
            {
                return RedirectToAction("Index", "Carrito");
            }
            else
            {
                return RedirectToAction("Index", "Carrito");
            }


        }





        [Authorize]
        [HttpPost]
        public ActionResult ActualizarCarrito(int id_producto, int cantidad)
        {



            string sRet = "";
            sRet = Carrito.ActualizarProductoCarrito(id_producto, int.Parse(Session["ID"].ToString()), cantidad);



            return RedirectToAction("Index", "Carrito");
        }


        [Authorize]
        public ActionResult EliminarDelCarrito(int id_producto)
        {


            string sRet = "";
            sRet = Carrito.EliminarDelCarrito(id_producto, int.Parse(Session["ID"].ToString()));


            if (sRet == "")
            {
                return RedirectToAction("Index", "Carrito");
            }
            else
            {
                return RedirectToAction("Index", "Carrito");
            }


        }


    }
}