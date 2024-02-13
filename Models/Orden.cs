using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace EcommerceNicolas.Models
{
    public class Orden
    {
        public int id { get; set; }
        public DateTime fecha { get; set; }

        public Decimal MontoTotal { get; set; }

        public int UsuarioID { get; set; }

        public int cotizacion_id { get; set; }

        public List<DetalleOrden> DetallesOrden { get; set; }

        public static IEnumerable<Orden> ObtenerOrdenes(int iIdUsuario, ref string sResult)
        {

            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spObtenerOrdenes", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                MyDataAdapter.SelectCommand.Parameters.AddWithValue("@IdUsuario", iIdUsuario);


                DataTable dt = new DataTable();
                MyDataAdapter.Fill(dt);


                List<Models.Orden> ListaOrdenes = new List<Models.Orden>();

                foreach (DataRow row in dt.Rows)
                {
                    var Orden = new Orden();
                    Orden.id = int.Parse(row["id"].ToString());
                    Orden.fecha = DateTime.Parse(row["Fecha_orden"].ToString());
                    Orden.MontoTotal = decimal.Parse(row["MontoTotal"].ToString());


                    ListaOrdenes.Add(Orden);
                }


                sResult = "";
                return ListaOrdenes;
            }
            catch (Exception ex)
            {
                sResult = ex.Message;
                return null;
            }

        }


        public static string GuardarOrden(int iIdUsuario, ref int iOrderID)
        {
            string sRet = "";

            SqlConnection MyConnection = default(SqlConnection);
            SqlCommand MySqlCommand = default(SqlCommand);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MySqlCommand = new SqlCommand("spGuardarOrden", MyConnection);
                MySqlCommand.CommandType = CommandType.StoredProcedure;

                MySqlCommand.Parameters.AddWithValue("@usuario_id", iIdUsuario);



                // Agrego los Parámetros al SPROC (OUT)
                SqlParameter pariOrderID = new SqlParameter("@OrderID", SqlDbType.Int);
                pariOrderID.Direction = ParameterDirection.Output;
              
                MySqlCommand.Parameters.Add(pariOrderID);



                MyConnection.Open();
                MySqlCommand.ExecuteNonQuery();

                //OBTENGO LOS VALORES DE LOS PARAMETROS DE SALIDA
                iOrderID = int.Parse(pariOrderID.Value.ToString());

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



        public static IEnumerable<DetalleOrden> ObtenerDetalleOrden(int iOrden, int iIdUsuario, ref string sResult)
        {

            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spObtenerDetalleOrden", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                MyDataAdapter.SelectCommand.Parameters.AddWithValue("@id_orden", iOrden);
                MyDataAdapter.SelectCommand.Parameters.AddWithValue("@id_usuario", iIdUsuario);


                DataTable dt = new DataTable();
                MyDataAdapter.Fill(dt);


                List<Models.DetalleOrden> DetalleOrden = new List<Models.DetalleOrden>();


                foreach (DataRow row in dt.Rows)
                {
                    var Detalle = new Models.DetalleOrden();

                    Detalle.Cantidad = int.Parse(row["cantidad"].ToString());
                    Detalle.CostoUnitario = decimal.Parse(row["PrecioEnPesos"].ToString());
                    Detalle.ProductoId = int.Parse(row["producto_id"].ToString());
                    Detalle.DescripcionProducto = row["Nombre"].ToString();
                    Detalle.OrderId = int.Parse(row["orden_id"].ToString());


                    DetalleOrden.Add(Detalle);

                    

                }

               

                sResult = "";
                return DetalleOrden;
            }
            catch (Exception ex)
            {
                sResult = ex.Message;
                return null;
            }

        }



    }



    public class DetalleOrden
    {
        public int id { get; set; }
        public int OrderId { get; set; }

        public int ProductoId { get; set; }

        public string DescripcionProducto { get; set; }

        public int Cantidad { get; set; }

        public decimal CostoUnitario { get; set; }
    }

}