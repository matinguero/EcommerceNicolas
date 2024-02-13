using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EcommerceNicolas.Models;

namespace EcommerceNicolas.Controllers
{
    public class OrdenController : Controller
    {
        // GET: Orden
        [Authorize]
        public ActionResult Gracias(int iOrden)
        {

            ViewBag.OrderID = iOrden.ToString();
            return View();
        }

        [Authorize]
        public ActionResult MisOrdenes()
        {


            string sRet = "";
            List<Models.Orden> ListaOrden = (List<Orden>)Orden.ObtenerOrdenes(int.Parse(Session["ID"].ToString()), ref sRet);


            return View(ListaOrden);



            
        }

        [Authorize]
        public ActionResult DetalleOrden(int iOrden)
        {

            ViewBag.OrderID = iOrden.ToString();


            string sRet = "";
            List<Models.DetalleOrden> ListaDetalleOrden = (List<DetalleOrden>)Orden.ObtenerDetalleOrden(iOrden, int.Parse(Session["ID"].ToString()), ref sRet);


            return View(ListaDetalleOrden);


           
        }


        [Authorize]
        public ActionResult GuardarOrden()
        {

            int iOrderID = 0;

            string sRet = "";
            sRet = Orden.GuardarOrden(int.Parse(Session["ID"].ToString()), ref iOrderID);


            if (sRet == "")
            {

                //TODO: Mandar mail con el detalle de la orden
                // MANDAR MAIL AL USUARIO LOGUEADO (con copia al administrador del sitio)
                //OrderID
                //Fecha
                //Monto
                //DETALLE ORDEN
                //NOMBRE PRODUCTo, CANTIDAD, PRECIO UNITARIO

                //VER DE PASAR EL ORDERID Generado por el guardado de la orden
                return RedirectToAction("Gracias/" + iOrderID.ToString(), "Orden");
            }
            else
            {
                return RedirectToAction("Index?message=" + sRet, "Carrito");
            }





        }



    }
}