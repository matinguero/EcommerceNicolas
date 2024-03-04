using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace EcommerceNicolas
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
               name: "ListadoProductos",
               url: "Productos/{id_categoria}",
               defaults: new { controller = "Productos", action = "Index", id_categoria = UrlParameter.Optional }
           );

            routes.MapRoute(
              name: "Gracias",
               url: "Orden/Gracias/{iOrden}",
            defaults: new { controller = "Orden", action = "Gracias", iOrden = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "DetalleProducto",
                url: "DetalleProducto/{id_producto}/{id_categoria}",
                defaults: new { controller = "Productos", action = "DetalleProducto", id = UrlParameter.Optional, id_producto = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "DetalleOrden",
                url: "Orden/DetalleOrden/{iOrden}",
                defaults: new { controller = "Orden", action = "DetalleOrden", iOrden = UrlParameter.Optional }
            );






            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );


            

        }
    }
}
