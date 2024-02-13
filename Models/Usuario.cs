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



    }
}