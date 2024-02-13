using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace EcommerceNicolas.Models
{
    public class Carrito
    {

        public int id { get; set; }
        public int UsuarioId { get; set; }

        public int ProductoId { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnitario { get; set; }

        public string DescripcionProducto { get; set; }

        public decimal Subtotal { get; set; }




        public static IEnumerable<Carrito> ObtenerCarrito(int iIdUsuario, ref string sResult)
        {

            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spObtenerCarrito", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                MyDataAdapter.SelectCommand.Parameters.AddWithValue("@IdUsuario", iIdUsuario);


                DataTable dt = new DataTable();
                MyDataAdapter.Fill(dt);


                List<Models.Carrito> ListaCarrito = new List<Models.Carrito>();

                foreach (DataRow row in dt.Rows)
                {
                    var ProductoCarrito = new Carrito();
                    ProductoCarrito.id = int.Parse(row["id"].ToString());
                    ProductoCarrito.ProductoId = int.Parse(row["Producto_Id"].ToString());
                    ProductoCarrito.UsuarioId = int.Parse(row["Usuario_Id"].ToString());
                    ProductoCarrito.Cantidad = int.Parse(row["Cantidad"].ToString());
                    ProductoCarrito.PrecioUnitario = decimal.Parse(row["PrecioEnPesos"].ToString());
                    ProductoCarrito.DescripcionProducto = row["DescripcionProducto"].ToString();
                    ProductoCarrito.Subtotal = decimal.Parse(row["Subtotal"].ToString());


                    ListaCarrito.Add(ProductoCarrito);
                }


                sResult = "";
                return ListaCarrito;
            }
            catch (Exception ex)
            {
                sResult = ex.Message;
                return null;
            }

        }


        public static string AgregarAlCarrito(int id_producto, int iIdUsuario, int iCantidad)
        {
            string sRet = "";

            SqlConnection MyConnection = default(SqlConnection);
            SqlCommand MySqlCommand = default(SqlCommand);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MySqlCommand = new SqlCommand("spAgregarAlCarrito", MyConnection);
                MySqlCommand.CommandType = CommandType.StoredProcedure;

                MySqlCommand.Parameters.AddWithValue("@usuario_id", iIdUsuario);
                MySqlCommand.Parameters.AddWithValue("@producto_id", id_producto);
                MySqlCommand.Parameters.AddWithValue("@cantidad", iCantidad);


                MyConnection.Open();
                MySqlCommand.ExecuteNonQuery();
                MyConnection.Close();
                MyConnection.Dispose();




                sRet = "";

            }
            catch (Exception ex)
            {
                sRet = ex.Message;

            }



            return sRet;
        }


        public static string ActualizarProductoCarrito(int id_producto, int iIdUsuario, int iCantidad)
        {
            string sRet = "";

            SqlConnection MyConnection = default(SqlConnection);
            SqlCommand MySqlCommand = default(SqlCommand);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MySqlCommand = new SqlCommand("spActualizarCarrito", MyConnection);
                MySqlCommand.CommandType = CommandType.StoredProcedure;

                MySqlCommand.Parameters.AddWithValue("@usuario_id", iIdUsuario);
                MySqlCommand.Parameters.AddWithValue("@producto_id", id_producto);
                MySqlCommand.Parameters.AddWithValue("@cantidad", iCantidad);


                MyConnection.Open();
                MySqlCommand.ExecuteNonQuery();
                MyConnection.Close();
                MyConnection.Dispose();




                sRet = "";

            }
            catch (Exception ex)
            {
                sRet = ex.Message;

            }



            return sRet;
        }




        public static string EliminarDelCarrito(int id_producto, int iIdUsuario)
        {
            string sRet = "";

            SqlConnection MyConnection = default(SqlConnection);
            SqlCommand MySqlCommand = default(SqlCommand);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MySqlCommand = new SqlCommand("spEliminarDelCarrito", MyConnection);
                MySqlCommand.CommandType = CommandType.StoredProcedure;

                MySqlCommand.Parameters.AddWithValue("@usuario_id", iIdUsuario);
                MySqlCommand.Parameters.AddWithValue("@producto_id", id_producto);


                MyConnection.Open();
                MySqlCommand.ExecuteNonQuery();
                MyConnection.Close();
                MyConnection.Dispose();




                sRet = "";

            }
            catch (Exception ex)
            {
                sRet = ex.Message;

            }



            return sRet;
        }


    }
}