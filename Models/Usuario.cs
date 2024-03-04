using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace EcommerceNicolas.Models
{
    public class Usuario
    {

        public int Id { get; set; }

        [Required(ErrorMessage = "El campo Email es requerido")]
        public string Email { get; set; }

        [Required(ErrorMessage = "El campo clave es requerido")]
        public string Clave { get; set; }

        public string Nombre { get; set; }

        public string Apellido { get; set; }



        public static string LoginUsuario(string sEmail, string sClave, ref DataTable dt)
        {
            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spLoginUsuario", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


                MyDataAdapter.SelectCommand.Parameters.Add("@email", SqlDbType.VarChar, 200);
                MyDataAdapter.SelectCommand.Parameters["@email"].Value = sEmail;

                MyDataAdapter.SelectCommand.Parameters.Add("@clave", SqlDbType.VarChar, 100);
                MyDataAdapter.SelectCommand.Parameters["@clave"].Value = sClave;


                //dt = new DataTable();
                MyDataAdapter.Fill(dt);
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }



        public static string ObtenerUsuario(int Id, ref DataTable dt)
        {
            SqlConnection MyConnection = default(SqlConnection);
            SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MyDataAdapter = new SqlDataAdapter("spObtenerUsuario", MyConnection);
                MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


                MyDataAdapter.SelectCommand.Parameters.Add("@id", SqlDbType.Int);
                MyDataAdapter.SelectCommand.Parameters["@id"].Value = Id;




                //dt = new DataTable();
                MyDataAdapter.Fill(dt);
                return "";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }



        public static string ModificarUsuario(int iId, string sNombre, string sApellido, string sClave)
        {
            string sRet = "";

            SqlConnection MyConnection = default(SqlConnection);
            SqlCommand MySqlCommand = default(SqlCommand);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MySqlCommand = new SqlCommand("spModificarUsuario", MyConnection);
                MySqlCommand.CommandType = CommandType.StoredProcedure;

                MySqlCommand.Parameters.AddWithValue("@id", iId);
                MySqlCommand.Parameters.AddWithValue("@Nombre", sNombre);
                MySqlCommand.Parameters.AddWithValue("@Apellido", sApellido);
                MySqlCommand.Parameters.AddWithValue("@Clave", sClave);


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



        public static string InsertarUsuario(string sUsuario, string sNombre, string sApellido, string sClave)
        {
            string sRet = "";

            SqlConnection MyConnection = default(SqlConnection);
            SqlCommand MySqlCommand = default(SqlCommand);

            try
            {
                MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                MySqlCommand = new SqlCommand("spInsertarUsuario", MyConnection);
                MySqlCommand.CommandType = CommandType.StoredProcedure;

                MySqlCommand.Parameters.AddWithValue("@Email", sUsuario);
                MySqlCommand.Parameters.AddWithValue("@Nombre", sNombre);
                MySqlCommand.Parameters.AddWithValue("@Apellido", sApellido);
                MySqlCommand.Parameters.AddWithValue("@Clave", sClave);


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