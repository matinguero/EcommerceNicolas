using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace EcommerceNicolas.Models
{
    public class Producto
    {
        public int id { get; set; }
        public string Descripcion { get; set; }

        public string Nombre { get; set; }

        public decimal Precio { get; set;}

        public int id_categoria { get; set; }

        public string Categoria { get; set; }

        public static IEnumerable<Producto> ObtenerProductos(int iCategoria, ref string sResult)
        {

            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spObtenerTodosLosProductos", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                MyDataAdapter.SelectCommand.Parameters.AddWithValue("@id_categoria", iCategoria);


                DataTable dt = new DataTable();
                MyDataAdapter.Fill(dt);


                List<Models.Producto> ListaProductos = new List<Models.Producto>();

                foreach (DataRow row in dt.Rows)
                {
                    var Producto = new Producto();
                    Producto.id = int.Parse(row["id"].ToString());
                    Producto.Descripcion = row["descripcion"].ToString();
                    Producto.Nombre = row["nombre"].ToString();
                    Producto.Precio = decimal.Parse(row["PrecioEnPesos"].ToString());
                    Producto.id_categoria = int.Parse(row["Categoria_id"].ToString());
                    Producto.Categoria = row["Categoria"].ToString();


                    ListaProductos.Add(Producto);
                }


                sResult = "";
                return ListaProductos;
            }
            catch (Exception ex)
            {
                sResult = ex.Message;
                return null;
            }

        }


        public static Producto ObtenerProducto(int iProductoid, int CategoriaId , ref string sResult)
        {

            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spObtenerProducto", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                //MyDataAdapter.SelectCommand.Parameters.AddWithValue("@categoria_id", CategoriaId);
                MyDataAdapter.SelectCommand.Parameters.AddWithValue("@producto_id", iProductoid);


                DataTable dt = new DataTable();
                MyDataAdapter.Fill(dt);


                var Producto = new Producto();
                foreach (DataRow row in dt.Rows)
                {
                    
                    Producto.id = int.Parse(row["id"].ToString());
                    Producto.Descripcion = row["descripcion"].ToString();
                    Producto.Nombre = row["nombre"].ToString();
                    Producto.Precio = decimal.Parse(row["PrecioEnPesos"].ToString());
                    Producto.id_categoria = int.Parse(row["Categoria_id"].ToString());
                    Producto.Categoria = row["Categoria"].ToString();

                }


                sResult = "";
                return Producto;
            }
            catch (Exception ex)
            {
                sResult = ex.Message;
                return null;
            }

        }



    }
}