using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EcommerceNicolas.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        [ChildActionOnly]
        public ActionResult MenuSitio()
        {
            string sRet = "";
            List<Models.ProductoCategorias> ListaCategorias = (List<Models.ProductoCategorias>)Models.ProductoCategorias.ObtenerCategorias(ref sRet);
            ViewData["Categorias"] = ListaCategorias;

            return PartialView("MenuSitio");
        }
    }
}