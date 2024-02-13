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
    public class ProductoCategorias
    {

       
            public int id { get; set; }

            [Required(ErrorMessage = "El campo Descripción es requerido")]
            [Display(Name = "Descripción")]
            public string Descripcion { get; set; }


            public static IEnumerable<ProductoCategorias> ObtenerCategorias(ref string sResult)
            {

                SqlConnection MyConnection = default(SqlConnection);
                SqlDataAdapter MyDataAdapter = default(SqlDataAdapter);

                try
                {
                    MyConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionStringSQL"].ConnectionString);
                    MyDataAdapter = new SqlDataAdapter("spObtenerCategorias", MyConnection);
                    MyDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;


                    DataTable dt = new DataTable();
                    MyDataAdapter.Fill(dt);


                    List<Models.ProductoCategorias> ListaCategorias = new List<Models.ProductoCategorias>();

                    foreach (DataRow row in dt.Rows)
                    {
                        var PCategoria = new ProductoCategorias();
                        PCategoria.id = int.Parse(row["id"].ToString());
                        PCategoria.Descripcion = row["nombre"].ToString();


                    ListaCategorias.Add(PCategoria);
                    }


                    sResult = "";
                    return ListaCategorias;
                }
                catch (Exception ex)
                {
                    sResult = ex.Message;
                    return null;
                }

            }


            

        }
    }
