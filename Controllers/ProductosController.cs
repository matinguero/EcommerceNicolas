using EcommerceNicolas.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceNicolas.Controllers
{
    public class ProductosController : Controller
    {
        // GET: Productos
        public ActionResult Index(int id_categoria)
        {
            string sRet = "";
            List<Models.Producto> ListaProductos = (List<Producto>)Producto.ObtenerProductos(id_categoria, ref sRet);

            return View(ListaProductos);
        }

        public ActionResult DetalleProducto(int id_producto, int id_categoria)
        {
            //TODO:TERMINAR DETALLE EN FRONT END
            string sRet = "";
            Models.Producto DetalleProducto = Producto.ObtenerProducto(id_producto,id_categoria, ref sRet);

            return View(DetalleProducto);

           
        }
    }
}